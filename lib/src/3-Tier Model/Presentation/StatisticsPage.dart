import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/TemplatePage.dart';
import 'package:fl_chart/fl_chart.dart';
import '../Application/NavigationService.dart';

class StatisticsPage extends LogHandler {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  StatisticsPage(NavigationController controller) {
    Widget statisticsTitle =
        WidgetConstructor.createText("Your Data");
    BodyWidget monthData = WidgetConstructor.createDropDown([
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ], "month");

    BarChartData chartData = BarChartData(
      barGroups: [
        BarChartGroupData(x: x)
      ],
      maxY: 
    );
    BarChart barData = BarChart(
  chartData,
  swapAnimationDuration: Duration(milliseconds: 150), // Optional
  swapAnimationCurve: Curves.linear, // Optional
);
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

  @override
  void storeUserInfo() async {
    var questionMap = extractQuestionResponse(bodyWidgets);
    //Change questions to shorthand Back4App columnName
    questionMap.forEach((question, response) {
      ParseServer.store("UserInfo", question, response);
    });
  }
}