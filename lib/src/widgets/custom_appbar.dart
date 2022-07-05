import 'package:berded_seller/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onGoBack;
  final VoidCallback? onGoForward;
  final VoidCallback? onOpenSearch;
  final VoidCallback? onReload;
  final VoidCallback? onGoHome;
  final VoidCallback? onOpenSideMenu;

  const CustomAppBar({Key? key, required this.title, this.onGoBack, this.onGoForward, this.onReload, this.onGoHome, this.onOpenSideMenu, this.onOpenSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginState state = context.read<LoginBloc>().state;
    final bool statusActive = state.result?.status == 'A';
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 55,
        child: AppBar(
          backgroundColor: ThemeColors.lightPrimary,
          title: Text(title),
          leading: IconButton(
              onPressed: () => statusActive ? Navigator.pop(context) : context.read<LoginBloc>().add(LoginEventLogout()), icon: Icon(statusActive == true ? Icons.close : Icons.logout )),
          actions: [
            if (onGoHome != null) IconButton(onPressed: onGoHome, icon: Icon(Icons.home, color: Colors.white,)),
            if (onGoBack != null) IconButton(onPressed: onGoBack, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
            if (onGoForward != null) IconButton(onPressed: onGoForward, icon: Icon(Icons.arrow_forward_ios, color: Colors.white,)),
            if (onReload != null) IconButton(onPressed: onReload, icon: Icon(Icons.refresh)),
            if (onOpenSearch != null) IconButton(onPressed: onOpenSearch, icon: Icon(Icons.search)),
            if (onOpenSideMenu != null) IconButton(onPressed: onOpenSideMenu, icon: Icon(Icons.menu))
          ],
        ),
      ),
    );
  }
}
