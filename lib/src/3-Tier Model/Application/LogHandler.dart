import 'package:flutter/cupertino.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/Response.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/Widgets/BodyWidgets.dart';

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

  bool inputsValid() {
    return bodyWidgets
        .every((bodyWidget) => bodyWidget.validateInput() == null);
  }

  // Refreshes response value for each question, called upon page navigation
  @required
  void setResponses() {
    int index = 0;
    questions.forEach((question) {
      var inputs = collectResponses();
      question.responseValue = inputs[index++];
    });
  }

  Future<bool> checkLog(
      String className, String columnName, bool Function(dynamic) test) async {
    var currentValue = await ParseServer.request(className, columnName);
    return test(currentValue);
  }

  // Individual pages handle exactly where to store
  @required
  void storeUserInfo(String className) {
    questions.forEach((question) {
      print(question.logKey);
      print(question.responseValue);
      ParseServer.store(className, question.logKey, question.response);
    });
  }
}
