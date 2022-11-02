import 'package:flutter/material.dart';

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

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      labelText: 'Password',
                    ),
                  )),
              // Continue Button
              Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: OutlinedButton(
                    onPressed: () {},
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

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      labelText: 'Username',
                    ),
                  )),
              // Password Form Field
              Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      labelText: 'Password',
                    ),
                  )),
              // Continue Button
              Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: OutlinedButton(
                    onPressed: () {},
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
              // Sign In button
              Container(
                  margin: const EdgeInsets.only(top: 30),
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
