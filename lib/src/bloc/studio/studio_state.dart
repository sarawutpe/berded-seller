part of 'studio_bloc.dart';

class StudioState extends Equatable {
  final bool isFetching;
  final bool isSuccess;
  final bool isError;
  final StudioResponse? result;

  const StudioState({this.isFetching = false, this.isSuccess = false, this.isError = false, this.result});

  StudioState copyWith({bool? isFetching, bool? isSuccess, bool? isError, StudioResponse? result}) {
    return StudioState(
      isFetching: isFetching ?? this.isFetching,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      result: result ?? this.result,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "{isFetching: $isFetching, isSuccess: $isSuccess, isError: $isError, result: $result";
  }

  @override
  List<Object?> get props => [isFetching, isSuccess, isError, result];
}
