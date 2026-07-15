import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/services/alert_scheduler_service.dart';
import '../../domain/models/tarea.dart';

class TareasNotifier extends StateNotifier<List<Tarea>> {
  final Ref ref;

  TareasNotifier(this.ref) : super([]) {
    cargarTareas();
  }

  /// Carga todas las tareas desde la base de datos local.
  Future<void> cargarTareas() async {
    final service = ref.read(isarServiceProvider);
    final lista = await service.obtenerTodasLasTareas();
    state = lista;
  }

  /// Guarda o actualiza una tarea y refresca la lista.
  Future<void> guardarTarea(Tarea tarea) async {
    final service = ref.read(isarServiceProvider);
    await service.guardarTarea(tarea);
    await cargarTareas();
    await ref.read(alertSchedulerServiceProvider).reprogramarAlertas();

    // Disparar sincronización de fondo
    ref.read(syncServiceProvider).syncAll().catchError((_) {});
  }

  /// Elimina una tarea por su UUID.
  Future<void> eliminarTarea(String id) async {
    final service = ref.read(isarServiceProvider);
    await service.eliminarTareaPorId(id);
    await cargarTareas();
    await ref.read(alertSchedulerServiceProvider).reprogramarAlertas();

    // Eliminar de Supabase de fondo
    ref.read(supabaseClientProvider).from('tareas').delete().eq('id', id).catchError((_) {});
    ref.read(syncServiceProvider).syncAll().catchError((_) {});
  }
}

/// Provider global para las tareas.
final tareasProvider = StateNotifierProvider<TareasNotifier, List<Tarea>>((ref) {
  return TareasNotifier(ref);
});

/// Provider familiar para filtrar automáticamente tareas pertenecientes a una empresa.
final tareasPorEmpresaProvider = Provider.family<List<Tarea>, String>((ref, empresaId) {
  final todas = ref.watch(tareasProvider);
  return todas.where((tarea) => tarea.empresaId == empresaId).toList();
});

/// Provider para tareas pendientes (no completadas ni canceladas)
final tareasPendientesProvider = Provider<List<Tarea>>((ref) {
  final todas = ref.watch(tareasProvider);
  return todas
      .where((tarea) => tarea.estado == EstadoTarea.pendiente || tarea.estado == EstadoTarea.enProgreso)
      .toList()
    ..sort((a, b) => a.fechaVencimiento.compareTo(b.fechaVencimiento));
});

/// Provider para tareas vencidas
final tareasVencidasProvider = Provider<List<Tarea>>((ref) {
  final todas = ref.watch(tareasProvider);
  final ahora = DateTime.now();
  return todas
      .where((tarea) =>
          (tarea.estado == EstadoTarea.pendiente || tarea.estado == EstadoTarea.enProgreso) &&
          tarea.fechaVencimiento.isBefore(ahora))
      .toList();
});
