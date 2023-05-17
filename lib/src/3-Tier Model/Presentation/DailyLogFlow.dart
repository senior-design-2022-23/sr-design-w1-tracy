import 'package:flutter/material.dart' hide Page;
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/Response.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/TemplatePage.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';

import '../Application/Adapters/modelViewerAdapter.dart';
import '../Application/NavigationService.dart';
import '../Application/PageSetBuilder.dart';

class DailyLogFlow extends Page with LogHandler {
  List<Page> pages = [];
  NavigationController controller;

  DailyLogFlow(this.controller) {
    int _currQuestion = 0;
    List<String> _answers = List<String>.filled(0, '');
    populateQuestions();

  }

  void createTransitionPage() {
    for(int i=0; i<questions.length; i+3) {
      List<QuestionResponse> qrs = [questions[i]];
        if(questions.length < i + 1) {
          qrs.add(questions[i+1]);
          qrs.add(questions[i+2]);
        }
        pages.add(_IndividualLogPage(qrs, controller));
    }
  }
  
  void populateQuestions() {
    questions.add(
        QuestionResponse(UserInputType.text, "Medications", "medications", questionText: "How many hours did you sleep last night?"));
    questions.add(
        QuestionResponse(UserInputType.text, "Medications", "medications", questionText: "How many meals did you consume yesterday?"));
    questions.add(
        QuestionResponse(UserInputType.text, "Medications", "medications", questionText: "How many hours of exercise did you complete?"));    
    
    setQuestions(questions);
  }

}

class _IndividualLogPage extends Page with LogHandler {

  List<QuestionResponse> qr;
  List<Widget> allWidgets = [];

  _IndividualLogPage(this.qr, NavigationController controller) {
    Map<Widget?, double> spacingConfig = {
      allWidgets[0]: 30,
      allWidgets[1]: 0,
      allWidgets[2]: 30,
      allWidgets[3]: 0,
      allWidgets[4]: 30,
      allWidgets[5]: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage);
    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }

  void createBodyWidgets() {
    qr.forEach((widget) {
      switch(widget.type) {
        case UserInputType.text:
          allWidgets.add(WidgetConstructor.createText(widget.questionText!));
          var q =  WidgetConstructor.createQuestion("");
          allWidgets.add(q);
          bodyWidgets.add(q);
          break;
        case UserInputType.numeric:
          allWidgets.add(WidgetConstructor.createText(widget.questionText!));
          var q =  WidgetConstructor.createQuestion("");
          allWidgets.add(q);
          bodyWidgets.add(q);
          break;
        case UserInputType.toggle: 
          // TODO: Handle this case.
          break;
        case UserInputType.list:
          // TODO: Handle this case.
          break;
        case UserInputType.height:
          // TODO: Handle this case.
          break;
        case UserInputType.weight:
          // TODO: Handle this case.
          break;
        case UserInputType.date:
          // TODO: Handle this case.
          break;
      }
    });
  }

}