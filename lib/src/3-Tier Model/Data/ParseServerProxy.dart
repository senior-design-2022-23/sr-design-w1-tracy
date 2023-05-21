import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseServer {
  static Future<ParseUser?> getUser(username, password) async {
    var user = await ParseUser(username, password, null);
    final response = await user.login();
    if (response.success) {
      return response.result;
    } else {
      return null;
    }
  }

  static Future<dynamic> currentUser() async {
    return ParseUser.currentUser();
  }

  static Future<ParseObject?> requestUserClass(String className) async {
    ParseUser? user = await currentUser();
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(className))
          ..whereEqualTo("User", user);
    final ParseResponse response = await query.query();
    if (response.success && response.results != null) {
      var result = response.results as List<ParseObject>;
      if (result.isNotEmpty) {
        return result.first;
      }
    }
    return null;
  }

  static Future<dynamic> request(String className, String columnName) async {
    final ParseUser? user = await ParseUser.currentUser();
    if (user != null) {
      final ParseObject? classObject = await requestUserClass(className);
      if (classObject != null) {
        final dynamic value = classObject.get<dynamic>(columnName);
        return value;
      }
    }
    return null;
  }

  static void updateAndStore(String objectTable, String info, dynamic newData,
      dynamic Function(dynamic, dynamic) operation) async {
    ParseUser? user = await currentUser();
    QueryBuilder<ParseObject> queryUsers =
        QueryBuilder<ParseObject>(ParseObject(objectTable))
          ..whereEqualTo('UserObj', user!.objectId);
    final ParseResponse parseResponse = await queryUsers.query();
    if (parseResponse.success && parseResponse.results != null) {
      var obj = parseResponse.results as ParseObject;
      dynamic currentValue = obj.get(info);
      dynamic updatedValue = operation(currentValue, newData);
      obj.set(info, updatedValue);
      await obj.save();
    }
  }

  static void createIfNotExists(objectTable) async {
    ParseUser? user = await currentUser();
    QueryBuilder<ParseObject> queryUsers =
        QueryBuilder<ParseObject>(ParseObject(objectTable))
          ..whereEqualTo('UserObj', user!.objectId);
    final ParseResponse parseResponse = await queryUsers.query();

    if (parseResponse.success &&
        parseResponse.results != null &&
        parseResponse.results!.isNotEmpty) {
      // If a row already exists for the user, do nothing
    } else {
      // If no row exists for the user, create a new ParseObject for the user
      ParseObject obj = ParseObject(objectTable);
      obj.set('UserObj', user!.objectId);

      // Save the object to the database, creating a new row
      await obj.save();
    }
  }

  static void store(objectTable, info, data) async {
    ParseUser? user = await currentUser();
    QueryBuilder<ParseObject> queryUsers =
        QueryBuilder<ParseObject>(ParseObject(objectTable))
          ..whereEqualTo('UserObj', user!.objectId);
    final ParseResponse parseResponse = await queryUsers.query();

    ParseObject obj;
    if (parseResponse.success &&
        parseResponse.results != null &&
        parseResponse.results!.isNotEmpty) {
      // If a row already exists for the user, update it
      obj = (parseResponse.results!.first) as ParseObject;
    } else {
      // If no row exists for the user, create a new ParseObject for the user
      obj = ParseObject(objectTable);
      obj.set('UserObj', user!.objectId);
    }

    // Set the other data fields
    obj.set(info, data);

    // Save the object to the database, creating a new row if necessary
    await obj.save();
  }

  static Future<ParseUser?> createUser(
    String email,
    String password,
  ) async {
    final user = ParseUser.createUser(email, password, email);
    final response = await user.signUp();
    if (response.success) {
      return response.result;
    } else {
      return null;
    }
  }
}
