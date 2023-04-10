import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/TemplatePage.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';

class PersonalInfoPage implements LogHandler{
  late TemplatePage template;
  PersonalInfoPage() {
    Widget heightText = BodyWidgets.createText("Height");
    BodyWidget heightFields = BodyWidgets.createDoubleQuestion("ft", "in", "height");
    Widget widthText = BodyWidgets.createText("Weight");
    BodyWidget widthFields = BodyWidgets.createQuestion("lbs", "weight");
    Widget sexText = BodyWidgets.createText("Sex");
    BodyWidget sexOptions =
        BodyWidgets.createToggleOptions(0, ['N/A', 'Male', 'Female'], "sex");
    Map<Widget?, double> spacingConfig = {
      heightText: 30,
      heightFields: 0,
      widthText: 20,
      widthFields: 0,
      sexText: 20,
      sexOptions: 5
    };
    List<Widget> spacedList = BodyWidgets.addSpacing(spacingConfig);
    Widget finalBody = BodyWidgets.addUXWrap(spacedList);
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
    var questionMap = extractQuestionResponse();
    //Change questions to shorthand Back4App columnName
    questionMap.forEach((question, response) {
      ParseServer.store("UserInfo", question, response);
    });
  }

}
