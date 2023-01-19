

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/application/activitypage_backend.dart';
import 'package:migraine_aid/src/features/profiling/application/alcoholpage_backend.dart';

class AlcoholPage extends StatefulWidget {
  const AlcoholPage ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AlcoholPageState();
}

class _AlcoholPageState extends State<AlcoholPage> {
  String daysDrank = "";
  String alcoholPerDay = "";

  var alcoholPerWeekMap = [
    'None (0x)',
    'Little or Rarely (1-2x)',
    'Often (3-4x)',
    'Frequently (5-6x)',
    'Everyday (>=7x)'
  ];
  // List of items in our dropdown menu
  var alcoholOnDayMap = [
    '1-2',
    '3-4',
    '5-6',
    '7-9',
    '10+'
  ];

  @override
  void initState() {
    super.initState();
    daysDrank  = 'None (0x)';
    alcoholPerDay = '1-2';
  }

  @override
  void dispose() {
    super.dispose();
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

        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "How often do you drink alcohol every week?",
                    style: TextStyle(
                        fontSize: 40, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButton(
                      value: daysDrank,
                      items: alcoholPerWeekMap.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          daysDrank = newValue!;
                        });
                      },
                    ),
                  ),
                  const Text(
                    "On average, how much alcohol do you consume when you drink?",
                    style: TextStyle(
                        fontSize: 40, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButton(
                      value: alcoholPerDay,
                      items: alcoholOnDayMap.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          alcoholPerDay = newValue!;
                        });
                      },
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 70),
                      child: OutlinedButton(
                        onPressed:  () async {
                          print('we here');
                          bool stored = await storeAlcohol(daysDrank, alcoholPerDay);
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


