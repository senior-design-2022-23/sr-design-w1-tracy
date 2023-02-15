import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/application/userQuestionnaireBackend.dart';
import 'package:migraine_aid/src/shared/staticTextWidget.dart';

import '../../../shared/basePage.dart';
import '../../../shared/continueButton.dart';
import '../../../shared/toggleButton.dart';
import '../../../shared/userFunctions.dart';
import '../../../shared/arrayToQuestion.dart';
import '../application/dailylogpage_backend.dart';



// THIS IS A TEST TO SHOW HOW THE BASE PAGE IS USED AS A TEMPLATE.
class DailyLoginPage extends StatefulWidget {
  const DailyLoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _DailyLoginPageState createState() => _DailyLoginPageState();
}

class _DailyLoginPageState extends State<DailyLoginPage> {
  List<String> questions = [];
  int questionIdx=0;
  List<String> answers = [];
  @override
  void initState() {
    super.initState();
    getChosenQuestions().then((List<String> result){
      setState(() {
        questions = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ansController = TextEditingController();
    return BasePage(
      title: 'Daily Login Page',
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(questionIdx < questions.length? questions[questionIdx] : 'loading...'),
            TextFormField(
              controller: ansController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255)),
                labelText: 'Answer',
              ),
            )
          ]),
      buttons: [
        ContinueButton(callback: ()
        async {
           if(questionIdx <= questions.length-1) {
             setState(() {
                answers.add(ansController.text);
                questionIdx++;
              });
           }
           else {
             await setAnswers(answers);
             // TODO: LINK PAGES
           }
        }),
      ],
      key: UniqueKey(),
    );
  }
}
