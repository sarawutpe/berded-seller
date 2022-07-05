part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  List<Object?> get props => [];
}


class LoginEventLogin extends LoginEvent {
  final User payload;
  LoginEventLogin(this.payload);
}

class LoginEventRestore extends LoginEvent {
  final bool? isRefresh;
  LoginEventRestore(this.isRefresh);
}

class LoginEventLogout extends LoginEvent {}

class LoginEventLogoutOnlyCurrentBranch extends LoginEvent {}

class LoginEventHidePassword extends LoginEvent {}
