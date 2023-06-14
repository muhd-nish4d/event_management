part of 'image_pick_bloc.dart';

abstract class ImagePickEvent extends Equatable {
  const ImagePickEvent();

  @override
  List<Object> get props => [];
}

class GetImageEvent extends ImagePickEvent {}

class RemoveImageEvent extends ImagePickEvent {}
