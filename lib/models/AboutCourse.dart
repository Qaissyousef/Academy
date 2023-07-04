import 'dart:convert';

List<AboutCourse> postFromJson(String str) =>
    List<AboutCourse>.from(json.decode(str).map((x) => AboutCourse.fromMap(x)));

class AboutCourse {
  AboutCourse({
    required this.course_id,
    required this.description,
    required this.duration,
    required this.about_id,
    required this.course_instuctor,
    required this.course_image,
    required this.category,
    required this.maxParticipants,
    required this.course_name,




  });

  final String course_id;
  final String description;
  final String duration;
  final int about_id;
  final String course_instuctor;
  final String course_image;
  final String category;
  final int maxParticipants;
  final String course_name;

  factory AboutCourse.fromMap(Map<String, dynamic> json) => AboutCourse(
      course_id: json['course_id'],
      description: json['description'],
      duration: json['duration'],
      about_id: json['about_id'],
      course_instuctor: json['course_instuctor'],
      course_image: json['course_image'],
      category: json['category'],
      maxParticipants: json['maxParticipants'],
    course_name: json['course_name'],


  );
}