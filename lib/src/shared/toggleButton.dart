import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// YES NO TOGGLE BUTTON
class ToggleButton extends StatefulWidget {
  final ValueSetter<String> callback;
  const ToggleButton({super.key, required this.callback});
  @override
  ToggleButtonState createState() => ToggleButtonState();

}

class ToggleButtonState extends State<ToggleButton> {
  bool _isYes = true;

  void _toggle() {
    setState(() {
      _isYes = !_isYes;
      _isYes? widget.callback("T") : widget.callback("F");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(_isYes ? 'YES' : 'NO'),
      onPressed: _toggle,
    );
  }
}