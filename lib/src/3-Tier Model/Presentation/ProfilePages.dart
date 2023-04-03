import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/TemplatePage.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';

class PersonalInfoPage {
  late TemplatePage template;
  PersonalInfoPage() {
    Widget heightText = BodyWidgets.createText("Height");
    Widget heightFields = BodyWidgets.createDoubleQuestion("ft", "in");
    Widget widthText = BodyWidgets.createText("Weight");
    Widget widthFields = BodyWidgets.createQuestion("lbs");
    Widget sexText = BodyWidgets.createText("Sex");
    Widget sexOptions =
        BodyWidgets.createToggleOptions(0, ['N/A', 'Male', 'Female']);
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
}
