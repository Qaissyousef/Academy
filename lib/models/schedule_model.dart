import 'dart:convert';

List<ScheduleCourse> postFromJson(String str) =>
    List<ScheduleCourse>.from(json.decode(str).map((x) => ScheduleCourse.fromMap(x)));

class ScheduleCourse {
  ScheduleCourse({
    required this.course_id,
    required this.duration,
    required this.instructor,
    required this.schedule_id,

    required this.date,
    required this.time,
    required this.location,
    required this.subject,
    required this.subjectpath,

  });

  final String course_id;
  final String duration;
  final String instructor;
  final int schedule_id;

  final String date;
  final String time;
  final String location;
  final String subject;
  final String subjectpath;


  factory ScheduleCourse.fromMap(Map<String, dynamic> json) => ScheduleCourse(
    course_id: json['course_id'],
    schedule_id: json['schedule_id'],

    duration: json['duration'],
    instructor: json['instructor'],

    date: json['date'],
    time: json['time'],
    location: json['location'],
    subject: json['subject'],
    subjectpath: json['subjectpath'],

  );
}