import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
            body: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 60),
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
                      "Settings",
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    const SizedBox(height: 30),
                    const ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 20),
                      collapsedTextColor: Colors.white,
                      textColor: Colors.white,
                      backgroundColor: Colors.white10,
                      title: Text('Preferences'),
                      subtitle: Text('Initial setup questions'),
                      children: <Widget>[
                        ExpansionTile(
                          childrenPadding: EdgeInsets.only(left: 20),
                          collapsedTextColor: Colors.white,
                          textColor: Colors.white,
                          title: Text('Activities'),
                          children: <Widget>[
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Excercise Frequency'),
                              subtitle: Text('How often do you exercise?'),
                            ),
                            ListTile(
                                textColor: Colors.white,
                                title: Text('Water Consumption'),
                                subtitle: Text('How much water do you drink?'))
                          ],
                        ),
                        ExpansionTile(
                          childrenPadding: EdgeInsets.only(left: 20),
                          collapsedTextColor: Colors.white,
                          textColor: Colors.white,
                          title: Text('Alcohol Consumption'),
                          children: <Widget>[
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Consumption Frequency'),
                              subtitle: Text(
                                  'How often do you drink alcohol every week?'),
                            ),
                            ListTile(
                                textColor: Colors.white,
                                title: Text('Average Consumption Volume'),
                                subtitle: Text(
                                    'On average, how much alcohol do you consume when you drink'))
                          ],
                        ),
                        ExpansionTile(
                          childrenPadding: EdgeInsets.only(left: 20),
                          collapsedTextColor: Colors.white,
                          textColor: Colors.white,
                          title: Text('Diet'),
                          children: <Widget>[
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Dietary Plans'),
                              subtitle: Text(
                                  'Do you follow any of these dietary plans and/or restrictions?'),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          childrenPadding: EdgeInsets.only(left: 20),
                          collapsedTextColor: Colors.white,
                          textColor: Colors.white,
                          title: Text('Medical'),
                          children: <Widget>[
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Medical History'),
                              subtitle: Text(
                                  'Tell us a bit about your Medical History'),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          childrenPadding: EdgeInsets.only(left: 20),
                          collapsedTextColor: Colors.white,
                          textColor: Colors.white,
                          title: Text('Personal Information'),
                          children: <Widget>[
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Height'),
                            ),
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Weight'),
                            ),
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Sex'),
                            ),
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Date of Birth'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
