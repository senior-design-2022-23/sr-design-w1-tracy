

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

Future<List<ParseObject>> doUserQuery() async {
  QueryBuilder<ParseUser> queryUsers =
  QueryBuilder<ParseUser>(ParseUser.forQuery());
  final ParseResponse apiResponse = await queryUsers.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results as List<ParseObject>;
  } else {
    return [];
  }
}


Future storeSleepHours(hours) async {
  // TODO: Change user function to get current user through ParseUser u = getCurrentUser()

  List<ParseObject> users = await doUserQuery();
    if(users != null) {
      ParseObject user = users.first;
      var obj = ParseObject('UserInfo')
        ..set('UserObj', user.objectId)
        ..set('SleepInfo', 2);
      await obj.save();
    }
}







