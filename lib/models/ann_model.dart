import 'dart:convert';

List<Announcement> postFromJson(String str) =>
    List<Announcement>.from(json.decode(str).map((x) => Announcement.fromMap(x)));

class Announcement {
  Announcement({
    required this.ann_id,
    required this.ann_title,
    required this.ann_description,
    required this.ann_creation_time,
    required this.ann_image,

  });

  final int ann_id;
  final String ann_title;
  final String ann_description;
  final String ann_creation_time;
  final String ann_image;

  factory Announcement.fromMap(Map<String, dynamic> json) => Announcement(
    ann_id: json['ann_id'],
    ann_title: json['ann_title'],
    ann_description: json['ann_description'],
    ann_creation_time: json['ann_creation_time'],
    ann_image: json['ann_image'],

  );
}