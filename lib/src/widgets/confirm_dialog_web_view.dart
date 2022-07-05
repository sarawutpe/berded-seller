import 'package:flutter/material.dart';

class ConfirmDialogWebView extends StatelessWidget {
  final String title;
  final String content;
  const ConfirmDialogWebView({required this.title, required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('ไม่'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('ใช่'),
        ),
      ],
    );
  }
}
