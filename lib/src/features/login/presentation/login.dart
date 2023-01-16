import 'package:flutter/material.dart';

import '../../create-account/presentation/signup.dart';
import '../application/login_authentication.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = TextEditingController();
    final passwordController = TextEditingController();
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
              // Back Arrow Button
              Transform.translate(
                offset: const Offset(-20, 0),
                child: IconButton(
                  color: const Color.fromARGB(255, 101, 101, 101),
                  icon: const Icon(Icons.arrow_back_ios),
                  tooltip: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Text(
                'Sign In',
                style: TextStyle(
                    fontSize: 50, color: Color.fromARGB(255, 255, 255, 255)),
              ),
              // Username Field Form
              Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: TextFormField(
                    controller: userController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      labelText: 'Username',
                    ),
                  )),
              // Password Field Form
              Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  )),
              // Continue Button
              Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: OutlinedButton(
                    onPressed: () async {
                        await doUserLogin(
                        userController.text.trim(),
                        passwordController.text.trim());
                  },
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 255, 255, 255)),
                      minimumSize: const Size(330, 70),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  )),
              // Sign In With Google Button
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        minimumSize: const Size(330, 70),
                        backgroundColor:
                        const Color.fromARGB(255, 223, 80, 80)),
                    child: const Text(
                      "Sign In With Google",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  )),
              // Create New Account Button
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                        minimumSize: const Size(330, 70),
                        backgroundColor:
                        const Color.fromARGB(255, 255, 255, 255)),
                    child: const Text(
                      "Create New Account",
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
