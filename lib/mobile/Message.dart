 import 'dart:convert';

List<Message> postFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromMap(x)));

class Message {
  Message({
    required this.user_id,
    required this.message_id,
    required this.message,
    required this.starred,
    required this.isUnread,
    required this.time,
    required this.message_title,
    required this.isChecked,
  });

  final int message_id;
  final int user_id;
  final String message;
  final String time;
  bool starred;
  bool isUnread;
  final String message_title;
  bool? isChecked;

  factory Message.fromMap(Map<String, dynamic> json) => Message(
    message_id: json['message_id'],
    user_id: json['user_id'],
    message: json['message_details'],
    starred: json['starred'],
    isUnread: json['isUnread'],
    time: json['time'],
    message_title: json['message_title'],
    isChecked: json['isChecked']
  );
}
