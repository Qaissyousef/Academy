import 'dart:convert';

List<User> postFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromMap(x)));

class User {
  User({
    required this.user_id,
    required this.name,
    required this.email,
    required this.user_type,
    required this.user_img,
    required this.user_status,

  });

  final int user_id;
  final String name;
  final String email;
  final String user_type;
  final String user_img;
  final String user_status;

  factory User.fromMap(Map<String, dynamic> json) => User(
    user_id: json['user_id'],
    name: json['name'],
    email: json['email'],
    user_type: json['user_type'],
    user_img: json['user_img'],
    user_status: json['user_status'],

  );
  static List<User> fromJsonList(List list) {

    return list.map((item) => User.fromMap(item)).toList();
  }

  bool isEqual(User model) {
    return this.user_id == model.user_id;
  }
}