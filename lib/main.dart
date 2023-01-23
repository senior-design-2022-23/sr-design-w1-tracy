import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/presentation/dietpage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/dietpage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/medicalpage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/sleeppage.dart';
import 'package:migraine_aid/src/shared/welcome.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = 'HZzudajLjqIOuUlTKJekdUyC3GKt5MzrBls7gJGZ';
  final keyClientKey = 'GYMIP6tfliC7C4s2HpUouH1MQkffo6WvXCnDu7uQ';
  final keyParseServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DietPage(), // Initial page upon launch
    );
  }
}
