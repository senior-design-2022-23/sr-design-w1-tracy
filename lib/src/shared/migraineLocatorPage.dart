import 'package:flutter/material.dart';
import 'modelViewerAdapter.dart';

class MigraineLocatorPage extends StatefulWidget {
  const MigraineLocatorPage({super.key});

  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<MigraineLocatorPage> {
  @override
  Widget build(BuildContext context) {
    var proxy = ModelViewerProxy();
    return Scaffold(
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: const Alignment(-.50, 0),
            child: FloatingActionButton(
              onPressed: () {
                proxy.prevModel();
              },
              child: const Icon(Icons.navigate_before),
            ),
          ),
          Align(
            alignment: const Alignment(.50, 0),
            child: FloatingActionButton(
              onPressed: () {
                proxy.nextModel();
              },
              child: const Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
      body: proxy.createModelView(),
    );
  }
}
