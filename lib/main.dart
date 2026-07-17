import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/database/isar_service.dart';
import 'core/database/database_provider.dart';
import 'core/notifications/notification_service.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';
import 'features/empresas/presentation/screens/empresas_list_screen.dart';
import 'features/licitaciones/presentation/screens/licitaciones_list_screen.dart';
import 'features/visitas/presentation/screens/visitas_list_screen.dart';
import 'features/tareas/presentation/screens/tareas_list_screen.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'core/navigation/navigation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().initialize();

  // Inicializar Supabase
  try {
    await Supabase.initialize(
      url: const String.fromEnvironment('SUPABASE_URL', defaultValue: 'https://kggcwobqdpygaxwzygqb.supabase.co'),
      anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtnZ2N3b2JxZHB5Z2F4d3p5Z3FiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODM5ODYyNzgsImV4cCI6MjA5OTU2MjI3OH0.OQQ6GwcPHTwFXN3756oO-g5OmFa_yJ4JSIJP6cZrHRY'),
    );
  } catch (e) {
    debugPrint('Error al inicializar Supabase: $e');
  }

  final isarService = await IsarService.inicializar();

  runApp(
    ProviderScope(
      overrides: [
        // Sobreescribir el proveedor para inyectar la instancia de Isar inicializada
        isarServiceProvider.overrideWithValue(isarService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Licitaciones CRM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: authState.isAuthenticated ? const MainNavigationScreen() : const LoginScreen(),
    );
  }
}


class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    final List<Widget> screens = const [
      DashboardScreen(),
      EmpresasListScreen(),
      VisitasListScreen(),
      TareasListScreen(),
      LicitacionesListScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          ref.read(navigationIndexProvider.notifier).state = index;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.business_outlined),
            selectedIcon: Icon(Icons.business),
            label: 'Empresas',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_walk_outlined),
            selectedIcon: Icon(Icons.directions_walk),
            label: 'Visitas',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: 'Tareas',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Licitaciones',
          ),
        ],
      ),
    );
  }
}
