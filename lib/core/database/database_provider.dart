import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'isar_service.dart';

/// Proveedor para acceder a la instancia única de IsarService.
/// Se sobreescribe en el punto de entrada de la aplicación (`main.dart`)
/// después de realizar la inicialización asíncrona de Isar.
final isarServiceProvider = Provider<IsarService>((ref) {
  throw UnimplementedError('El isarServiceProvider debe ser sobreescrito en ProviderScope');
});
