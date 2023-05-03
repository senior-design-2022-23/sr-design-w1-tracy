import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/TemplatePage.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';

import '../Application/NavigationService.dart';
import '../Application/Response.dart';

class DailyLogFactory {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  List<Map<Widget, double>> spacingConfigs = [];

  List<DailyLogPage> createDailyLogPages(NavigationController controller) {
    createPageSet(getQuestionInfo());
    int index = 0;
    List<DailyLogPage> pages = [];
    for (var spacingConfig in spacingConfigs) {
      pages.add(DailyLogPage(controller, spacingConfig, index++));
    }
    return pages;
  }

  List<List<Widget>> createPageSet(List<Question> questions) {
    // break list of widgets into a list of list of widgets
    List<Widget> widgets = createBodyWidgets(questions);
    List<List<Widget>> pageSet = [];
    for (int i = 0; i < widgets.length; i++) {
      if (i - widgets.length == 1) {
        List<Widget> page = [];
        page.add(widgets[i]);
        pageSet.add((page));
        break;
      }
      List<Widget> page = [];
      page.add(widgets[i]);
      page.add(widgets[i + 1]);
      pageSet.add((page));
      for (int j = 0; j < 2; j++) {
        Map<Widget, double> spacingConfig = {};
        if (questions[i + j].type == Type.number) {
          spacingConfig[widgets[i + j]] = 30;
        }
        if (questions[i + j].type == Type.toggle) {
          spacingConfig[widgets[i + j]] = 20;
        }
        spacingConfigs.add(spacingConfig);
      }
      i++;
    }

    return pageSet;
  }

  List<Question> getQuestionInfo() {
    Question q1 = Question(Type.toggle, 'Did you go to the gym today', '');
    Question q2 = Question(
        Type.number, 'How many bottles of water did you drink today?', '');
    List<Question> q = [];
    q.add(q1);
    q.add(q2);
    return q;
  }

  List<Widget> createBodyWidgets(List<Question> questions) {
    List<Widget> widgets = [];
    for (Question q in questions) {
      switch (q.type) {
        case Type.number:
          Widget numberQuestionText = WidgetConstructor.createText(q.value);
          BodyWidget numberQuestionTextFields =
              WidgetConstructor.createQuestion("", q.shorthand);
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

class DailyLogPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  List<Map<Widget, double>> spacingConfigs = [];
  DailyLogPage(NavigationController controller,
      Map<Widget, double> spacingConfig, int index) {
    List<Widget> spacedList =
        WidgetConstructor.addSpacing(spacingConfigs[index]);
    Widget finalBody;
    if (index == 0) {
      finalBody = WidgetConstructor.addUXWrap(
        spacedList,
        backLogic: () {},
        title: 'Daily Log',
      );
    } else {
      finalBody = WidgetConstructor.addUXWrap(
        spacedList,
        backLogic: controller.previousPage,
        title: 'Daily Log',
      );
    }

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
}
