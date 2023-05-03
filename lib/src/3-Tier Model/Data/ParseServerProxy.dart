
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../shared/userFunctions.dart';

class ParseServer {

  static Future<ParseUser> getUser(username, password) async {
    final user = ParseUser(username, password, null);
    return user;
  }

  static Future<ParseUser> currentUser() async {
    return await ParseUser.currentUser();
  }

  static Future<ParseObject?> request(objectTable, tableColumn, info) async {
    ParseUser? user = await currentUser();
    QueryBuilder<ParseObject> queryUsers = QueryBuilder<ParseObject>(
        ParseObject(objectTable))
        ..whereEqualTo(tableColumn, info);
    final ParseResponse parseResponse = await queryUsers.query();
    if (parseResponse.success && parseResponse.results != null) {
      var obj = (parseResponse.results) as ParseObject;
      return obj.get(info);
    }
    return null;
  }

  static void store(objectTable, info, data) async {
    ParseUser? user = await currentUser();
    QueryBuilder<ParseObject> queryUsers = QueryBuilder<ParseObject>(
        ParseObject(objectTable))
      ..whereEqualTo('UserObj', user.objectId);
    final ParseResponse parseResponse = await queryUsers.query();
    if (parseResponse.success && parseResponse.results != null) {
      var obj = (parseResponse.results) as ParseObject;
      obj.set(info, data);
    }
  }

}