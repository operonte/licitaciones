import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/notifications/notification_service.dart';
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
    await _reprogramarAlertas();
  }

  /// Elimina una tarea por su UUID.
  Future<void> eliminarTarea(String id) async {
    final service = ref.read(isarServiceProvider);
    await service.eliminarTareaPorId(id);
    await cargarTareas();
    await _reprogramarAlertas();
  }

  Future<void> _reprogramarAlertas() async {
    final licitaciones = await ref.read(isarServiceProvider).obtenerTodasLasLicitaciones();
    final visitas = await ref.read(isarServiceProvider).obtenerTodasLasVisitas();
    await NotificationService().programarTodasLasAlertas(
      licitaciones: licitaciones,
      visitas: visitas,
      tareas: state,
    );
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
