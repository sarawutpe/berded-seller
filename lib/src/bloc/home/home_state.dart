part of 'home_bloc.dart';

enum GeneralStatus { isFetching, isSuccess, isError }

class HomeState extends Equatable {
  final GeneralStatus initialStatus;
  const HomeState({this.initialStatus = GeneralStatus.isFetching });

  @override
  List<Object> get props => [initialStatus];
}

