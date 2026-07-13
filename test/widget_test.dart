import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:licitaciones/main.dart';
import 'package:licitaciones/core/database/database_provider.dart';
import 'package:licitaciones/core/database/isar_service.dart';
import 'package:licitaciones/features/empresas/domain/models/empresa.dart';
import 'package:licitaciones/features/establecimientos/domain/models/establecimiento.dart';
import 'package:licitaciones/features/licitaciones/domain/models/licitacion.dart';

void main() {
  late Isar isar;
  late IsarService service;
  late Directory tempDir;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('isar_widget_test_dir');
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
    // Isar.close() puede bloquear el event loop del test runner.
    // Lo ejecutamos sin await y limpiamos el directorio temporal con un delay.
    isar.close();
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    } catch (_) {}
  });

  testWidgets('Navegacion y carga inicial de pestañas en la App', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          isarServiceProvider.overrideWithValue(service),
        ],
        child: const MyApp(),
      ),
    );

    // Dar tiempo a los StateNotifiers para cargar datos asíncronos de Isar
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));

    // 1. Verificar presencia de elementos en el Dashboard
    expect(find.text('Licitaciones & CRM'), findsOneWidget);
    expect(find.text('Resumen Comercial'), findsOneWidget);
    expect(find.text('No hay licitaciones próximas activas'), findsOneWidget);

    // 2. Navegar a la pestaña de "Empresas"
    await tester.tap(find.byIcon(Icons.business_outlined));
    await tester.pump(const Duration(milliseconds: 500));

    // Verificar presencia de elementos en Empresas
    expect(find.text('Empresas Registradas'), findsOneWidget);
    expect(find.text('No hay empresas registradas'), findsOneWidget);

    // 3. Navegar a la pestaña de "Licitaciones"
    await tester.tap(find.byIcon(Icons.assignment_outlined));
    await tester.pump(const Duration(milliseconds: 500));

    // Verificar presencia de elementos en Licitaciones
    expect(find.text('Licitaciones de Seguridad'), findsOneWidget);
    expect(find.text('No hay licitaciones registradas'), findsOneWidget);
  });
}
