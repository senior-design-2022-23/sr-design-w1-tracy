import 'package:google_sign_in/google_sign_in.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email', 'openid', 'profile'],
  );

  // Sign up with email and password
  Future<String?> signUp(
      {required String email,
      required String password,
      String? firstName,
      String? lastName}) async {
    try {
      final user = await ParseServer.getUser(email, password); // USERNAME NOT NEEDED
      if (firstName != null && lastName != null) {
        user.set("firstName", firstName);
        user.set("lastName", lastName);
      }
      var response = await user.signUp();
      if (response.success) {
        return "Success!";
      } else {
        return response.error!.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Log in with email and password
  Future<String?> logIn(
      {required String email, required String password}) async {
    try {
      final user = await ParseServer.getUser(email, password);
      final response = await user.login();
      if (response.success) {
        return null;
      } else {
        return response.error!.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Log in with Google
  Future<String?> logInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      if (googleAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleAccount.authentication;
        return await logIn(
            email: googleAccount.email, password: googleAccount.id);
      }
    } catch (error) {
      print("Unable to sign in with Google.");
      return error.toString();
    }
  }

  // Log out
  Future<void> logOut() async {
    await _googleSignIn.signOut();
    ParseUser user = await ParseServer.currentUser();
    user.logout();
  }
}
