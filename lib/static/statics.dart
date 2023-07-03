import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  static void followUser(String userId) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Get the current user's UID
    final String currentUserId = firebaseAuth.currentUser?.uid ?? '';

    // Update the follow relationship in Firestore
    firebaseFirestore.collection('users').doc(userId).update({
      'followers': FieldValue.arrayUnion([currentUserId]),
    }).then((value) {
      // Update the UI or show a success message
      print('Successfully followed user $userId');
    }).catchError((error) {
      // Handle error
      print('Error following user $userId: $error');
    });
  }

  static void unfollowUser(String userId) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // Get the current user's UID
    final String currentUserId = firebaseAuth.currentUser?.uid ?? '';

    // Update the follow relationship in Firestore
    firebaseFirestore.collection('users').doc(userId).update({
      'followers': FieldValue.arrayRemove([currentUserId]),
    }).then((value) {
      // Update the UI or show a success message
      print('Successfully unfollowed user $userId');
    }).catchError((error) {
      // Handle error
      print('Error unfollowing user $userId: $error');
    });
  }
}
