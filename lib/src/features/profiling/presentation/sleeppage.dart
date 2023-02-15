import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/application/sleeppage_backend.dart';
import 'package:migraine_aid/src/shared/toggleButton.dart';

import '../../../shared/continueButton.dart';
import '../../../shared/userFunctions.dart';
import 'dietpage.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({Key? key,}) : super(key: key);

  @override
  State<SleepPage> createState() => _SleepPageState();

}

class _SleepPageState extends State<SleepPage> {
  int value = 0;
  String regular = 'T';
  @override
  void initState() {
    super.initState();
    value = 0;
    regular = 'T';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "About how many hours a night do you generally sleep?",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      tooltip: '-1',
                      onPressed: () {
                        setState(() {
                          if(value > 3) {
                            value -= 1;
                          }
                        });
                      },
                    ),
                  ),
                  Text(
                      '$value',
                       style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      )
                  ),
                  Material(
                    color:  Colors.transparent,
                    child: IconButton(
                      icon: const Icon(
                          Icons.arrow_forward_ios_outlined
                      ),
                      tooltip: '+1',
                      onPressed: () {
                        setState(() {
                          if(value < 16) {
                            value += 1;
                          }
                        });
                      },
                    ),
                  ),

                ],
              ),
              const Text(
                "Is your sleep pattern regular",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                ),
              ),
              ToggleButton(callback: (regular) {
                this.regular = regular;
              }),
              SizedBox(height: 16),
              ContinueButton(callback: ()
              async {
                bool stored = await storeSleepHours(value, regular);
                if(!stored) {
                  // TODO: Error handling
                } else {
                  goToPage(context, const DietPage());
                }
              }),
            ],

        )
    )
    );
  }
}
