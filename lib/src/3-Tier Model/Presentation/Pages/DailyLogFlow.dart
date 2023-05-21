import 'dart:math';

import 'package:flutter/material.dart' hide Page;
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/Response.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/Widgets/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/Pages/TemplatePage.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';

import '../../Application/Adapters/modelViewerAdapter.dart';
import '../../Application/NavigationService.dart';
import '../../Application/PageSetBuilder.dart';

enum QuestionSubset {
  PainAndSymptoms,
  MedicationAndTherapies,
  SleepAndRest,
  DietAndConsumption,
  LifestyleAndBehaviors,
  EnvironmentalFactors,
  TriggersAndManagement,
  Miscellaneous
}

class DailyLogFactory {
  List<Page> pages = [];
  List<QuestionResponse> questions = [
    QuestionResponse(UserInputType.numeric, "Migraine Pain Level", "painLevel",
        questionText:
            "On a scale of 1-10, how would you rate your migraine pain today?",
        subset: QuestionSubset.PainAndSymptoms),
    QuestionResponse(UserInputType.toggle, "Aura Warning", "auraWarning",
        questionText:
            "Did you experience any aura or other warning signs before the migraine?",
        subset: QuestionSubset.PainAndSymptoms),
    QuestionResponse(UserInputType.toggle, "Other Symptoms", "otherSymptoms",
        questionText:
            "Did you experience any other symptoms today, such as nausea, vomiting, sensitivity to light/sound, or visual disturbances?",
        subset: QuestionSubset.PainAndSymptoms),
    QuestionResponse(UserInputType.toggle, "Medication", "medication",
        questionText: "Did you take any medication for your migraine today?",
        subset: QuestionSubset.MedicationAndTherapies),
    QuestionResponse(
        UserInputType.toggle, "Migraine Alleviation", "migraineAlleviation",
        questionText:
            "Have you done anything different today that might have helped alleviate your migraine symptoms?",
        subset: QuestionSubset.MedicationAndTherapies),
    QuestionResponse(UserInputType.numeric, "Sleep Duration", "sleepDuration",
        questionText: "How many hours of sleep did you get last night?",
        subset: QuestionSubset.SleepAndRest),
    QuestionResponse(
        UserInputType.toggle, "Sleep Disturbance", "sleepDisturbance",
        questionText:
            "Did you have any interruptions or disturbances during your sleep?",
        subset: QuestionSubset.SleepAndRest),
    QuestionResponse(UserInputType.numeric, "Meal Count", "mealCount",
        questionText: "How many meals did you have today?",
        subset: QuestionSubset.DietAndConsumption),
    QuestionResponse(UserInputType.toggle, "Trigger Food", "triggerFood",
        questionText:
            "Did you consume any food or drink today that you think might have triggered your migraine?",
        subset: QuestionSubset.DietAndConsumption),
    QuestionResponse(
        UserInputType.numeric, "Water Consumption", "waterConsumption",
        questionText: "How much water did you drink today? (In bottles)",
        subset: QuestionSubset.DietAndConsumption),
    QuestionResponse(
        UserInputType.toggle, "Caffeine Consumption", "caffeineConsumption",
        questionText: "Did you consume any caffeine today?",
        subset: QuestionSubset.DietAndConsumption),
    QuestionResponse(
        UserInputType.toggle, "Dairy Consumption", "dairyConsumption",
        questionText: "Did you consume any dairy products today?",
        subset: QuestionSubset.DietAndConsumption),
    QuestionResponse(
        UserInputType.toggle, "Alcohol Consumption", "alcoholConsumption",
        questionText: "Did you consume any alcoholic beverages today?",
        subset: QuestionSubset.DietAndConsumption),
    QuestionResponse(UserInputType.toggle, "Appetite Change", "appetiteChange",
        questionText:
            "Did you experience any changes in your appetite or taste perception today?",
        subset: QuestionSubset.DietAndConsumption),
    QuestionResponse(UserInputType.numeric, "Physical Activity Level",
        "physicalActivityLevel",
        questionText:
            "How would you rate your overall level of physical activity today? (Rate on a scale of 1 to 10)",
        subset: QuestionSubset.LifestyleAndBehaviors),
    QuestionResponse(UserInputType.toggle, "Correlation Physical Activity",
        "correlationPhysicalActivity",
        questionText:
            "Did you notice any correlation between your physical activity and the intensity of your migraine?",
        subset: QuestionSubset.LifestyleAndBehaviors),
    QuestionResponse(UserInputType.numeric, "Stress Level", "stressLevel",
        questionText:
            "Were you exposed to any significant sources of stress today? (Rate on a scale of 1 to 10)",
        subset: QuestionSubset.EnvironmentalFactors),
    QuestionResponse(
        UserInputType.toggle, "Environmental Changes", "environmentalChanges",
        questionText:
            "Were there any significant environmental changes today, such as weather changes or exposure to bright lights, loud noises, or strong odors?",
        subset: QuestionSubset.EnvironmentalFactors),
    QuestionResponse(
        UserInputType.numeric, "Emotional Changes", "emotionalChanges",
        questionText:
            "Were there any significant emotional or psychological changes today, such as increased stress, anxiety, or depression? (Rate on a scale of 1 to 10)",
        subset: QuestionSubset.LifestyleAndBehaviors),
    QuestionResponse(UserInputType.numeric, "Migraine Impact", "migraineImpact",
        questionText:
            "How did today's migraine affect your daily activities or work? (Rate impact on a scale of 1 to 10)",
        subset: QuestionSubset.Miscellaneous),
    QuestionResponse(
        UserInputType.toggle, "Family Migraines", "familyMigraines",
        questionText: "Did any of your family members have a migraine today?",
        subset: QuestionSubset.Miscellaneous),
    QuestionResponse(UserInputType.toggle, "Speech Changes", "speechChanges",
        questionText:
            "Did you experience any changes in your speech prior to your migraine today?",
        subset: QuestionSubset.Miscellaneous),
    QuestionResponse(UserInputType.toggle, "Screen Time", "screenTime",
        questionText:
            "Was there any change in your screen time today compared to a typical day? (Increase, Decrease, Same)",
        subset: QuestionSubset.Miscellaneous),
    QuestionResponse(UserInputType.toggle, "Eye Strain", "eyeStrain",
        questionText:
            "Did you have any eye strain or vision-related issues today other than those typically associated with a migraine?",
        subset: QuestionSubset.Miscellaneous),
    QuestionResponse(UserInputType.toggle, "Strong Odor", "strongOdor",
        questionText:
            "Have you been around anyone today who was wearing a strong perfume or cologne?",
        subset: QuestionSubset.Miscellaneous),
    QuestionResponse(UserInputType.toggle, "Mood Swing", "moodSwing",
        questionText:
            "Did you have any significant changes in mood prior to your migraine, such as feelings of elation or irritability?",
        subset: QuestionSubset.Miscellaneous),
    QuestionResponse(
        UserInputType.toggle, "Hormonal Changes", "hormonalChanges",
        questionText:
            "Did your migraine coincide with any hormonal changes today, such as your menstrual cycle?",
        subset: QuestionSubset.Miscellaneous),
  ];
  List<QuestionResponse> selected = [];
  List<BodyWidget> bodyWidgets = [];
  List<Widget> widgets = [];
  NavigationController controller;

  DailyLogFactory(this.controller, Map<String, dynamic> profile) {
    selectQuestions(profile);
    createPages();
  }

  void createPages() {
    createBodyWidgets();

    var pageIndex = 0;
    while ((widgets.length - pageIndex * 6) % 6 == 0 &&
        (widgets.length - pageIndex * 6) >= 6) {
      List<Widget> widgetSubset =
          widgets.sublist(pageIndex * 6, pageIndex * 6 + 6);
      if (pageIndex == 0)
        pages.add(_IndividualLogPage([], widgetSubset, controller, "First"));
      else if ((widgets.length - (pageIndex + 1) * 6) < 6)
        pages.add(_IndividualLogPage([], widgetSubset, controller, "Last"));
      else
        pages.add(_IndividualLogPage([], widgetSubset, controller, "Middle"));

      pageIndex += 1;
    }
  }

  List<QuestionResponse> selectQuestions(Map<String, dynamic> profile) {
    if (profile != null) return [];
    Set<String> selectedQuestions = {};
    if (profile['sex'] == 'Female') {
      selectedQuestions.add(
          "Did your migraine coincide with any hormonal changes today, such as your menstrual cycle?");
    }
    // Check if patient exercises frequently and adjust questions accordingly
    if (profile['exercise_frequency'] != 'Never') {
      selectedQuestions.addAll(questions
          .where((e) => e.subset == QuestionSubset.LifestyleAndBehaviors)
          .map((e) => e.questionText!));
      if (profile['exercise_intensity'] ==
          'Moderate intensity (e.g., brisk walking, light cycling)') {
        selectedQuestions.add(
            "Did your migraine today occur after any specific physical activity, such as lifting heavy items or straining?");
      } else {
        selectedQuestions.add(
            "Did you notice any correlation between your physical activity and the intensity of your migraine?");
      }
    }
    // Check for high caffeine consumption
    if (profile['regular_caffeine_consumption'] != 'Minimal (0-50mg)') {
      selectedQuestions.add("Did you consume any caffeine today?");
    }
    // Check for sleep patterns
    if (profile['average_sleep'] < 6) {
      selectedQuestions.add("How many hours of sleep did you get last night?");
      selectedQuestions.add(
          "Did you have any interruptions or disturbances during your sleep?");
    }
    // Check for dairy consumption
    if (profile['regular_dairy_products_consumed'].length > 2) {
      selectedQuestions.add("Did you consume any dairy products today?");
    }
    // Check for specific fruit consumption
    if (profile['fruits_eaten_regularly'].length > 2) {
      selectedQuestions.add(
          "Did you consume any food or drink today that you think might have triggered your migraine?");
    }
    // Check for medication intake
    if (profile['medications'].length > 0) {
      selectedQuestions
          .add("Did you take any medication for your migraine today?");
    }
    // Check for meal frequency
    if (profile['meal_frequency'] == '1-2 meals per day' ||
        profile["infrequentMeals"] == true) {
      selectedQuestions.add("How many meals did you have today?");
      selectedQuestions.add(
          "Did your migraine occur after any prolonged period of fasting?");
    }
    // If less than 15 questions, fill in with general questions
    if (selectedQuestions.length < 15) {
      selectedQuestions
          .addAll(questions.map((question) => question.questionText!));
    }
    if (profile["sex"] == "Male") {
      selectedQuestions.remove(
          "Did your migraine coincide with any hormonal changes today, such as your menstrual cycle?");
    }
    selectedQuestions = selectedQuestions.take(10).toSet();
    return questions
        .where((question) => selectedQuestions.contains(question.questionText))
        .toList();
  }

  void createBodyWidgets() {
    questions.forEach((question) {
      switch (question.type) {
        case UserInputType.text:
          widgets.add(WidgetConstructor.createText(question.questionText!));
          var q = WidgetConstructor.createQuestion("Enter Text Here");
          widgets.add(q);
          bodyWidgets.add(q);
          break;
        case UserInputType.numeric:
          widgets.add(WidgetConstructor.createText(question.questionText!));
          var q = WidgetConstructor.createQuestion("Enter value here");
          widgets.add(q);
          bodyWidgets.add(q);
          break;
        case UserInputType.toggle:
          widgets.add(WidgetConstructor.createText(question.questionText!));
          var q = WidgetConstructor.createToggleOptions(0, ["No", "Yes"]);
          widgets.add(q);
          bodyWidgets.add(q);
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

  List<T> selectRandomElements<T>(List<T> list, int count) {
    if (count > list.length) {
      throw ArgumentError(
          'The count cannot be greater than the length of the list.');
    }

    final random = Random();
    final selectedElements = <T>[];

    while (selectedElements.length < count) {
      final randomIndex = random.nextInt(list.length);
      final randomElement = list[randomIndex];

      if (!selectedElements.contains(randomElement)) {
        selectedElements.add(randomElement);
      }
    }

    return selectedElements;
  }
}

class _IndividualLogPage extends Page {
  List<Widget> pageWidgets;
  List<BodyWidget> bodyWidgets = [];
  String index;
  _IndividualLogPage(this.bodyWidgets, this.pageWidgets,
      NavigationController controller, this.index) {
    Map<Widget?, double> spacingConfig = {
      pageWidgets[0]: 30,
      pageWidgets[1]: 0,
      pageWidgets[2]: 30,
      pageWidgets[3]: 0,
      pageWidgets[4]: 30,
      pageWidgets[5]: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    var backLogic = controller.previousPage;
    if (index == "First") backLogic = controller.toHome;
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        title: "Daily Log", backLogic: backLogic);
    template = TemplatePage(
        body: finalBody,
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }
}
