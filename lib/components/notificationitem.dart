import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final DateTime time;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat.Hm().format(time).toString();
    return Dismissible(
      key: Key(time.toString()), // Unique key for each notification
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Implement delete action here
        // Example: Delete the notification from the list
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notification deleted'),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                // Implement undo action here
              },
            ),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(message),
            trailing: Text(formattedDate),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Divider(
              height: 2.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
