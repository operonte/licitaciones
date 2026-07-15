import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_provider.dart';
import '../notifications/notification_service.dart';

/// Servicio centralizado para reprogramar las alertas de notificaciones.
/// Evita la duplicación de lógica de reprogramación entre múltiples providers.
class AlertSchedulerService {
  final Ref ref;

  AlertSchedulerService(this.ref);

  /// Reprograma todas las alertas cargando el estado actualizado desde Isar.
  Future<void> reprogramarAlertas() async {
    final databaseService = ref.read(isarServiceProvider);

    final licitaciones = await databaseService.obtenerTodasLasLicitaciones();
    final visitas = await databaseService.obtenerTodasLasVisitas();
    final tareas = await databaseService.obtenerTodasLasTareas();

    await NotificationService().programarTodasLasAlertas(
      licitaciones: licitaciones,
      visitas: visitas,
      tareas: tareas,
    );
  }
}

/// Provider para inyectar AlertSchedulerService en la aplicación.
final alertSchedulerServiceProvider = Provider<AlertSchedulerService>((ref) {
  return AlertSchedulerService(ref);
});
