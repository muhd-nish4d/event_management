part of 'fillup_bloc.dart';

abstract class FillupEvent extends Equatable {
  const FillupEvent();

  @override
  List<Object> get props => [];
}

class FillUpInitialEvent extends FillupEvent{}

class FilleCompleteEvent extends FillupEvent {
  final UserModel userData;
  final File? coverImage;
  final File? profileImage;

  const FilleCompleteEvent(this.userData, this.coverImage, this.profileImage);
}
