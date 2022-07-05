import 'package:berded_seller/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

getFullAvatarImagePath(String imagePath) {
  if (imagePath.isEmpty) {
    return AssetImage('assets/icon/ic_launcher_android.png');
  } else {
    return NetworkImage('${Constants.IMAGE_PATH}/profile/$imagePath');
  }
}

getFullProfileImagePath(String imagePath) {
  if (imagePath.isEmpty) {
    return AssetImage('assets/icon/ic_launcher_android.png');
  } else {
    return NetworkImage('$imagePath');
  }
}

getOperatorImagePath(String imagePath, double width, double height) {
  if (imagePath.isEmpty) {
    return Image.asset('assets/icon/ic_circle.png', width: 40, height: 40,);
  } else {
    final newPath = "ic_op_${imagePath.toLowerCase().replaceAll(" ", "_")}.png";
    return Image.asset('assets/icon/$newPath', width: width, height: height,);
  }
}
