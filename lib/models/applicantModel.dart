import 'dart:convert';

List<applicantModel> postFromJson(String str) =>
    List<applicantModel>.from(json.decode(str).map((x) => applicantModel.fromMap(x)));

class applicantModel {
  applicantModel({
    required this.name,

    required this.applicant_title,
    required this.applicant_academy_level,
    required this.applicant_reason,
    required this.applicant_ahcievement,
    required this.applicant_future,
    required this.status,
    required this.email,


  });
  final String name;



  final String applicant_title;
  final String applicant_academy_level;
  final String applicant_reason;
  final String applicant_ahcievement;
  final String applicant_future;
  final String status;
  final String email;

  factory applicantModel.fromMap(Map<String, dynamic> json) => applicantModel(
    name: json['name'],


    //
    //
    applicant_title: json['applicant_title'],
    //
    applicant_academy_level: json['applicant_academy_level'],
    applicant_reason: json['applicant_reason'],
    applicant_ahcievement: json['applicant_ahcievement'],
    applicant_future: json['applicant_future'],
    status: json['status'],
    email: json['email'],

  );
}