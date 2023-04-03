import 'package:flutter/material.dart';

class BodyWidgets {
  static Widget createText(String questionText) {
    return Text(
      questionText,
      style: const TextStyle(
          fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
    );
  }

  static Widget createQuestion(String label) {
    return TextFormField(
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
    );
  }

  static Widget createDoubleQuestion(
    String firstLabel,
    String secondLabel,
  ) {
    return Row(children: <Widget>[
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
    ]);
  }

  static Widget createToggleOptions(
      int selectedOptionIndex, List<String> optionsList) {
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
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
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
    });
  }

  static Widget createIntCounter(int value) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
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
    });
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
}
