import 'package:flutter/material.dart';

class ErrorPopup extends StatelessWidget {
  final String errorMessage;

  const ErrorPopup({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.red,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}