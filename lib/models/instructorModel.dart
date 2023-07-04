import 'dart:convert';

List<InstructorModel> postFromJson(String str) =>
    List<InstructorModel>.from(json.decode(str).map((x) => InstructorModel.fromMap(x)));

class InstructorModel {
  InstructorModel({
    required this.course_id,
    required this.name,
    required this.name_id,
    // required this.event_end_date,


  });

  final String course_id;
  final String name;
  final int name_id;

  factory InstructorModel.fromMap(Map<String, dynamic> json) => InstructorModel(
    course_id: json['course_id'],
    name: json['name'],

    name_id: json['name_id'],


  );
}