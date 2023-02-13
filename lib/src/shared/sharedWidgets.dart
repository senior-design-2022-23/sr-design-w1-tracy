import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:migraine_aid/src/shared/userFunctions.dart';
import 'package:migraine_aid/src/shared/welcome.dart';

class AuthenticationWidget extends StatelessWidget {
  final Widget child;

  const AuthenticationWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state == AuthenticationState.authenticated) {
          return child;
        }
        return const WelcomePage();
      },
    );
  }
}
=======

class ErrorPopup extends StatelessWidget {
  final String errorMessage;

  const ErrorPopup({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
            minimumSize: const Size(100, 40),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
              child: const Text(
                "Continue",
              style: TextStyle(
                fontSize: 17,
                color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
>>>>>>> main
