import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post({
    required this.post_id,
    required this.user_id,
    required this.post_description,
    required this.post_title,
    required this.post_replies,
    required this.course_id,
    required this.name,
    required this.user_img,
    required this.post_time,
  });

  final int post_id;
  final int user_id;
  final int post_replies;
  final String post_title;
  final String course_id;
  final String post_description;
  final String name;
  final String user_img;
  final String post_time;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
      post_id: json['post_id'],
      user_id: json['user_id'],
      post_description: json['post_description'],
      post_title: json['post_title'],
      post_replies: json['post_replies'],
      course_id: json['course_id'],
      name: json['user_name'],
      user_img: json['user_img'],
      post_time: json['post_time']);
}
