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
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const StaticTextWidget(text: "Choose atleast 1 of the following questions", fontSize: 30.0),
            ArrayToCheckboxList(items: priorityQuestions,
                callback: (updatedList) {
                    checked = updatedList;
                }
            ),
          ]),
      buttons: [
        ContinueButton(callback: ()
        async {
            List<String> setQ = [];
            for (int i=0;i<checked.length;i++) {
              if(checked[i]) {
                setQ.add(priorityQuestions[i]);
              }
            }
            setQuestions(setQ);

        }),
      ],
      key: UniqueKey(),
    );
  }
}
