

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../shared/userFunctions.dart';
import '../../login/application/login_authentication.dart';

Future<List<String>> getQuestions() async {
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
    List<dynamic> array = obj.get('questions') ?? [];
    List<String> arrayStr = array.cast<String>();
    return arrayStr;
  }
  return [];
}

Future<List<List<String>>> getAllQuestions() async {

  QueryBuilder<ParseObject> queryQuestions = QueryBuilder<ParseObject>(ParseObject('Questions'));
  final ParseResponse parseResponse = await queryQuestions.query();
  if (parseResponse.success && parseResponse.results != null) {
    List<ParseObject> obj = (parseResponse.results) as List<ParseObject>;
    List<dynamic> allQuestions = [];
    List<String> priQuestions = await getQuestions();
    for (ParseObject q in obj) {
        allQuestions.add(q.get('question'));
      }
    List<String> allQuestionsString = allQuestions.cast<String>();
    for(String q in priQuestions) {
      if(allQuestionsString.contains(q)) {
        allQuestionsString.remove(q);
      }
    }
    List<List<String>> finalList = [];
    finalList.add(allQuestionsString);
    finalList.add(priQuestions);
    return finalList;
  }
  return [];
}

Future setQuestions(List<String> setQ) async {
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
    obj.set('questions', setQ);
    obj.save();
  }
  return [];
}





