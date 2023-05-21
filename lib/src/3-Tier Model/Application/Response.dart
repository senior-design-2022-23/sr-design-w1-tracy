// This class represents all information relating to each question in the application

import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/Pages/DailyLogFlow.dart';

class QuestionResponse {
  final UserInputType type;
  final String
      referenceName; // Used to reference question to user without elication
  final String logKey; // Used to reference the question's column in Back4App
  final String?
      questionText; // A string that is the questions displayed to the user
  final String? units; // Optional: units attached to response text
  QuestionResponse(this.type, this.referenceName, this.logKey,
      {this.units, this.questionText, this.subset});
  dynamic responseValue = "";
  QuestionSubset? subset;

  dynamic get response {
    if (type == UserInputType.weight) {
      return double.parse(responseValue);
    }
    if (units != null) {
      return responseValue + " " + units;
    }
    return responseValue;
  }

  void setResponse(dynamic value) {
    responseValue = value;
  }
}

// Enum doesn't exactly represent each bodyWidget type or each response type
// Seperates responses with different display/validation logic
enum UserInputType { numeric, text, list, height, weight, date, toggle }
