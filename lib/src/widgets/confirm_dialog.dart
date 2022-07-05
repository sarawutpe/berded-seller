import 'package:flutter/material.dart';

class ConfirmDialog {
  final BuildContext context;
  final String title;
  final VoidCallback onPress;

  ConfirmDialog({required this.context, required this.title, required this.onPress}) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(title),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ไม่', style: const TextStyle(color: Colors.grey),),
            ),
            TextButton(
              onPressed: onPress,
              child: Text(
                'ใช่',
              ),
            ),
          ],
        );
      },
    );
  }
}
