part of 'forgot_password_bloc.dart';

class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForgotPasswordEventInitial extends ForgotPasswordEvent {
  final WebViewController? initWebViewController;
  ForgotPasswordEventInitial(this.initWebViewController);
}

class ForgotPasswordEventSetLoading extends ForgotPasswordEvent {
  final bool isLoading;
  ForgotPasswordEventSetLoading({ required this.isLoading });
}

class ForgotPasswordEventGoBack extends ForgotPasswordEvent {}
