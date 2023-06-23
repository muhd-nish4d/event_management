part of 'post_image_bloc.dart';

abstract class PostImageEvent extends Equatable {
  const PostImageEvent();

  @override
  List<Object> get props => [];
}

class SelectImageEvent extends PostImageEvent {
  final String selecteImagePath;

  const SelectImageEvent(this.selecteImagePath);
}

class CropImageEvent extends PostImageEvent {
  final String imageForCrop;
  final BuildContext context;

  const CropImageEvent(this.imageForCrop, this.context);
}

class UploadImagEvent extends PostImageEvent {
  final Post postModel;
  final String imagePathForUpload;

  const UploadImagEvent(this.imagePathForUpload, this.postModel);
}
