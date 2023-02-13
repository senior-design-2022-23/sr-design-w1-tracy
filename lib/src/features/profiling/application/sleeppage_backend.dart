

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../shared/userFunctions.dart';
import '../../login/application/login_authentication.dart';

Future<bool> storeSleepHours(hours, regular) async {
  //TODO: this line is for testing purposes. Remove when pages linked.
  await doUserLogin('kbhuwalk@gmail.com', 'Kush1234');

  ParseUser? user = await getCurrentUser();
  if(user == null) {
    return false;
  }
  QueryBuilder<ParseObject> queryUsers = QueryBuilder<ParseObject>(ParseObject('UserInfo'))
    ..whereEqualTo('UserObj', user.objectId);
  final ParseResponse parseResponse = await queryUsers.query();
  if (parseResponse.success && parseResponse.results != null) {
    var obj = (parseResponse.results!.first) as ParseObject;
      obj.set('SleepInfo', hours);
      obj.set('isRegular', regular);

    List<dynamic> array = obj.get('questions') ?? [];
    String sleepQuestion = 'How many hours did you sleep last night?';
    if ((regular != 'T' || hours < 8) && !array.contains(sleepQuestion)) {
      array.add(sleepQuestion);
    }
    obj.set('questions', array);
    await obj.save();
    return true;
  }
  return false;
}


