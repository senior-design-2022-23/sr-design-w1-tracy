import 'package:flutter/material.dart';
import 'package:migraine_aid/AuthenticationUI.dart';
import 'package:migraine_aid/PersonalInformationUI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Pass in prerequisite data to PIPage widget
      home:
          // WelcomePage(),
          PersonalInformationPage(name: "Mary Jenkins"),
    );
  }
}
