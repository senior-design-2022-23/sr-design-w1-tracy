import 'package:flutter/material.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';
import 'modelViewerAdapter.dart';

class MigraineLocatorPage extends StatefulWidget {
  const MigraineLocatorPage({super.key});

  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<MigraineLocatorPage> {
  int headIndex = 0;
  @override
  Widget build(BuildContext context) {
    var proxy = ModelViewerProxy();
    return Scaffold(
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: const Alignment(-.50, -.20),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  headIndex -= 1;
                  proxy.loadModel(headIndex);
                });
              },
              child: const Icon(Icons.navigate_before),
            ),
          ),
          Align(
            alignment: const Alignment(.50, -.20),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  headIndex += 1;
                  proxy.loadModel(headIndex);
                });
              },
              child: const Icon(Icons.navigate_next),
            ),
          ),
          Align(
              alignment: const Alignment(0, -.50),
              child: ContinueButton(callback: () {})),
        ],
      ),
      body: proxy.init(),
    );
  }
}
