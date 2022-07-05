import 'dart:async';

import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/widgets/confirm_dialog_web_view.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

part 'store_menu_event.dart';

part 'store_menu_state.dart';

class StoreMenuBloc extends Bloc<StoreMenuEvent, StoreMenuState> {
  StoreMenuBloc() : super(StoreMenuState()) {
    on<StoreMenuEventInitial>(_mapStoreMenuEventInitialToState);
    on<StoreMenuEventGoBack>(_mapStoreMenuEventGoBackToState);
    on<StoreMenuEventSetLoading>(_mapStoreMenuEventSetLoadingToState);
  }

  FutureOr<void> _mapStoreMenuEventInitialToState(StoreMenuEventInitial event, Emitter<StoreMenuState> emit) {
    emit(state.copyWith(webViewController: event.initWebViewController));
  }

  Future<FutureOr<void>> _mapStoreMenuEventGoBackToState(StoreMenuEventGoBack event, Emitter<StoreMenuState> emit) async {
    final canGoBack = await state.webViewController!.canGoBack();
    if (canGoBack) {
      state.webViewController!.goBack();
    } else {
      showDialog(
          context:  navigatorState.currentContext!,
          builder: (BuildContext context) => ConfirmDialogWebView(title: 'แจ้งเตือน', content: 'คุณอยู่ในหน้าสุดท้าย'));
    }
  }

  FutureOr<void> _mapStoreMenuEventSetLoadingToState(StoreMenuEventSetLoading event, Emitter<StoreMenuState> emit) {
    final bool isLoading = event.isLoading;
    emit(state.copyWith(isLoading: isLoading));
  }
}
