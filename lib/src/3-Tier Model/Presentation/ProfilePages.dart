import 'package:flutter/material.dart' hide Page;
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/Response.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/TemplatePage.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';

import '../Application/Adapters/modelViewerAdapter.dart';
import '../Application/NavigationService.dart';
import '../Application/PageSetBuilder.dart';

class _TransitionPage extends Page {
  final String _pageText;
  _TransitionPage(this._pageText, NavigationController controller) {
    Widget transitionText = WidgetConstructor.createText(_pageText,
        fontSize: 50, align: TextAlign.center);
    Map<Widget?, double> spacingConfig = {
      transitionText: 70,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage);
    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }
}

class TransitionPageFactory {
  static createTransitionPage(
      String largeText, NavigationController navigationController) {
    return _TransitionPage(largeText, navigationController);
  }
}

class PersonalInfoPage extends Page with LogHandler {
  PersonalInfoPage(NavigationController controller) {
    createQuestions();
    Widget heightText = WidgetConstructor.createText("Height");
    BodyWidget heightFields =
        WidgetConstructor.createDoubleQuestion("ft", "in");
    Widget widthText = WidgetConstructor.createText("Weight");
    BodyWidget widthFields = WidgetConstructor.createQuestion("lbs");
    Widget sexText = WidgetConstructor.createText("Sex");
    BodyWidget sexOptions =
        WidgetConstructor.createToggleOptions(0, ['N/A', 'Male', 'Female']);
    Widget dobText = WidgetConstructor.createText("Date of Birth");
    BodyWidget dobSelector = WidgetConstructor.createDatePicker();
    bodyWidgets = [heightFields, widthFields, sexOptions, dobSelector];
    Map<Widget?, double> spacingConfig = {
      heightText: 30,
      heightFields: 0,
      widthText: 20,
      widthFields: 0,
      sexText: 20,
      sexOptions: 5,
      dobText: 20,
      dobSelector: 5
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage,
        title: "Hi, let's set up your profile!");
    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }

  void createQuestions() {
    questions.add(QuestionResponse(UserInputType.height, "Height", "height"));
    questions.add(QuestionResponse(UserInputType.weight, "Weight", "weight"));
    questions.add(QuestionResponse(UserInputType.toggle, "Sex", "sex"));
    questions.add(QuestionResponse(UserInputType.date, "Date of Birth", "DOB"));
    setQuestions(questions);
  }

  List<QuestionResponse> getQuestions() {
    return questions;
  }
}

class ActivityPage extends Page with LogHandler {
  ActivityPage(NavigationController controller) {
    createQuestions();
    Widget frequencyText = WidgetConstructor.createText(
        "How frequently do you engage in physical activity?");
    BodyWidget frequencyFields = WidgetConstructor.createDropDown([
      'Never',
      'Occasionally (1-2 times per week)',
      'Regularly (3-4 times per week)',
      'Very frequently (5-6 times per week)',
      'Daily (7 or more times per week)',
    ]);
    Widget intensityText = WidgetConstructor.createText(
        "What type of physical activity intensity do you typically engage in?");
    BodyWidget intensityFields = WidgetConstructor.createDropDown([
      'None',
      'Low intensity (e.g., walking, light yoga)',
      'Moderate intensity \n(e.g., brisk walking, light cycling)',
      'High intensity \n(e.g., running, weightlifting)',
      'Mixed intensity \n(varying types and levels of activities)',
    ]);
    Widget waterText = WidgetConstructor.createText(
        "What is your daily consumption of bottled water?");
    BodyWidget waterFields = WidgetConstructor.createDropDown([
      'Not sure',
      '1-2 bottles per day',
      '3-4 bottles per day',
      '5-6 bottles per day',
      '7-8 bottles per day',
      '9-10 bottles per day',
      'More than 10 bottles per day',
    ]);

    bodyWidgets = [frequencyFields, intensityFields, waterFields];
    Map<Widget?, double> spacingConfig = {
      frequencyText: 30,
      frequencyFields: 0,
      intensityText: 30,
      intensityFields: 0,
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

  void createQuestions() {
    questions.add(QuestionResponse(
        UserInputType.text, "Excercise Frequency", "excerciseFreq"));
    questions.add(QuestionResponse(UserInputType.text,
        "Typical Excercise Intensity", "excerciseIntensity"));
    questions.add(QuestionResponse(
        UserInputType.text, "Daily Water Consumption", "waterBottles"));
    setQuestions(questions);
  }

  List<QuestionResponse> getQuestions() {
    return questions;
  }
}

class DietPage extends Page with LogHandler {
  DietPage(NavigationController controller) {
    createQuestions();
    Widget frequencyText = WidgetConstructor.createText(
        "What is your typical daily meal frequency?");
    BodyWidget frequencyDropdown = WidgetConstructor.createDropDown([
      '1-2 meals per day',
      '3-4 meals per day',
      '5-6 meals per day',
      'More than 6 meals per day',
      'Varies from day to day',
    ]);
    List<String> fruitOptions = [
      'None',
      'Bananas',
      'Grapes or Raisins',
      'Citrus fruits (Oranges, Lemons, etc.)',
      'Plums, Prunes, or Figs',
      'Pineapple',
      'Avocado',
      'Beans and Legumes',
      'Apples',
      'Peaches',
      'Dried fruits',
      'I\'m not sure',
    ];
    BodyWidget fruitChecklist = WidgetConstructor.createCheckboxList(
        "Select any of the following fruit you regularly eat?",
        fruitOptions.length,
        fruitOptions);
    List<String> caffeineOptions = [
      'Minimal (0-50mg)',
      'Moderate (50-100mg)',
      'High (100-200mg)',
      'Very High (More than 200mg)',
      'Varies day by day',
    ];
    Widget caffieineText = WidgetConstructor.createText(
        "What is your typical daily caffeine consumption?");
    BodyWidget caffeineDropdown =
        WidgetConstructor.createDropDown(caffeineOptions);
    List<String> dairyOptions = [
      'Cheese',
      'Yogurt',
      'Buttermilk',
      'Chocolate',
      'Sour Cream',
      'Milk',
      'Ice Cream',
      'Butter',
      'Dairy-based Desserts (puddings, custards, etc.)',
    ];
    BodyWidget dairyChecklist = WidgetConstructor.createCheckboxList(
        "Please indicate any of the following dairy or dairy-based products that you regularly consume:",
        dairyOptions.length,
        dairyOptions);
    List<String> miscOptions = [
      'None',
      'Foods containing Nitrites (e.g., processed meats like bacon, hot dogs)',
      'Soy Sauce',
      'Yeast Extract (e.g., Marmite, Vegemite)',
      'Foods containing MSG (Monosodium Glutamate)',
      'Artificial Sweeteners (e.g., aspartame, sucralose)',
      'Aged Cheeses',
      'Foods high in Tyramine (e.g., smoked fish, soy products)',
      'Caffeinated Beverages',
      'Foods with high sodium content',
      'Fermented, pickled, or marinated foods',
      'I\'m not sure',
    ];
    BodyWidget miscChecklist = WidgetConstructor.createCheckboxList(
        "Which of these other food items or additives, known to potentially trigger migraines, do you regularly consume?",
        miscOptions.length,
        miscOptions);
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
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Diet Questions");
    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }

  void createQuestions() {
    questions.add(QuestionResponse(
        UserInputType.text, "Meal Frequency", "mealFrequency"));
    questions.add(QuestionResponse(
        UserInputType.text, "Fruits Eaten Regularly", "fruitsEaten"));
    questions.add(QuestionResponse(UserInputType.text,
        "Regular Caffiene Consumpution", "caffieneConsumpution"));
    questions.add(QuestionResponse(UserInputType.text,
        "Regular Dairy Products Consumed", "dairyConsumpution"));
    questions.add(QuestionResponse(UserInputType.text,
        "Typical trigger products consumed", "miscProducts"));
    setQuestions(questions);
  }

  List<QuestionResponse> getQuestions() {
    return questions;
  }
}

class SleepPage extends Page with LogHandler {
  SleepPage(NavigationController controller) {
    Widget sleepText = WidgetConstructor.createText(
        "How much sleep do you get on average?",
        align: TextAlign.center);
    BodyWidget sleepCounter = WidgetConstructor.createIntCounter(7);
    bodyWidgets = [sleepCounter];
    Map<Widget?, double> spacingConfig = {
      sleepText: 30,
      sleepCounter: 20,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Sleep Questions");
    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }

  void createQuestions() {
    questions.add(
        QuestionResponse(UserInputType.numeric, "Average Sleep", "avgSleep"));
    questions.add(QuestionResponse(
        UserInputType.toggle, "Irregular Sleep Pattern", "irregularSleep"));
    setQuestions(questions);
  }
}

class MigraineInfoPage extends Page with LogHandler {
  MigraineInfoPage() {
    createQuestions();
    Widget lengthText =
        WidgetConstructor.createText("How long do your migraines last?");
    BodyWidget lengthCounter = WidgetConstructor.createQuestion('hrs');
    Widget frequencyText =
        WidgetConstructor.createText("How often do you have migraines?");
    BodyWidget frequencyCounter = WidgetConstructor.createQuestion('week');
    Widget timeText = WidgetConstructor.createText(
        "What time of day do your migraines usually occur?");
    BodyWidget timeDropdown =
        WidgetConstructor.createDropDown(["Morning", "Evening", "Night"]);
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

  void createQuestions() {
    questions.add(QuestionResponse(
        UserInputType.numeric, "Typical Migraine Length", "migraineLength"));
    questions.add(QuestionResponse(
        UserInputType.text, "Migraine Frequency", "migraineFrequency"));
    questions.add(QuestionResponse(
        UserInputType.text, "Typical Migraine Time", "migraineTime"));
    setQuestions(questions);
  }
}

class HeadIndexManager {
  int headIndex = 0;
  final ModelViewerProxy proxy;

  HeadIndexManager._privateConstructor(this.proxy);

  static HeadIndexManager? _instance;

  static HeadIndexManager getInstance(ModelViewerProxy proxy) {
    _instance ??= HeadIndexManager._privateConstructor(proxy);
    return _instance!;
  }
}

class MigraineSelectionPage extends Page with LogHandler {
  final NavigationController controller;
  late MigraineSelector selector;
  late String selection;
  MigraineSelectionPage(this.controller) {
    print(
        "_____________________________))))))))))))))))))_______________________");
    createQuestions();
    selector = MigraineSelector(controller, questions[0]);
  }

  @override
  Widget getRootWidget() {
    return selector;
  }

  @override
  List<dynamic> collectResponses() {
    selection = questions[0].response;
    print(
        "----------------------------------------------------------------Selection" +
            selection);
    return [selection];
  }

  void createQuestions() {
    questions.add(QuestionResponse(
        UserInputType.text, "Typical Migraine Type", "migraineType"));
    print(
        'Setting question to: for QuestionResponse object: ${questions[0].hashCode}');
    setQuestions(questions);
  }

  @override
  void storeUserInfo() async {
    Map<String, String> modelToAttackType = {'human_head.glb': 'N/A'};
    // Access the headIndex from HeadIndexManager
    HeadIndexManager? manager = HeadIndexManager._instance;
    if (manager != null) {
      int headIndex = manager.headIndex;
      String currentModelSelected = manager.proxy.getModelName(headIndex);
      Map<String, dynamic> qrMap = {
        "MigraineAttackType": modelToAttackType[currentModelSelected]
      };
      var questionMap = qrMap;
      // Change questions to shorthand Back4App columnName
      questionMap.forEach((question, response) {
        ParseServer.store("UserInfo", question, response);
      });
    }
  }
}

class MigraineSelector extends StatelessWidget {
  final NavigationController controller;
  final QuestionResponse question;
  late HeadIndexManager manager =
      HeadIndexManager.getInstance(ModelViewerProxy());
  late ModelViewerProxy proxy = manager.proxy;
  late String currentMigraineType = assetNameToMigraineType(proxy.currentAsset);

  bool _isLoading = true;

  MigraineSelector(this.controller, this.question, {Key? key}) {
    print("setting" + currentMigraineType);
    print("QuestionResponse object in constructor: ${question.hashCode}");

    question.setResponse(currentMigraineType);
    print(question.response);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      Future.delayed(const Duration(seconds: 7)).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      return Scaffold(
        floatingActionButton: Stack(
          children: <Widget>[
            Align(
              alignment: const Alignment(0.15, .8),
              child: Opacity(
                opacity: _isLoading ? 0 : 1,
                child: WidgetConstructor.createText(currentMigraineType),
              ),
            ),
            Align(
              alignment: const Alignment(-.70, .20),
              child: Opacity(
                opacity: _isLoading ? 0 : 1,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      manager.headIndex -= 1;
                      proxy.loadModel(manager.headIndex);
                      currentMigraineType =
                          assetNameToMigraineType(proxy.currentAsset);
                      question.responseValue = currentMigraineType;
                    });
                  },
                  child: const Icon(Icons.navigate_before),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(.85, .20),
              child: Opacity(
                opacity: _isLoading ? 0 : 1,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      manager.headIndex += 1;
                      proxy.loadModel(manager.headIndex);
                      currentMigraineType =
                          assetNameToMigraineType(proxy.currentAsset);
                      question.responseValue = currentMigraineType;
                    });
                  },
                  child: const Icon(Icons.navigate_next),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.5, 1),
              child: Opacity(
                  opacity: _isLoading ? 0 : 1,
                  child: WidgetConstructor.createButton(controller.nextPage)),
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            proxy.init(),
            if (_isLoading)
              Container(
                  child: TemplatePage(
                      body: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetConstructor.createText(
                                "Generating 3D Models"),
                            WidgetConstructor.createText("Please Wait..."),
                            const SizedBox(height: 30),
                            const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 10,
                            )
                          ]),
                      title: "",
                      buttons: const [])),
          ],
        ),
      );
    });
  }

  String assetNameToMigraineType(String assetName) {
    String migraineType;

    switch (assetName) {
      case 'assets/models/human_head.glb':
        migraineType = 'No Migraine Selected';
        break;
      case 'assets/models/tension.glb':
        migraineType = 'Tension Headache';
        break;
      case 'assets/models/Cluster.glb':
        migraineType = 'Cluster Headache';
        break;
      case 'assets/models/Migraine.glb':
        migraineType = 'Migraine Headache';
        break;
      case 'assets/models/Post_Tramatic.glb':
        migraineType = 'Post-traumatic Headache';
        break;
      default:
        migraineType = 'ERROR';
    }

    return migraineType;
  }
}

class MedicalPage extends Page with LogHandler {
  MedicalPage(NavigationController controller) {
    createQuestions();
    Widget medicationText = WidgetConstructor.createText(
        "Enter any medication you take daily or on a need-to basis. Optional dosage and frequency fields available after selecting medicine");
    BodyWidget medicationSearch = WidgetConstructor.createMedicationWidget();
    bodyWidgets = [medicationSearch];
    Map<Widget?, double> spacingConfig = {
      medicationText: 30,
      medicationSearch: 30,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Medications");
    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }

  void createQuestions() {
    questions.add(
        QuestionResponse(UserInputType.text, "Medications", "medications"));
    setQuestions(questions);
  }
}

class ConfirmationPage extends Page {
  List<String> responses = [];

  ConfirmationPage(NavigationController controller) {
    Widget confirmationText = WidgetConstructor.createText(
        "Here is a list of your responses, would you like to edit?");

    Widget compiledQuestionList = Container(
      height: 500, // Set height as required
      child: ListView.builder(
        itemCount: responses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\t${responses[index]}'),
          );
        },
      ),
    );

    Map<Widget?, double> spacingConfig = {
      confirmationText: 30,
      compiledQuestionList: 0
    };

    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);

    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Edit Responses?");

    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }
}
