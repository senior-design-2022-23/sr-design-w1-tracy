

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/application/activitypage_backend.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ActivityPageState();
  }

class _ActivityPageState extends State<ActivityPage> {
  String gymDropDownValue = "";
  String waterDropDownValue = "";
  @override
  void initState() {
    super.initState();
    gymDropDownValue  = 'None (0x)';
    waterDropDownValue = 'Unsure';
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var gymQuestion = [
      'None (0x)',
      'Little or Rarely (1-2x)',
      'Often (3-4x)',
      'Frequently (5-6x)',
      'Everyday (>=7x)'
    ];
    // List of items in our dropdown menu
    var waterQuestion = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10+'
    ];

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

        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "How often do you exercise?",
                    style: TextStyle(
                        fontSize: 40, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButton(
                      value: gymDropDownValue,
                      items: gymQuestion.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          gymDropDownValue = newValue!;
                        });
                      },
                    ),
                  ),
                  const Text(
                    "Approximately how many bottles of water do you drink a day?",
                    style: TextStyle(
                        fontSize: 40, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButton(
                      value: waterDropDownValue,
                      items: waterQuestion.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          waterDropDownValue = newValue!;
                        });
                      },
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 70),
                      child: OutlinedButton(
                        onPressed:  () async {
                            bool stored = await storeActivity(gymDropDownValue, waterDropDownValue);
                            print(stored);
                            if(!stored) {
                                //TODO: ERROR HANDLING
                            }
                        },
                        style: TextButton.styleFrom(
                          side: const BorderSide(
                              width: 1, color: Color.fromARGB(255, 255, 255, 255)),
                          minimumSize: const Size(330, 70),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      )),
                ]
            )
        )
    );
  }

}


