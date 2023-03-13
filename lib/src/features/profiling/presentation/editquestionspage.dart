import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/application/userQuestionnaireBackend.dart';
import 'package:migraine_aid/src/features/profiling/presentation/chosenquestionpage.dart';
import 'package:migraine_aid/src/shared/staticTextWidget.dart';

import '../../../shared/basePage.dart';
import '../../../shared/continueButton.dart';
import '../../../shared/toggleButton.dart';
import '../../../shared/userFunctions.dart';
import '../../../shared/arrayToQuestion.dart';

import '../application/sleeppage_backend.dart';
import 'dietpage.dart';


// THIS IS A TEST TO SHOW HOW THE BASE PAGE IS USED AS A TEMPLATE.
class EditQuestionnaire extends StatefulWidget {
  const EditQuestionnaire({
    Key? key,
  }) : super(key: key);

  @override
  EditQuestionnaireState createState() => EditQuestionnaireState();
}

class EditQuestionnaireState extends State<EditQuestionnaire> {
  int limit = 1;
  List<String> priorityQuestions = [];
  List<String> otherQuestions = [];
  List<bool> checkboxValues = [];


  @override
  void initState() {
    super.initState();
    limit = 1;
    getAllQuestions().then((List<List<String>> result) {
      setState(() {
        otherQuestions = result[0];
        priorityQuestions = result[1];
        checkboxValues = List.filled(otherQuestions.length + priorityQuestions.length, false);
        for(int i = 0;i<priorityQuestions.length;i++) {
          checkboxValues[i] = true;
        }
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
            const StaticTextWidget(text: "Choose 3 questions!", fontSize: 30.0),
            ListView.builder(
                shrinkWrap: true,
                itemCount: priorityQuestions.length + otherQuestions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: Checkbox(
                        value: checkboxValues[index],
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxValues[index] = value!;
                          });
                        },
                      ),
                      title: Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: index < priorityQuestions.length?
                          Text(priorityQuestions[index]):

                          Text(otherQuestions[index - priorityQuestions.length])
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
                    int l = priorityQuestions.length;
                    List<String> newQuestions = [];
                    for(int i=0;i<checkboxValues.length;i++) {
                      if(checkboxValues[i] == true) {
                        if(i<l) {
                          newQuestions.add(priorityQuestions[i]);
                        }else
                        {
                          newQuestions.add(otherQuestions[i-l]);
                        }
                      }
                    }
                    setQuestions(newQuestions);
                    goToPage(context, UserQuestionnaire());
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

