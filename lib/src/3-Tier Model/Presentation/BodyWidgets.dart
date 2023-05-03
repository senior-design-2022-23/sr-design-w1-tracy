import 'package:flutter/material.dart';

import '../Application/Response.dart';
import 'package:excel/excel.dart';
import 'dart:io';

class WidgetConstructor {
  static Widget createText(String questionText, {double fontSize = 20}) {
    return Text(
      questionText,
      style: TextStyle(
          fontSize: fontSize, color: const Color.fromARGB(255, 255, 255, 255)),
    );
  }

  static BodyWidget createQuestion(String label, String shorthand) {
    return BodyWidget(
        shorthand,
        TextFormField(
          decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              constraints: const BoxConstraints(maxWidth: 150),
              label: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              )),
        ));
  }

  static BodyWidget createDoubleQuestion(
      String firstLabel, String secondLabel, String shorthand) {
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
            ),
          ),
          const Spacer(),
        ]));
  }

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

  static BodyWidget createDropDown(List<String> options, String shorthand) {
    String currentValue = "";
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

  static BodyWidget createCheckboxList(String questionText, int selectionLimit,
      List<String> options, String shorthand) {
    List<bool> isChecked = List.generate(options.length, (_) => false);
    List<int> selectionList = [];
    return BodyWidget(shorthand,
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              questionText,
              style: const TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            children: List.generate(isChecked.length, (index) {
              return CheckboxListTile(
                title: Text(options[index]),
                value: isChecked[index],
                onChanged: (value) {
                  setState(() {
                    if (selectionLimit <=
                        isChecked.where((element) => element).length) {
                      isChecked[index] = value!;
                    }
                  });
                },
              );
            }),
          );
        },
      );
    }));
  }

  static BodyWidget createIntCounter(int value, String shorthand) {
    return BodyWidget(shorthand,
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              tooltip: '-1',
              onPressed: () {
                setState(() {
                  if (value > 3) {
                    value -= 1;
                  }
                });
              },
            ),
          ),
          Text('$value',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              )),
          Material(
            color: Colors.transparent,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              tooltip: '+1',
              onPressed: () {
                setState(() {
                  if (value < 16) {
                    value += 1;
                  }
                });
              },
            ),
          ),
        ],
      );
    }));
  }

  static Widget createBackButton(Function onPressed) {
    return Transform.translate(
      offset: const Offset(-20, 0),
      child: IconButton(
        color: const Color.fromARGB(255, 101, 101, 101),
        icon: const Icon(Icons.arrow_back_ios),
        tooltip: 'Back',
        onPressed: () => onPressed(),
      ),
    );
  }

  static Widget createTitle(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 30, color: Color.fromARGB(255, 255, 255, 255)));
  }

  static List<Widget> addSpacing(Map<Widget?, double> spacingBefore) {
    List<Widget> concatList = [];
    spacingBefore.forEach((widget, spacingDistance) {
      if (widget != null) {
        concatList.add(widget);
      }
      if (spacingDistance > 0) {
        concatList.add(SizedBox(height: spacingDistance));
      }
    });
    return concatList;
  }

  static Widget addUXWrap(List<Widget> bodyWidgets,
      {Function? backLogic, String? title}) {
    List<Widget> widgets = [];
    backLogic != null ? widgets.add(createBackButton(backLogic)) : null;
    title != null ? widgets.add(createTitle(title)) : null;
    widgets = widgets + bodyWidgets;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        ),
      ),
    );
  }

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
          final file = File('rx.xlsx');
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
}

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
