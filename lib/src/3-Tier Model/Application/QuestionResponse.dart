import 'package:flutter/material.dart';
import 'package:migraine_aid/src/shared/staticTextWidget.dart';
import '../Presentation/TemplatePage.dart';
import 'LogHandler.dart';


class Question {
  final Type type;
  final String value;
  final String shorthand;
  Question(this.type, this.value, this.shorthand);
}

class Response {
  final Type type;
  // ignore: prefer_typing_uninitialized_variables
  final value;
  final String shorthand;

  Response(this.type, this.value, this.shorthand);
}

enum Type {
  number,
  text,
  height,
  weight,
  date,
  migraine,
  toggle
}

