import 'package:flutter/material.dart';

import '../Application/Response.dart';

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

  static Widget createButton(Function() onPressed,
      {Color color = Colors.white}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        side: BorderSide(width: 1, color: color),
        minimumSize: const Size(330, 70),
      ),
      child: Text(
        "Continue",
        style: TextStyle(fontSize: 17, color: color),
      ),
    );
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

  static BodyWidget createIntCounter(int value, String shorthand) {
    return BodyWidget(shorthand,
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Material(
            color: Colors.black38,
            child: IconButton(
              iconSize: 70,
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
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 150,
              )),
          Material(
            color: Colors.transparent,
            child: IconButton(
              iconSize: 70,
              color: Colors.black38,
              icon: const Icon(Icons.arrow_forward_ios_outlined),
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

  static Widget createTitle(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 30, color: Color.fromARGB(255, 255, 255, 255)));
  }

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
