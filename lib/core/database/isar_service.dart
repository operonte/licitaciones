import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/empresas/domain/models/empresa.dart';
import '../../features/establecimientos/domain/models/establecimiento.dart';
import '../../features/licitaciones/domain/models/licitacion.dart';

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

  /// Elimina una Empresa por su UUID (id String).
  Future<bool> eliminarEmpresaPorId(String id) async {
    final empresa = await obtenerEmpresaPorId(id);
    if (empresa != null && empresa.localId != null) {
      return await isar.writeTxn(() async {
        return await isar.empresas.delete(empresa.localId!);
      });
    }
    return false;
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
}
