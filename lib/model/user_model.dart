enum UserType { profession, cleint }

class UserModel {
  UserType? userType;
  String? companyName;
  String? ownerName;
  String? profession;
  String? phoneNumber;
  String? userBio;
  String? profileImage;
  List<dynamic>? follow;
  String? coverImage;
  String? uid;

  UserModel(
      {required this.follow,
      required this.userType,
      required this.companyName,
      required this.ownerName,
      required this.profession,
      required this.phoneNumber,
      required this.userBio,
      required this.profileImage,
      required this.coverImage,
      required this.uid});

  bool isFollowed(String currentUserId) {
    return follow!.contains(currentUserId);
  }

  factory UserModel.formMap(Map<String, dynamic> map) {
    UserType type;
    if (map['userType'] == 'cleint') {
      type = UserType.cleint;
    } else {
      type = UserType.profession;
    }
    return UserModel(
        follow: map['followers'] ?? [],
        userType: type,
        companyName: map['companyName'] ?? '',
        ownerName: map['ownerName'] ?? '',
        profession: map['profession'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        userBio: map['userBio'] ?? '',
        profileImage: map['profileImage'] ?? '',
        coverImage: map['coverImage'] ?? '',
        uid: map['uid'] ?? '');
  }
  Map<String, dynamic> toMap() {
    return {
      'userType': userType?.toString().split('.').last ?? '',
      'companyName': companyName ?? '',
      'ownerName': ownerName ?? 'Avatar',
      'profession': profession ?? 'Camera',
      'phoneNumber': phoneNumber ?? '2323',
      'userBio': userBio ?? 'hi',
      'profileImage': profileImage,
      'coverImage': coverImage,
      'uid': uid
    };
  }
}
