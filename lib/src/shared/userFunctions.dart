import 'package:flutter/material.dart';
import 'package:migraine_aid/src/shared/sharedWidgets.dart';
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

showError(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Stack(children: [
          Container(
            color: Colors.black54,
          ),
          Center(
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ErrorPopup(
                  errorMessage: message),
            ),
          )
        ]);
      });
}
Future<ParseUser?> getCurrentUser() async {
  if (await hasUserLogged()) {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  } else {
    return null;
  }
}

  Future <String> getCurrentUserName() async {
  if(await hasUserLogged()) {
    ParseObject? currentUser = await ParseUser.currentUser() as ParseObject?;
    print('name: ' + currentUser?.get('firstName'));
    return currentUser?.get('firstName');
  }else {
    return '';
  }
void goToPage(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
