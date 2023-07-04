import 'dart:convert';

List<MaterialsModel> postFromJson(String str) =>
    List<MaterialsModel>.from(json.decode(str).map((x) => MaterialsModel.fromMap(x)));

class MaterialsModel {
  MaterialsModel({
    required this.course_id,
    required this.author,
    required this.material_id,
    required this.file_name,

    required this.time,
    required this.title,
  });

  final String course_id;
  final String author;
  final String material_id;

  final String time;
  final String title;
  final String file_name;


  factory MaterialsModel.fromMap(Map<String, dynamic> json) => MaterialsModel(
    course_id: json['course_id'],
    material_id: json['material_id'],
    author: json['author'],
    time: json['time'],
    title: json['title'],
    file_name: json['file_name'],

  );
}