part of 'top_up_bloc.dart';

@immutable
class TopUpState extends Equatable {
  const TopUpState({
    this.webViewController,
    this.isLoading = true,
  });

  final WebViewController? webViewController;
  final bool isLoading;

  TopUpState copyWith({
    WebViewController? webViewController,
    bool? isLoading,
  }) {
    return TopUpState(
      webViewController: webViewController ?? this.webViewController,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [webViewController, isLoading];
}
