import 'package:flutter/material.dart';

// This takes in a text and a fontSize, and follows our decorations for text.
class StaticTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  const StaticTextWidget({super.key, required this.text, this.fontSize = 20.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
            fontSize: fontSize,
            color: const Color.fromARGB(255, 255, 255, 255)),
      );
  }
}