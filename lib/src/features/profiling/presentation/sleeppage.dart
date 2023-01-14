import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class SleepPage extends StatelessWidget {
  const SleepPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarouselController ccontroller = CarouselController();
    List<String> hrsSlept = ["2", "3", "4", "5", "6", "7", "8", "9", "10"];

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
                "Approximately, how many hours of sleep do you get a night?",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white
                )
              ),
              CarouselSlider(
                carouselController: ccontroller,
                options: CarouselOptions(),
                items: hrsSlept.map((e) => Container(
                    color: Colors.transparent,
                    child: Center(child:
                    Text(e.toString(),
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white),
                    )),
                )).toList()
              )
            ],
          )
      )
      )
    );
  }

}