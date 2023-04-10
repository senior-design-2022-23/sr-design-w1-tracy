import 'package:flutter/cupertino.dart';

class BodyWidget {
  final String question;
  late dynamic response;
  final Widget widget;
  BodyWidget(this.question, this.widget);

  Widget getWidget() {
    return widget;
  }
  String getQuestion() {
    return question;
  }
  
  dynamic getResponse() {
    return response;
  }

  void setResponse(response) {
    this.response = response;
  }
}