import 'package:flutter/material.dart';
import 'package:migraine_aid/src/shared/staticTextWidget.dart';

// NOTE: THIS IS A TEMPLATE PAGE. MAKE BETTER IF POSSIBLE
class BasePage extends StatefulWidget {
  final Widget body;
  final String title;
  final List<Widget> buttons;

  const BasePage({required Key key, required this.body, required this.title, required this.buttons}) : super(key: key);

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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