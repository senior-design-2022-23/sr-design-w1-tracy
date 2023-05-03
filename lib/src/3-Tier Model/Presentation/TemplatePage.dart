import 'package:flutter/material.dart';
import 'package:migraine_aid/src/shared/staticTextWidget.dart';

class TemplatePage extends StatefulWidget {
  final Widget body;
  final String title;
  final List<Widget> buttons;

  const TemplatePage(
      {required this.body, required this.title, required this.buttons}
      );

  @override
  TemplatePageState createState() => TemplatePageState();
}

class TemplatePageState extends State<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 124, 154, 88),
              Color.fromARGB(255, 141, 184, 86),
              Color.fromARGB(255, 101, 120, 78),
              Color.fromARGB(255, 109, 144, 67)
            ])),
        child: Column(
          children: <Widget>[
            Expanded(
              child: widget.body,
            ),
            Container(
              padding: EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.buttons,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
