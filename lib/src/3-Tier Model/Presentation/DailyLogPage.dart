import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/TemplatePage.dart';
import 'package:migraine_aid/src/features/daily-forms/application/dailylogpage_backend.dart';
import 'package:migraine_aid/src/features/profiling/application/userQuestionnaireBackend.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';

import '../Application/QuestionResponse.dart';


class DailyLogPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  DailyLogPage() {

    List<Question> questions = getQuestionInfo();
    List<List<Widget>> pageWidgets = createPageSet(questions);
    // Map<Widget?, double> spacingConfig = {
    //   heightText: 30,
    //   heightFields: 0,
    //   widthText: 20,
    //   widthFields: 0,
    //   sexText: 20,
    //   sexOptions: 5
    // };

    Widget finalBody = WidgetConstructor.addUXWrap(spacedList);

    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [ContinueButton(callback: () {})]);
  }

  TemplatePage getWidget() {
    return template;
  }

  @override
  void storeUserInfo() async {
    var questionMap = extractQuestionResponse(bodyWidgets);
    //Change questions to shorthand Back4App columnName
    questionMap.forEach((question, response) {
      ParseServer.store("UserInfo", question, response);
    });
  }

  List<List<Widget>> createPageSet(questions){  // break list of widgets into a list of list of widgets
    List<Widget> widgets = createBodyWidgets(questions);
    List<List<Widget>> pageSet = [];

    for(int i=0;i<widgets.length;i++) {
      List<Widget> page = [];
      page.add(widgets[i]);
      pageSet.add((page));
    }
    return pageSet;
  }

  List<Question> getQuestionInfo() {
    ParseObject o =
  }

  List<Widget> createBodyWidgets(List<Question> questions) {
    List<Widget> widgets = [];
    for(Question q in questions) {
      switch (q.type) {
        case Type.number:
          Widget numberQuestionText = WidgetConstructor.createText(q.value);
          BodyWidget numberQuestionTextFields = WidgetConstructor
              .createQuestion("", q.shorthand);
          widgets.add(numberQuestionText);
          widgets.add(numberQuestionTextFields);
          bodyWidgets.add(numberQuestionTextFields);
          break;
        case Type.toggle:
          Widget toggleText = WidgetConstructor.createText(q.value);
          BodyWidget options = WidgetConstructor.createToggleOptions(
              0, ['Yes', 'No'], q.shorthand);
          widgets.add(toggleText);
          widgets.add(options);
          bodyWidgets.add(options);
          break;
        default:
        // code to be executed if variable doesn't match any of the cases above
      }
    }
    return widgets;
  }
}