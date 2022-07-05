import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/bloc/app_block_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(App());
    },
    blocObserver: AppBlocObserver(),
  );

}
