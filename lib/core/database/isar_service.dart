import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/empresas/domain/models/empresa.dart';
import '../../features/establecimientos/domain/models/establecimiento.dart';
import '../../features/licitaciones/domain/models/licitacion.dart';
import '../../features/visitas/domain/models/visita.dart';
import '../../features/tareas/domain/models/tarea.dart';

class IsarService {
  final Isar isar;

  IsarService(this.isar);

  /// Inicializa la base de datos local Isar con los esquemas correspondientes.
  static Future<IsarService> inicializar() async {
    final dir = await getApplicationDocumentsDirectory();
    final isarInstance = await Isar.open(
      [
        EmpresaSchema,
        EstablecimientoSchema,
        LicitacionSchema,
        VisitaSchema,
        TareaSchema,
      ],
      directory: dir.path,
    );
    return IsarService(isarInstance);
  }

  // ==========================================
  // OPERACIONES CRUD: EMPRESA
  // ==========================================

  /// Guarda o actualiza una Empresa en la base de datos local.
  Future<void> guardarEmpresa(Empresa empresa) async {
    await isar.writeTxn(() async {
      await isar.empresas.put(empresa);
    });
  }

  /// Obtiene una Empresa por su UUID (id String).
  Future<Empresa?> obtenerEmpresaPorId(String id) async {
    return await isar.empresas.filter().idEqualTo(id).findFirst();
  }

  /// Obtiene todas las Empresas almacenadas localmente.
  Future<List<Empresa>> obtenerTodasLasEmpresas() async {
    return await isar.empresas.where().findAll();
  }

  /// Elimina una Empresa y sus establecimientos y licitaciones asociados.
  Future<bool> eliminarEmpresaPorId(String id) async {
    final empresa = await obtenerEmpresaPorId(id);
    if (empresa == null || empresa.localId == null) return false;

    final establecimientos = await obtenerEstablecimientosPorEmpresa(id);
    final licitaciones = await obtenerLicitacionesPorEmpresa(id);

    return await isar.writeTxn(() async {
      for (final est in establecimientos) {
        if (est.localId != null) {
          await isar.establecimientos.delete(est.localId!);
        }
      }
      for (final lic in licitaciones) {
        if (lic.localId != null) {
          await isar.licitacions.delete(lic.localId!);
        }
      }
      return await isar.empresas.delete(empresa.localId!);
    });
  }

  // ==========================================
  // OPERACIONES CRUD: ESTABLECIMIENTO
  // ==========================================

  /// Guarda o actualiza un Establecimiento en la base de datos local.
  Future<void> guardarEstablecimiento(Establecimiento establecimiento) async {
    await isar.writeTxn(() async {
      await isar.establecimientos.put(establecimiento);
    });
  }

  /// Obtiene un Establecimiento por su UUID (id String).
  Future<Establecimiento?> obtenerEstablecimientoPorId(String id) async {
    return await isar.establecimientos.filter().idEqualTo(id).findFirst();
  }

  /// Obtiene los Establecimientos pertenecientes a una Empresa específica.
  Future<List<Establecimiento>> obtenerEstablecimientosPorEmpresa(String empresaId) async {
    return await isar.establecimientos.filter().empresaIdEqualTo(empresaId).findAll();
  }

  /// Obtiene todos los Establecimientos almacenados localmente.
  Future<List<Establecimiento>> obtenerTodosLosEstablecimientos() async {
    return await isar.establecimientos.where().findAll();
  }

  /// Elimina un Establecimiento por su UUID (id String).
  Future<bool> eliminarEstablecimientoPorId(String id) async {
    final establecimiento = await obtenerEstablecimientoPorId(id);
    if (establecimiento != null && establecimiento.localId != null) {
      return await isar.writeTxn(() async {
        return await isar.establecimientos.delete(establecimiento.localId!);
      });
    }
    return false;
  }

  // ==========================================
  // OPERACIONES CRUD: LICITACION
  // ==========================================

  /// Guarda o actualiza una Licitación en la base de datos local.
  Future<void> guardarLicitacion(Licitacion licitacion) async {
    await isar.writeTxn(() async {
      await isar.licitacions.put(licitacion);
    });
  }

  /// Obtiene una Licitación por su UUID (id String).
  Future<Licitacion?> obtenerLicitacionPorId(String id) async {
    return await isar.licitacions.filter().idEqualTo(id).findFirst();
  }

  /// Obtiene las Licitaciones pertenecientes a una Empresa específica.
  Future<List<Licitacion>> obtenerLicitacionesPorEmpresa(String empresaId) async {
    return await isar.licitacions.filter().empresaIdEqualTo(empresaId).findAll();
  }

  /// Obtiene todas las Licitaciones almacenadas localmente.
  Future<List<Licitacion>> obtenerTodasLasLicitaciones() async {
    return await isar.licitacions.where().findAll();
  }

  /// Elimina una Licitación por su UUID (id String).
  Future<bool> eliminarLicitacionPorId(String id) async {
    final licitacion = await obtenerLicitacionPorId(id);
    if (licitacion != null && licitacion.localId != null) {
      return await isar.writeTxn(() async {
        return await isar.licitacions.delete(licitacion.localId!);
      });
    }
    return false;
  }

  // ==========================================
  // OPERACIONES CRUD: VISITA
  // ==========================================

  /// Guarda o actualiza una Visita en la base de datos local.
  Future<void> guardarVisita(Visita visita) async {
    await isar.writeTxn(() async {
      await isar.visitas.put(visita);
    });
  }

  /// Obtiene una Visita por su UUID (id String).
  Future<Visita?> obtenerVisitaPorId(String id) async {
    return await isar.visitas.filter().idEqualTo(id).findFirst();
  }

  /// Obtiene las Visitas pertenecientes a una Empresa específica.
  Future<List<Visita>> obtenerVisitasPorEmpresa(String empresaId) async {
    return await isar.visitas.filter().empresaIdEqualTo(empresaId).sortByFechaVisitaDesc().findAll();
  }

  /// Obtiene todas las Visitas almacenadas localmente.
  Future<List<Visita>> obtenerTodasLasVisitas() async {
    return await isar.visitas.where().sortByFechaVisitaDesc().findAll();
  }

  /// Elimina una Visita por su UUID (id String).
  Future<bool> eliminarVisitaPorId(String id) async {
    final visita = await obtenerVisitaPorId(id);
    if (visita != null && visita.localId != null) {
      return await isar.writeTxn(() async {
        return await isar.visitas.delete(visita.localId!);
      });
    }
    return false;
  }

  // ==========================================
  // OPERACIONES CRUD: TAREA
  // ==========================================

  /// Guarda o actualiza una Tarea en la base de datos local.
  Future<void> guardarTarea(Tarea tarea) async {
    await isar.writeTxn(() async {
      await isar.tareas.put(tarea);
    });
  }

  /// Obtiene una Tarea por su UUID (id String).
  Future<Tarea?> obtenerTareaPorId(String id) async {
    return await isar.tareas.filter().idEqualTo(id).findFirst();
  }

  /// Obtiene las Tareas pertenecientes a una Empresa específica.
  Future<List<Tarea>> obtenerTareasPorEmpresa(String empresaId) async {
    return await isar.tareas.filter().empresaIdEqualTo(empresaId).sortByFechaVencimiento().findAll();
  }

  /// Obtiene todas las Tareas almacenadas localmente.
  Future<List<Tarea>> obtenerTodasLasTareas() async {
    return await isar.tareas.where().sortByFechaVencimiento().findAll();
  }

  /// Elimina una Tarea por su UUID (id String).
  Future<bool> eliminarTareaPorId(String id) async {
    final tarea = await obtenerTareaPorId(id);
    if (tarea != null && tarea.localId != null) {
      return await isar.writeTxn(() async {
        return await isar.tareas.delete(tarea.localId!);
      });
    }
    return false;
  }
}
