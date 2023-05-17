/*
import 'package:flutter/material.dart';
import '../Application/LogHandler.dart';
import '../Application/NavigationService.dart';
import 'BodyWidgets.dart';
import 'TemplatePage.dart';

class LoadingPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  LoadingPage(NavigationController controller) {
    Widget statisticsTitle =
        WidgetConstructor.createText("Your Data");
    bodyWidgets = [exerciseFields, waterFields];
    Map<Widget?, double> spacingConfig = {
      exerciseText: 30,
      exerciseFields: 0,
      waterText: 20,
      waterFields: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Activity Questions");
    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }

  TemplatePage getWidget() {
    return template;
  }

}*/
