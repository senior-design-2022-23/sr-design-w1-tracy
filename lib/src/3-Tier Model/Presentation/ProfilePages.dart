import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/TemplatePage.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';

class PersonalInfoPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  PersonalInfoPage() {
    Widget heightText = WidgetConstructor.createText("Height");
    BodyWidget heightFields =
        WidgetConstructor.createDoubleQuestion("ft", "in", "height");
    Widget widthText = WidgetConstructor.createText("Weight");
    BodyWidget widthFields = WidgetConstructor.createQuestion("lbs", "weight");
    Widget sexText = WidgetConstructor.createText("Sex");
    BodyWidget sexOptions = WidgetConstructor.createToggleOptions(
        0, ['N/A', 'Male', 'Female'], "sex");
    bodyWidgets = [heightFields, widthFields, sexOptions];
    Map<Widget?, double> spacingConfig = {
      heightText: 30,
      heightFields: 0,
      widthText: 20,
      widthFields: 0,
      sexText: 20,
      sexOptions: 5
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
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
}

class ActivityPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  ActivityPage() {
    Widget exerciseText =
        WidgetConstructor.createText("How often do you exercise?");
    BodyWidget exerciseFields = WidgetConstructor.createDropDown([
      'None (0x)',
      'Little or Rarely (1-2x)',
      'Often (3-4x)',
      'Frequently (5-6x)',
      'Everyday (>=7x)'
    ], "exercise");
    Widget waterText = WidgetConstructor.createText(
        "Approximately how many bottles of water do you drink a day?");
    BodyWidget waterFields = WidgetConstructor.createDropDown([
      'Unsure',
      '1-2 bottles',
      '3-4 bottles',
      '5-6 bottles',
      '7-8 bottles',
      '9-10 bottles',
      '10+ bottles',
    ], "water");

    bodyWidgets = [exerciseFields, waterFields];
    Map<Widget?, double> spacingConfig = {
      exerciseText: 30,
      exerciseFields: 0,
      waterText: 20,
      waterFields: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
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
}

class DietFrequencyPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  DietFrequencyPage() {
    Widget dietFreqText = WidgetConstructor.createText("How often do you eat?");
    BodyWidget frequencyFields = WidgetConstructor.createDropDown(
        ['1-2x/day', '3-4x/day', '5-6x/day', '>6x/day', 'It depends'], "");
    Widget dietFreqText = WidgetConstructor.createText("Do y?");
    BodyWidget frequencyFields = WidgetConstructor.createDropDown(
        ['1-2x/day', '3-4x/day', '5-6x/day', '>6x/day', 'It depends'], "");
    bodyWidgets = [frequencyFields];
    Map<Widget?, double> spacingConfig = {
      dietFreqText: 30,
      frequencyFields: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
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
}
