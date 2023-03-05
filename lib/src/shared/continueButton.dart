import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// CODE FOR CONTINUE BUTTON. Must pass in a callback function for onPress.
class ContinueButton extends StatefulWidget {
  final VoidCallback callback;
  final Widget content;
  const ContinueButton({super.key, required this.callback, this.content = const Text(
    "Continue",
    style: TextStyle(
        fontSize: 17,
        color: Color.fromARGB(255, 255, 255, 255)),
  ),});
  @override
  ContinueButtonState createState() => ContinueButtonState();
}

class ContinueButtonState extends State<ContinueButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        margin: const EdgeInsets.only(top: 10),
        child: OutlinedButton(
            onPressed: widget.callback,
            style: TextButton.styleFrom(
              side: const BorderSide(
                  width: 1, color: Color.fromARGB(255, 255, 255, 255)),
              minimumSize: const Size(330, 70),
            ),
            child: widget.content
        ));
  }
}