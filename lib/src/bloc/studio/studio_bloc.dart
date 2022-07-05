
import 'dart:async';
import 'dart:convert';

import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/models/phone_number_model.dart';
import 'package:berded_seller/src/models/response/studio_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'studio_event.dart';
part 'studio_state.dart';

class StudioBloc extends Bloc<StudioEvent, StudioState> {
  StudioBloc() : super(StudioState()) {
    on<StudioEventCustomNumber>(_mapToStudioEventCustomNumber);
  }

  FutureOr<void> _mapToStudioEventCustomNumber(StudioEventCustomNumber event, Emitter<StudioState> emit) {
    emit(state.copyWith(isFetching: true, isError: false, isSuccess: false));

    final result = studioResponseFromJson(jsonEncode(event.payload));

    emit(state.copyWith(isFetching: false, isError: false, isSuccess: true, result: result));


    logger.d(state);
  }
}
