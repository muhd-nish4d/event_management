part of 'image_pick_bloc.dart';

abstract class ImagePickState extends Equatable {
  const ImagePickState();

  @override
  List<Object> get props => [];
}

class ImagePickInitialState extends ImagePickState {}

class ImageLoadingState extends ImagePickState {}

class ImageLoadedState extends ImagePickState {
  final File? imageFile;

  const ImageLoadedState(this.imageFile);
}

class ImageErrorState extends ImagePickState {
  final String errorMessage;

  const ImageErrorState(this.errorMessage);
}
