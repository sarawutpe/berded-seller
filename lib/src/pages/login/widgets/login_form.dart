import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/bloc/branch/branch_bloc.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/models/response/branch_response_model.dart';
import 'package:berded_seller/src/models/user_model.dart';
import 'package:berded_seller/src/pages/router.dart';
import 'package:berded_seller/src/services/network_service.dart';
import 'package:berded_seller/src/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showClearButton = false;

  showError() async {
    await Flushbar(
      title: 'Error - cannot connect to server',
      message: 'Please internet connection',
      duration: Duration(seconds: 3),
    ).show(navigatorState.currentContext!);
  }

  @override
  void initState() {
    final MyBranchesResponse? selectedBranch = navigatorState.currentContext!.read<BranchBloc>().state.selectedBranch;
    _usernameController.text = selectedBranch?.email ?? '';
    super.initState();
    // set state clear button
    _usernameController.addListener(() {
      setState(() {
        _showClearButton = _usernameController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Card(
                      child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[ ]'))],
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "ชื่อผู้ใช้",
                            suffixIcon: _showClearButton
                                ? IconButton(
                                    onPressed: () => _usernameController.clear(),
                                    icon: Icon(Icons.clear, color: ThemeColors.lightPrimary),
                                  )
                                : null,
                            icon: Padding(
                              padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
                              child: Image.asset(
                                'assets/icon/ic_user.png',
                                width: 25,
                                height: 25,
                              ),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Card(
                      child: TextField(
                        obscureText: state.isHidePassword ? false : true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "รหัสผ่าน",
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/icon/ic_password.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                context.read<LoginBloc>().add(LoginEventHidePassword());
                              },
                              icon: state.isHidePassword
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: ThemeColors.lightPrimary,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: ThemeColors.lightPrimary,
                                    )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: state.isFetching
                            ? null
                            : () {
                                if (_usernameController.text != "" && _passwordController.text != "") {
                                  final user = User(username: _usernameController.text.trim(), password: _passwordController.text.trim());
                                  context.read<LoginBloc>().add(LoginEventLogin(user));
                                  this._passwordController.clear();
                                }
                              },
                        style: ElevatedButton.styleFrom(primary: ThemeColors.lightPrimary),
                        child: state.isFetching ? Text("กำลังโหลด") : Text("เข้าสู่ระบบ"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await AppTrackingTransparency.requestTrackingAuthorization();
                          Navigator.pushNamed(context, AppRoute.forgot_password);
                        },
                        child: const Text(
                          "ลืมรหัสผ่าน",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
