import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/login/presentation/login.dart';
import 'package:migraine_aid/src/features/profiling/presentation/activitypage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/dietpage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/dietpage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/medicalpage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/personalinfopage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/sleeppage.dart';
import 'package:migraine_aid/src/shared/welcome.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'HZzudajLjqIOuUlTKJekdUyC3GKt5MzrBls7gJGZ';
  const keyClientKey = 'GYMIP6tfliC7C4s2HpUouH1MQkffo6WvXCnDu7uQ';
  const keyParseServerUrl = 'https://parseapi.back4app.com';
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
      home: ActivityPage() // Initial page upon launch
    );
  }
}