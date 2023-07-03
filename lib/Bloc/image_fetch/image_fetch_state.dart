part of 'image_fetch_bloc.dart';

abstract class ImageFetchState extends Equatable {
  const ImageFetchState();

  @override
  List<Object> get props => [];
}

class ImageFetchInitial extends ImageFetchState {}

class ImageFetchLoadingState extends ImageFetchState {}

class ImageFetchLoadedState extends ImageFetchState {
  final List<Post> allPosts;

  const ImageFetchLoadedState(this.allPosts);
}

class ImageFetchErrorState extends ImageFetchState {
  final String error;

  const ImageFetchErrorState(this.error);
}
