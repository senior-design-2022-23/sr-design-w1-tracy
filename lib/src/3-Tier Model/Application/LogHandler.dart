import 'package:flutter/cupertino.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/BodyWidgets.dart';

class LogHandler {
  // takes question and response from each widget, makes a map, for profiling and daily logs

   Map<String, dynamic> extractQuestionResponse(List<BodyWidget> widgetList){
     Map<String,dynamic> qrMap = {};
     for (var widget in widgetList) {
       qrMap[widget.getQuestion()] = widget.getResponse();
     }
     return qrMap;
   }

   void storeUserInfo(){
     throw UnimplementedError();
   }
}
