import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/application/sleeppage_backend.dart';

class SleepDailyPage extends StatefulWidget {
  const SleepDailyPage({Key? key,}) : super(key: key);

  @override
  State<SleepDailyPage> createState() => _SleepDailyPageState();

}

class _SleepDailyPageState extends State<SleepDailyPage> {
  int value = 0;

  @override
  void initState() {
    super.initState();
    value = 0;
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
                  "",
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
                // continue button
                OutlinedButton(
                    onPressed: ()
                    async {
                      bool stored = await storeSleepHours(value);
                      if(!stored) {
                        // TODO: Error handling
                      }
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
              ],

            )
        )
    );
  }
}
