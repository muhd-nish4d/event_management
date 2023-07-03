class ChatMessage {
  String? sender;
  String? message;
  String? timeStamp;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.timeStamp,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
        sender: map['sender'],
        message: map['message'],
        timeStamp: map['timeStamp']);
  }

  Map<String, dynamic> toMap() {
    return {'sender': sender, 'message': message, 'timeStamp': timeStamp};
  }
}
