import 'dart:convert';

List<FaqModel> postFromJson(String str) =>
    List<FaqModel>.from(json.decode(str).map((x) => FaqModel.fromMap(x)));

class FaqModel {
  FaqModel({
    required this.faq_id,
    required this.faq_title,
    required this.faq_description,
    required this.faq_unique,

  });

  final int faq_id;
  final String faq_title;
  final String faq_description;
  final String faq_unique;

  factory FaqModel.fromMap(Map<String, dynamic> json) => FaqModel(
    faq_id: json['faq_id'],
    faq_title: json['faq_title'],
    faq_description: json['faq_description'],
    faq_unique: json['faq_unique'],

  );
}