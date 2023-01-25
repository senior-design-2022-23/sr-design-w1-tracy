import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../login/presentation/login.dart';

Future doUserLogin(username, password) async {
  final user = ParseUser(username, password, null);
  await user.login();
}

Future<String> registerUserByGoogle(String first, String last) async {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  try {
    await googleSignIn.signIn();
  } catch (error) {
    return error.toString();
  }
  if (await googleSignIn.isSignedIn()) {
    final user = ParseUser.createUser(googleSignIn.currentUser?.displayName,
        googleSignIn.currentUser?.id, googleSignIn.currentUser?.email);
    user.set("firstName", first);
    user.set("lastName", last);
    var response = await user.signUp();
    if (response.success) {
      return "Success!";
    } else {
      return response.error!.message;
    }
  }
  return "Unable to sign up with Google.";
}

Future<String> loginWithGoogle(String first, String last) async {
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
  return "Unable to sign up with Google.";
}
