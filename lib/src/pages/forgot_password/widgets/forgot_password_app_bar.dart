import 'package:berded_seller/src/bloc/branch/branch_bloc.dart';
import 'package:berded_seller/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/bloc/manage_menu/manage_menu_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../router.dart';

class ForgotPasswordAppBar extends StatelessWidget {
  final String title;
  const ForgotPasswordAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 55,
        child: AppBar(
          backgroundColor: ThemeColors.lightPrimary,
          title: Text(title),
          leading: IconButton(onPressed: () => Navigator.pushReplacementNamed(context, AppRoute.login), icon: Icon(Icons.close)),
        ),
      ),
    );
  }
}
