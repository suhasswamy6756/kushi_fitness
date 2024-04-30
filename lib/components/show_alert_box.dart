import 'package:flutter/material.dart';
class ShowAlertBox extends StatelessWidget {
  String text;
   ShowAlertBox({
    super.key,
    required this.text,

  });

  @override
  Widget build(BuildContext context) {

        return AlertDialog(
          title: const Text('alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );

  }
}
