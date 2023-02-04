import 'package:animation_sample/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

///
/// Business Logic Class for Notification
///
class NotificationService {
  NotificationService();

  final _localNotificationHandler = FlutterLocalNotificationsPlugin();

  ///
  /// Initialize the handler
  ///
  Future<void> init(
      {bool initScheduled = false, required BuildContext context}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _localNotificationHandler
        .initialize(const InitializationSettings(android: android),
            onDidReceiveNotificationResponse: (response) async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SecondPage(taskName: response.payload ?? '')));
    }, onDidReceiveBackgroundNotificationResponse: backGroundHandler());
  }

  ///
  /// Send a notification from application
  ///
  void sendPushNotification(
      {int id = 0,
      required String title,
      required String body,
      required String payLoad,
      required DateTime now,
      required DateTime taskDue}) async {
    if (_initNotification(now, taskDue)) {
      _localNotificationHandler.show(
          id, title, body, _createNotificationDetails(),
          payload: payLoad);
    }
  }

  ///
  /// Create a new instance of Notification Details
  ///
  NotificationDetails _createNotificationDetails() {
    // TODO: I need to understand what this guy is doing
    const NotificationDetails _notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
    );

    return _notificationDetails;
  }

  ///
  /// Enable local push-notification based on 2 dates
  /// [currentDate] 現在の日付
  /// [taskDueDate]　タスクの締め切り日時
  ///
  bool _initNotification(DateTime currentDate, DateTime taskDueDate) {
    // Task will be notified 3 days before or overdue
    if (taskDueDate.difference(currentDate).inDays <= 3.0) {
      return true;
    }
    return false;
  }

  ///
  /// Method for returning from background
  ///
  backGroundHandler() {}
}
