import 'dart:async';

import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/widgets/confirm_dialog_web_view.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

part 'manage_menu_event.dart';
part 'manage_menu_state.dart';

class ManageMenuBloc extends Bloc<ManageMenuEvent, ManageMenuState> {
  ManageMenuBloc() : super(ManageMenuState()) {
    on<ManageMenuEventInitial>(_mapManageMenuEventInitialToState);
    on<ManageMenuEventGoBack>(_mapManageMenuEventGoBackToState);
    on<ManageMenuEventSetLoading>(_mapManageMenuEventSetLoadingToState);
  }

FutureOr<void> _mapManageMenuEventInitialToState(ManageMenuEventInitial event, Emitter<ManageMenuState> emit) {
  emit(state.copyWith(webViewController: event.initWebViewController));
}

Future<FutureOr<void>> _mapManageMenuEventGoBackToState(ManageMenuEventGoBack event, Emitter<ManageMenuState> emit) async {
  final canGoBack = await state.webViewController!.canGoBack();

  if (canGoBack) {
    state.webViewController!.goBack();
  } else {
    showDialog(
        context:  navigatorState.currentContext!,
        builder: (BuildContext context) => ConfirmDialogWebView(title: 'แจ้งเตือน', content: 'คุณอยู่ในหน้าสุดท้าย',));
  }
}

  FutureOr<void> _mapManageMenuEventSetLoadingToState(ManageMenuEventSetLoading event, Emitter<ManageMenuState> emit) {
    final bool isLoading = event.isLoading;
    emit(state.copyWith(isLoading: isLoading));
  }
}
