
import 'package:flutter/material.dart';
import 'package:berded_seller/src/pages/branch/branch_page.dart';
import 'package:berded_seller/src/pages/index.dart';
import 'package:berded_seller/src/pages/package/package_page.dart';
import 'package:berded_seller/src/pages/gallery/gallery_page.dart';
import 'package:berded_seller/src/pages/studio/studio_page.dart';
import 'package:berded_seller/src/pages/top_up/top_up_page.dart';

class AppRoute {
  static const login = 'login';
  static const forgot_password = 'forgot_password';
  static const branch = 'branch';
  static const home = 'home';
  static const studio = 'studio';
  static const gallery = 'gallery';
  static const store = 'store_menu';
  static const manage_menu = 'manage_menu';
  static const top_up = 'top_up';
  static const package = 'package';

  final _route = <String, WidgetBuilder>{
    login: (context) => LoginPage(),
    forgot_password: (context) => ForgotPasswordPage(),
    branch: (context) => BranchPage(),
    home: (context) => HomePage(),
    studio: (context) => StudioPage(),
    store: (context) => StoreMenuPage(),
    gallery: (context) => GalleryPage(),
    manage_menu: (context) => ManageMenuPage(),
    top_up: (context) => TopUpPage(),
    package: (context) => PackagePage(),
  };

  get getAll => _route;
}
