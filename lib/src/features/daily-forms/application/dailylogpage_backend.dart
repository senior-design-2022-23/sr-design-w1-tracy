

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../shared/userFunctions.dart';
import '../../login/application/login_authentication.dart';

Future<List<String>> getChosenQuestions() async {
  //TODO: this line is for testing purposes. Remove when pages linked.
  await doUserLogin('kbhuwalk@gmail.com', 'Kush1234');

  ParseUser? user = await getCurrentUser();
  if(user == null) {
    return [];
  }
  QueryBuilder<ParseObject> queryUsers = QueryBuilder<ParseObject>(ParseObject('UserInfo'))
    ..whereEqualTo('UserObj', user.objectId);
  final ParseResponse parseResponse = await queryUsers.query();
  if (parseResponse.success && parseResponse.results != null) {
    var obj = (parseResponse.results!.first) as ParseObject;
    List<dynamic> array = obj.get('questionsChosen') ?? [];
    List<String> arrayStr = array.cast<String>();
    return arrayStr;
  }
  return [];
}

Future setAnswers(List<String> answers) async {
  //TODO: this line is for testing purposes. Remove when pages linked.
  await doUserLogin('kbhuwalk@gmail.com', 'Kush1234');

  ParseUser? user = await getCurrentUser();
  if(user == null) {
    return;
  }
  QueryBuilder<ParseObject> queryUsers = QueryBuilder<ParseObject>(ParseObject('UserInfo'))
    ..whereEqualTo('UserObj', user.objectId);
  final ParseResponse parseResponse = await queryUsers.query();
  if (parseResponse.success && parseResponse.results != null) {
    var obj = (parseResponse.results!.first) as ParseObject;
    obj.set('answers', answers);
    obj.save();
  }

}






