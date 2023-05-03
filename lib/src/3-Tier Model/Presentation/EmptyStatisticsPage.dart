// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/TemplatePage.dart';
import '../Application/NavigationService.dart';

class StatisticsPage extends LogHandler {
  late TemplatePage template;
  List<Widget> bodyWidgets = [];
  StatisticsPage(NavigationController controller) {

    Widget emptyBoxDescription = WidgetConstructor.createText("Looks like you haven't logged any data just yet. Once you complete your first log or migraine attack, you will see your data here.");
    Widget backBtn = WidgetConstructor.createBackButton(() => null);
    Widget attackBtn = WidgetConstructor.createButton(() => null);
    Widget dailyBtn = WidgetConstructor.createButton(() => null);
    Widget settingsBtn = WidgetConstructor.createButton(() => null);
    bodyWidgets = [attackBtn, dailyBtn, settingsBtn];
    Map<Widget?, double> spacingConfig = {
      backBtn: 0,
      emptyBoxDescription: 100 
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Hi, Let's Get Started.");
    template = TemplatePage(
        body: finalBody,
        title: "",
        buttons: [dailyBtn, attackBtn, settingsBtn]);
  }

  TemplatePage getWidget() {
    return template;
  }

  @override
  void storeUserInfo() async {
    final file = File('../../../assets/libraries/tempDemoData.txt');
    
    final openFile = await file.open(mode: FileMode.write);
    await openFile.writeString("");
    await openFile.close();
  }

}