import 'package:flutter/material.dart';
import 'package:migraine_aid/src/shared/staticTextWidget.dart';
import '../Presentation/TemplatePage.dart';
import 'LogHandler.dart';

class Response {
  final ResponseType type;
  // ignore: prefer_typing_uninitialized_variables
  final value;
  Response(this.type, this.value);
}

enum ResponseType {
  number,
  text,
  height,
  weight,
  date,
  migraine,
}

