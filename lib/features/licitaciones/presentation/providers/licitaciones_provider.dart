import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../domain/models/licitacion.dart';

class LicitacionesNotifier extends StateNotifier<List<Licitacion>> {
  final Ref ref;

  LicitacionesNotifier(this.ref) : super([]) {
    cargarLicitaciones();
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
  }

  /// Elimina una licitación por su UUID.
  Future<void> eliminarLicitacion(String id) async {
    final service = ref.read(isarServiceProvider);
    await service.eliminarLicitacionPorId(id);
    await cargarLicitaciones();
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
