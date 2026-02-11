import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();
  final LoggerService _loggerService = GetIt.I<LoggerService>();

  User getSignedInUser() {
    if(_client.auth.currentUser == null) {
      throw Exception('No user is currently signed in.');
    }
    return _client.auth.currentUser!;
  }

  String getSignedInUserId() => getSignedInUser().id;

  bool get userIsSignedIn => _client.auth.currentUser != null;

  Future signInWithGoogle() async {
    try {
      const iosClientId =
          '381902294075-k4u2q9s5o3pa387s8ik2t7r0jepjkiss.apps.googleusercontent.com';
      const serverClientId =
          '381902294075-l89s5kr3vp025i7qhk3o978hna3qmnrf.apps.googleusercontent.com';

      final GoogleSignIn signIn = GoogleSignIn.instance;

      await signIn.initialize(
        clientId: iosClientId,
        serverClientId: serverClientId,
      );

      final GoogleSignInAccount googleUser;
      try {
        googleUser = await GoogleSignIn.instance.authenticate();
      } catch (e) {
        rethrow;
      }

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      final response = await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken!,
      );

      final currentSession = _client.auth.currentSession;
      final currentUser = _client.auth.currentUser;

      var sub = _client.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;

        switch (event) {
          case AuthChangeEvent.signedIn:
            print("User Signed In: ${session?.user.email}");
            // Redirect to Home
            break;
          case AuthChangeEvent.signedOut:
            print("User Signed Out");
            // Redirect to Login
            break;
          case AuthChangeEvent.tokenRefreshed:
            print("Token was refreshed automatically");
            break;
          default:
            break;
        }
      });
    } catch (e, s) {
      _loggerService.logException(
        exception: e,
        featureArea: 'SessionService.signInWithGoogle',
        stackTrace: s,
      );

      rethrow;
    }
  }
}
