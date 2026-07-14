import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'isar_service.dart';
import 'sync_service.dart';

/// Proveedor para acceder a la instancia única de IsarService.
/// Se sobreescribe en el punto de entrada de la aplicación (`main.dart`)
/// después de realizar la inicialización asíncrona de Isar.
final isarServiceProvider = Provider<IsarService>((ref) {
  throw UnimplementedError('El isarServiceProvider debe ser sobreescrito en ProviderScope');
});

/// Proveedor para la instancia del cliente de Supabase
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Proveedor para el SyncService
final syncServiceProvider = Provider<SyncService>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  final supabase = ref.watch(supabaseClientProvider);
  return SyncService(isarService: isarService, supabase: supabase);
});
