// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import '../../model/post_model.dart';
// import '../../model/user_model.dart';
// import '../../widgets/circular_progress_indicator.dart';
// import '../home/widgets/pro_post_card.dart';

// class ScreenPostsView extends StatelessWidget {
//   const ScreenPostsView({super.key, required this.user});
//   final UserModel user;

//   @override
//   Widget build(BuildContext context) {
//     final firestore = FirebaseFirestore.instance;
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//           child: StreamBuilder(
//         stream: firestore.collection('posts').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Expanded(
//               child: ListView(
//                 children: List.generate(snapshot.data!.docs.length, (index) {
//                   var images = snapshot.data?.docs.where((element) {
//                     return 'creatorId' == user.uid;
//                   }) as Map<String, dynamic>;
//                   var imageDetails = Post.fromMap(images);
//                   return PostCard(
//                     postDetails: imageDetails,
//                     userData: user,
//                   );
//                 }),
//               ),
//               // ListView.builder(
//               //   itemBuilder: (context, index) {
//               //     var images = snapshot.data?.docs[index].data();
//               //     var imageDetails = Post.fromMap(images!);
//               //     return FutureBuilder(
//               //       future: getUser(images, firestore),
//               //       builder: (context, userModelSnapshot) {
//               //         if (userModelSnapshot.hasData) {
//               //           UserModel user = userModelSnapshot.data!;
//               //           return PostCard(
//               //             postDetails: imageDetails,
//               //             userData: user,
//               //           );
//               //         } else if (userModelSnapshot.hasError) {
//               //           return Text('Error');
//               //         } else {
//               //           return Text('data');
//               //         }
//               //       },
//               //     );
//               //   },
//               //   itemCount: snapshot.data?.docs.length,
//               // ),
//             );
//           } else {
//             return const Expanded(child: CustomProgressIndicator());
//           }
//         },
//       )

//           //  ListView.builder(
//           //   itemBuilder: (context, index) {
//           //     return const PostCard(
//           //       postDetails: null,
//           //       userData: null,
//           //     );
//           //   },
//           // ),
//           ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/post_model.dart';
import '../../model/user_model.dart';
import '../../widgets/circular_progress_indicator.dart';
import '../home/widgets/pro_post_card.dart';

class ScreenPostsView extends StatelessWidget {
  const ScreenPostsView({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('posts')
              .where('creatorId', isEqualTo: user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final documents = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final postData =
                      documents[index].data() as Map<String, dynamic>;
                  final imageDetails = Post.fromMap(postData);
                  return PostCard(
                    postDetails: imageDetails,
                    userData: user,
                  );
                },
              );
            } else {
              return const CustomProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<String> getUserImage(
      String userId, FirebaseFirestore firestore) async {
    final querySnapshot = await firestore.collection('posts').doc().get();

    final userData = querySnapshot.data() as Map<String, dynamic>;
    final userImage = userData['image'] as String;

    return userImage;
  }
}
