import 'dart:convert';

List<attendwebModel> postFromJson(String str) =>
    List<attendwebModel>.from(json.decode(str).map((x) => attendwebModel.fromMap(x)));

class attendwebModel {
  attendwebModel({

    required this.user_id,

    required this.name,

    required this.course_id,
    required this.date,
    required this.percentage,
    required this.user_type,
    required this.user_img,
    required this.email,
    required this.user_status,


  });

  final String name ;

  final String email ;

  final int user_id;
final String course_id ;
final String date ;
final int percentage ;


final String user_type ;

final String user_img ;

final String user_status ;






  factory attendwebModel.fromMap(Map<String, dynamic> json) => attendwebModel(
    name: json['name'],
    email: json['email'],

    user_id: json['user_id'],
    course_id: json['course_id'],
    date: json['date'],
    percentage: json['percentage'],
    user_type: json['user_type'],
    user_img: json['user_img'],
    user_status: json['user_status'],


  );
}