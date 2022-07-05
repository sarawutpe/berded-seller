import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../app.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    logger.d(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {

    logger.e(error);

    // if (error == 'DioError [DioErrorType.connectTimeout]: Connecting timed out [5000ms]') {
    //   logger.d('connectTimeout');
    // }

    super.onError(bloc, error, stackTrace);
  }
}