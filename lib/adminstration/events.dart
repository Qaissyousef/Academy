import 'dart:convert';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/adminstration/addEvents.dart';
import 'package:pif_admin_dashboard/adminstration/webSpecificEvent.dart';
import 'package:pif_admin_dashboard/responsiveness/eventsResponsive.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../main.dart';
import '../models/event_model.dart';
import '../pfpimg.dart';
import '../responsiveness/adminResponsive.dart';
import '../responsiveness/admissionResponsive.dart';
import '../responsiveness/announcementResponsive.dart';
import '../responsiveness/coursesResponsive.dart';
import '../responsiveness/faqResponsive.dart';
import '../responsiveness/helpResponsive.dart';
import '../responsiveness/homeResponsive.dart';
import '../responsiveness/messageResponsive.dart';
import '../responsiveness/settingsResponsive.dart';
import '../responsiveness/usersResponive.dart';
import 'package:http/http.dart' as http;

class events extends StatefulWidget {
  const events({Key? key}) : super(key: key);

  @override
  State<events> createState() => _eventsState();
}

class _eventsState extends State<events> {
  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to logout?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(ctx).pop();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            MyApp(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                      // MaterialPageRoute(builder: (context) => coursesPage()),
                      // transitionDuration: const Duration(seconds: 0),
                    );
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  DateTimeRange? picked = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 365 * 5)),
      end: DateTime.now().add((const Duration(days: 365 * 5))));

  final GlobalKey _menuKey = GlobalKey();
  var _dateTime = DateTime.parse("2022-10-01 00:00:00.000");
  late ScrollController _scrollController;

  Future<List<EventModel>> fetchEventPost(
      bool isAscending, bool isHighest, String category) async {
    List<EventModel> events = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllEventsEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        events.add(EventModel.fromMap(jsonDecode(response.body)[i]));
      }

      if (category.compareTo("Date") == 0) {
        if (isAscending) {
          events
              .sort((a, b) => a.event_start_date.compareTo(b.event_start_date));
        } else {
          events
              .sort((a, b) => b.event_start_date.compareTo(a.event_start_date));
        }
      } else {
        if (isHighest) {
          events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));
        } else {
          events.sort((a, b) => a.event_capacity.compareTo(b.event_capacity));
        }
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> filterPostEng(
      bool isAscending, DateTimeRange date) async {
    print("enter");
    List<EventModel> ann = [];
    List<EventModel> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllEventsEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        ann.add(EventModel.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        ann.sort((a, b) => DateTime.parse(a.event_start_time)
            .compareTo(DateTime.parse(b.event_start_time)));
      } else {
        ann.sort((a, b) => DateTime.parse(b.event_start_time)
            .compareTo(DateTime.parse(a.event_start_time)));
      }

      var startDate = date.start;
      var endDate = date.end;

      for (int i = 0; i < ann.length; i++) {
        var eventStart = DateTime.parse(ann[i].event_start_date);
        print(startDate);
        print(endDate);
        print(eventStart);
        if (eventStart.isAfter(startDate) && eventStart.isBefore(endDate)) {
          print("true");
          results.add(ann[i]);
        }
      }
      print(results.length);

      if (results.isEmpty) {
        hasData = false;
      } else {
        hasData = true;
      }

      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> filterEventPost(bool isAscending, bool isHighest,
      String category, String date, String location) async {
    List<EventModel> events = [];
    List<EventModel> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + "GetAllEventsEng"));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        events.add(EventModel.fromMap(jsonDecode(response.body)[i]));
      }
      if (isHighest) {
        events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));
      } else {
        events.sort((a, b) => a.event_capacity.compareTo(b.event_capacity));
      }
      // if (category.compareTo("Date") == 0) {
      //   if (isAscending) {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(a.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(b.event_start_date)));
      //   } else {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(b.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(a.event_start_date)));
      //   }
      // } else {
      //   if (isHighest) {
      //     events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));
      //   } else {
      //     events.sort((a, b) => a.event_capacity.compareTo(b.event_capacity));
      //   }
      // }

      var now = new DateTime.now();
      var now_1w = now.subtract(const Duration(days: 7));
      var now_1m = now.subtract(const Duration(days: 30));

      if (date == "All") {
        for (int i = 0; i < events.length; i++) {
          if (events[i].event_location.compareTo(location) == 0 ||
              location == "All") {
            results.add(events[i]);
          }
        }
      } else if (date == "Latest") {
        events.sort((a, b) => b.event_start_date.compareTo(a.event_start_date));
        results = events.sublist(0, 10);
      } else if (date == "week") {
        for (int i = 0; i < events.length; i++) {
          var eventDate =
              DateFormat('d MMM y').parse(events[i].event_start_date);
          if (eventDate.isAfter(now_1w) &&
              (events[i].event_location.compareTo(location) == 0 ||
                  location == "All")) {
            results.add(events[i]);
          }
        }
      } else if (date == "month") {
        for (int i = 0; i < events.length; i++) {
          var eventDate =
              DateFormat('d MMM y').parse(events[i].event_start_date);
          if (eventDate.isAfter(now_1m) &&
              (events[i].event_location.compareTo(location) == 0 ||
                  location == "All")) {
            results.add(events[i]);
          }
        }
      }

      if (results.isEmpty) {
        hasData = false;
      } else {
        hasData = true;
      }

      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> filterEventPostArb(bool isAscending, bool isHighest,
      String category, String date, String location) async {
    List<EventModel> events = [];
    List<EventModel> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + "GetAllEventsArb"));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        events.add(EventModel.fromMap(jsonDecode(response.body)[i]));
      }
      if (isHighest) {
        events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));
      } else {
        events.sort((a, b) => a.event_capacity.compareTo(b.event_capacity));
      }
      // if (category.compareTo("Date") == 0) {
      //   if (isAscending) {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(a.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(b.event_start_date)));
      //   } else {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(b.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(a.event_start_date)));
      //   }
      // } else {
      //   if (isHighest) {
      //     events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));
      //   } else {
      //     events.sort((a, b) => a.event_capacity.compareTo(b.event_capacity));
      //   }
      // }

      var now = new DateTime.now();
      var now_1w = now.subtract(const Duration(days: 7));
      var now_1m = now.subtract(const Duration(days: 30));

      if (date == "All") {
        for (int i = 0; i < events.length; i++) {
          if (events[i].event_location.compareTo(location) == 0 ||
              location == "All") {
            results.add(events[i]);
          }
        }
      } else if (date == "Latest") {
        events.sort((a, b) => b.event_start_date.compareTo(a.event_start_date));
        results = events.sublist(0, 10);
      } else if (date == "week") {
        for (int i = 0; i < events.length; i++) {
          var eventDate =
              DateFormat('d MMM y').parse(events[i].event_start_date);
          if (eventDate.isAfter(now_1w) &&
              (events[i].event_location.compareTo(location) == 0 ||
                  location == "All")) {
            results.add(events[i]);
          }
        }
      } else if (date == "month") {
        for (int i = 0; i < events.length; i++) {
          var eventDate =
              DateFormat('d MMM y').parse(events[i].event_start_date);
          if (eventDate.isAfter(now_1m) &&
              (events[i].event_location.compareTo(location) == 0 ||
                  location == "All")) {
            results.add(events[i]);
          }
        }
      }

      if (results.isEmpty) {
        hasData = false;
      } else {
        hasData = true;
      }

      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> searchEventPost(String name) async {
    List<EventModel> events = [];
    List<EventModel> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllEventsEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        events.add(EventModel.fromMap(jsonDecode(response.body)[i]));
      }

      // if (category.compareTo("Date") == 0) {
      //   if (isAscending) {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(a.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(b.event_start_date)));
      //   } else {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(b.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(a.event_start_date)));
      //   }
      // } else
      // {
      events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));

      if (isHighest) {
        events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));
      } else {
        events.sort((a, b) => a.event_capacity.compareTo(b.event_capacity));
      }
      // }

      if (name.isNotEmpty) {
        events.forEach((element) {
          if (element.event_title.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(events);
      }

      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> searchEventPostArb(String name) async {
    List<EventModel> events = [];
    List<EventModel> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllEventsArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        events.add(EventModel.fromMap(jsonDecode(response.body)[i]));
      }

      // if (category.compareTo("Date") == 0) {
      //   if (isAscending) {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(a.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(b.event_start_date)));
      //   } else {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(b.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(a.event_start_date)));
      //   }
      // } else
      // {
      events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));

      if (isHighest) {
        events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));
      } else {
        events.sort((a, b) => a.event_capacity.compareTo(b.event_capacity));
      }
      // }

      if (name.isNotEmpty) {
        events.forEach((element) {
          if (element.event_title.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(events);
      }

      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<EventModel>> EventPost;
  late Future<List<EventModel>> EventPostArb;
  bool isAscending = false;
  bool isHighest = true;
  String category = "Date";
  String date = "All";
  String location = "All";
  TextEditingController _searchController = TextEditingController();
  bool hasData = true;

  Future<http.Response> deleteRequest(int uid) async {
    Map data = {
      "event_id": uid,
      "event_title": "title 3",
      "event_start_date": "23rd October 22",
      "event_end_date": "25th October 22",
      "event_start_time": "12:34",
      "event_end_time": "12:50",
      "event_description": "fff",
      "event_mention_account": "qwe",
      "event_tags": "qe",
      "event_link": "ew",
      "event_schedule_time": "ef",
      "event_capacity": 32,
      "event_location": "online",
      "rsvp": 0
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'DeleteEvent'),
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    setState(() {
      EventPost =
          filterEventPost(isAscending, isHighest, category, date, location);
    });
    return response;
  }

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();
    EventPost =
        filterEventPost(isAscending, isHighest, category, date, location);
    EventPostArb =
        filterEventPostArb(isAscending, isHighest, category, date, location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final button = PopupMenuButton(
        icon: const Icon(Icons.more_vert_rounded,
            size: 18, color: Color(0xFF999999)),
        key: _menuKey,
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(child: Text('Edit'), value: 'Edit'),
              PopupMenuItem<String>(child: Text('Report'), value: 'Report'),
              PopupMenuItem<String>(
                  child: Text(
                    'Delete'.tr().toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  value: 'Report'),
            ],
        onSelected: (_) {});

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final filterBtn = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      scrollable: true,
      title: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close))),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Form(
          child: Row(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      width: width * 0.1,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  date = "All";
                                  EventPost = filterEventPost(isAscending,
                                      isHighest, category, date, location);
                                  EventPostArb = filterEventPostArb(isAscending,
                                      isHighest, category, date, location);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "All".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            date.compareTo("All") == 0
                                ? SvgPicture.asset(
                                    "assets/images/sortyes.svg",
                                    fit: BoxFit.scaleDown,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    Container(
                      width: width * 0.1,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  date = "Latest";
                                  EventPost = filterEventPost(isAscending,
                                      isHighest, category, date, location);
                                  EventPostArb = filterEventPostArb(isAscending,
                                      isHighest, category, date, location);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Latest Events".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            date.compareTo("Latest") == 0
                                ? SvgPicture.asset(
                                    "assets/images/sortyes.svg",
                                    fit: BoxFit.scaleDown,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    Container(
                      width: width * 0.1,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  date = "week";
                                  EventPost = filterEventPost(isAscending,
                                      isHighest, category, date, location);
                                  EventPostArb = filterEventPostArb(isAscending,
                                      isHighest, category, date, location);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Posted in last 7 days".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            date.compareTo("week") == 0
                                ? SvgPicture.asset(
                                    "assets/images/sortyes.svg",
                                    fit: BoxFit.scaleDown,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    Container(
                      width: width * 0.1,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  date = "month";
                                  EventPost = filterEventPost(isAscending,
                                      isHighest, category, date, location);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Posted in last 30 days".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            date.compareTo("month") == 0
                                ? SvgPicture.asset(
                                    "assets/images/sortyes.svg",
                                    fit: BoxFit.scaleDown,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.06,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: width * 0.1,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  location = "All";
                                  EventPost = filterEventPost(isAscending,
                                      isHighest, category, date, location);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "All".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            location.compareTo("All") == 0
                                ? SvgPicture.asset(
                                    "assets/images/sortyes.svg",
                                    fit: BoxFit.scaleDown,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    Container(
                      width: width * 0.1,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  location = "online";
                                  EventPost = filterEventPost(isAscending,
                                      isHighest, category, date, location);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Online".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            location.compareTo("Online") == 0
                                ? SvgPicture.asset(
                                    "assets/images/sortyes.svg",
                                    fit: BoxFit.scaleDown,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    Container(
                      width: width * 0.1,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  location = "offline";
                                  EventPost = filterEventPost(isAscending,
                                      isHighest, category, date, location);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Offline".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            location.compareTo("Offline") == 0
                                ? SvgPicture.asset(
                                    "assets/images/sortyes.svg",
                                    fit: BoxFit.scaleDown,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final searchtab = Container(
      width: width * 0.4,
      height: height * 0.048,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 18.0, right: 20.0, top: 5, bottom: 5),
        child: Row(
          children: [
            Image.asset(
              "assets/images/search.png",
              fit: BoxFit.scaleDown,
            ),

            // SvgPicture.asset("assets/images/search.svg",fit: BoxFit.scaleDown,),

            SizedBox(
              width: width * 0.009,
            ),
            SizedBox(
              width: width * 0.28,
              height: height * 0.4,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    EventPost = searchEventPost(value);
                    EventPostArb = searchEventPostArb(value);
                  });
                },
                controller: _searchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'Search'.tr().toString(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                  hintStyle: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.009,
            ),

            SvgPicture.asset(
              "assets/images/Separator.svg",
              fit: BoxFit.scaleDown,
            ),

            InkWell(
              hoverColor: Colors.transparent,
              onTap: () async {
                picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(DateTime.now().year - 5),
                  lastDate: DateTime(DateTime.now().year + 5),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                        //Header background color
                        primaryColor: Color(0xff007A33),

                        //Background color
                        scaffoldBackgroundColor: Colors.white,
                        //Divider color
                        dividerColor: Colors.grey,
                        //Non selected days of the month color
                        textTheme: TextTheme(
                          bodyText2: TextStyle(color: Colors.black),
                        ),
                        colorScheme: ColorScheme.fromSwatch().copyWith(
                          //Selected dates background color
                          primary: Color(0xff007A33),
                          //Month title and week days color
                          onSurface: Colors.black,
                          //Header elements and selected dates text color
                          onPrimary: Colors.white,
                        ),
                      ),
                      child: Column(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 400.0,
                              maxHeight: height * 0.7,
                            ),
                            child: child,
                          )
                        ],
                      ),
                    );
                  },
                );
                setState(() {
                  if (picked != null) {
                    EventPost = filterPostEng(isAscending, picked!);
                  } else {
                    EventPost = filterPostEng(isAscending, picked!);
                  }
                });

                print(picked);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.021,
                  ),
                  SvgPicture.asset(
                    "assets/images/filter.svg",
                    fit: BoxFit.scaleDown,
                  ),
                  Text(
                    "  Filter".tr(),
                    style: GoogleFonts.barlow(
                      textStyle: TextStyle(
                          color: Color(0xFF215732),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: width * 0.01),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    final sortbtn = Container(
      height: height * 0.047,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black, width: 0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17),
        child: InkWell(
          hoverColor: Colors.transparent,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  String? dropdownvalue = 'Admin';
                  Locale? lang = const Locale("en");
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    scrollable: true,
                    title: Column(
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.close))),
                      ],
                    ),
                    content: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Form(
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Capacity".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(
                                          color: Color(0xFF222222),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),

                                  Container(
                                    width: width * 0.14,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Color(0xFFEEEEEE)))),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: height * 0.012,
                                      ),
                                      child: Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isHighest = true;
                                                category = "Capacity";
                                              });
                                              EventPost = filterEventPost(
                                                  isAscending,
                                                  isHighest,
                                                  category,
                                                  date,
                                                  location);
                                              EventPostArb = filterEventPostArb(
                                                  isAscending,
                                                  isHighest,
                                                  category,
                                                  date,
                                                  location);

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Highest to Lowest".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: const TextStyle(
                                                    color: Color(0xFF222222),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          isHighest
                                              ? SvgPicture.asset(
                                                  "assets/images/sortyes.svg",
                                                  fit: BoxFit.scaleDown,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.012,
                                  ),

                                  // SizedBox(height: ),

                                  Container(
                                    width: width * 0.14,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Color(0xFFEEEEEE)))),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: height * 0.012,
                                      ),
                                      child: Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isHighest = false;
                                                category = "Capacity";
                                              });
                                              EventPost = filterEventPost(
                                                  isAscending,
                                                  isHighest,
                                                  category,
                                                  date,
                                                  location);
                                              EventPostArb = filterEventPostArb(
                                                  isAscending,
                                                  isHighest,
                                                  category,
                                                  date,
                                                  location);

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Lowest to Highest".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: const TextStyle(
                                                    color: Color(0xFF222222),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          !isHighest
                                              ? SvgPicture.asset(
                                                  "assets/images/sortyes.svg",
                                                  fit: BoxFit.scaleDown,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/images/sort.svg",
                fit: BoxFit.scaleDown,
              ),
              Text(
                "  Sort".tr(),
                style: GoogleFonts.barlow(
                  textStyle: TextStyle(
                      color: const Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: width * 0.01),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // final detailrow = InkWell(
    //   hoverColor: Colors.transparent,
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       PageRouteBuilder(
    //         pageBuilder: (context, animation1, animation2) =>
    //         const webSpecificEvent(),
    //         transitionDuration: const Duration(seconds: 0),
    //       ),
    //     );
    //   },
    //   child: Material(
    //     color: Colors.white,
    //     elevation: 1,
    //     child: Container(
    //       width: width * 0.92,
    //       height: height * 0.07,
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: width * 0.0125,
    //           ),
    //           Container(
    //             width: width * 0.2,
    //             child: Text(
    //               "Investment Techniques & Tools:...".tr(),
    //               style: GoogleFonts.barlow(
    //                 textStyle: const TextStyle(
    //                     color: Color(0xFF222222),
    //                     fontWeight: FontWeight.w400,
    //                     fontStyle: FontStyle.normal,
    //                     fontSize: 16),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: width * 0.08,
    //             child: Text(
    //               "260".tr(),
    //               style: GoogleFonts.barlow(
    //                 textStyle: const TextStyle(
    //                     color: Color(0xFF222222),
    //                     fontWeight: FontWeight.w400,
    //                     fontStyle: FontStyle.normal,
    //                     fontSize: 16),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: width * 0.08,
    //             child: Text(
    //               "189".tr(),
    //               style: GoogleFonts.barlow(
    //                 textStyle: const TextStyle(
    //                     color: Color(0xFF222222),
    //                     fontWeight: FontWeight.w400,
    //                     fontStyle: FontStyle.normal,
    //                     fontSize: 16),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: width * 0.09,
    //             child: Text(
    //               "Online".tr(),
    //               style: GoogleFonts.barlow(
    //                 textStyle: const TextStyle(
    //                     color: Color(0xFF222222),
    //                     fontWeight: FontWeight.w400,
    //                     fontStyle: FontStyle.normal,
    //                     fontSize: 16),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: width * 0.1,
    //             child: Text(
    //               "May 31, 2022".tr(),
    //               style: GoogleFonts.barlow(
    //                 textStyle: const TextStyle(
    //                     color: Color(0xFF222222),
    //                     fontWeight: FontWeight.w400,
    //                     fontStyle: FontStyle.normal,
    //                     fontSize: 16),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: width * 0.115,
    //             child: Text(
    //               "5:30 PM - 6:30 PM".tr(),
    //               style: GoogleFonts.barlow(
    //                 textStyle: const TextStyle(
    //                     color: Color(0xFF222222),
    //                     fontWeight: FontWeight.w400,
    //                     fontStyle: FontStyle.normal,
    //                     fontSize: 16),
    //               ),
    //             ),
    //           ),
    //           const Icon(
    //             Icons.more_vert_outlined,
    //             size: 18,
    //             color: Color(0Xff999999),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width * 0.003,
            color: const Color(0xFFBD9B60),
            // child: Text("we"),
          ),
          Drawer(
            width: width * 0.2,
            child: Container(
              color: const Color(0xFF183028),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: DrawerHeader(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.008,
                            ),
                            Image.asset(
                              "assets/images/pifLogo.png", fit: BoxFit.contain,
                              width: width * 0.06,
                              //86
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const ImageIcon(
                      AssetImage("assets/images/home.png"),
                      color: Color(0xFFBD9B60),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Home".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
                            color: Color(0xFFBD9B60),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const HomeResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.001, right: width * 0.002),
                        child: const Icon(Icons.list,
                            color: Color(0xFFBD9B60), size: 26.2)),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Courses".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
                            color: Color(0xFFBD9B60),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const courseResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: context.locale == const Locale("en")
                            ? width * 0.01
                            : 0.0,
                        left: context.locale == const Locale("en")
                            ? 0.0
                            : width * 0.01),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFBD9B60),
                        //
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              context.locale == const Locale("en") ? 0 : 40.0),
                          bottomLeft: Radius.circular(
                              context.locale == const Locale("en") ? 0 : 40.0),
                          topRight: Radius.circular(
                              context.locale == const Locale("en") ? 40 : 0.0),
                          bottomRight: Radius.circular(
                              context.locale == const Locale("en") ? 40 : 0.0),
                        ),
                      ),
                      child: ListTile(
                        leading: const ImageIcon(
                          AssetImage("assets/images/admin.png"),
                          color: Colors.white,
                        ),
                        minLeadingWidth: width * 0.02,
                        title: Text(
                          "Administration".tr(),
                          style: GoogleFonts.barlow(
                            textStyle: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18),
                          ),
                        ),
                        onTap: () => {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const adminResponsive(),
                              transitionDuration: const Duration(seconds: 0),
                            ),
                          )
                        },
                      ),
                    ),
                  ),
                  Padding(
                    // padding:  EdgeInsets.only(right: width*0.01,left: ),
                    padding: EdgeInsets.only(
                        right: context.locale == const Locale("en")
                            ? width * 0.01
                            : width * 0.025,
                        left: context.locale == const Locale("en")
                            ? width * 0.025
                            : width * 0.01),

                    child: Row(
                      children: [
                        Container(
                          height: height * 0.06,
                          width: 5,
                          color: const Color(0xFFBD9B60),
                          // child: Text("we"),
                        ),
                        Expanded(
                          child: Container(
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(189, 155, 96, 0.2),
                              //
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    context.locale == const Locale("en")
                                        ? 0
                                        : 40.0),
                                bottomLeft: Radius.circular(
                                    context.locale == const Locale("en")
                                        ? 0
                                        : 40.0),
                                topRight: Radius.circular(
                                    context.locale == const Locale("en")
                                        ? 40
                                        : 0.0),
                                bottomRight: Radius.circular(
                                    context.locale == const Locale("en")
                                        ? 40
                                        : 0.0),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListTile(
                                title: Text(
                                  "Events".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: const TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18),
                                  ),
                                ),
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const eventResponsive(),
                                      transitionDuration:
                                          const Duration(seconds: 0),
                                    ),
                                  )
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(
                          right: context.locale == const Locale("en")
                              ? 0
                              : width * 0.028,
                          left: context.locale == const Locale("en")
                              ? width * 0.028
                              : 0),
                      child: Text(
                        "Announcements".tr(),
                        style: GoogleFonts.barlow(
                          textStyle: const TextStyle(
                              color: Color(0xFFBD9B60),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const announcementResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      ),
                    },
                  ),
                  ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(
                          right: context.locale == const Locale("en")
                              ? 0
                              : width * 0.028,
                          left: context.locale == const Locale("en")
                              ? width * 0.028
                              : 0),
                      child: Text(
                        "Users".tr(),
                        style: GoogleFonts.barlow(
                          textStyle: const TextStyle(
                              color: Color(0xFFBD9B60),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const userResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(left: width * 0.0028),
                      child: SvgPicture.asset("assets/images/admission.svg",
                          color: const Color(0xFFBD9B60)),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Admission".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
                            color: Color(0xFFBD9B60),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const admissionResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 2.0, left: 2),
                      child: SvgPicture.asset("assets/images/settings.svg",
                          color: const Color(0xFFBD9B60)),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Settings".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
                            color: Color(0xFFBD9B60),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const settingResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/images/Headphone.svg",
                        color: const Color(0xFFBD9B60)),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Help".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
                            color: Color(0xFFBD9B60),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const helpResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  SizedBox(
                    height: height * 0.004,
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/images/faqicon.svg",
                        color: Color(0xFFBD9B60)),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "FAQ".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: TextStyle(
                            color: Color(0xFFBD9B60),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              faqResponsive(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                        // MaterialPageRoute(builder: (context) => coursesPage()),
                        // transitionDuration: const Duration(seconds: 0),
                      )
                    },
                  ),
                  SizedBox(
                    height: height * 0.004,
                  ),
                  const Divider(
                    color: Color(0xffFFFFFF),
                    thickness: 0.2,
                    indent: 12,
                    endIndent: 12,
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/images/message.svg"),
                    minLeadingWidth: 1,
                    title: Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.003, right: width * 0.003),
                      child: Text(
                        "Messages".tr(),
                        style: GoogleFonts.barlow(
                          textStyle: const TextStyle(
                              color: Color(0xFFBD9B60),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MessageResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  const Divider(
                    color: Color(0xffFFFFFF),
                    thickness: 0.2,
                    indent: 12,
                    endIndent: 12,
                  ),
                  ListTile(
                    leading: const ImageIcon(
                      AssetImage("assets/images/logout.png"),
                      color: Color(0xFFBD9B60),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Logout".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
                            color: Color(0xFFBD9B60),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18),
                      ),
                    ),
                    onTap: () => {
                      _delete(context),
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: WebSmoothScroll(
                controller: _scrollController,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.03,
                      top: 20.0,
                      bottom: 20.0,
                      right: width * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        height: height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Administration /".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    "Events".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(
                                          color: Color(0xFF215732),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                const MessageResponsive(),
                                            transitionDuration:
                                                const Duration(seconds: 0),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/message.svg")),
                                  SizedBox(
                                    width: width * 0.0152,
                                  ),
                                  InkWell(
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                const settingResponsive(),
                                            transitionDuration:
                                                const Duration(seconds: 0),
                                          ),
                                        );
                                      },
                                      child: pfpImage ??
                                          (isSwitched
                                              ? Image.asset(
                                                  "assets/images/noFace.png",
                                                  width: width * 0.0277,
                                                  height: height * 0.344,
                                                )
                                              : Image.asset(
                                                  "assets/images/noFace.png",
                                                  width: width * 0.0277,
                                                  height: height * 0.344,
                                                )))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.13,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 17,
                                        color: Colors.black,
                                      )),
                                  SizedBox(
                                    width: width * 0.002,
                                  ),
                                  Text(
                                    "Events".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(
                                          color: Color(0xFF222222),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 28),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 43,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const addEvent(),
                                      transitionDuration:
                                          const Duration(seconds: 0),
                                    ),
                                  );
                                },
                                child: Text('Add new event'.tr().toString(),
                                    strutStyle: const StrutStyle(
                                        forceStrutHeight: true),
                                    style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    )),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF215732),
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    side: const BorderSide(
                                        width: 0.4, color: Color(0xFF215732))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.01, vertical: width * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  searchtab,
                                  SizedBox(
                                    width: width * 0.005,
                                  ),
                                  sortbtn,
                                ],
                              ),
                              SizedBox(
                                height: height * 0.035,
                              ),
                              Card(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * 0.92,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: width * 0.92,
                                          height: height * 0.07,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF5F0E5),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(9.0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(9.0),
                                                bottomLeft: Radius.circular(0)),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width * 0.0125,
                                              ),
                                              Container(
                                                width: width * 0.2,
                                                child: Text(
                                                  "Name".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: const TextStyle(
                                                        color:
                                                            Color(0xFFBD9B60),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.08,
                                                child: Text(
                                                  "Capacity".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: const TextStyle(
                                                        color:
                                                            Color(0xFFBD9B60),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.08,
                                                child: Text(
                                                  "RSVP".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: const TextStyle(
                                                        color:
                                                            Color(0xFFBD9B60),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.09,
                                                child: Text(
                                                  "Location".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: const TextStyle(
                                                        color:
                                                            Color(0xFFBD9B60),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.1,
                                                child: Text(
                                                  "Date".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: const TextStyle(
                                                        color:
                                                            Color(0xFFBD9B60),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.12,
                                                child: Text(
                                                  "Time".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: const TextStyle(
                                                        color:
                                                            Color(0xFFBD9B60),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.002,
                                        ),
                                        FutureBuilder<List<EventModel>>(
                                          future: context.locale == Locale("en")
                                              ? EventPost
                                              : EventPostArb,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              if (!hasData) {
                                                return Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "No Events".tr(),
                                                      style: GoogleFonts.barlow(
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Color(
                                                                    0xFF222222),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data!.length,
                                                  itemBuilder: (_, index) =>
                                                      Container(
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          hoverColor: Colors
                                                              .transparent,
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              PageRouteBuilder(
                                                                pageBuilder: (context,
                                                                        animation1,
                                                                        animation2) =>
                                                                    webSpecificEvent(
                                                                  eventID: snapshot
                                                                      .data![
                                                                          index]
                                                                      .event_id,
                                                                  eventTitle: snapshot
                                                                      .data![
                                                                          index]
                                                                      .event_title,
                                                                ),
                                                                transitionDuration:
                                                                    const Duration(
                                                                        seconds:
                                                                            0),
                                                              ),
                                                              // MaterialPageRoute(builder: (context) => coursesPage()),
                                                              // transitionDuration: const Duration(seconds: 0),
                                                            );
                                                          },
                                                          child: Material(
                                                            color: Colors.white,
                                                            elevation: 1,
                                                            child: Container(
                                                              width:
                                                                  width * 0.92,
                                                              height:
                                                                  height * 0.07,
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: width *
                                                                        0.0125,
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        width *
                                                                            0.2,
                                                                    child: Text(
                                                                      "${snapshot.data![index].event_title}"
                                                                          .tr(),
                                                                      style: GoogleFonts
                                                                          .barlow(
                                                                        textStyle: const TextStyle(
                                                                            color:
                                                                                Color(0xFF222222),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: 16),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        width *
                                                                            0.08,
                                                                    child: Text(
                                                                      "${snapshot.data![index].event_capacity}"
                                                                          .tr(),
                                                                      style: GoogleFonts
                                                                          .barlow(
                                                                        textStyle: const TextStyle(
                                                                            color:
                                                                                Color(0xFF222222),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: 16),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        width *
                                                                            0.08,
                                                                    child: Text(
                                                                      "${snapshot.data![index].rsvp}"
                                                                          .tr(),
                                                                      style: GoogleFonts
                                                                          .barlow(
                                                                        textStyle: const TextStyle(
                                                                            color:
                                                                                Color(0xFF222222),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: 16),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        width *
                                                                            0.09,
                                                                    child: Text(
                                                                      "${snapshot.data![index].event_location}"
                                                                          .tr(),
                                                                      style: GoogleFonts
                                                                          .barlow(
                                                                        textStyle: const TextStyle(
                                                                            color:
                                                                                Color(0xFF222222),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: 16),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        width *
                                                                            0.1,
                                                                    child: Text(
                                                                      DateFormat.yMMMMd(context.locale.toString()).format(DateFormat('MMM dd yyyy').parse(snapshot
                                                                          .data![
                                                                              index]
                                                                          .event_start_date)),
                                                                      style: GoogleFonts
                                                                          .barlow(
                                                                        textStyle: const TextStyle(
                                                                            color:
                                                                                Color(0xFF222222),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: 16),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: width *
                                                                        0.115,
                                                                    child: Text(
                                                                      "${DateFormat.Hm(context.locale.toString()).format(DateFormat('HH:mm').parse(snapshot.data![index].event_start_time))} - ${DateFormat.Hm(context.locale.toString()).format(DateFormat('HH:mm').parse(snapshot.data![index].event_end_time))}",
                                                                      style: GoogleFonts
                                                                          .barlow(
                                                                        textStyle: const TextStyle(
                                                                            color:
                                                                                Color(0xFF222222),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: 16),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  PopupMenuButton(
                                                                    onSelected:
                                                                        (result) {
                                                                      // your logic
                                                                      if (result ==
                                                                          0) {
                                                                        print(
                                                                            "delete");
                                                                        // deleteRequestAra(snapshot
                                                                        //     .data![index]
                                                                        //     .event_id);

                                                                        deleteRequest(snapshot
                                                                            .data![index]
                                                                            .event_id);
                                                                      }
                                                                    },
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                            bc) {
                                                                      return [
                                                                        PopupMenuItem(
                                                                          child: Text("Delete"
                                                                              .tr()
                                                                              .toString()),
                                                                          value:
                                                                              0,
                                                                        ),
                                                                      ];
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            } else {
                                              return Center(
                                                  child: Text(
                                                      "No Items Found".tr(),
                                                      style: GoogleFonts.barlow(
                                                          textStyle: const TextStyle(
                                                              color: Color(
                                                                  0xFF222222),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 16))));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                              SizedBox(
                                height: height * 0.2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
