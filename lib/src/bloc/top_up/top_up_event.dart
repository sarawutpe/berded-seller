part of 'top_up_bloc.dart';

@immutable
class TopUpEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TopUpEventInitial extends TopUpEvent {
  final WebViewController? initWebViewController;
  TopUpEventInitial(this.initWebViewController);
}

class TopUpEventSetLoading extends TopUpEvent {
  final bool isLoading;
  TopUpEventSetLoading({ required this.isLoading });
}

class TopUpEventGoBack extends TopUpEvent {}
