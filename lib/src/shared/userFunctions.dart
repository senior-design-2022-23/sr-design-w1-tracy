import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

Future<bool> hasUserLogged() async {
  ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
  if (currentUser == null) {
    return false;
  }
  //Checks whether the user's session token is valid
  final ParseResponse? parseResponse =
      await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

  if (parseResponse?.success == null || !parseResponse!.success) {
    //Invalid session. Logout
    await currentUser.logout();
    return false;
  } else {
    return true;
  }
}

Future<ParseUser?> getCurrentUser() async {
  if (await hasUserLogged()) {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  } else {
    return null;
  }
}

void goToPage(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
