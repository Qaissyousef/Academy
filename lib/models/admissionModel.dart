import 'dart:convert';

List<admissionModel> postFromJson(String str) =>
    List<admissionModel>.from(json.decode(str).map((x) => admissionModel.fromMap(x)));

class admissionModel {
  admissionModel({
    required this.name,
    required this.user_img,
    required this.uid,

    // required this.course_id,
    // required this.user_id,
    // required this.applicant_title,
    // required this.participants_email,
    // required this.applicant_academy_level,
    // required this.applicant_reason,
    // required this.applicant_ahcievement,
    // required this.applicant_future,
    required this.status,
    // required this.email,
    required this.submissionTime,


  });
  final String name;
  final int uid;
  final String user_img;
  final String submissionTime;


  // final int course_id;
  // final int user_id;
  // final String applicant_title;
  // final String participants_email;
  // final String applicant_academy_level;
  // final String applicant_reason;
  // final String applicant_ahcievement;
  // final String applicant_future;
  final String status;
  // final String email;

  factory admissionModel.fromMap(Map<String, dynamic> json) => admissionModel(
    name: json['name'],
    user_img: json['user_img'],
    submissionTime: json['submissionTime'],
    uid: json['user_id'],


    //
    // course_id: json['course_id'],
    // user_id: json['user_id'],
    //
    // applicant_title: json['applicant_title'],
    //
    // participants_email: json['participants_email'],
    // applicant_academy_level: json['applicant_academy_level'],
    // applicant_reason: json['applicant_reason'],
    // applicant_ahcievement: json['applicant_ahcievement'],
    // applicant_future: json['applicant_future'],
    status: json['status'],
    // email: json['email'],

  );
}