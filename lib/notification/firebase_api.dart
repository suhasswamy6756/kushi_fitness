import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static void initialize() {
    AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'daily_greetings_channel',
          channelName: 'Daily Greetings',
          importance: NotificationImportance.Max,
          channelDescription: 'Channel for daily greetings notifications',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );
  }

  static void scheduleNotifications() {
    DateTime now = DateTime.now().add(const Duration(hours: 5, minutes: 30)); // Adjusted for Indian Standard Time

    sendNotification('Good Morning!', 'Start your day with some steps!', now.add(Duration(minutes: 55))); // Morning notification at 12:30 AM
    sendNotification('Good Afternoon!', 'Keep moving and stay healthy!', now.add(Duration(hours: 13))); // Afternoon notification at 1:00 PM
    sendNotification('Good Evening!', 'Great job! Keep going!', now.add(Duration(hours: 17))); // Evening notification at 5:00 PM
    sendNotification('Good Night!', 'Time to wind down. See you tomorrow!', now.add(Duration(hours: 21))); // Night notification at 9:00 PM
  }

  static void sendNotification(String title, String body, DateTime scheduledTime) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: scheduledTime.hour, // Unique ID for each notification hour
        channelKey: 'daily_greetings_channel',
        title: title,
        body: body,
      ),
      schedule: NotificationInterval(
        interval: 1440, // Interval in hours (24 hours for daily notifications)
        timeZone: 'Asia/Kolkata', // Time zone identifier for Indian Standard Time
        repeats: true,
      ),
    );
  }
}
