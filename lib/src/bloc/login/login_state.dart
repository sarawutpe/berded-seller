part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isFetching;
  final bool isSuccess;
  final bool isError;
  final LoginResponse? result;
  final bool isHidePassword;

  const LoginState({this.isFetching = false, this.isSuccess = false, this.isError = false, this.result, this.isHidePassword = false});

  LoginState copyWith({bool? isFetching, bool? isSuccess, bool? isError, LoginResponse? result, bool? isHidePassword}) {
    return LoginState(
      isFetching: isFetching ?? this.isFetching,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      result: result ?? this.result,
      isHidePassword: isHidePassword ?? this.isHidePassword,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "{isFetching: $isFetching, isSuccess: $isSuccess, isError: $isError, result: $result, isHidePassword: $isHidePassword}";
  }

  @override
  List<Object?> get props => [isFetching, isSuccess, isError, result, isHidePassword];
}
