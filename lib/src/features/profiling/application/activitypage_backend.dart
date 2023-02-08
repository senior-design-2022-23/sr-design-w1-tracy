import 'package:migraine_aid/src/features/login/application/login_authentication.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../../../shared/userFunctions.dart';

Future<bool> storeActivity(gym, water, List<String> waterQuestion) async {

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
    if (gym != 'None (0x)') {
      List<dynamic> array = obj.get('questions') ?? [];
      array.add('Did you go to the gym today?');
      obj.set('questions', array);
    } //TODO: What if they change settings?

    if(waterQuestion.indexOf(water) < 7) {
      List<dynamic> array = obj.get('questions') ?? [];
      array.add('How much water did you drink today?');
      obj.set('questions', array);
    }
    await obj.save();
    return true;
  }
  return false;
}
