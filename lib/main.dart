import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/NavigationService.dart';
import 'package:migraine_aid/src/shared/welcome.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // const keyApplicationId = 'HZzudajLjqIOuUlTKJekdUyC3GKt5MzrBls7gJGZ';
  // const keyClientKey = 'GYMIP6tfliC7C4s2HpUouH1MQkffo6WvXCnDu7uQ';
  // const keyParseServerUrl = 'https://parseapi.back4app.com';
  // await Parse().initialize(keyApplicationId, keyParseServerUrl,
  //     clientKey: keyClientKey, autoSendSessionId: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final NavigationService pageNavigator = NavigationService(WelcomePage());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: pageNavigator // Initial page upon launch
        );
  }
}
