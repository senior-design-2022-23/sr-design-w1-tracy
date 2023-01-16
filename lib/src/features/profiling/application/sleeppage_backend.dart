

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../shared/userFunctions.dart';

Future storeSleepHours(hours) async {
   ParseUser? user = await getCurrentUser();
    if(user != null) {
      var obj = ParseObject('UserInfo')
        ..set('UserObj', user.objectId)
        ..set('SleepInfo', hours);
      await obj.save();
    }
  }




