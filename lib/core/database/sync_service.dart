import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'isar_service.dart';
import '../../features/empresas/domain/models/empresa.dart';
import '../../features/establecimientos/domain/models/establecimiento.dart';
import '../../features/licitaciones/domain/models/licitacion.dart';
import '../../features/visitas/domain/models/visita.dart';
import '../../features/tareas/domain/models/tarea.dart';

class SyncService {
  final IsarService isarService;
  final SupabaseClient supabase;

  SyncService({
    required this.isarService,
    required this.supabase,
  });

  /// Realiza la sincronización bidireccional completa (push y luego pull)
  Future<void> syncAll() async {
    try {
      // 1. Subir cambios locales
      await pushLocalChanges();
      
      // 2. Descargar cambios remotos
      await pullRemoteChanges();
    } catch (e) {
      // Registrar error o fallar de forma silenciosa para no interrumpir al usuario
      debugPrint('Sincronización fallida: $e');
    }
  }

  /// Sube todos los registros locales modificados (isSynced == false) a Supabase
  Future<void> pushLocalChanges() async {
    // Sincronizar Empresas
    final dirtyEmpresas = (await isarService.obtenerTodasLasEmpresas())
        .where((e) => !e.isSynced)
        .toList();
    for (final empresa in dirtyEmpresas) {
      await supabase.from('empresas').upsert(empresa.toSupabaseJson());
      await isarService.guardarEmpresa(empresa.copyWith(isSynced: true));
    }

    // Sincronizar Establecimientos
    final dirtyEstablecimientos = (await isarService.obtenerTodosLosEstablecimientos())
        .where((e) => !e.isSynced)
        .toList();
    for (final est in dirtyEstablecimientos) {
      await supabase.from('establecimientos').upsert(est.toSupabaseJson());
      await isarService.guardarEstablecimiento(est.copyWith(isSynced: true));
    }

    // Sincronizar Licitaciones
    final dirtyLicitaciones = (await isarService.obtenerTodasLasLicitaciones())
        .where((e) => !e.isSynced)
        .toList();
    for (final lic in dirtyLicitaciones) {
      await supabase.from('licitaciones').upsert(lic.toSupabaseJson());
      await isarService.guardarLicitacion(lic.copyWith(isSynced: true));
    }

    // Sincronizar Visitas
    final dirtyVisitas = (await isarService.obtenerTodasLasVisitas())
        .where((e) => !e.isSynced)
        .toList();
    for (final visita in dirtyVisitas) {
      await supabase.from('visitas').upsert(visita.toSupabaseJson());
      await isarService.guardarVisita(visita.copyWith(isSynced: true));
    }

    // Sincronizar Tareas
    final dirtyTareas = (await isarService.obtenerTodasLasTareas())
        .where((e) => !e.isSynced)
        .toList();
    for (final tarea in dirtyTareas) {
      await supabase.from('tareas').upsert(tarea.toSupabaseJson());
      await isarService.guardarTarea(tarea.copyWith(isSynced: true));
    }
  }

  /// Trae los cambios de la nube y los actualiza en Isar si son más nuevos
  Future<void> pullRemoteChanges() async {
    // Descargar Empresas
    final List<dynamic> remoteEmpresas = await supabase.from('empresas').select();
    for (final data in remoteEmpresas) {
      final remote = Empresa.fromJson(_mapSnakeToCamel(data as Map<String, dynamic>));
      final local = await isarService.obtenerEmpresaPorId(remote.id);
      if (local == null || remote.updatedAt.isAfter(local.updatedAt)) {
        await isarService.guardarEmpresa(remote.copyWith(localId: local?.localId, isSynced: true));
      }
    }

    // Descargar Establecimientos
    final List<dynamic> remoteEstablecimientos = await supabase.from('establecimientos').select();
    for (final data in remoteEstablecimientos) {
      final remote = Establecimiento.fromJson(_mapSnakeToCamel(data as Map<String, dynamic>));
      final local = await isarService.obtenerEstablecimientoPorId(remote.id);
      if (local == null || remote.updatedAt.isAfter(local.updatedAt)) {
        await isarService.guardarEstablecimiento(remote.copyWith(localId: local?.localId, isSynced: true));
      }
    }

    // Descargar Licitaciones
    final List<dynamic> remoteLicitaciones = await supabase.from('licitaciones').select();
    for (final data in remoteLicitaciones) {
      final remote = Licitacion.fromJson(_mapSnakeToCamel(data as Map<String, dynamic>));
      final local = await isarService.obtenerLicitacionPorId(remote.id);
      if (local == null || remote.updatedAt.isAfter(local.updatedAt)) {
        await isarService.guardarLicitacion(remote.copyWith(localId: local?.localId, isSynced: true));
      }
    }

    // Descargar Visitas
    final List<dynamic> remoteVisitas = await supabase.from('visitas').select();
    for (final data in remoteVisitas) {
      final remote = Visita.fromJson(_mapSnakeToCamel(data as Map<String, dynamic>));
      final local = await isarService.obtenerVisitaPorId(remote.id);
      if (local == null || remote.updatedAt.isAfter(local.updatedAt)) {
        await isarService.guardarVisita(remote.copyWith(localId: local?.localId, isSynced: true));
      }
    }

    // Descargar Tareas
    final List<dynamic> remoteTareas = await supabase.from('tareas').select();
    for (final data in remoteTareas) {
      final remote = Tarea.fromJson(_mapSnakeToCamel(data as Map<String, dynamic>));
      final local = await isarService.obtenerTareaPorId(remote.id);
      if (local == null || remote.updatedAt.isAfter(local.updatedAt)) {
        await isarService.guardarTarea(remote.copyWith(localId: local?.localId, isSynced: true));
      }
    }
  }

  /// Mapea llaves de snake_case a camelCase de forma recursiva
  Map<String, dynamic> _mapSnakeToCamel(Map<String, dynamic> snakeJson) {
    final Map<String, dynamic> camelJson = {};
    snakeJson.forEach((key, value) {
      final parts = key.split('_');
      final camelKey = parts[0] + parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
      
      // Si el valor es una lista de objetos (como contactos o compromisos)
      if (value is List) {
        camelJson[camelKey] = value.map((item) {
          if (item is Map<String, dynamic>) {
            return _mapSnakeToCamel(item);
          }
          return item;
        }).toList();
      } else if (value is Map<String, dynamic>) {
        camelJson[camelKey] = _mapSnakeToCamel(value);
      } else {
        camelJson[camelKey] = value;
      }
    });
    return camelJson;
  }
}
