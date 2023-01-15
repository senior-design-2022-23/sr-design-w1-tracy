import 'dart:js';

import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/presentation/sleeppage.dart';


class DietPage extends StatelessWidget {
  const DietPage ({Key? key}) : super(key: key);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Do you have any of the following"
                    " dietary preferences and/or restrictions?",
                style: TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              const SizedBox(height: 30),
              Container(
                  padding: const EdgeInsets.all(15),
                  child: ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    alignment: MainAxisAlignment.spaceBetween,
                    buttonPadding: const EdgeInsets.all(2),
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: _dietChoice("SAD - Standard American Diet", context),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: _dietChoice("AFD - Asian Food Diet", context),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: _dietChoice("FFD - Fast Food Diet", context),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: _dietChoice("Pescatarian / Mediterranean Diet", context),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: _dietChoice("Gluten Free Diet", context),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: _dietChoice("Vegetarian Diet", context),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: _dietChoice("Vegan Diet", context),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: _dietChoice("Paleo Diet", context),
                      ),
                    ]
                  )),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SleepPage()));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text(
                      "CONTINUE",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )

                  )
              )
            ]
          )
        )
      )
    );
  }

  OutlinedButton _dietChoice(String option, BuildContext context) {
    return(
      OutlinedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:  (context) => const DietPage())); // TODO),);
        },
        style: TextButton.styleFrom(
          side: const BorderSide(width: 1, color: Color.fromARGB(255, 255, 255, 255)),
          backgroundColor: const Color.fromARGB(255, 8, 8, 8),
          minimumSize: const Size(300, 60),
        ),
        child: Text(
          option,
          style: const TextStyle(
              fontSize: 17,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      )
    );
  }
  
}