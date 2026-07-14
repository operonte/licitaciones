import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../../establecimientos/presentation/providers/establecimientos_provider.dart';
import '../../../licitaciones/presentation/providers/licitaciones_provider.dart';
import '../../domain/models/empresa.dart';

class EmpresasNotifier extends StateNotifier<List<Empresa>> {
  final Ref ref;

  EmpresasNotifier(this.ref) : super([]) {
    cargarEmpresas();
  }

  /// Carga todas las empresas desde Isar y actualiza el estado.
  Future<void> cargarEmpresas() async {
    final service = ref.read(isarServiceProvider);
    final lista = await service.obtenerTodasLasEmpresas();
    // Ordenar de más reciente a más antigua
    lista.sort((a, b) => b.fechaRegistro.compareTo(a.fechaRegistro));
    state = lista;
  }

  /// Agrega o actualiza una empresa en Isar y refresca la lista.
  Future<void> guardarEmpresa(Empresa empresa) async {
    final service = ref.read(isarServiceProvider);
    await service.guardarEmpresa(empresa);
    await cargarEmpresas();
    
    // Disparar sincronización de fondo
    ref.read(syncServiceProvider).syncAll().catchError((_) {});
  }

  /// Elimina una empresa y sus relaciones por su UUID.
  Future<void> eliminarEmpresa(String id) async {
    final service = ref.read(isarServiceProvider);
    await service.eliminarEmpresaPorId(id);
    await cargarEmpresas();
    await ref.read(establecimientosProvider.notifier).cargarEstablecimientos();
    await ref.read(licitacionesProvider.notifier).cargarLicitaciones();
    
    // Eliminar de Supabase de fondo
    ref.read(supabaseClientProvider).from('empresas').delete().eq('id', id).catchError((_) {});
    ref.read(syncServiceProvider).syncAll().catchError((_) {});
  }
}

/// Provider para la lista de empresas.
final empresasProvider = StateNotifierProvider<EmpresasNotifier, List<Empresa>>((ref) {
  return EmpresasNotifier(ref);
});
