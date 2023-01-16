

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../shared/userFunctions.dart';

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

  Future storeSleepHours(hours) async {
    ParseUser? user = await getCurrentUser();
    if(user != null) {
      var obj = ParseObject('UserInfo')
        ..set('UserObj', user.objectId)
        ..set('SleepInfo', hours);
      await obj.save();
    }
  }
}




