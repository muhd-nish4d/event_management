part of 'post_image_bloc.dart';

abstract class PostImageState extends Equatable {
  const PostImageState();

  @override
  List<Object> get props => [];
}

class PostImageInitial extends PostImageState {}

class PostLoadingState extends PostImageState {}

class PostImageSelectedState extends PostImageState {}

class PostImageCroppedState extends PostImageState {
  final String croppedImage;

  const PostImageCroppedState(this.croppedImage);
}

class PostUploadedState extends PostImageState {}

class PostErrorState extends PostImageState {
  final String error;

  const PostErrorState(this.error);
}
