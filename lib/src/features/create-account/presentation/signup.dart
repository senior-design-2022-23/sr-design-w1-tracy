import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/presentation/personalinfopage.dart';
import 'package:migraine_aid/src/shared/userFunctions.dart';

import '../../login/presentation/login.dart';
import '../application/authentication.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerFirstName = TextEditingController();
    final controllerLastName = TextEditingController();
    final controllerUsername = TextEditingController();
    final controllerPassword = TextEditingController();
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
                'Sign Up',
                style: TextStyle(
                    fontSize: 50, color: Color.fromARGB(255, 255, 255, 255)),
              ),

              // Container for same line Text Field
              Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Row(children: <Widget>[
                    Flexible(
                      flex: 0,
                      // First Name Form Field
                      child: TextFormField(
                        controller: controllerFirstName,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          constraints: BoxConstraints(maxWidth: 150),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          labelText: 'First Name',
                        ),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 10,
                      // Last Name Form Field
                      child: TextFormField(
                        controller: controllerLastName,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          labelText: 'Last Name',
                        ),
                      ),
                    ),
                    const Spacer()
                  ])),
              // Username Form Field
              Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: TextFormField(
                    controller: controllerUsername,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      labelText: 'Email',
                    ),
                  )),
              // Password Form Field
              Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: TextFormField(
                    controller: controllerPassword,
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
                  margin: const EdgeInsets.only(top: 40),
                  child: OutlinedButton(
                    onPressed: () async {
                      String message = await registerUserByEmail(
                          controllerUsername.text.trim(),
                          controllerUsername.text.trim(),
                          controllerPassword.text.trim(),
                          controllerFirstName.text.trim(),
                          controllerLastName.text.trim());
                      if (await hasUserLogged()) {
                        goToPage(
                            context,
                            PersonalInformationPage(
                                name: controllerFirstName.text.trim()));
                      } else {
                        //do something with message (maybe showError(message))
                      }
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
              // Sign-in with Google button
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      String message = await registerUserByGoogle(
                          controllerFirstName.text.trim(),
                          controllerLastName.text.trim());
                      if (await hasUserLogged()) {
                        goToPage(
                            context,
                            PersonalInformationPage(
                                name: controllerFirstName.text.trim()));
                      }
                    },
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
              // Sign In button
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      goToPage(context, const SignUpPage());
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
