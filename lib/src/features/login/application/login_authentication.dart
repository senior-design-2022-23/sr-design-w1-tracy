
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../login/presentation/login.dart';

Future doUserLogin(username, password) async {
  final user = ParseUser(username, password, null);
  var response = await user.login();
  print(response.results);

}