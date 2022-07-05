import 'package:berded_seller/src/bloc/branch/branch_bloc.dart';
import 'package:berded_seller/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:berded_seller/src/bloc/manage_menu/manage_menu_bloc.dart';
import 'package:berded_seller/src/bloc/studio/studio_bloc.dart';
import 'package:berded_seller/src/bloc/top_up/top_up_bloc.dart';
import 'package:berded_seller/src/pages/home/home_page.dart';
import 'package:berded_seller/src/pages/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'bloc/home/home_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/store_menu/store_menu_bloc.dart';
import 'constants/app_theme.dart';
import 'constants/constants.dart';
import 'pages/index.dart';

final navigatorState = GlobalKey<NavigatorState>();

final logger = Logger(
  printer: PrettyPrinter(
    colors: true,
  ),
);

final loggerNoStack = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    colors: true,
  ),
);

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) {
      Logger.level = Level.nothing;
    } else {
      Logger.level = Level.debug;
    }

    // prevent screen rotation on mobile
    if (!Device.get().isTablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    final loginBloc = BlocProvider<LoginBloc>(create: (context) => LoginBloc());
    final forgotPasswordBloc = BlocProvider<ForgotPasswordBloc>(create: (create) => ForgotPasswordBloc());
    final homeBloc = BlocProvider<HomeBloc>(create: (context) => HomeBloc());
    final storeMenuBloc = BlocProvider<StoreMenuBloc>(create: (context) => StoreMenuBloc());
    final manageMenuBloc = BlocProvider<ManageMenuBloc>(create: (context) => ManageMenuBloc());
    final branchBloc = BlocProvider<BranchBloc>(create: (context) => BranchBloc());
    final topUpBloc = BlocProvider<TopUpBloc>(create: (context) => TopUpBloc());
    final studioBloc = BlocProvider<StudioBloc>(create: (context) => StudioBloc());

    return MultiBlocProvider(providers: [
      loginBloc,
      forgotPasswordBloc,
      homeBloc,
      storeMenuBloc,
      manageMenuBloc,
      branchBloc,
      topUpBloc,
      studioBloc,
    ], child: _buildWithTheme(context));
  }
}

Widget _buildWithTheme(BuildContext context) {
  return Sizer(builder: (context, orientation, deviceType) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorState,
      routes: AppRoute().getAll,
      title: 'Berded Seller',
      themeMode: _themeMode(state: false),
      theme: appThemeData[AppTheme.Light],
      darkTheme: appThemeData[AppTheme.Dark],
      home: _initialPage(),
    );
  });
}

ThemeMode _themeMode({bool? state}) => state! ? ThemeMode.dark : ThemeMode.light;

// NOTE: Initial Page
_initialPage() {
  return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        // NOTE: Default view for transient duration.
        if (!snapshot.hasData)
          return Container(
            color: Colors.white,
          );

        // NOTE: Check authentication.
        final token = snapshot.data?.getString(Constants.ACCESS_TOKEN) ?? "";
        if (token.isEmpty) {
          return LoginPage();
        }else{
          return HomePage();
        }
      });
}
