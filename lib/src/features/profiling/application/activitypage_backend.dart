import 'package:migraine_aid/src/features/login/application/login_authentication.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../../../shared/userFunctions.dart';

Future<bool> storeActivity(gym, water, List<String> waterQuestion) async {
  String askGym = 'Did you go to the gym today?';
  String askWater = 'How many bottles of water did you drink today?';

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
    List<dynamic> array = obj.get('questions') ?? [];

    if (gym != 'None (0x)' && !array.contains(askGym)) {
      array.add(askGym);
    }
    if(waterQuestion.indexOf(water) < 4 && !array.contains(askWater)) {
      array.add(askWater);
    }
    obj.set('questions', array);
    await obj.save();
    return true;
  }
  return false;
}
