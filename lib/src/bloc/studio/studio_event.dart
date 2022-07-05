part of 'studio_bloc.dart';

abstract class StudioEvent extends Equatable {
  const StudioEvent();
  List<Object?> get props => [];
}

class StudioEventCustomNumber extends StudioEvent {
  final PhoneNumberModel payload;
  StudioEventCustomNumber(this.payload);
}
