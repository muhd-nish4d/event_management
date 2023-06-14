import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_pick_event.dart';
part 'image_pick_state.dart';

class ImagePickBloc extends Bloc<ImagePickEvent, ImagePickState> {
  ImagePickBloc() : super(ImagePickInitialState()) {
    on<ImagePickEvent>((event, emit) async {
      emit(ImageLoadingState());
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(ImageLoadedState(File(pickedFile.path)));
      } else {
        emit(const ImageErrorState('No image selected'));
      }
    });
    on<RemoveImageEvent>((event, emit) async {
      emit(ImagePickInitialState());
    });
  }
}
