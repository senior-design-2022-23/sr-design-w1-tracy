// ignore_for_file: file_names

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple'

Future<String> registerUserByEmail(String username, String email, String pass,
    String first, String last) async {
  final user = ParseUser.createUser(username, pass, email);
  user.set("firstName", first);
  user.set("lastName", last);
  var response = await user.signUp();
  if (response.success) {
    return "Success!";
  } else {
    return response.error!.message;
  }
}

Future<String> registerUserByGoogle(String first, String last) async {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  try {
    await googleSignIn.signIn();
  } catch (error) {
    return error.toString();
  }
  if (await googleSignIn.isSignedIn()) {
    final user = ParseUser.createUser(googleSignIn.currentUser?.email,
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

// Future<String> registerUserThroughApple(String first, String last) async {
//   return "Unable to sign up with Apple. Please try again later or sign up using"
//       "a different method.";
// }