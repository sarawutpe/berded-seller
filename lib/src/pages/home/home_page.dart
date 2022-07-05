import 'dart:async';

import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/bloc/branch/branch_bloc.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/constants/constants.dart';
import 'package:berded_seller/src/pages/home/widgets/custom_drawer.dart';
import 'package:berded_seller/src/pages/home/widgets/home_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _refreshController = StreamController<void>();

  Future<void> restoreLoginMeta() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final metaJSON = prefs.getString(Constants.AUTHORIZED_META);
      if (metaJSON == null) {
        // logout
        context.read<LoginBloc>().add(LoginEventLogout());
      } else {
        // restore
        context.read<LoginBloc>().add(LoginEventRestore(false));
      }
    } catch (e) {
      logger.e(e.toString());
      context.read<LoginBloc>().add(LoginEventLogout());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _refreshController.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return FutureBuilder(
            future: restoreLoginMeta(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: ThemeColors.lightPrimary,
                  centerTitle: true,
                  title: _buildTitle(),
                  actions: [

                  ],
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    context.read<BranchBloc>().add(BranchEventRefreshMyBranch(streamController: this._refreshController));
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      HomeMenu(),
                    ],
                  ),
                ),
                drawer: CustomDrawer(),
              );
            },
          );
        });
  }

  Widget _buildTitle() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Text(state.result?.branch_name ?? "Loading...");
      },
    );
  }
}
