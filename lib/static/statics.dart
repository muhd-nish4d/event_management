import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../model/event_reqbooking_model.dart';

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
      log('Successfully followed user $userId');
    }).catchError((error) {
      // Handle error
      log('Error following user $userId: $error');
    });

    firebaseFirestore.collection('users').doc(currentUserId).update({
      'following': FieldValue.arrayUnion([userId]),
    }).then((value) {
      // Update the UI or show a success message
      log('Successfully followed user $userId');
    }).catchError((error) {
      // Handle error
      log('Error following user $userId: $error');
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
      log('Successfully unfollowed user $userId');
    }).catchError((error) {
      // Handle error
      log('Error unfollowing user $userId: $error');
    });

    firebaseFirestore.collection('users').doc(currentUserId).update({
      'following': FieldValue.arrayRemove([userId]),
    }).then((value) {
      // Update the UI or show a success message
      log('Successfully unfollowed user $userId');
    }).catchError((error) {
      // Handle error
      log('Error unfollowing user $userId: $error');
    });
  }

  static void likeUserPost(String imageId) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Get the current user's UID
    final String currentUserId = firebaseAuth.currentUser?.uid ?? '';

    // Update the follow relationship in Firestore
    firebaseFirestore.collection('posts').doc(imageId).update({
      'likeBy': FieldValue.arrayUnion([currentUserId]),
    }).then((value) {
      // Update the UI or show a success message
      log('Successfully  user $imageId');
    }).catchError((error) {
      // Handle error
      log('Error following user $imageId: $error');
    });
  }

  static void unLikeUserPost(String imageId) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final String currentUserId = firebaseAuth.currentUser?.uid ?? '';

    firebaseFirestore.collection('posts').doc(imageId).update({
      'likeBy': FieldValue.arrayRemove([currentUserId]),
    }).then((value) {
      log('Successfully removed user $imageId');
    }).catchError((error) {
      log('Error following user $imageId: $error');
    });
  }

  static Future<String?> getPostIdByImage(String imageId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('id', isEqualTo: imageId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String postId = documentSnapshot.id;
        return postId;
      } else {
        return null;
      }
    } catch (e) {
      log('Error getting post ID: $e');
      return null;
    }
  }

  static Future<void> sendReqForEventBook(EventBookingReq req) async {
    final String currentUser = FirebaseAuth.instance.currentUser?.uid ?? '';
    req.senderId = currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('bookingRequests')
          .add(req.toMap());
      log('sender   ${req.senderId.toString()}');
      log('resp   ${req.recipientId.toString()}');
    } catch (e) {
      log(e.toString());
    }
  }

  static Stream<List<EventBookingReq>> getBookingRequestsStream(
      String recipientUser) {
    final String currentUser = FirebaseAuth.instance.currentUser?.uid ?? '';
    return FirebaseFirestore.instance
        .collection('bookingRequests')
        .where('senderId', isEqualTo: recipientUser)
        .where('recipientId', isEqualTo: currentUser)
        .where('status', isEqualTo: 'notResponded')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => EventBookingReq.fromMap(doc.data()))
          .toList();
    });
  }

  static String createChatRoomId({required String resp}) {
    final String currentUser = FirebaseAuth.instance.currentUser?.uid ?? '';
    log(currentUser);
    log(resp);
    if (currentUser[0].toLowerCase().codeUnits[0] >
        resp[0].toLowerCase().codeUnits[0]) {
      return '$currentUser$resp';
    } else {
      return '$resp$currentUser';
    }
  }

  static String? dateTimeConvert(String date) {
    final parsedDate = DateTime.parse(date);
    try {
      return DateFormat.yMMMEd().format(parsedDate);
    } catch (e) {
      return null;
    }
  }

  static Future<void> deletePost(String imageLink) async {
    try {
      // Create a query to find the document with the matching image link
      var querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('imagePath', isEqualTo: imageLink)
          .get();

      // Check if there is a document with the matching image link
      if (querySnapshot.docs.isNotEmpty) {
        // Delete the document(s) found in the query results
        for (var documentSnapshot in querySnapshot.docs) {
          await documentSnapshot.reference.delete();
        }
        log('Document(s) with the image link deleted successfully.');


      } else {
        log('No document found with the provided image link.');
      }
    } catch (e) {
      log('Error deleting document: $e');
    }
  }
}
