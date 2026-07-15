import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  AuthNotifier() : super(UserAuthState()) {
    try {
      state = UserAuthState(user: Supabase.instance.client.auth.currentUser);
      // Listen to changes in Supabase authentication state
      Supabase.instance.client.auth.onAuthStateChange.listen((data) {
        state = UserAuthState(user: data.session?.user);
      });
    } catch (e) {
      debugPrint('Supabase initialization bypassed/failed (expected in tests): $e');
    }
  }

  /// Initiates the Google Sign-In flow and registers the credentials with Supabase.
  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      const webClientId = String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');

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
  return AuthNotifier();
});
