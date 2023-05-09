import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import '../Application/Response.dart';

// Static constructor for initializing consistent page widgets
class WidgetConstructor {
  // Creates a string of Text
  static Widget createText(String questionText, {double fontSize = 20}) {
    if (questionText.isEmpty) {
      throw ArgumentError('Question text must not be null or empty.');
    }
    return Text(
      questionText,
      style: TextStyle(
        fontSize: fontSize,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  // Body Widget for a singular Text Field per question
  static BodyWidget createQuestion(String label, String shorthand,
      {Function(String)? nameValidator}) {
    if (label.isEmpty) {
      throw ArgumentError('Label must not be null or empty.');
    }
    if (shorthand.isEmpty) {
      throw ArgumentError('Shorthand must not be null or empty.');
    }

    return BodyWidget(
      shorthand,
      TextFormField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          constraints: const BoxConstraints(),
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text.';
          }
          // Call the nameValidator function and return the result
          return nameValidator != null ? nameValidator(value) : null;
        },
      ),
    );
  }

  // Creates an Image widget
  static Widget createImage(String imageAsset,
      {double width = 350, double height = 275, BoxFit boxFit = BoxFit.cover}) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(150),
        child: Image.asset(
          imageAsset,
          width: width,
          height: height,
          fit: boxFit,
        ),
      ),
    );
  }

  // Creates a large button for page navigation
  static Widget createButton(Function() onPressed,
      {String text = "Continue", Color color = Colors.white}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        side: BorderSide(width: 1, color: color),
        minimumSize: const Size(330, 70),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 17, color: color),
      ),
    );
  }

  // Body Widget for 2 Text Fields in the same column per question
  static BodyWidget createDoubleQuestion(
      String firstLabel, String secondLabel, String shorthand,
      {Function(String)? firstValidator, Function(String)? secondValidator}) {
    return BodyWidget(
        shorthand,
        Row(children: <Widget>[
          Flexible(
            flex: 0,
            // First Name Form Field
            child: TextFormField(
              decoration: InputDecoration(
                label: Text(
                  firstLabel,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
                border: const UnderlineInputBorder(),
                constraints: const BoxConstraints(maxWidth: 150),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text.';
                }
                // Call the nameValidator function and return the result
                return firstValidator != null ? firstValidator(value) : null;
              },
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 10,
            // Last Name Form Field
            child: TextFormField(
              decoration: InputDecoration(
                label: Text(
                  secondLabel,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
                border: const UnderlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text.';
                }
                // Call the nameValidator function and return the result
                return secondValidator != null ? secondValidator(value) : null;
              },
            ),
          ),
          const Spacer(),
        ]));
  }

  // Body Widget for small set of toggleable options
  static BodyWidget createToggleOptions(
      int selectedOptionIndex, List<String> optionsList, String shorthand) {
    var booleanList = <bool>[];
    var widgetList = <Widget>[];
    int index = 0;
    for (var option in optionsList) {
      bool isSelected = index == selectedOptionIndex;
      booleanList.add(isSelected);
      widgetList.add(Text(
        option,
        textAlign: TextAlign.center,
      ));
      index = index + 1;
    }
    return BodyWidget(shorthand,
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < booleanList.length; i++) {
              booleanList[i] = i == index;
            }
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        selectedBorderColor: Colors.white,
        selectedColor: Colors.black,
        fillColor: Colors.white,
        color: Colors.white,
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 110.0,
        ),
        isSelected: booleanList,
        children: widgetList,
      );
    }));
  }

  // Body Widget for a singular selected option per question
  static BodyWidget createDropDown(List<String> options, String shorthand) {
    String currentValue = options.isNotEmpty ? options[0] : "";
    return BodyWidget(shorthand,
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return DropdownButton(
        value: currentValue,
        items: options.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            currentValue = newValue!;
          });
        },
      );
    }));
  }

  // Body Widget for variable # of options selected per question
  static BodyWidget createCheckboxList(String questionText, int selectionLimit,
      List<String> options, String shorthand) {
    List<bool> isChecked = List.generate(options.length, (_) => false);
    List<int> selectionList = [];
    return BodyWidget(
        shorthand,
        Transform.translate(
            offset: const Offset(-15, 0),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        questionText,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      children: List.generate(isChecked.length, (index) {
                        return CheckboxListTile(
                          title: Text(options[index]),
                          value: isChecked[index],
                          onChanged: (value) {
                            setState(() {
                              if (value == true &&
                                  selectionLimit <=
                                      isChecked
                                          .where((element) => element)
                                          .length) {
                                return;
                              }
                              isChecked[index] = value!;
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
              );
            })));
  }

  // Body widget for searching list of strings
  static BodyWidget createMedicationWidget(String shorthand) {
    return BodyWidget(shorthand, StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        String searchText = '';
        List<String> selectedItems = [];

        // Define a function to update the search text and suggestions
        void updateSearchText(String searchText) {
          setState(() {
            searchText = searchText;
          });
        }

        // Define a function to handle selecting a suggestion
        void onSuggestionSelected(String suggestion) {
          setState(() {
            if (selectedItems.contains(suggestion)) {
              selectedItems.remove(suggestion);
            } else {
              selectedItems.add(suggestion);
            }
            searchText = '';
          });
        }

        List<String> getMedications() {
          final file = File('assets/libraries/MedicationLists.xlsx');
          final bytes = file.readAsBytesSync();
          final excel = Excel.decodeBytes(bytes);
          final sheet = excel.tables['Sheet1'];

          if (sheet == null) {
            return [];
          }

          final medications = <String>[];
          for (var row in sheet.rows) {
            final displayNameValue = row[0]?.value;
            final displayNameSynonymValue = row[1]?.value;
            if (displayNameValue != null) {
              medications.add(displayNameValue.toString());
            }
            if (displayNameSynonymValue != null) {
              medications.add(displayNameSynonymValue.toString());
            }
          }
          return medications;
        }

        // Get the list of medications from the Excel file
        List<String> medications = getMedications();

        // Filter the medications based on the search text
        List<String> suggestions = medications
            .where((medication) =>
                medication.toLowerCase().contains(searchText.toLowerCase()))
            .toList();

        // Build the widget tree
        return Column(
          children: [
            TextField(
              onChanged: updateSearchText,
              decoration: const InputDecoration(
                labelText: 'Search Medications',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              value: null,
              items: suggestions
                  .map((suggestion) => DropdownMenuItem(
                        value: suggestion,
                        child: Text(suggestion),
                      ))
                  .toList(),
              onChanged: (value) => onSuggestionSelected(value!),
              decoration: const InputDecoration(
                labelText: 'Medications',
              ),
              isDense: true,
              isExpanded: true,
              selectedItemBuilder: (BuildContext context) {
                return selectedItems.map<Widget>((String item) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(item),
                  );
                }).toList();
              },
            ),
          ],
        );
      },
    ));
  }

  // Body widget for strictly numerical responses
  static BodyWidget createIntCounter(
    int value,
    String shorthand, {
    int minValue = 0,
    int maxValue = 100,
    int increment = 1,
    int decrement = 1,
  }) {
    return BodyWidget(
      shorthand,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: IconButton(
                  color: Colors.black38,
                  iconSize: 70,
                  icon: const Icon(Icons.arrow_back_ios),
                  tooltip: '-$decrement',
                  onPressed: () {
                    setState(() {
                      if (value - decrement >= minValue) {
                        value -= decrement;
                      }
                    });
                  },
                ),
              ),
              Text(
                '$value',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 150,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  iconSize: 70,
                  color: Colors.black38,
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {
                    setState(() {
                      if (value + increment <= maxValue) {
                        value += increment;
                      }
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // A unique header button for back navigation
  static Widget createBackButton(Function() onPressed) {
    return Transform.translate(
      offset: const Offset(-20, 0),
      child: IconButton(
        color: const Color.fromARGB(255, 101, 101, 101),
        icon: const Icon(Icons.arrow_back_ios),
        tooltip: 'Back',
        onPressed: onPressed,
      ),
    );
  }

  // A unique header title
  static Widget createTitle(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 30, color: Color.fromARGB(255, 255, 255, 255)));
  }

  // Adds empty spaced widgets between body widgets
  static List<Widget> addSpacing(Map<Widget?, double> spacingBefore) {
    List<Widget> concatList = [];
    spacingBefore.forEach((widget, spacingDistance) {
      if (spacingDistance > 0) {
        concatList.add(SizedBox(height: spacingDistance));
      }
      if (widget != null) {
        concatList.add(widget);
      }
    });
    return concatList;
  }

  // Wraps spaced widgets with a header, padding, and a scrollable view
  static Widget addUXWrap(List<Widget> bodyWidgets,
      {Function()? backLogic, String? title}) {
    List<Widget> widgets = [const SizedBox(height: 40)];
    backLogic != null ? widgets.add(createBackButton(backLogic)) : null;
    title != null ? widgets.add(createTitle(title)) : null;
    widgets = widgets + bodyWidgets;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ),
      ),
    );
  }
}

// Extended Flutter Widgets - Autonomously control their own state
class BodyWidget extends StatelessWidget {
  final String question;
  late Response response;
  final Widget widget;
  BodyWidget(this.question, this.widget, {super.key});

  Widget getWidget() {
    return widget;
  }

  String getQuestion() {
    return question;
  }

  dynamic getResponse() {
    return response;
  }

  void setResponse(response) {
    this.response = response;
  }

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }
}
