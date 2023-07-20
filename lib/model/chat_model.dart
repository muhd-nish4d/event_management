class ChatMessage {
  String? sender;
  String? message;
  String? timeStamp;
  String? dateTime;

  ChatMessage(
      {required this.sender,
      required this.message,
      required this.timeStamp,
      required this.dateTime});

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
        sender: map['sender'],
        message: map['message'],
        timeStamp: map['timeStamp'],
        dateTime: map['dateTime']);
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'message': message,
      'timeStamp': timeStamp,
      'dateTime': dateTime
    };
  }
}
