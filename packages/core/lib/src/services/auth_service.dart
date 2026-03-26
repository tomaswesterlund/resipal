import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:core/lib.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();
  final LoggerService _loggerService = GetIt.I<LoggerService>();

  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;
  User? get currentUser => _client.auth.currentUser;

  User getSignedInUser() {
    if (currentUser == null) {
      throw Exception('No user is currently signed in.');
    }
    return currentUser!;
  }

  String getSignedInUserId() => getSignedInUser().id;
  bool get userIsSignedIn => currentUser != null;
  Session? get currentSession => _client.auth.currentSession;
  Future refreshSession() async => await _client.auth.refreshSession();

  Future<AuthResponse> signInWithIdToken({required String idToken}) async {
    return await _client.auth.signInWithIdToken(provider: OAuthProvider.google, idToken: idToken);
  }

  Future<AuthResponse> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );

      final idToken = credential.identityToken;
      if (idToken == null) throw Exception('Apple ID Token is null');

      // EXTREMELY IMPORTANT: This is what actually logs the user into Supabase
      return await _client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: null, // Only needed if you manually generated one
      );
    } catch (e, s) {
      _loggerService.error(exception: e, featureArea: 'AuthService.signInWithApple', stackTrace: s);
      rethrow;
    }
  }

  Future signInWithGoogle() async {
    try {
      final config = GetIt.I<AuthServiceConfig>();
      final GoogleSignIn signIn = GoogleSignIn.instance;

      await signIn.initialize(clientId: config.iosClientId, serverClientId: config.serverClientId);

      final googleUser = await signIn.authenticate();
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) throw Exception('Google ID Token is null');

      // This call will trigger the onAuthStateChange stream automatically
      await signInWithIdToken(idToken: idToken);
    } catch (e, s) {
      _loggerService.error(exception: e, featureArea: 'AuthService.signInWithGoogle', stackTrace: s);
      rethrow;
    }
  }

  Future signout() async => await _client.auth.signOut(scope: SignOutScope.global);
}

class AuthServiceConfig {
  final String iosClientId;
  final String serverClientId;

  AuthServiceConfig({required this.iosClientId, required this.serverClientId});
}
