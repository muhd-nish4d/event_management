import 'package:event_management/screens/chat/person_chat/model/massege_model.dart';

List<Message> messages = [
  Message(
      text: 'Hi',
      time: DateTime.now().subtract(const Duration(days: 1)),
      isSentByMe: true),
  Message(text: 'Hi', time: DateTime.now(), isSentByMe: false),
  Message(text: 'Hello', time: DateTime.now(), isSentByMe: true)
];
