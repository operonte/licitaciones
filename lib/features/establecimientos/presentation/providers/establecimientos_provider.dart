import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../domain/models/establecimiento.dart';

class EstablecimientosNotifier extends StateNotifier<List<Establecimiento>> {
  final Ref ref;

  EstablecimientosNotifier(this.ref) : super([]) {
    cargarEstablecimientos();
  }

  /// Carga todos los establecimientos desde la base de datos local.
  Future<void> cargarEstablecimientos() async {
    final service = ref.read(isarServiceProvider);
    final lista = await service.obtenerTodosLosEstablecimientos();
    state = lista;
  }

  /// Guarda o actualiza un establecimiento y refresca la lista.
  Future<void> guardarEstablecimiento(Establecimiento est) async {
    final service = ref.read(isarServiceProvider);
    await service.guardarEstablecimiento(est);
    await cargarEstablecimientos();
  }

  /// Elimina un establecimiento por su UUID.
  Future<void> eliminarEstablecimiento(String id) async {
    final service = ref.read(isarServiceProvider);
    await service.eliminarEstablecimientoPorId(id);
    await cargarEstablecimientos();
  }
}

/// Provider global para los establecimientos.
final establecimientosProvider = StateNotifierProvider<EstablecimientosNotifier, List<Establecimiento>>((ref) {
  return EstablecimientosNotifier(ref);
});

/// Provider familiar para filtrar automáticamente establecimientos pertenecientes a una empresa.
final establecimientosPorEmpresaProvider = Provider.family<List<Establecimiento>, String>((ref, empresaId) {
  final todos = ref.watch(establecimientosProvider);
  return todos.where((est) => est.empresaId == empresaId).toList();
});
