part of 'manage_menu_bloc.dart';

class ManageMenuState extends Equatable {
  const ManageMenuState({
    this.webViewController,
    this.isLoading = true,
  });

  final WebViewController? webViewController;
  final bool isLoading;

  ManageMenuState copyWith({WebViewController? webViewController,
    bool? isLoading,}) {
    return ManageMenuState(webViewController: webViewController ?? this.webViewController,
      isLoading: isLoading ?? this.isLoading,);
  }

  @override
  List<Object?> get props => [webViewController, isLoading];
}


