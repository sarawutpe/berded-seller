part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.webViewController,
    this.isLoading = true,
  });

  final WebViewController? webViewController;
  final bool isLoading;

  ForgotPasswordState copyWith({
    WebViewController? webViewController,
    bool? isLoading,
  }) {
    return ForgotPasswordState(
      webViewController: webViewController ?? this.webViewController,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [webViewController, isLoading];
}
