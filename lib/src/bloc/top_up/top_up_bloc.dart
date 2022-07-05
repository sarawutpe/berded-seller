import 'dart:async';

import 'package:berded_seller/src/widgets/confirm_dialog_web_view.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

import '../../app.dart';

part 'top_up_event.dart';
part 'top_up_state.dart';

class TopUpBloc extends Bloc<TopUpEvent, TopUpState> {
  TopUpBloc() : super(TopUpState()) {
    on<TopUpEventInitial>(_mapTopUpEventInitialToState);
    on<TopUpEventGoBack>(_mapTopUpEventGoBackToState);
    on<TopUpEventSetLoading>(_mapTopUpEventSetLoadingToState);
  }

  FutureOr<void> _mapTopUpEventInitialToState(TopUpEventInitial event, Emitter<TopUpState> emit) {
    emit(state.copyWith(webViewController: event.initWebViewController));
  }

  Future<FutureOr<void>> _mapTopUpEventGoBackToState(TopUpEventGoBack event, Emitter<TopUpState> emit) async {
    final canGoBack = await state.webViewController!.canGoBack();
    if (canGoBack) {
      state.webViewController!.goBack();
    } else {
      showDialog(
          context:  navigatorState.currentContext!,
          builder: (BuildContext context) => ConfirmDialogWebView(title: 'แจ้งเตือน', content: 'คุณอยู่ในหน้าสุดท้าย'));
    }
  }

  FutureOr<void> _mapTopUpEventSetLoadingToState(TopUpEventSetLoading event, Emitter<TopUpState> emit) {
    final bool isLoading = event.isLoading;
    emit(state.copyWith(isLoading: isLoading));
  }
}
