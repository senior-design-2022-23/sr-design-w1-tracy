import 'dart:async';

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

String? validateNumerical(String input) {
  if (input.isEmpty || input.trim() == "") return "Required Field";
  double? number = double.tryParse(input);
  if (number != null) {
    if (number <= 0) return "Invalid value";
  } else {
    return "Numerical text only";
  }
  return null;
}

class PersonalInfoPage extends Page with LogHandler {
  late Widget heightText;
  late BodyWidget heightFields;
  late Widget widthText;
  late BodyWidget widthFields;
  PersonalInfoPage(NavigationController controller) {
    createQuestions();
    StreamController<bool> isMetricController =
        StreamController<bool>.broadcast();
    createFutureWidgets(isMetricController.stream);
    BodyWidget metricOptions = WidgetConstructor.createToggleOptions(
        0, ['Imperial', 'Metric'], onpressed: (index) {
      if (index == 0) isMetricController.add(false);
      if (index == 1) isMetricController.add(true);
    });
    Widget sexText = WidgetConstructor.createText("Sex");
    BodyWidget sexOptions =
        WidgetConstructor.createToggleOptions(0, ['N/A', 'Male', 'Female']);
    Widget dobText = WidgetConstructor.createText("Date of Birth");
    BodyWidget dobSelector = WidgetConstructor.createDatePicker();

    bodyWidgets = [
      heightFields,
      widthFields,
      metricOptions,
      sexOptions,
      dobSelector
    ];
    Map<Widget?, double> spacingConfig = {
      heightText: 30,
      heightFields: 0,
      widthText: 20,
      widthFields: 0,
      metricOptions: 10,
      sexText: 20,
      sexOptions: 5,
      dobText: 20,
      dobSelector: 5
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage,
        title: "Hi, let's set up your profile!");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(() {
        if (inputsValid()) {
          setResponses();
          controller.nextPage();
        }
      })
    ]);
  }

  void createFutureWidgets(Stream<bool> isMetric) {
    heightText = StreamBuilder(
        stream: isMetric,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return WidgetConstructor.createText("Height",
                tooltip:
                    "Enter your height in centimeters"); // alternate widget
          } else {
            return WidgetConstructor.createText("Height",
                tooltip: "Enter your height in feet and inches");
          }
        });
    heightFields = WidgetConstructor.createDoubleQuestion(
      "ft",
      "in",
      firstValidator: (input) {
        return validateNumerical(input);
      },
      secondValidator: (input) {
        return validateNumerical(input);
      },
    ).futureBuilderSwitch(
        isMetric,
        WidgetConstructor.createQuestion(
          "cm",
          inputValidator: (input) {
            return validateNumerical(input);
          },
        ));
    widthText = StreamBuilder(
        stream: isMetric,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return WidgetConstructor.createText("Weight");
          }
          return WidgetConstructor.createText("Weight");
        });
    widthFields =
        WidgetConstructor.createQuestion("lbs", inputValidator: (input) {
      return validateNumerical(input);
    }).futureBuilderSwitch(
            isMetric,
            WidgetConstructor.createQuestion("kg", inputValidator: (input) {
              return validateNumerical(input);
            }));
  }

  void createQuestions() {
    questions.add(QuestionResponse(UserInputType.height, "Height", "height"));
    questions.add(QuestionResponse(UserInputType.weight, "Weight", "weight"));
    questions.add(
        QuestionResponse(UserInputType.weight, "Unit System", "unitSystem"));
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
    BodyWidget frequencyDropdown = WidgetConstructor.createDropDown([
      'Never',
      'Occasionally (1-2 times per week)',
      'Regularly (3-4 times per week)',
      'Very frequently (5-6 times per week)',
      'Daily (7 or more times per week)',
    ]);
    Widget intensityText = WidgetConstructor.createText(
        "What type of physical activity intensity do you typically engage in?");
    BodyWidget intensityDropdown = WidgetConstructor.createDropDown([
      'None',
      'Low intensity (e.g., walking, light yoga)',
      'Moderate intensity \n(e.g., brisk walking, light cycling)',
      'High intensity \n(e.g., running, weightlifting)',
      'Mixed intensity \n(varying types and levels of activities)',
    ]);
    Widget waterText = WidgetConstructor.createText(
        "What is your daily consumption of bottled water?");
    BodyWidget waterDropdown = WidgetConstructor.createDropDown([
      'Not sure',
      '1-2 bottles per day',
      '3-4 bottles per day',
      '5-6 bottles per day',
      '7-8 bottles per day',
      '9-10 bottles per day',
      'More than 10 bottles per day',
    ]);

    bodyWidgets = [frequencyDropdown, intensityDropdown, waterDropdown];
    Map<Widget?, double> spacingConfig = {
      frequencyText: 30,
      frequencyDropdown: 0,
      intensityText: 30,
      intensityDropdown: 0,
      waterText: 20,
      waterDropdown: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Activity Questions");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(() {
        setResponses();
        controller.nextPage();
      })
    ]);
  }

  void createQuestions() {
    questions.add(QuestionResponse(
        UserInputType.text, "Excercise Frequency", "excerciseFreq"));
    questions.add(QuestionResponse(UserInputType.text,
        "Typical Excercise Intensity", "excerciseIntensity"));
    questions.add(QuestionResponse(
        UserInputType.text, "Daily Water Consumption", "waterConsumption"));
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
    bodyWidgets = [
      frequencyDropdown,
      fruitChecklist,
      caffeineDropdown,
    ];
    Map<Widget?, double> spacingConfig = {
      frequencyText: 30,
      frequencyDropdown: 0,
      fruitChecklist: 30,
      caffieineText: 30,
      caffeineDropdown: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Diet Questions");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(() {
        setResponses();
        controller.nextPage();
      })
    ]);
  }

  void createQuestions() {
    questions.add(QuestionResponse(
        UserInputType.text, "Meal Frequency", "mealFrequency"));
    questions.add(QuestionResponse(
        UserInputType.text, "Fruits Eaten Regularly", "fruitConsumption"));
    questions.add(QuestionResponse(UserInputType.text,
        "Regular Caffiene Consumpution", "caffieneConsumpution"));
    setQuestions(questions);
  }

  List<QuestionResponse> getQuestions() {
    return questions;
  }
}

class SecondDietPage extends Page with LogHandler {
  SecondDietPage(NavigationController controller) {
    createQuestions();
    List<String> dairyOptions = [
      'None',
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
    bodyWidgets = [dairyChecklist, miscChecklist];
    Map<Widget?, double> spacingConfig = {
      dairyChecklist: 30,
      miscChecklist: 30,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Diet Questions");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(() {
        setResponses();
        controller.nextPage();
      })
    ]);
  }

  void createQuestions() {
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
    createQuestions();
    Widget sleepText = WidgetConstructor.createText(
        "How much sleep do you get on average?",
        align: TextAlign.center);
    BodyWidget sleepCounter = WidgetConstructor.createIntCounter(7);
    Widget irregularText = WidgetConstructor.createText(
        "Do you have an irregular sleep pattern?",
        align: TextAlign.center);
    BodyWidget irregularOptions =
        WidgetConstructor.createToggleOptions(0, ['No', 'Yes']);
    bodyWidgets = [sleepCounter, irregularOptions];
    Map<Widget?, double> spacingConfig = {
      sleepText: 30,
      sleepCounter: 20,
      irregularText: 30,
      irregularOptions: 0
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Sleep Questions");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(() {
        setResponses();
        controller.nextPage();
      })
    ]);
  }

  void createQuestions() {
    questions.add(QuestionResponse(
      UserInputType.numeric,
      "Average Sleep",
      "avgSleep",
    ));
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
    BodyWidget lengthCounter = WidgetConstructor.createQuestion(
      'hrs',
      inputValidator: (input) {
        return validateNumerical(input);
      },
    );
    Widget frequencyText =
        WidgetConstructor.createText("How often do you have migraines?");
    BodyWidget frequencyCounter =
        WidgetConstructor.createQuestion('week(s)', inputValidator: (input) {
      return validateNumerical(input);
    });
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
        body: finalBody, buttons: [ContinueButton(callback: () {})]);
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
    return [selection];
  }

  void createQuestions() {
    questions.add(QuestionResponse(
        UserInputType.text, "Typical Migraine Type", "migraineType"));
    setQuestions(questions);
  }

  @override
  void storeUserInfo(String className) async {
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
        ParseServer.store(className, question, response);
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
    // question.setResponse(currentMigraineType);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      return Scaffold(
        floatingActionButton: Stack(
          children: <Widget>[
            Align(
              alignment: const Alignment(2, -.6),
              child: Opacity(
                opacity: _isLoading ? 0 : 1,
                child: WidgetConstructor.createText(
                    "Please choose the best Migraine Area that represents yours",
                    fontColor: Colors.white54,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: const Alignment(0.15, .8),
              child: Opacity(
                opacity: _isLoading ? 0 : 1,
                child: WidgetConstructor.createText(currentMigraineType,
                    align: TextAlign.center),
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
            IgnorePointer(
              ignoring: !_isLoading,
              child: _isLoading
                  ? TemplatePage(
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
                      buttons: const [])
                  : Container(),
            ),
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

class MedicationPage extends Page with LogHandler {
  MedicationPage(NavigationController controller) {
    createQuestions();
    Widget medicationText = WidgetConstructor.createText(
        "Enter any medication you take daily or on a need-to basis. Optional dosage and frequency fields available after selecting medicine");
    // BodyWidget medicationSearch = WidgetConstructor.createMedicationWidget();
    // bodyWidgets = [medicationSearch];
    Map<Widget?, double> spacingConfig = {
      medicationText: 30,
      // medicationSearch: 30,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Medications");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(() {
        // setResponses();
        controller.nextPage();
      })
    ]);
  }

  void createQuestions() {
    questions.add(QuestionResponse(
        UserInputType.text, "Medications Used", "medicationsUsed"));
    setQuestions(questions);
  }
}

class MedicalHistoryPage extends Page with LogHandler {
  MedicalHistoryPage(NavigationController controller) {
    createQuestions();
    Widget medicationText = WidgetConstructor.createText(
        "Please record any history of medical problems");
    // BodyWidget medicationSearch = WidgetConstructor.createMedicationWidget();
    // bodyWidgets = [medicationSearch];
    Map<Widget?, double> spacingConfig = {
      medicationText: 30,
      // medicationSearch: 30,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Medications");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(() {
        // setResponses();
        controller.nextPage();
      })
    ]);
  }

  void createQuestions() {
    questions.add(QuestionResponse(
        UserInputType.text, "Medical History Problems", "medicalProblems"));
    setQuestions(questions);
  }
}

class MenstruationInformation extends Page with LogHandler {
  MenstruationInformation(NavigationController controller) {
    createQuestions();
    Widget dateText =
        WidgetConstructor.createText("When did your last menstrual cycle end?");
    BodyWidget dateSelector = WidgetConstructor.createDatePicker();
    Widget lengthText = WidgetConstructor.createText(
        "Approximately, how long did your last cycle last?");
    BodyWidget lengthDropdown = WidgetConstructor.createDropDown([
      "Less than 21 days",
      "21-28 days (Average)",
      "29-35 days",
      "36-42 days",
      "More than 42 days",
      "My cycle length varies significantly and is not consistent",
    ]);

    bodyWidgets = [dateSelector, lengthDropdown];
    Map<Widget?, double> spacingConfig = {
      dateText: 30,
      dateSelector: 0,
      lengthText: 30,
      lengthDropdown: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Menstruation Questions");
    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(() {
        setResponses();
        controller.nextPage();
      })
    ]);
  }

  void createQuestions() {
    questions.add(QuestionResponse(
        UserInputType.text, "Menstruation Cycle End", "menstruationCycleEnd"));
    questions.add(QuestionResponse(UserInputType.text,
        "Menstruation Cycle Length", "menstruationCycleLength"));
    setQuestions(questions);
  }
}

class ConfirmationPage extends Page {
  List<String> stats;

  ConfirmationPage(NavigationController controller, {this.stats = const []}) {
    Widget confirmationText = WidgetConstructor.createText(
        "Here is a list of your responses, would you like to edit?");
    print(stats.toString());
    Widget compiledQuestionList = Container(
      height: 400, // Set height as required
      child: ListView.builder(
        itemCount: stats.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\t${stats[index]}'),
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
        buttons: [WidgetConstructor.createButton(controller.nextPage)]);
  }
}
