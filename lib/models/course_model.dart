import 'dart:convert';

List<Course> postFromJson(String str) =>
    List<Course>.from(json.decode(str).map((x) => Course.fromMap(x)));

class Course {
  Course({
    required this.course_id,
    required this.course_name,
    required this.course_name_eng,
    required this.course_image,
    required this.course_instructor,
    required this.applicants,
    required this.deadline,
    required this.admission,
  });

  final String course_id;
  final String course_name;
  final String course_name_eng;
  final String course_image;
  final String course_instructor;
  final int applicants;
  final String deadline;
  final int admission;

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        course_id: json['course_id'],
        course_name: json['course_name'],
        course_name_eng: json['course_name_eng'],
        course_image: json['course_image'],
        course_instructor: json['course_instructor'],
        applicants: json['applicants'],
        deadline: json['deadline'],
        admission: json['admission'],
      );
}
