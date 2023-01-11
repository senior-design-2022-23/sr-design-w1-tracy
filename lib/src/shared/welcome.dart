import 'package:flutter/material.dart';

import '../features/create-account/presentation/signup.dart';
import '../features/login/presentation/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Top Level Container
    return Container(
      // Background Gradient Decoration
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

      // Structural Container for Widgets
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.only(top: 100, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Welcome!',
                style: TextStyle(
                    fontSize: 50, color: Color.fromARGB(255, 255, 255, 255)),
              ),
              const Text(
                'To begin tracking migraines login below',
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
              ),

              // Sign Up Button
              Container(
                  margin: const EdgeInsets.only(top: 325),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 255, 255, 255)),
                      minimumSize: const Size(330, 70),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  )),

              // Sign In Button
              Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                        minimumSize: const Size(330, 70),
                        backgroundColor:
                        const Color.fromARGB(255, 255, 255, 255)),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 17, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}