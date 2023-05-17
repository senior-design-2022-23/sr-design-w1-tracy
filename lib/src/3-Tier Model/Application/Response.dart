// This class represents all information relating to each question in the application
import 'package:flutter/material.dart';

class QuestionResponse {
  final UserInputType type;
  final String
      referenceName; // Used to reference question to user without elication
  final String logKey; // Used to reference the question's column in Back4App
  final bool
      isNullable; // Determines whether the response can be return as null
  final String? questionText; // A string that is the questions displayed to the user
  final String? units; // Optional: units attached to response text
  QuestionResponse(this.type, this.referenceName, this.logKey,
      {this.isNullable = true, this.units, this.questionText});
  late dynamic responseValue;

  get response {
    if (responseValue != null) {
      if (isNullable) {
        return responseValue;
      }
      // TODO: ADD ERROR CHECKING HERE
      throw Exception(
        "Response value is null and not nullable.s",
      );
    }
  }

  void setResponse(dynamic value) {
    responseValue = value;
  }
}

// Enum doesn't exactly represent each bodyWidget type or each response type
// Seperates responses with different display/validation logic
enum UserInputType { numeric, text, list, height, weight, date, toggle }
