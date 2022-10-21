import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignInAccount? _currentUser;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}

Future<void> _handleSignOut() => _googleSignIn.disconnect();

void googleSignIn() {
  _handleSignIn();
  _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    _currentUser = account;
  });
  print(_currentUser);
}

void googleSignOut() {
  _handleSignOut();
}
