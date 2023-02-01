import 'package:google_sign_in/google_sign_in.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

Future doUserLogin(username, password) async {
  final user = ParseUser(username, password, null);
  print(username);
  await user.login();
}

Future<String> loginWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
      serverClientId: 'GYMIP6tfliC7C4s2HpUouH1MQkffo6WvXCnDu7uQ',
      clientId: '11511470133-uv8gt8n2645mg41ttp2igeqso1550ckr.apps.googleusercontent.com');
  try {
    await googleSignIn.signIn();
    print("did");
    final user = ParseUser(googleSignIn.currentUser?.displayName, googleSignIn.currentUser?.id, null);
    print(user.username);
    await user.login();
  } catch (error) {
    return error.toString();
  }
  return "Unable to sign in with Google.";
}
