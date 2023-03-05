import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/application/userQuestionnaireBackend.dart';
import 'package:migraine_aid/src/shared/staticTextWidget.dart';

import '../../../shared/basePage.dart';
import '../../../shared/continueButton.dart';
import '../../../shared/toggleButton.dart';
import '../../../shared/userFunctions.dart';
import '../../../shared/arrayToQuestion.dart';

import '../application/sleeppage_backend.dart';
import 'dietpage.dart';


// THIS IS A TEST TO SHOW HOW THE BASE PAGE IS USED AS A TEMPLATE.
class UserQuestionnaire extends StatefulWidget {
  const UserQuestionnaire({
    Key? key,
  }) : super(key: key);

  @override
  _UserQuestionnaireState createState() => _UserQuestionnaireState();
}

class _UserQuestionnaireState extends State<UserQuestionnaire> {
  String question='';
  int limit = 1;
  List<String> priorityQuestions = [];
  List<bool> checked = [];
  @override
  void initState() {
    super.initState();
    question = '';
    limit = 1;
    getQuestions().then((List<String> result){
      setState(() {
        priorityQuestions = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Question Options Page',
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const StaticTextWidget(text: "All Done!", fontSize: 30.0),
            const StaticTextWidget(text: "We've pre-selected a few questions to ask you everyday!", fontSize: 30.0),
            ListView.builder(
                shrinkWrap: true,
                itemCount: priorityQuestions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Text(
                          priorityQuestions[index],
                        ),
                      )
                  );
                }),
            Column(
              children: [
                ContinueButton(
                  callback: ()    // TODO: push to choose questions
                  async {
                  },
                  content: Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget> [
                      Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      Icon(Icons.edit_note_rounded,
                          color: Colors.white),
                    ],
                  ),
                ),
                ContinueButton(
                  callback: ()  // TODO: push somewhere
                  async {
                  },
                ),
              ],
            )
          ],
        ),),
      buttons: [],
      key: UniqueKey(),
    );
  }
}
