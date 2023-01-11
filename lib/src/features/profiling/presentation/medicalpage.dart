import 'package:flutter/material.dart';

class MedicalPageIntro extends StatelessWidget {
  const MedicalPageIntro ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container (
          child: Column (
            children: <Widget>[
              const Text("Tell us a bit about your Medical History",
                  style: TextStyle(
                      fontSize: 40, color: Colors.white
                  )),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextButton(
                  style: TextButton.styleFrom(
                    side: const BorderSide(width: 1, color: Colors.white),
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.green
                  ),
                  onPressed: () {  },
                  child: const Text(
                    "Continue...",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                    ),
                  ),
                )]
            )
          )
        )
      );
  }



}