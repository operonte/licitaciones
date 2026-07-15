import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../../empresas/presentation/providers/empresas_provider.dart';
import '../../../establecimientos/presentation/providers/establecimientos_provider.dart';
import '../../../licitaciones/presentation/providers/licitaciones_provider.dart';
import '../../../visitas/presentation/providers/visitas_provider.dart';
import '../../../tareas/presentation/providers/tareas_provider.dart';

/// Class representing the state of the user authentication.
class UserAuthState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;
  final bool isGuest;

  UserAuthState({this.user, this.isLoading = false, this.errorMessage, this.isGuest = false});

  /// Whether the user is authenticated (either logged in or guest mode).
  bool get isAuthenticated => user != null || isGuest;

  UserAuthState copyWith({User? user, bool? isLoading, String? errorMessage, bool? isGuest}) {
    return UserAuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isGuest: isGuest ?? this.isGuest,
    );
  }
}

/// Notifier to handle authentication lifecycle with Google and Supabase.
class AuthNotifier extends StateNotifier<UserAuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(UserAuthState()) {
    try {
      final currentUser = Supabase.instance.client.auth.currentUser;
      state = UserAuthState(user: currentUser);
      
      if (currentUser != null) {
        // Trigger background sync on startup if already logged in
        Future.microtask(() => _triggerSync());
      }

      // Listen to changes in Supabase authentication state
      Supabase.instance.client.auth.onAuthStateChange.listen((data) {
        final previousUser = state.user;
        final newUser = data.session?.user;
        state = UserAuthState(user: newUser);

        // If a user just logged in, trigger synchronization
        if (previousUser == null && newUser != null) {
          _triggerSync();
        }
      });
    } catch (e) {
      debugPrint('Supabase initialization bypassed/failed (expected in tests): $e');
    }
  }

  Future<void> _triggerSync() async {
    try {
      await ref.read(syncServiceProvider).syncAll();
      // Reload all providers to pull local changes into state
      await ref.read(empresasProvider.notifier).cargarEmpresas();
      await ref.read(establecimientosProvider.notifier).cargarEstablecimientos();
      await ref.read(licitacionesProvider.notifier).cargarLicitaciones();
      await ref.read(visitasProvider.notifier).cargarVisitas();
      await ref.read(tareasProvider.notifier).cargarTareas();
    } catch (e) {
      debugPrint('Error en la sincronización tras login/inicio: $e');
    }
  }

  /// Initiates the Google Sign-In flow and registers the credentials with Supabase.
  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      const webClientId = String.fromEnvironment(
        'GOOGLE_WEB_CLIENT_ID',
        defaultValue: '364331814995-3uq6g8il27b5uvtt450efqg8qnvkc7er.apps.googleusercontent.com',
      );

      // Initialize GoogleSignIn singleton instance
      await GoogleSignIn.instance.initialize(
        clientId: kIsWeb ? webClientId : null,
        serverClientId: webClientId.isNotEmpty ? webClientId : null,
      );

      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('No se pudo obtener el ID Token de Google.');
      }

      await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  /// Sign out from Supabase and Google.
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    try {
      if (!state.isGuest) {
        await Supabase.instance.client.auth.signOut();
        try {
          await GoogleSignIn.instance.signOut();
        } catch (_) {}
      }
      state = UserAuthState(); // Reset to logged-out state
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  /// Skip login and enter as guest.
  void skipLogin() {
    state = UserAuthState(isGuest: true);
  }
}

/// Provider to access authentication state and triggers.
final authProvider = StateNotifierProvider<AuthNotifier, UserAuthState>((ref) {
  return AuthNotifier(ref);
});
