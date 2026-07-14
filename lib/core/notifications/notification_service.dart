import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import '../../features/licitaciones/domain/models/licitacion.dart';
import '../../features/visitas/domain/models/visita.dart';
import '../../features/tareas/domain/models/tarea.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _plugin.initialize(settings);
    _initialized = true;
  }

  Future<void> programarTodasLasAlertas({
    required List<Licitacion> licitaciones,
    required List<Visita> visitas,
    required List<Tarea> tareas,
  }) async {
    if (!_initialized) await initialize();
    await _plugin.cancelAll();

    await programarAlertasLicitaciones(licitaciones);
    await programarAlertasVisitas(visitas);
    await programarAlertasTareas(tareas);
  }

  Future<void> programarAlertasLicitaciones(List<Licitacion> licitaciones) async {
    for (final lic in licitaciones) {
      if (lic.estado != EstadoLicitacion.proxima && lic.estado != EstadoLicitacion.activa) {
        continue;
      }

      final fechaAlerta = lic.fechaLimiteEntrega.subtract(
        Duration(days: lic.diasAnticipacionAlerta),
      );
      if (fechaAlerta.isBefore(DateTime.now())) continue;

      final id = lic.id.hashCode;
      await _plugin.zonedSchedule(
        id,
        'Licitación próxima',
        '${lic.titulo} vence el ${lic.fechaLimiteEntrega.day}/${lic.fechaLimiteEntrega.month}',
        tz.TZDateTime.from(fechaAlerta, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'licitaciones_alertas',
            'Alertas de Licitaciones',
            channelDescription: 'Recordatorios de fechas límite de licitaciones',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> programarAlertasVisitas(List<Visita> visitas) async {
    for (final vis in visitas) {
      if (vis.proximaVisitaAgendada == null) continue;
      
      final fechaVisita = vis.proximaVisitaAgendada!;
      if (fechaVisita.isBefore(DateTime.now())) continue;

      final id = ('visita_${vis.id}').hashCode;
      await _plugin.zonedSchedule(
        id,
        'Visita agendada',
        'Tienes una visita agendada para el ${fechaVisita.day}/${fechaVisita.month}',
        tz.TZDateTime.from(fechaVisita.subtract(const Duration(days: 1)), tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'visitas_alertas',
            'Alertas de Visitas',
            channelDescription: 'Recordatorios de visitas agendadas',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> programarAlertasTareas(List<Tarea> tareas) async {
    for (final tar in tareas) {
      if (tar.estado == EstadoTarea.completada || tar.estado == EstadoTarea.cancelada) continue;
      
      final fechaVencimiento = tar.fechaVencimiento;
      if (fechaVencimiento.isBefore(DateTime.now())) continue;

      final id = ('tarea_${tar.id}').hashCode;
      await _plugin.zonedSchedule(
        id,
        'Tarea por vencer',
        '${tar.titulo} vence el ${fechaVencimiento.day}/${fechaVencimiento.month}',
        tz.TZDateTime.from(fechaVencimiento.subtract(const Duration(days: 1)), tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'tareas_alertas',
            'Alertas de Tareas',
            channelDescription: 'Recordatorios de tareas por vencer',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
