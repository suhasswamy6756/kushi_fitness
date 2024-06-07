import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class notify {
  // Initialize notification channels
  static Future<void> initializeNotification() async {
    try {
      await AwesomeNotifications().initialize(
        null, // Use default icon
        [
          NotificationChannel(
            channelKey: 'flutter_schedule_channel',
            channelName: 'Flutter Schedule Channel',
            channelDescription: 'This channel is used for scheduling fitness reminders.',
            importance: NotificationImportance.Max,
            defaultPrivacy: NotificationPrivacy.Public,
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            defaultColor: Colors.transparent,
            locked: true,
            enableVibration: true,
            playSound: true,
          ),
        ],
      );
      print("Notification channel initialized successfully.");
    } catch (e) {
      print("Error initializing notification channel: $e");
    }
  }

  // Schedule daily notifications
  static Future<void> scheduleDailyNotifications() async {
    try {
      String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

      await _scheduleNotification('Good Morning!', 'Start your day with some steps!', 8, localTimeZone); // 8:00 AM
      await _scheduleNotification('Good Afternoon!', 'Keep moving and stay healthy!', 13, localTimeZone); // 1:00 PM
      await _scheduleNotification('Good Evening!', 'Great job! Keep going!', 17, localTimeZone); // 5:00 PM
      await _scheduleNotification('Good Night!', 'Time to wind down. See you tomorrow!', 21, localTimeZone); // 9:00 PM
      print("Daily notifications scheduled successfully.");
    } catch (e) {
      print("Error scheduling daily notifications: $e");
    }
  }

  // Helper method to schedule a single notification
  static Future<void> _scheduleNotification(String title, String body, int hour, String localTimeZone) async {
    try {
      int notificationId = _generateUniqueId();

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'flutter_schedule_channel',
          title: title,
          body: body,
          notificationLayout: NotificationLayout.BigText,
          locked: true,
          wakeUpScreen: true,
          autoDismissible: false,
          fullScreenIntent: true,
          backgroundColor: Colors.transparent,
        ),
        schedule: NotificationCalendar(
          hour: hour,
          minute: 0,
          second: 0,
          millisecond: 0,
          timeZone: localTimeZone,
          repeats: true, // Ensures the notification repeats daily
          preciseAlarm: true, // Ensure precise alarm
          allowWhileIdle: true, // Allow notification while the device is idle
        ),
        actionButtons: [
          NotificationActionButton(
            key: "close",
            label: "Close Reminder",
            autoDismissible: true,
          ),
        ],
      );
      print("Notification scheduled: $title at $hour:00");
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }

  // Generate a unique ID for each notification
  static int _generateUniqueId() {
    Random random = Random();
    return random.nextInt(1000000) + 1;
  }
}


