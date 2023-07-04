import 'dart:convert';

List<Reply> postFromJson(String str) =>
    List<Reply>.from(json.decode(str).map((x) => Reply.fromMap(x)));

class Reply {
  Reply({
    required this.post_id,
    required this.user_id,
    required this.user_img,
    required this.name,
    required this.reply,
    required this.reply_time,

  });

  final int post_id ;
  final int user_id ;
  final String reply ;
  final String user_img;
  final String name;
  final String reply_time;


  factory Reply.fromMap(Map<String, dynamic> json) => Reply(
      post_id: json['post_id'],
      user_id: json['user_id'],
      reply: json['reply'],
      user_img: json['user_img'],
      name: json['user_name'],
      reply_time: json['reply_time']

  );
}