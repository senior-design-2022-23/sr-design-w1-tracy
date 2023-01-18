import 'package:migraine_aid/src/features/login/application/login_authentication.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../../../shared/userFunctions.dart';

Future<bool> storeActivity(gym, water) async {

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
    obj..set('Gym_Time', gym)
       ..set('Water_Time', water);
    await obj.save();
    return true;
  }
  return false;
}
