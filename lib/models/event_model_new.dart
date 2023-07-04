import 'dart:convert';

List<EventModel> postFromJson(String str) =>
    List<EventModel>.from(json.decode(str).map((x) => EventModel.fromMap(x)));

class EventModel {

  EventModel({
    required this.event_id,
    required this.event_title,
    required this.event_start_date,
    required this.event_end_date,
    required this.event_start_time,
    required this.event_end_time,
    required this.event_mention_account,
    required this.event_tags,
    required this.event_capacity,
    required this.rsvp,
    required this.event_location,
    required this.event_description,
  });

  final int event_id;
  final String event_title;
  final String event_start_date;
  final String event_end_date;
  final String event_start_time;
  final String event_end_time;
  final String event_mention_account;
  final String event_tags;
  final String event_location;
  final int event_capacity;
  final int rsvp;
  final String event_description;

  factory EventModel.fromMap(Map<String, dynamic> json) => EventModel(
    event_id: json['event_id'],
    event_title: json['event_title'],
    event_start_date: json['event_start_date'],
    event_end_date: json['event_end_date'],
    event_start_time: json['event_start_time'],
    event_end_time: json['event_end_time'],
    event_mention_account: json['event_mention_account'],
    event_tags: json['event_tags'],
    event_capacity: json['event_capacity'],
    rsvp: json['rsvp'],
    event_location: json['event_location'],
    event_description: json['event_description']
  );
}