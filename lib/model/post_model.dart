class Post {
  String? id;
  String? title;
  String? creatorId;
  String? creatorImageId;
  String? imagePath;
  List<String>? likes;
  int? totalLikes;
  int? timestamp;

  Post(
      {required this.id,
      required this.title,
      required this.creatorId,
      required this.creatorImageId,
      required this.imagePath,
      required this.likes,
      required this.totalLikes,
      required this.timestamp});

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        id: map['id'],
        title: map['title'],
        creatorId: map['creatorId'],
        creatorImageId: map['creatorImageId'],
        imagePath: map['imagePath'],
        likes: map['likes'],
        totalLikes: map['totalLikes'],
        timestamp: map['timestamp']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'creatorId': creatorId,
      'creatorImageId': creatorImageId,
      'imagePath': imagePath,
      'likeBy': likes,
      'totalLikes': totalLikes,
      'timestamp': timestamp,
    };
  }
}
