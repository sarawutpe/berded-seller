import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:berded_seller/src/bloc/branch/branch_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/constants/constants.dart';
import 'package:berded_seller/src/models/authorized_branch.dart';
import 'package:berded_seller/src/models/response/login_response_model.dart';
import 'package:berded_seller/src/models/user_model.dart';
import 'package:berded_seller/src/pages/router.dart';
import 'package:berded_seller/src/services/network_service.dart';
import 'package:berded_seller/src/widgets/confirm_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

import '../../app.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEventLogin>(_mapToLoginEventLogin);
    on<LoginEventLogout>(_mapToLoginEventLogout);
    on<LoginEventLogoutOnlyCurrentBranch>(_mapToLoginEventLogoutOnlyCurrentBranch);
    on<LoginEventHidePassword>(_mapToLoginEventHidePassword);
    on<LoginEventRestore>(_mapToLoginEventRestore);
  }

  // Login
  Future<FutureOr<void>> _mapToLoginEventLogin(LoginEventLogin event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      isFetching: true,
      isError: false,
      isSuccess: false,
    ));

    try {
      final LoginResponse result = await NetworkService().login(event.payload);
      if (result.result == Constants.OK) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(Constants.ACCESS_TOKEN, result.token);
        await prefs.setString(Constants.USERNAME, event.payload.username!);
        // logger.d(result.toJson().toString());
        await prefs.setString(Constants.AUTHORIZED_META, json.encode(result.toJson()));
        // save authorized branch
        navigatorState.currentContext!.read<BranchBloc>().add(BranchEventSaveAsAuthorized(
              seller_id: result.seller_id,
              token: result.token,
              username: result.username,
            ));

        // delayed
        emit(state.copyWith(isFetching: false, isError: false, isSuccess: true, result: result));
        // NOTE: A = Active, I = Inactive
        if (result.status == 'I') {
          await Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.top_up);
        } else {
          await Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.home);
        }
      } else if (result.result == Constants.NOK) {
        // change state
        emit(state.copyWith(
          isFetching: false,
          isError: true,
          isSuccess: false,
        ));
        // alert
        await Flushbar(
          titleColor: ThemeColors.lightTextErrorAlert,
          title: 'Login failed',
          message: 'The username or password incorrect!',
          duration: Duration(seconds: 3),
        ).show(navigatorState.currentContext!);
      }
    } catch (e) {
      emit(state.copyWith(isFetching: false, isError: true, isSuccess: false, result: null));
      // alert
      await Flushbar(
        titleColor: ThemeColors.lightTextErrorAlert,
        title: 'Error - cannot connect to server',
        message: 'Please internet connection',
        duration: Duration(seconds: 3),
      ).show(navigatorState.currentContext!);
    }
  }

  // Reset
  Future<FutureOr<void>> _mapToLoginEventLogout(LoginEventLogout event, Emitter<LoginState> emit) async {
    ConfirmDialog(
      context: navigatorState.currentState!.context,
      title: 'คุณต้องการออกจากระบบใช่หรือไม่',
      onPress: () async {
        await clearPreference();
        navigatorState.currentState!.context.read<BranchBloc>().add(BranchEventReInitial());
        Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.login);
        emit(const LoginState());
      },
    );
  }

  // Logout only current branch
  Future<FutureOr<void>> _mapToLoginEventLogoutOnlyCurrentBranch(LoginEventLogoutOnlyCurrentBranch event, Emitter<LoginState> emit) async {
    ConfirmDialog(
      context: navigatorState.currentState!.context,
      title: 'คุณต้องการออกจากระบบใช่หรือไม่',
      onPress: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final authorizedBranchesJSON = prefs.getString(Constants.AUTHORIZED_STORES) ?? "[]";
        final authorizedBranches = authorizedBranchesFromJson(authorizedBranchesJSON);

        // Remove current to update
        authorizedBranches.removeWhere((element) {
          return element.sellerId == state.result?.seller_id;
        });

        await prefs.setString(Constants.AUTHORIZED_STORES, json.encode(authorizedBranches));
        if (authorizedBranches.length > 0) {
          // login next authorizedBranches
          navigatorState.currentState!.context.read<BranchBloc>().add(BranchEventSetAuthorizedBranches(authorizedBranches: authorizedBranches));
          Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.branch);
        } else {
          await clearPreference();
          navigatorState.currentState!.context.read<BranchBloc>().add(BranchEventReInitial());
          Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.login);
          emit(const LoginState());
        }
      },
    );
  }

  // Hide password
  FutureOr<void> _mapToLoginEventHidePassword(event, Emitter<LoginState> emit) {
    // change state toggle
    emit(state.copyWith(isHidePassword: !state.isHidePassword));
  }

  // Restore login response state
  Future<FutureOr<void>> _mapToLoginEventRestore(LoginEventRestore event, Emitter<LoginState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final metaJSON = prefs.getString(Constants.AUTHORIZED_META) ?? "";
      final LoginResponse loginResponse = loginResponseFromJson(metaJSON);
      final authorizedBranchesJSON = prefs.getString(Constants.AUTHORIZED_STORES) ?? "[]";
      final authorizedBranches = authorizedBranchesFromJson(authorizedBranchesJSON);
      // Find index
      final index = authorizedBranches.indexWhere((element) {
        return element.sellerId == loginResponse.seller_id;
      });
      await prefs.setString(Constants.ACCESS_TOKEN, authorizedBranches[index].jwt);
      final LoginResponse result = await NetworkService().getCurrentBranch();
      await prefs.setString(Constants.AUTHORIZED_META, json.encode(result.toJson()));
      emit(state.copyWith(isFetching: false, isError: false, isSuccess: true, result: result));
      if (result.status == 'I') {
        if (event.isRefresh == null || event.isRefresh == false) await Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.top_up);
      } else {
        if (event.isRefresh == true) await Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.home);
      }
    } catch (error) {
      // check offline
      final isOnlineResult = await isOnline();
      if (isOnlineResult == false) {
        return await Flushbar(
          titleColor: ThemeColors.lightTextErrorAlert,
          title: 'Error - คุณกำลังออฟไลน์',
          message: 'โปรดตรวจสอบอินเทอร์เน็ตs',
          duration: Duration(seconds: 3),
        ).show(navigatorState.currentContext!);
      } else if (isOnlineResult == true) {
        return null;
      } else {
        // force to logout
        await clearPreference();
        navigatorState.currentState!.context.read<BranchBloc>().add(BranchEventReInitial());
        Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.login);
        emit(const LoginState());
      }
    }
  }

  isOnline() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Future clearPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    CookieManager().clearCookies();
  }
}
