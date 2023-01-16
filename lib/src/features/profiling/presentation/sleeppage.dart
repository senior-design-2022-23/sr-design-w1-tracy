import 'package:flutter/material.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({Key? key,}) : super(key: key);

  @override
  State<SleepPage> createState() => _SleepPageState();

}

class _SleepPageState extends State<SleepPage>{

  Color getForegroundColor(Set<MaterialState> states) {
    const interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
    };

    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    } else if (states.contains(MaterialState.focused)) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }

  Color getBackgroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.focused)) return Colors.black;
    if (states.contains(MaterialState.pressed)) return Colors.green;

    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 124, 154, 88),
                  Color.fromARGB(255, 141, 184, 86),
                  Color.fromARGB(255, 101, 120, 78),
                  Color.fromARGB(255, 109, 144, 67)
                ])),
        child: Column(
            children: <Widget>[
              const Text(
                "About how many hours a night do you generally sleep?",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 60,
                    padding: const EdgeInsets.all(3.5),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    child: Row(
                      children: <Widget>[
                        _sleepNumber("2"),
                        _sleepNumber("3"),
                        _sleepNumber("4"),
                        _sleepNumber("5"),
                        _sleepNumber("6"),
                        _sleepNumber("7"),
                        _sleepNumber("8"),
                        _sleepNumber("9"),
                        _sleepNumber("10"),
                      ],
                    )),
              ),
              OutlinedButton(
                  onPressed: () => {
                  },
                  child:
                  const Text(
                      "CONTINUE",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      )
                  )
              )
            ]
        )
    );
  }

  Expanded _sleepNumber(String hour) {

    final foregroundColor = MaterialStateProperty.resolveWith<Color>(getForegroundColor);
    final backgroundColor = MaterialStateProperty.resolveWith<Color>(getBackgroundColor);

    final style = ButtonStyle(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
    );

    return Expanded(
        child: OutlinedButton (
          style: style,
          onPressed: () => {
          },
          child: Text(
              hour,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              )
          ),
        )
    );
  }
}

