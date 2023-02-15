import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migraine_aid/src/shared/staticTextWidget.dart';

import '../../../shared/basePage.dart';
import '../../../shared/continueButton.dart';
import '../../../shared/toggleButton.dart';
import '../../../shared/userFunctions.dart';
import '../application/sleeppage_backend.dart';
import 'dietpage.dart';


// THIS IS A TEST TO SHOW HOW THE BASE PAGE IS USED AS A TEMPLATE.
class SleepPageTest extends StatefulWidget {
  const SleepPageTest({
    Key? key,
  }) : super(key: key);

  @override
  _SleepPageTest createState() => _SleepPageTest();
}

class _SleepPageTest extends State<SleepPageTest> {
  int value = 0;
  String regular = 'T';

  @override
  void initState() {
    super.initState();
    value = 8;
    regular = 'T';
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Sleep Page',
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const StaticTextWidget(text: "About how many hours a night do you generally sleep?", fontSize: 30.0),
            Row(
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
                    )),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
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
            const StaticTextWidget(text: "Is your sleep pattern regular?", fontSize: 30.0),
            ToggleButton(callback: (regular) {
              this.regular = regular;
            }),
          ]),
      buttons: [
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
      key: UniqueKey(),
    );
  }
}
