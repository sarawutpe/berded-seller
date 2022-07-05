part of 'manage_menu_bloc.dart';

class ManageMenuEvent extends Equatable {
  const ManageMenuEvent();

  @override
  List<Object?> get props => [];
}

class ManageMenuEventInitial extends ManageMenuEvent {
  final WebViewController? initWebViewController;
  ManageMenuEventInitial(this.initWebViewController);
}

class ManageMenuEventSetLoading extends ManageMenuEvent {
  final bool isLoading;
  ManageMenuEventSetLoading({ required this.isLoading });
}

class ManageMenuEventGoBack extends ManageMenuEvent {}
