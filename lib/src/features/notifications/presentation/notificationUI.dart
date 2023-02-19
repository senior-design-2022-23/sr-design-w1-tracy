import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class AppNotification {
  AppNotification();
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void scheduleNotification(String notificationTitle,
      String notificationBody, Duration duration) async {
    await _initTimezone();
    _initLocalNotifications();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        //NOTE: CHANGE ID FOR PRODUCTION
        0,
        notificationTitle,
        notificationBody,
        tz.TZDateTime.now(tz.local).add(duration),
        const NotificationDetails(
            android: AndroidNotificationDetails('TestID', 'Daily Form Channel',
                'Trigger Report has beeb generated')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future<void> _initTimezone() async {
    String timezone = "";
    tz.initializeTimeZones();
    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      print('Could not get the local timezone');
    }
    tz.setLocalLocation(tz.getLocation(timezone));
  }

  static void _initLocalNotifications() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('test');

    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
