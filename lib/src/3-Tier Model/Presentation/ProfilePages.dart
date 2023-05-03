import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/TemplatePage.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';

class _TransitionPage extends LogHandler {
  final String _pageText;
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  _TransitionPage(this._pageText) {
    Widget transitionText =
        WidgetConstructor.createText(_pageText, fontSize: 50);
    Map<Widget?, double> spacingConfig = {
      transitionText: 30,
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
    UnimplementedError();
  }
}

class TransitionPageFactory {
  static LogHandler createTransitionPage(String largeText) {
    return _TransitionPage(largeText);
  }
}

class PersonalInfoPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  PersonalInfoPage() {
    Widget heightText = WidgetConstructor.createText("Height");
    BodyWidget heightFields = WidgetConstructor.createDoubleQuestion("ft", "in", "height");
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

class DietPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  DietPage() {
    Widget frequencyText =
        WidgetConstructor.createText("How often do you eat?");
    BodyWidget frequencyDropdown = WidgetConstructor.createDropDown(
        ['1-2x/day', '3-4x/day', '5-6x/day', '>6x/day', 'It depends'], "");
    List<String> fruitOptions = [
      '1-2x/day',
      '3-4x/day',
      '5-6x/day',
      '>6x/day',
      'It depends'
    ];
    BodyWidget fruitChecklist = WidgetConstructor.createCheckboxList(
        "Select any of the following fruit you regularly eat?",
        fruitOptions.length,
        fruitOptions,
        "");
    List<String> caffeineOptions = [
      '1-2x/day',
      '3-4x/day',
      '5-6x/day',
      '>6x/day',
      'It depends'
    ];
    Widget caffieineText =
        WidgetConstructor.createText("How much caffeine do you consume?");
    BodyWidget caffeineDropdown =
        WidgetConstructor.createDropDown(caffeineOptions, "");
    List<String> dairyOptions = [
      '1-2x/day',
      '3-4x/day',
      '5-6x/day',
      '>6x/day',
      'It depends'
    ];
    BodyWidget dairyChecklist = WidgetConstructor.createCheckboxList(
        "Select any of the following dairy products you consume:",
        dairyOptions.length,
        dairyOptions,
        "");
    List<String> miscOptions = [
      'Pickled Herring',
      'Nitrites',
      'Soy Sauce',
      'Yeast Extract',
      'Tenderizer',
      'MSG',
      'Artifical Sweetners'
    ];
    BodyWidget miscChecklist = WidgetConstructor.createCheckboxList(
        "Select the following products you consume:",
        miscOptions.length,
        miscOptions,
        "");
    bodyWidgets = [
      frequencyDropdown,
      fruitChecklist,
      caffeineDropdown,
      dairyChecklist,
      miscChecklist
    ];
    Map<Widget?, double> spacingConfig = {
      frequencyText: 30,
      frequencyDropdown: 0,
      fruitChecklist: 30,
      caffieineText: 30,
      caffeineDropdown: 0,
      dairyChecklist: 30,
      miscChecklist: 30,
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

class SleepPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  SleepPage() {
    Widget sleepText =
        WidgetConstructor.createText("How much sleep do you get on averge?");
    BodyWidget sleepCounter = WidgetConstructor.createIntCounter(7, '');
    bodyWidgets = [sleepCounter];
    Map<Widget?, double> spacingConfig = {
      sleepText: 30,
      sleepCounter: 0,
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

class MigraineInfoPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  MigraineInfoPage() {
    Widget lengthText =
        WidgetConstructor.createText("How long do your migraines last?");
    BodyWidget lengthCounter = WidgetConstructor.createQuestion('hrs', '');
    Widget frequencyText =
        WidgetConstructor.createText("How often do you have migraines?");
    BodyWidget frequencyCounter = WidgetConstructor.createQuestion('week', '');
    Widget timeText = WidgetConstructor.createText(
        "What time of day do your migraines usually occur?");
    BodyWidget timeDropdown =
        WidgetConstructor.createDropDown(["Morning", "Evening", "Night"], '');
    bodyWidgets = [lengthCounter, frequencyCounter, timeDropdown];
    Map<Widget?, double> spacingConfig = {
      lengthText: 30,
      lengthCounter: 0,
      frequencyText: 30,
      frequencyCounter: 0,
      timeText: 30,
      timeDropdown: 0,
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

class MedicalPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  MedicalPage() {
    Widget medicationText = WidgetConstructor.createText(
        "Enter any medication you take daily or on a need-to basis. Optional dosage and frequency fields available after selecting medicine");
    BodyWidget sleepCounter = WidgetConstructor.createIntCounter(7, '');
    bodyWidgets = [sleepCounter];
    Map<Widget?, double> spacingConfig = {
      medicationText: 30,
      sleepCounter: 0,
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
