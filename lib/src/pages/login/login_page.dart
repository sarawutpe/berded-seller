import 'package:berded_seller/src/bloc/branch/branch_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/pages/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.lightPrimary,
        title:  Text("เข้าสู่ระบบผู้ขาย"),
        centerTitle: true,
        automaticallyImplyLeading: context.read<BranchBloc>().state.isSwitchBranch,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 96.w,
          height: double.infinity,
          child: LoginForm(),
        ),
      ),
    );
  }
}


