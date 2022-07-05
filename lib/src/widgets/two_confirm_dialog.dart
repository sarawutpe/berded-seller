import 'package:flutter/material.dart';

class TwoConfirmDialog {
  final BuildContext context;
  final String title;
  final String firstLabel;
  final String secondLabel;
  final VoidCallback onPressFirstButton;
  final VoidCallback onPressSecondButton;

  TwoConfirmDialog({
    required this.context,
    required this.title,
    required this.firstLabel,
    required this.secondLabel,
    required this.onPressFirstButton,
    required this.onPressSecondButton,
  }) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(title),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ยกเลิก',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: onPressFirstButton,
              child: Text(firstLabel),
            ),
            TextButton(
              onPressed: onPressSecondButton,
              child: Text(secondLabel),
            )
          ],
        );
      },
    );
  }
}
