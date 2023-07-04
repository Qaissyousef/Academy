import 'dart:convert';

List<certificateModel> postFromJson(String str) =>
    List<certificateModel>.from(json.decode(str).map((x) => certificateModel.fromMap(x)));

class certificateModel {
  certificateModel({

    required this.user_id,
    required this.course_id,
    required this.date,
    required this.percentage,
    required this.survey_completion,
    required this.name,
    required this.user_img,
    required this.img,
    required this.attendance_id,
    required this.certificate_id,
    required this.email,


  });

  final String name ;
  //
  final String survey_completion ;
  final String email ;

  final int user_id;
  final String course_id ;
  final String date ;
  final int percentage ;
  final String img ;
  final int certificate_id ;

  final String user_img ;

  final int attendance_id ;






  factory certificateModel.fromMap(Map<String, dynamic> json) => certificateModel(
    name: json['name'],
    attendance_id: json['attendance_id'],
    email: json['email'],

    user_id: json['user_id'],
    course_id: json['course_id'],
    img: json['img'],
    percentage: json['percentage'],
    survey_completion: json['survey_completion'],
    user_img: json['user_img'],
    date: json['date'],

    certificate_id: json['certificate_id'],

  );
}