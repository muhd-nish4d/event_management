part of 'image_fetch_bloc.dart';

abstract class ImageFetchEvent extends Equatable {
  const ImageFetchEvent();

  @override
  List<Object> get props => [];
}

class ImageFetchInitialEvent extends ImageFetchEvent {}
