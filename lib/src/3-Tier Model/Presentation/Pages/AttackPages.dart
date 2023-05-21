import 'package:flutter/material.dart' hide Page;

import '../../Application/LogHandler.dart';
import '../../Application/NavigationService.dart';
import '../../Application/PageSetBuilder.dart';

import '../Widgets/BodyWidgets.dart';
import 'TemplatePage.dart';

class AttackQuestion extends Page with LogHandler {
  Function() canContinue(String answer, NavigationController controller) {
    if (answer == "Yes") {
      //TODO: Log attack here
      return controller.nextPage;
    }
    return controller.toHome;
  }

  AttackQuestion(NavigationController controller) {
    Widget attackText = WidgetConstructor.createText(
        "Have you recently had a migraine episode or are you currently experiencing one?",
        align: TextAlign.center);
    BodyWidget attackToggle =
        WidgetConstructor.createToggleOptions(0, ["No", "Yes"]);

    bodyWidgets = [attackToggle];
    Map<Widget?, double> spacingConfig = {
      attackText: 70,
      attackToggle: 40,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.toHome, title: "Experiencing An Attack?");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(
        () {
          final canContinueFn = canContinue(attackToggle.input, controller);
          return canContinueFn();
        },
        text: "Continue",
      )
    ]);
  }
}

class MigrainePain extends Page with LogHandler {
  MigrainePain(NavigationController controller) {
    Widget painText = WidgetConstructor.createText(
        "On a scale of 1-10, how great is your pain?");
    BodyWidget painCounter =
        WidgetConstructor.createIntCounter(1, minValue: 1, maxValue: 10);
    Widget durationText = WidgetConstructor.createText(
      "What was the duration of your migraine episode?",
    );
    BodyWidget durationFields = WidgetConstructor.createDropDown([
      "Short-lasting (less than 4 hours)",
      "Moderate duration (4 to 72 hours)",
      "Prolonged (more than 72 hours)",
    ]);
    Widget ongoingText = WidgetConstructor.createText(
      "Please indicate if your current migraine is part of an ongoing episode.",
    );
    BodyWidget ongoingToggle =
        WidgetConstructor.createToggleOptions(0, ["No", "Yes"]);
    bodyWidgets = [painCounter, durationFields, ongoingToggle];
    Map<Widget?, double> spacingConfig = {
      painText: 30,
      painCounter: 0,
      durationText: 30,
      durationFields: 0,
      ongoingText: 30,
      ongoingToggle: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.toHome, title: "Migraine Details");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(controller.nextPage),
    ]);
  }
}

class MigraineSymptoms extends Page with LogHandler {
  MigraineSymptoms(NavigationController controller) {
    Widget nauseaText = WidgetConstructor.createText(
      "Are you experiencing symptoms of nausea or vomiting?",
    );
    BodyWidget nauseaToggle =
        WidgetConstructor.createToggleOptions(0, ["No", "Yes"]);
    Widget sensitivityText = WidgetConstructor.createText(
      "Do you experience sensitivity to light and/or sound during your migraines?",
    );
    BodyWidget sensitivityToggle =
        WidgetConstructor.createToggleOptions(0, ["No", "Yes"]);
    Widget dizzyText = WidgetConstructor.createText(
      "Are you experiencing any sensations of tingling or dizziness?",
    );
    BodyWidget dizzyToggle =
        WidgetConstructor.createToggleOptions(0, ["No", "Yes"]);
    bodyWidgets = [nauseaToggle, sensitivityToggle, dizzyToggle];
    Map<Widget?, double> spacingConfig = {
      nauseaText: 30,
      nauseaToggle: 0,
      sensitivityText: 30,
      sensitivityToggle: 0,
      dizzyText: 30,
      dizzyToggle: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Migraine Symptoms");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(controller.nextPage),
    ]);
  }
}
