import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static String getUniqueId() {
    return const Uuid().v4().toString();
  }

  static Future<XFile> getImageFileImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedImage!;
  }
}
