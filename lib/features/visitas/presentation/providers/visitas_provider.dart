import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/notifications/notification_service.dart';
import '../../domain/models/visita.dart';

class VisitasNotifier extends StateNotifier<List<Visita>> {
  final Ref ref;

  VisitasNotifier(this.ref) : super([]) {
    cargarVisitas();
  }

  /// Carga todas las visitas desde la base de datos local.
  Future<void> cargarVisitas() async {
    final service = ref.read(isarServiceProvider);
    final lista = await service.obtenerTodasLasVisitas();
    state = lista;
  }

  /// Guarda o actualiza una visita y refresca la lista.
  Future<void> guardarVisita(Visita visita) async {
    final service = ref.read(isarServiceProvider);
    await service.guardarVisita(visita);
    await cargarVisitas();
    await _reprogramarAlertas();
  }

  /// Elimina una visita por su UUID.
  Future<void> eliminarVisita(String id) async {
    final service = ref.read(isarServiceProvider);
    await service.eliminarVisitaPorId(id);
    await cargarVisitas();
    await _reprogramarAlertas();
  }

  Future<void> _reprogramarAlertas() async {
    final licitaciones = await ref.read(isarServiceProvider).obtenerTodasLasLicitaciones();
    final tareas = await ref.read(isarServiceProvider).obtenerTodasLasTareas();
    await NotificationService().programarTodasLasAlertas(
      licitaciones: licitaciones,
      visitas: state,
      tareas: tareas,
    );
  }
}

/// Provider global para las visitas.
final visitasProvider = StateNotifierProvider<VisitasNotifier, List<Visita>>((ref) {
  return VisitasNotifier(ref);
});

/// Provider familiar para filtrar automáticamente visitas pertenecientes a una empresa.
final visitasPorEmpresaProvider = Provider.family<List<Visita>, String>((ref, empresaId) {
  final todas = ref.watch(visitasProvider);
  return todas.where((visita) => visita.empresaId == empresaId).toList();
});

/// Provider para visitas próximas (agendadas para el futuro)
final proximasVisitasProvider = Provider<List<Visita>>((ref) {
  final todas = ref.watch(visitasProvider);
  final ahora = DateTime.now();
  return todas
      .where((visita) => visita.proximaVisitaAgendada != null && visita.proximaVisitaAgendada!.isAfter(ahora))
      .toList()
    ..sort((a, b) => a.proximaVisitaAgendada!.compareTo(b.proximaVisitaAgendada!));
});
