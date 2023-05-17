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

class DailyLogFlow {
  List<Page> pages = [];
  List<QuestionResponse> questions = [];
  List<BodyWidget> bodyWidgets = [];
  List<Widget> widgets = [];
  NavigationController controller;

  DailyLogFlow(this.controller) {
    createTransitionPages();
  }

  void createTransitionPages() {
    populateQuestions();
    createBodyWidgets();

    var pageIndex = 0;
    while ((widgets.length - pageIndex * 6) % 6 == 0 &&
        (widgets.length - pageIndex * 6) >= 6) {
      List<Widget> widgetSubset =
          widgets.sublist(pageIndex * 6, pageIndex * 6 + 6);
      pages.add(_IndividualLogPage([], widgetSubset, controller));
      pageIndex += 1;
    }
  }

  void populateQuestions() {
    questions.add(QuestionResponse(
        UserInputType.text, "Medications", "medications",
        questionText: "How many hours did you sleep last night?"));
    questions.add(QuestionResponse(
        UserInputType.text, "Medications", "medications",
        questionText: "How many meals did you consume yesterday?"));
    questions.add(QuestionResponse(
        UserInputType.text, "Medications", "medications",
        questionText: "How many hours of exercise did you complete?"));
  }

  void createBodyWidgets() {
    questions.forEach((question) {
      print(question.questionText);
      switch (question.type) {
        case UserInputType.text:
          widgets.add(WidgetConstructor.createText(question.questionText!));
          var q = WidgetConstructor.createQuestion("Enter Text Here");
          widgets.add(q);
          bodyWidgets.add(q);
          break;
        case UserInputType.numeric:
          widgets.add(WidgetConstructor.createText(question.questionText!));
          var q = WidgetConstructor.createQuestion("Enter Here");
          widgets.add(q);
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

class _IndividualLogPage extends Page {
  List<Widget> pageWidgets;
  List<BodyWidget> bodyWidgets = [];
  _IndividualLogPage(
      this.bodyWidgets, this.pageWidgets, NavigationController controller) {
    Map<Widget?, double> spacingConfig = {
      pageWidgets[0]: 30,
      pageWidgets[1]: 0,
      pageWidgets[2]: 30,
      pageWidgets[3]: 0,
      pageWidgets[4]: 30,
      pageWidgets[5]: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage);
    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }
}
