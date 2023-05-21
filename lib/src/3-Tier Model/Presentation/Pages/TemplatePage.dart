import 'package:flutter/material.dart' hide Page;
import 'package:migraine_aid/src/shared/staticTextWidget.dart';

import '../../Application/NavigationService.dart';
import '../../Application/PageSetBuilder.dart';
import '../Widgets/BodyWidgets.dart';

class TemplatePage extends StatefulWidget {
  final Widget body;
  final List<Widget> buttons;

  const TemplatePage({required this.body, required this.buttons});

  @override
  TemplatePageState createState() => TemplatePageState();
}

class TemplatePageState extends State<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: widget.body,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(18),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing:
                        8, // Adjust the spacing between buttons horizontally
                    runSpacing:
                        8, // Adjust the spacing between buttons vertically
                    alignment: WrapAlignment.center,
                    children: widget.buttons,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransitionPage extends Page {
  final String _pageText;
  Function()? continueLocation;
  _TransitionPage(this._pageText, NavigationController controller,
      {continueLocation, backLocation}) {
    continueLocation ??= controller.nextPage;
    backLocation ??= controller.previousPage;
    Widget transitionText = WidgetConstructor.createText(_pageText,
        fontSize: 50, align: TextAlign.center);
    Map<Widget?, double> spacingConfig = {
      transitionText: 70,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage);
    template = TemplatePage(
        body: finalBody,
        buttons: [WidgetConstructor.createButton(continueLocation)]);
  }
}

class TransitionPageFactory {
  Function()? continueLocation;
  static createTransitionPage(
      String largeText, NavigationController navigationController,
      {continueLocation, backLocation}) {
    return _TransitionPage(largeText, navigationController,
        continueLocation: continueLocation, backLocation: backLocation);
  }
}
