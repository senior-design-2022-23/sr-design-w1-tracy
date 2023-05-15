import 'package:flutter/cupertino.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/Response.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';

class LogHandler {
  List<QuestionResponse> questions =
      []; // QuestionResponses are strictly for logging logic
  List<BodyWidget> bodyWidgets =
      []; // BodyWidgets can display questions and validate input based on question

  void setQuestions(List<QuestionResponse> emptyResponseQuestions) {
    questions = emptyResponseQuestions;
  }

  // Typical collection case, pages may vary
  List<dynamic> collectResponses() {
    return bodyWidgets.map((widget) => widget.input).toList();
  }

  // Refreshes response value for each question, called upon page navigation
  @required
  void setResponses() {
    int index = 0;
    questions.forEach((question) {
      print(question.referenceName);
      var inputs = collectResponses();
      question.responseValue = inputs[index++];
    });
  }

  // Individual pages handle exactly where to store
  @required
  void storeUserInfo() {
    questions.forEach((question) {
      ParseServer.store("UserInfo", question.logKey, question.response);
    });
  }
}
