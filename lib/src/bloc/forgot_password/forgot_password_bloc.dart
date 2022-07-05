import 'dart:async';

import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/widgets/confirm_dialog_web_view.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<ForgotPasswordEventInitial>(_mapForgotPasswordEventInitialToState);
    on<ForgotPasswordEventGoBack>(_mapForgotPasswordEventGoBackToState);
    on<ForgotPasswordEventSetLoading>(_mapForgotPasswordEventSetLoadingToState);
  }

  FutureOr<void> _mapForgotPasswordEventInitialToState(ForgotPasswordEventInitial event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(webViewController: event.initWebViewController));
  }

  Future<FutureOr<void>> _mapForgotPasswordEventGoBackToState(ForgotPasswordEventGoBack event, Emitter<ForgotPasswordState> emit) async {
    final canGoBack = await state.webViewController!.canGoBack();
    if (canGoBack) {
      state.webViewController!.goBack();
    } else {
      showDialog(
          context:  navigatorState.currentContext!,
          builder: (BuildContext context) => ConfirmDialogWebView(title: 'แจ้งเตือน', content: 'คุณต้องการออกจากหน้านี้หรือไม่'));
    }
  }

  FutureOr<void> _mapForgotPasswordEventSetLoadingToState(ForgotPasswordEventSetLoading event, Emitter<ForgotPasswordState> emit) {
    final bool isLoading = event.isLoading;
    emit(state.copyWith(isLoading: isLoading));
  }
}
