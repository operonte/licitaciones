import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:licitaciones/features/empresas/domain/models/empresa.dart';
import 'package:licitaciones/features/establecimientos/domain/models/establecimiento.dart';
import 'package:licitaciones/features/establecimientos/domain/models/contacto.dart';
import 'package:licitaciones/features/licitaciones/domain/models/licitacion.dart';
import 'package:licitaciones/core/database/isar_service.dart';

void main() {
  group('Pruebas de Modelos (Serialización JSON)', () {
    test('Empresa JSON serialization', () {
      final fecha = DateTime(2026, 7, 13);
      final contactoEmpresa = Contacto(
        nombre: 'María García',
        cargo: 'Directora Comercial',
        telefono: '+56987654321',
        email: 'maria@seguridad.cl',
      );

      final empresa = Empresa(
        id: 'uuid-empresa-123',
        razonSocial: 'Seguridad Industrial S.A.',
        rut: '76.123.456-7',
        rubro: 'Minería',
        estadoRelacion: EstadoRelacion.prospecto,
        fechaRegistro: fecha,
        contactos: [contactoEmpresa],
      );

      final json = empresa.toJson();
      expect(json['id'], 'uuid-empresa-123');
      expect(json['razonSocial'], 'Seguridad Industrial S.A.');
      expect(json['estadoRelacion'], 'prospecto');
      expect(json['fechaRegistro'], fecha.toIso8601String());
      expect(json['contactos'].length, 1);
      expect(json['contactos'].first['nombre'], 'María García');

      final deJson = Empresa.fromJson(json);
      expect(deJson.id, empresa.id);
      expect(deJson.razonSocial, empresa.razonSocial);
      expect(deJson.estadoRelacion, empresa.estadoRelacion);
      expect(deJson.fechaRegistro, empresa.fechaRegistro);
      expect(deJson.contactos.length, 1);
      expect(deJson.contactos.first.nombre, 'María García');
    });

    test('Establecimiento y Contacto JSON serialization', () {
      final contacto = Contacto(
        nombre: 'Juan Pérez',
        cargo: 'Gerente de Operaciones',
        telefono: '+56912345678',
        email: 'juan.perez@seguridad.cl',
      );

      final establecimiento = Establecimiento(
        id: 'uuid-est-123',
        empresaId: 'uuid-empresa-123',
        nombreSucursal: 'Sucursal Norte',
        direccion: 'Av. Las Industrias 456',
        cantidadGuardiasEstimados: 12,
        contactos: [contacto],
      );

      final json = establecimiento.toJson();
      expect(json['id'], 'uuid-est-123');
      expect(json['empresaId'], 'uuid-empresa-123');
      expect(json['contactos'].first['nombre'], 'Juan Pérez');

      final deJson = Establecimiento.fromJson(json);
      expect(deJson.id, establecimiento.id);
      expect(deJson.contactos.first.nombre, 'Juan Pérez');
    });

    test('Licitacion JSON serialization', () {
      final fechaPub = DateTime(2026, 7, 1);
      final fechaLim = DateTime(2026, 7, 30);
      final licitacion = Licitacion(
        id: 'uuid-lic-123',
        empresaId: 'uuid-empresa-123',
        titulo: 'Servicios de Guardia 2026',
        fechaPublicacion: fechaPub,
        fechaLimiteEntrega: fechaLim,
        presupuestoEstimado: 150000.0,
        estado: EstadoLicitacion.activa,
        diasAnticipacionAlerta: 5,
      );

      final json = licitacion.toJson();
      expect(json['id'], 'uuid-lic-123');
      expect(json['presupuestoEstimado'], 150000.0);
      expect(json['estado'], 'activa');

      final deJson = Licitacion.fromJson(json);
      expect(deJson.id, licitacion.id);
      expect(deJson.presupuestoEstimado, licitacion.presupuestoEstimado);
    });
  });

  group('Pruebas de Base de Datos Isar (CRUD Local)', () {
    late Isar isar;
    late IsarService service;
    late Directory tempDir;

    setUpAll(() async {
      // Inicializar Isar Core para pruebas (descarga las librerías binarias locales si es necesario)
      await Isar.initializeIsarCore(download: true);
    });

    setUp(() async {
      // Crear directorio temporal único para cada prueba
      tempDir = await Directory.systemTemp.createTemp('isar_test_dir');
      isar = await Isar.open(
        [
          EmpresaSchema,
          EstablecimientoSchema,
          LicitacionSchema,
        ],
        directory: tempDir.path,
      );
      service = IsarService(isar);
    });

    tearDown(() async {
      await isar.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('CRUD de Empresas', () async {
      final contactoEmpresa = Contacto(
        nombre: 'Pedro López',
        cargo: 'Gerente General',
        telefono: '555-1234',
        email: 'pedro@empresa.cl',
      );

      final empresa = Empresa(
        id: 'uuid-1',
        razonSocial: 'Empresa Test',
        rut: '12.345.678-9',
        rubro: 'Retail',
        estadoRelacion: EstadoRelacion.prospecto,
        fechaRegistro: DateTime.now(),
        contactos: [contactoEmpresa],
      );

      // Create
      await service.guardarEmpresa(empresa);

      // Read
      final obtenida = await service.obtenerEmpresaPorId('uuid-1');
      expect(obtenida, isNotNull);
      expect(obtenida!.razonSocial, 'Empresa Test');
      expect(obtenida.rut, '12.345.678-9');
      expect(obtenida.contactos.length, 1);
      expect(obtenida.contactos.first.nombre, 'Pedro López');

      // Update
      final empresaModificada = Empresa(
        localId: obtenida.localId,
        id: obtenida.id,
        razonSocial: 'Empresa Test Modificada',
        rut: obtenida.rut,
        rubro: obtenida.rubro,
        estadoRelacion: EstadoRelacion.asesorado,
        fechaRegistro: obtenida.fechaRegistro,
        contactos: obtenida.contactos,
      );
      await service.guardarEmpresa(empresaModificada);

      final obtenidaModificada = await service.obtenerEmpresaPorId('uuid-1');
      expect(obtenidaModificada!.razonSocial, 'Empresa Test Modificada');
      expect(obtenidaModificada.estadoRelacion, EstadoRelacion.asesorado);
      expect(obtenidaModificada.contactos.length, 1);

      // Delete
      final eliminado = await service.eliminarEmpresaPorId('uuid-1');
      expect(eliminado, isTrue);

      final obtenidaEliminada = await service.obtenerEmpresaPorId('uuid-1');
      expect(obtenidaEliminada, isNull);
    });

    test('CRUD de Establecimientos y Licitaciones asociados', () async {
      final empresaId = 'empresa-asociada-uuid';

      final est = Establecimiento(
        id: 'est-1',
        empresaId: empresaId,
        nombreSucursal: 'Planta Industrial',
        direccion: 'Calle Falsa 123',
        cantidadGuardiasEstimados: 4,
        contactos: [
          Contacto(
            nombre: 'Carlos Guardia',
            cargo: 'Supervisor',
            telefono: '999999999',
            email: 'carlos@guardia.cl',
          )
        ],
      );

      final lic = Licitacion(
        id: 'lic-1',
        empresaId: empresaId,
        titulo: 'Licitación Anual Seguridad',
        fechaPublicacion: DateTime.now(),
        fechaLimiteEntrega: DateTime.now().add(const Duration(days: 30)),
        presupuestoEstimado: 50000.0,
        estado: EstadoLicitacion.proxima,
        diasAnticipacionAlerta: 10,
      );

      // Guardar
      await service.guardarEstablecimiento(est);
      await service.guardarLicitacion(lic);

      // Consultar establecimientos por empresa
      final establecimientos = await service.obtenerEstablecimientosPorEmpresa(empresaId);
      expect(establecimientos.length, 1);
      expect(establecimientos.first.nombreSucursal, 'Planta Industrial');
      expect(establecimientos.first.contactos.first.nombre, 'Carlos Guardia');

      // Consultar licitaciones por empresa
      final licitaciones = await service.obtenerLicitacionesPorEmpresa(empresaId);
      expect(licitaciones.length, 1);
      expect(licitaciones.first.titulo, 'Licitación Anual Seguridad');

      // Eliminar
      await service.eliminarEstablecimientoPorId('est-1');
      await service.eliminarLicitacionPorId('lic-1');

      expect(await service.obtenerEstablecimientoPorId('est-1'), isNull);
      expect(await service.obtenerLicitacionPorId('lic-1'), isNull);
    });
  });
}
