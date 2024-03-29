import 'package:migraine_aid/src/features/login/application/login_authentication.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../../../shared/userFunctions.dart';

Future<bool> storeAlcohol(daysDrank, alcDay) async {
  //TODO: remove next line when pages linked.
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
    obj..set('DaysDrank', daysDrank)
      ..set('AlcoholOnDay', alcDay);

    List<dynamic> array = obj.get('questions') ?? [];
    List<String> alcoholQuestion = ['Did you consume any alcohol today', 'How much alcohol did you drink today?'];
    if (alcoholQuestion[0] != 'None (0x)' && !array.contains(alcoholQuestion[0])) {
      array.add(alcoholQuestion[0]);
      array.add(alcoholQuestion[1]);
    }
    obj.set('questions', array);
    await obj.save();
    return true;
  }
  return false;
}
