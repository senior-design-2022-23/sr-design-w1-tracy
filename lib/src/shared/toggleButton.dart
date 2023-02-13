import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  @override
  final ValueSetter<String> callback;
  const ToggleButton({super.key, required this.callback});
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