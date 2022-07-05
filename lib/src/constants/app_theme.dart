import 'package:flutter/material.dart';

enum AppTheme { Light, Dark }

final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
  ),
  AppTheme.Dark: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white
  )
};

class ThemeColors {
  // Light Mode.
  static Color lightPrimary = Color(0xFFCD3234);
  // Text Alert
  static Color lightTextErrorAlert = Color(0XFFD32F2F);
  static Color lightTextWarningAlert = Color(0XFFED6C02);
  static Color lightTextInfoAlert = Color(0XFF0288D1);
  static Color lightTextSuccessAlert = Color(0XFF2E7D32);

  static Color lightQRCode = Colors.grey.shade900;
  static Color lightIcon = Colors.black45;
  static Color lightTextHint = Colors.black26;
  static Color lightText = Colors.black;
  static Color lightTextTotal = Colors.blue;
  static Color lightIconDelete = Colors.red;
  static Color lightHeaderTable = Colors.grey.shade200;
  static Color lightBodyTable = Colors.white70;
  static Color lightFillTextField = Colors.grey.shade100;
  static Color lightTextInTextField = Colors.grey.shade700;
  static Color lightRowSelected = Colors.blue.shade50;
  static Color lightStockAmount = Colors.red;
  static Color lightCardDialog = Colors.grey.shade200;
  static Color lightBorder = Colors.grey.shade300;

  // Light Mode Dialog.
  static Color lightTextInDialog = Colors.black38;
  static Color lightTextTotalInDialog = Colors.blue;
  static List<Color> lightIconSuccessInDialog = <Color>[
    Colors.blueAccent,
    Colors.lightBlueAccent,
  ];

  // Dark Mode.
  static Color darkQRCode = Colors.white70;
  static Color darkIcon = Colors.white;
  static Color darkTextHint = Colors.white60;
  static Color darkText = Colors.white;
  static Color darkTextTotal = Colors.green;
  static Color darkIconDelete = Colors.white70;
  static Color darkHeaderTable = Colors.grey.shade800;
  static Color darkBodyTable = Colors.grey.shade800;
  static Color darkFillTextField = Colors.grey.shade600;
  static Color darkTextInTextField = Colors.white;
  static Color darkRowSelected = Colors.grey.shade700;
  static Color darkStockAmount = Colors.blue.shade600;
  static Color darkCardDialog = Colors.grey.shade700;
  static Color darkBorder = Colors.grey.shade600;

  // Dark Mode Dialog.
  static Color darkTextInDialog = Colors.white;
  static Color darkTextTotalInDialog = Colors.green;
  static List<Color> darkIconSuccessInDialog = <Color>[
    Colors.green,
    Colors.lightGreen,
  ];

}