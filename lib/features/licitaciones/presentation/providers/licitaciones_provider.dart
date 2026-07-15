import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/services/alert_scheduler_service.dart';
import '../../domain/models/licitacion.dart';

class LicitacionesNotifier extends StateNotifier<List<Licitacion>> {
  final Ref ref;

  LicitacionesNotifier(this.ref) : super([]) {
    _init();
  }

  Future<void> _init() async {
    await cargarLicitaciones();
    await ref.read(alertSchedulerServiceProvider).reprogramarAlertas();
  }

  /// Carga todas las licitaciones desde Isar y las ordena cronológicamente.
  Future<void> cargarLicitaciones() async {
    final service = ref.read(isarServiceProvider);
    final lista = await service.obtenerTodasLasLicitaciones();
    // Ordenar por fecha límite de entrega más cercana primero
    lista.sort((a, b) => a.fechaLimiteEntrega.compareTo(b.fechaLimiteEntrega));
    state = lista;
  }

  /// Guarda o actualiza una licitación y refresca la lista.
  Future<void> guardarLicitacion(Licitacion licitacion) async {
    final service = ref.read(isarServiceProvider);
    await service.guardarLicitacion(licitacion);
    await cargarLicitaciones();
    await ref.read(alertSchedulerServiceProvider).reprogramarAlertas();

    // Disparar sincronización de fondo
    ref.read(syncServiceProvider).syncAll().catchError((_) {});
  }

  /// Elimina una licitación por su UUID.
  Future<void> eliminarLicitacion(String id) async {
    final service = ref.read(isarServiceProvider);
    await service.eliminarLicitacionPorId(id);
    await cargarLicitaciones();
    await ref.read(alertSchedulerServiceProvider).reprogramarAlertas();

    // Eliminar de Supabase de fondo
    ref.read(supabaseClientProvider).from('licitaciones').delete().eq('id', id).catchError((_) {});
    ref.read(syncServiceProvider).syncAll().catchError((_) {});
  }
}

/// Provider global para las licitaciones.
final licitacionesProvider = StateNotifierProvider<LicitacionesNotifier, List<Licitacion>>((ref) {
  return LicitacionesNotifier(ref);
});

/// Provider para licitaciones filtradas (próximas y activas) ordenadas por vencimiento.
final proximasLicitacionesProvider = Provider<List<Licitacion>>((ref) {
  final todas = ref.watch(licitacionesProvider);
  return todas
      .where((lic) => lic.estado == EstadoLicitacion.proxima || lic.estado == EstadoLicitacion.activa)
      .toList();
});
