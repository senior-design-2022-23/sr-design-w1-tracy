import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../login/presentation/login.dart';

Future doUserLogin(username, password) async {
  final user = ParseUser(username, password, null);
  await user.login();
}

Future<String> loginWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  try {
    await googleSignIn.signIn();
  } catch (error) {
    return error.toString();
  }
  if (await googleSignIn.isSignedIn()) {
    await doUserLogin(
        googleSignIn.currentUser?.displayName, googleSignIn.currentUser?.id);
  }
  return "Unable to sign in with Google.";
}
