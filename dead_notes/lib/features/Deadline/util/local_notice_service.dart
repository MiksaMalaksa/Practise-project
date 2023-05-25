import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class LocalNoticeService {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    // #1
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

    // #2
    const initSettings =
    InitializationSettings(android: androidSetting);

    // #3
    await _localNotificationsPlugin.initialize(initSettings).then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }

  Future<void> addNotification({
    required String title,
    required String body,
    required int endTime,
    required String channel,
  }) async {
    // #1
    tzData.initializeTimeZones();
    final scheduleTime =
    tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, endTime);

    // #2
    final androidDetail = AndroidNotificationDetails(
        channel, // channel Id
        channel  // channel Name
    );

    final noticeDetail = NotificationDetails(
      android: androidDetail,
    );
    NotificationDetails(android: AndroidNotificationDetails(channel, channel, icon: '@mipmap/ic_launcher', importance: Importance.high,));
    // #3
    final id = 0;
    // #4
    await _localNotificationsPlugin.show(
      id,
      title,
      body,
      noticeDetail,
    );
  }


}