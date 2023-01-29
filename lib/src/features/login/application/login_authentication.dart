import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

Future doUserLogin(username, password) async {
  final user = ParseUser(username, password, null);
  print(username);
  await user.login();
}

Future<String> loginWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    await doUserLogin(googleUser?.displayName, googleUser?.id);
  } catch (error) {
    return error.toString();
  }
  return "Unable to sign in with Google.";
}
