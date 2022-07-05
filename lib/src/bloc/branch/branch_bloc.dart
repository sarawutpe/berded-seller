import 'dart:async';
import 'dart:convert';

import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/constants/constants.dart';
import 'package:berded_seller/src/models/authorized_branch.dart';
import 'package:berded_seller/src/models/response/branch_response_model.dart';
import 'package:berded_seller/src/models/response/login_response_model.dart';
import 'package:berded_seller/src/pages/router.dart';
import 'package:berded_seller/src/services/network_service.dart';
import 'package:berded_seller/src/widgets/confirm_dialog.dart';
import 'package:berded_seller/src/widgets/custom_alert_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'branch_event.dart';

part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchState()) {
    on<BranchEventReInitial>(_mapBranchEventReInitial);
    on<BranchEventSelect>(_mapBranchEventSelect);
    on<BranchEventFetchMyBranches>(_mapBranchEventFetchMyBranches);
    on<BranchEventSaveAsAuthorized>(_mapBranchEventSaveAsAuthorized);
    on<BranchEventRefreshMyBranch>(_mapBranchEventRefreshMyBranch);
    on<BranchEventSetAuthorizedBranches>(_mapToBranchEventSetAuthorizedBranches);
  }

  Future<FutureOr<void>> _mapBranchEventSelect(BranchEventSelect event, Emitter<BranchState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final authorizedBranchesJSON = prefs.getString(Constants.AUTHORIZED_STORES) ?? "[]";
      final authorizedBranches = authorizedBranchesFromJson(authorizedBranchesJSON);

      // Find index
      final index = authorizedBranches.indexWhere((element) {
        return element.sellerId == event.selectedBranch.sellerId;
      });
      // Check
      if (index != -1) {
        await prefs.setString(Constants.ACCESS_TOKEN, authorizedBranches[index].jwt);
        final LoginResponse result = await NetworkService().getCurrentBranch();
        await prefs.setString(Constants.AUTHORIZED_META, json.encode(result.toJson()));
        await Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.home);
      } else {
        emit(state.copyWith(selectedBranch: event.selectedBranch, isSwitchBranch: true));
        await Navigator.pushNamed(navigatorState.currentContext!, AppRoute.login);
      }
    } catch (e) {
      prefs.remove(Constants.AUTHORIZED_STORES);
      navigatorState.currentContext!.read<LoginBloc>().add(LoginEventLogout());
    }
  }

  Future<FutureOr<void>> _mapBranchEventFetchMyBranches(BranchEventFetchMyBranches event, Emitter<BranchState> emit) async {
    emit(state.copyWith(isFetching: true, isSuccess: false, isError: false, isSwitchBranch: false, myBranchesResponse: []));
    try {
      final List<MyBranchesResponse> result = await NetworkService().branches();
      if (result.length < 2) {
        showDialog(
          context: navigatorState.currentContext!,
          builder: (BuildContext context) => CustomAlertDialog(
            title: "มี 1 สาขา",
            content: 'คุณไม่สามารถเปลี่ยนสาขาได้',
          ),
        );
      }else {
        Navigator.pushNamed(navigatorState.currentContext!, AppRoute.branch);
        emit(state.copyWith(isFetching: false, isSuccess: true, isError: false, isSwitchBranch: false, myBranchesResponse: result));
      }

    } catch (e) {
      logger.d(e.toString());
      emit(state.copyWith(isFetching: false, isSuccess: false, isError: true, isSwitchBranch: false));
    }
  }

  Future<FutureOr<void>> _mapBranchEventSaveAsAuthorized(BranchEventSaveAsAuthorized event, Emitter<BranchState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final authorizedBranchesJSON = prefs.getString(Constants.AUTHORIZED_STORES) ?? "[]";
      final authorizedBranches = authorizedBranchesFromJson(authorizedBranchesJSON);

      // Remove current to update
      authorizedBranches.removeWhere((element) {
        return element.sellerId == event.seller_id;
      });

      authorizedBranches.add(AuthorizedBranch(email: event.username, sellerId: event.seller_id, jwt: event.token));
      await prefs.setString(Constants.AUTHORIZED_STORES, json.encode(authorizedBranches));
      emit(state.copyWith(sellerId: event.seller_id, authorizedBranches: authorizedBranches));
    } catch (e) {
      prefs.remove(Constants.AUTHORIZED_STORES);
      navigatorState.currentContext!.read<LoginBloc>().add(LoginEventLogout());
    }
  }

  Future<FutureOr<void>> _mapBranchEventRefreshMyBranch(BranchEventRefreshMyBranch event, Emitter<BranchState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{

      final LoginResponse result = await NetworkService().getCurrentBranch();
      await prefs.setString(Constants.AUTHORIZED_META, json.encode(result.toJson()));
      event.streamController?.sink.add(null);
    } catch (e) {
      prefs.remove(Constants.AUTHORIZED_STORES);
      navigatorState.currentContext!.read<LoginBloc>().add(LoginEventLogout());
    }
  }

  FutureOr<void> _mapBranchEventReInitial(BranchEventReInitial event, Emitter<BranchState> emit) {
    emit(const BranchState());
  }

  FutureOr<void> _mapToBranchEventSetAuthorizedBranches(BranchEventSetAuthorizedBranches event, Emitter<BranchState> emit) {
    final List<AuthorizedBranch> authorizedBranches = event.authorizedBranches;
    emit(state.copyWith(authorizedBranches: authorizedBranches));
  }
}
