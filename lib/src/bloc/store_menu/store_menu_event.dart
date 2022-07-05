part of 'store_menu_bloc.dart';

class StoreMenuEvent extends Equatable {
  const StoreMenuEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StoreMenuEventInitial extends StoreMenuEvent {
  final WebViewController? initWebViewController;
  StoreMenuEventInitial(this.initWebViewController);
}

class StoreMenuEventSetLoading extends StoreMenuEvent {
  final bool isLoading;
  StoreMenuEventSetLoading({ required this.isLoading });
}

class StoreMenuEventGoBack extends StoreMenuEvent {}
