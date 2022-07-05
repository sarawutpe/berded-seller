part of 'store_menu_bloc.dart';

class StoreMenuState extends Equatable {
  const StoreMenuState({
    this.webViewController,
    this.isLoading = true,
  });

  final WebViewController? webViewController;
  final bool isLoading;

  StoreMenuState copyWith({
    WebViewController? webViewController,
    bool? isLoading,
  }) {
    return StoreMenuState(
      webViewController: webViewController ?? this.webViewController,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [webViewController, isLoading];
}
