import 'package:flutter/material.dart' hide Page;

import '../../Application/NavigationService.dart';
import '../../Application/PageSetBuilder.dart';
import '../Widgets/BodyWidgets.dart';
import 'TemplatePage.dart';

class HomePage extends Page {
  HomePage(NavigationController controller) {
    Widget logMigraineButton = WidgetConstructor.createQuadButton(
        controller.toAttack,
        text: "Log Migraine",
        emoji: "🤯",
        color: Colors.red);
    Widget statisticsButton = WidgetConstructor.createQuadButton(
        controller.toStatistics,
        text: "Statistics",
        emoji: "📊",
        color: Colors.purple);
    Widget dailyLogButton = WidgetConstructor.createQuadButton(
        controller.toDailyLog,
        text: "Daily Log",
        emoji: "📅",
        color: Colors.deepOrangeAccent,
        shouldShake: true);
    Widget profileSettingsButton = WidgetConstructor.createQuadButton(
        controller.nextPage,
        text: "Profile Settings",
        emoji: "👤",
        color: Colors.blueGrey);

    List<Widget> quadrantWidgets = [
      logMigraineButton,
      statisticsButton,
      dailyLogButton,
      profileSettingsButton,
    ];

    Widget quadrant = WidgetConstructor.createQuadrantLayout(quadrantWidgets);
    Map<Widget, double> spacingConfig = {quadrant: 90};
    List<Widget> spacedQuadrant = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody =
        WidgetConstructor.addUXWrap(spacedQuadrant, title: "Home");
    template = TemplatePage(
      body: finalBody,
      buttons: const [],
    );
  }
}

class SettingsPage extends Page {
  SettingsPage(NavigationController navigationController) {
    Widget settingsList = ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 20),
      collapsedTextColor: Colors.white,
      textColor: Colors.white,
      backgroundColor: Colors.white10,
      title: WidgetConstructor.createText('Preferences'),
      subtitle: WidgetConstructor.createText('Initial setup questions'),
      children: <Widget>[
        ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 20),
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          title: WidgetConstructor.createText('Activities'),
          children: <Widget>[
            ListTile(
              textColor: Colors.white,
              title: WidgetConstructor.createText('Excercise Frequency'),
              subtitle:
                  WidgetConstructor.createText('How often do you exercise?'),
            ),
            ListTile(
                textColor: Colors.white,
                title: WidgetConstructor.createText('Water Consumption'),
                subtitle: WidgetConstructor.createText(
                    'How much water do you drink?'))
          ],
        ),
        ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 20),
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          title: WidgetConstructor.createText('Alcohol Consumption'),
          children: <Widget>[
            ListTile(
              textColor: Colors.white,
              title: WidgetConstructor.createText('Consumption Frequency'),
              subtitle: WidgetConstructor.createText(
                  'How often do you drink alcohol every week?'),
            ),
            ListTile(
                textColor: Colors.white,
                title:
                    WidgetConstructor.createText('Average Consumption Volume'),
                subtitle: WidgetConstructor.createText(
                    'On average, how much alcohol do you consume when you drink'))
          ],
        ),
        ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 20),
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          title: WidgetConstructor.createText('Diet'),
          children: <Widget>[
            ListTile(
              textColor: Colors.white,
              title: WidgetConstructor.createText('Dietary Plans'),
              subtitle: WidgetConstructor.createText(
                  'Do you follow any of these dietary plans and/or restrictions?'),
            ),
          ],
        ),
        ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 20),
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          title: WidgetConstructor.createText('Medical'),
          children: <Widget>[
            ListTile(
              textColor: Colors.white,
              title: WidgetConstructor.createText('Medical History'),
              subtitle: WidgetConstructor.createText(
                  'Tell us a bit about your Medical History'),
            ),
          ],
        ),
        ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 20),
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          title: WidgetConstructor.createText('Personal Information'),
          children: <Widget>[
            ListTile(
              textColor: Colors.white,
              title: WidgetConstructor.createText('Height'),
            ),
            ListTile(
              textColor: Colors.white,
              title: WidgetConstructor.createText('Weight'),
            ),
            ListTile(
              textColor: Colors.white,
              title: WidgetConstructor.createText('Sex'),
            ),
            ListTile(
              textColor: Colors.white,
              title: WidgetConstructor.createText('Date of Birth'),
            ),
          ],
        ),
      ],
    );
    Map<Widget, double> spacingConfig = {settingsList: 40};
    List<Widget> spacedBody = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedBody,
        backLogic: navigationController.previousPage, title: "Settings");
    template = TemplatePage(
      body: finalBody,
      buttons: const [],
    );
  }
}

class Statistics extends Page {
  List<String> stats;

  Statistics(NavigationController controller,
      {this.stats = const [
        "Height: ",
        "Weight: ",
        "Sex: N/A",
        "Date of Birth: 2023-05-19",
        "Excercise Frequency: Never",
        "Typical Excercise Intensity: None",
        "Daily Water Consumption: Not sure",
        "Meal Frequency: 1-2 meals per day",
        "Fruits Eaten Regularly: Not Selected",
        "Regular Caffiene Consumpution: Minimal (0-50mg)",
        "Regular Dairy Products Consumed: Not Selected",
        "Typical trigger products consumed: Not Selected",
        " Medications:",
        "Average Sleep: 7 hours",
        "Typical Migraine Type:"
      ]}) {
    Widget confirmationText = WidgetConstructor.createText(
        "Here is a list of your profile statistics, would you like to export to pdf?");

    Widget compiledQuestionList = SizedBox(
      height: 400, // Set height as required
      child: ListView.builder(
        itemCount: stats.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\t${stats[index]}'),
          );
        },
      ),
    );

    Map<Widget?, double> spacingConfig = {
      confirmationText: 30,
      compiledQuestionList: 0
    };

    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);

    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Profile Statistics:");

    template = TemplatePage(body: finalBody, buttons: [
      WidgetConstructor.createButton(controller.toHome,
          text: "Export To PDF", color: Colors.red),
      WidgetConstructor.createButton(controller.toHome, text: "Return Home")
    ]);
  }
}
