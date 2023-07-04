import 'dart:convert';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:group_button/group_button.dart';

import 'package:pif_admin_dashboard/adminstration/webSpecificEvent.dart';
import 'package:pif_admin_dashboard/pfpimg.dart';

import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/eventsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/faqResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/usersResponive.dart';
import 'package:pif_admin_dashboard/models/user_model.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'courseDetails/courseTabs.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'models/event_model.dart';
import 'models/course_model.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;

class home extends StatefulWidget {

  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
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
                  onPressed: () async {
                    final SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.remove('email');
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

  List<EnrolledData> _chartData = [];

  Future<int> fetchTodaysEventsEng() async {
    List<int> eventsToday = [];

    final responseEng =
        await http.get(Uri.parse(global.apiAddress + 'GetAllEventsEng'));

    if (responseEng.statusCode == 200) {
      final parsedEng =
          json.decode(responseEng.body).cast<Map<String, dynamic>>();
      final finParsedEng = parsedEng
          .map<EventModel>((json) => EventModel.fromMap(json))
          .toList();

      DateFormat format = DateFormat('MMM dd yyyy'); // this is the format used
      for (EventModel event in finParsedEng) {
        DateTime eventDate = format.parse(event.event_start_date);
        DateTime now = DateTime.now(); // get current datetime

        bool isToday = eventDate.year == now.year &&
            eventDate.month == now.month &&
            eventDate.day == now.day;

        if (isToday) {
          eventsToday.add(1); // add the event to the list
        }
      }

      return eventsToday.length;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<int> eventsTodayCount;

  Future<String> fetchStudentsCountEng() async {
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetStudentsCountEng'));

    if (response.statusCode == 200) {
      print("Todays events body: ${response.body.toString()}");
      return response.body.toString();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<String> fetchCompleteCoursesCountEng() async {
    final response = await http
        .get(Uri.parse(global.apiAddress + 'GetCompleteCourseCountEng'));

    if (response.statusCode == 200) {
      print("compplete events body: ${response.body.toString()}");
      return response.body.toString();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<String> fetchOngoingCoursesCountEng() async {
    final response = await http
        .get(Uri.parse(global.apiAddress + 'GetOngoingCoursesCountEng'));

    if (response.statusCode == 200) {
      print("Todays events body: ${response.body.toString()}");
      return response.body.toString();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<String> fetchUpcomingEventsCountEng() async {
    final response = await http
        .get(Uri.parse(global.apiAddress + 'GetUpcomingEventsCountEng'));

    if (response.statusCode == 200) {
      print("Upcoming events body: ${response.body.toString()}");
      return response.body.toString();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> fetchEventsEng() async {
    final responseEng =
        await http.get(Uri.parse(global.apiAddress + 'GetAllEventsEng'));

    if (responseEng.statusCode == 200) {
      final parsedEng =
          json.decode(responseEng.body).cast<Map<String, dynamic>>();
      final finParsedEng = parsedEng
          .map<EventModel>((json) => EventModel.fromMap(json))
          .toList();
      print(" Events today: ${parsedEng} and type: ${parsedEng.runtimeType}");
      return finParsedEng;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> fetchEventsArb() async {
    final responseArb =
        await http.get(Uri.parse(global.apiAddress + 'GetAllEventsArb'));

    if (responseArb.statusCode == 200) {
      final parsedArb =
          json.decode(responseArb.body).cast<Map<String, dynamic>>();

      return parsedArb
          .map<EventModel>((json) => EventModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<EventModel>> eventsArabic;
  late Future<List<EventModel>> eventsEnglish;
  Future<List<Course>> fetchCourse() async {
    List<Course> courses = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        courses.add(Course.fromMap(jsonDecode(response.body)[i]));
      }
      print(" Courses today: ${courses} and type: ${courses.runtimeType}");

      return courses;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late ScrollController _scrollController;

  Future<User> fetchUser() async {
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAUser/${global.userID}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<User>((json) => User.fromMap(json)).toList()[0];
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<User> user;
  String email = "";

  @override
  void initState() {
    _chartData = getChartData(0);
    // initialize scroll controllers
    _scrollController = ScrollController();
    eventsTodayCount = fetchTodaysEventsEng();
    eventsEnglish = fetchEventsEng();
    eventsArabic = fetchEventsArb();
    getEml();
    super.initState();

    user = fetchUser();
  }

  void getEml() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("route", "Home");
    setState() {
      email = pref.getString("email")!;
      print(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    PageController page = PageController();

    final annCard = InkWell(
      hoverColor: Colors.transparent,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: width * 0.355,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFFFFFF),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.04,
                    child: SvgPicture.asset("assets/images/bell.svg",
                        height: 2, width: 2, fit: BoxFit.scaleDown),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F2E7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(
                                "Update to Our Academy Guidelines: View now"
                                    .tr()
                                    .toString(),
                                strutStyle: StrutStyle(forceStrutHeight: true),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      fontFamily: 'Barlow',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xFF222222)),
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                "10 May, 2022 | 5:29 PM".tr().toString(),
                                strutStyle: StrutStyle(forceStrutHeight: true),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      fontFamily: 'Barlow',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xFF999999)),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(width: 70),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final event1 = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => webSpecificEvent()),
          // );
        },
        child: Container(
          // decoration:  BoxDecoration(
          //   borderRadius: BorderRadius.circular(150),
          //
          //
          // ),

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFFFFFF),
            ),
            // color: Color(0xFFFFFFFF),

            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.038,
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Jun ".tr().toString(),
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                  fontFamily: 'Barlow',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xFF999999)),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "16".tr().toString(),
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                  fontFamily: 'Barlow',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xFFBD9B60)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F2E7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.17,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.022,
                              ),
                              Text(
                                "5:30-6:30 PM".tr().toString(),
                                strutStyle: StrutStyle(forceStrutHeight: true),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      fontFamily: 'Barlow',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xFF999999)),
                                ),
                              ),
                              SizedBox(height: height * 0.009),
                              Text(
                                "Meet & Greet ".tr().toString(),
                                strutStyle: StrutStyle(forceStrutHeight: true),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      fontFamily: 'Barlow',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xFF222222)),
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                "This event is for meeting all the PIF"
                                    .tr()
                                    .toString(),
                                strutStyle: StrutStyle(forceStrutHeight: true),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      fontFamily: 'Barlow',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xFF999999)),
                                ),
                              ),
                              SizedBox(height: height * 0.002),
                              Text(
                                "Academy students and instructors."
                                    .tr()
                                    .toString(),
                                strutStyle: StrutStyle(forceStrutHeight: true),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      fontFamily: 'Barlow',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xFF999999)),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.022,
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(width: 70),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final event2 = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // decoration:  BoxDecoration(
        //   borderRadius: BorderRadius.circular(150),
        //
        //
        // ),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFFFFFFF),
          ),
          // color: Color(0xFFFFFFFF),

          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.038,
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Jun ".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF999999)),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "18".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFFBD9B60)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9F2E7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.17,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.022,
                            ),
                            Text(
                              "5:30-6:30 PM".tr().toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF999999)),
                              ),
                            ),
                            SizedBox(height: height * 0.009),
                            Text(
                              "Data Analytics Workshop Meet ".tr().toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF222222)),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "Practice your skills in a real life scenario."
                                  .tr()
                                  .toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF999999)),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.022,
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 70),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final event3 = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFFFFFFF),
          ),
          // color: Color(0xFFFFFFFF),

          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.038,
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "May ".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF999999)),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "31".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFFBD9B60)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9F2E7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.17,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.022,
                            ),
                            Text(
                              "5:30-6:30 PM".tr().toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF999999)),
                              ),
                            ),
                            SizedBox(height: height * 0.009),
                            Text(
                              "Investment Techniques & Tools: Meet-Up at Head Quarters"
                                  .tr()
                                  .toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF222222)),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "In-person meet-up. Get to know your instructor and ask questions!"
                                  .tr()
                                  .toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF999999)),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.022,
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 70),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final event4 = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // decoration:  BoxDecoration(
        //   borderRadius: BorderRadius.circular(150),
        //
        //
        // ),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFFFFFFF),
          ),
          // color: Color(0xFFFFFFFF),

          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.038,
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "May ".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF999999)),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "29".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFFBD9B60)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9F2E7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.17,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.022,
                            ),
                            Text(
                              "5:30-6:30 PM".tr().toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF999999)),
                              ),
                            ),
                            SizedBox(height: height * 0.009),
                            Text(
                              "Quizzing your knowledge: Data Analytics "
                                  .tr()
                                  .toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF222222)),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "Show up and grow what you already know by attending this quiz!"
                                  .tr()
                                  .toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF999999)),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.022,
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 70),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final courseOne = Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => tabForCourses()),
          // );
        },
        child: Container(
          height: 111,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.20555,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Financial Modelling ".tr().toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF222222)),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.002),
                            Row(
                              children: [
                                Text(
                                  "Instructor: ".tr().toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF999999)),
                                  ),
                                ),
                                Text(
                                  "Ahmed Alsahli".tr().toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFFBD9B60)),
                                  ),
                                ),
                              ],
                            ),
                            // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                            SizedBox(height: height * 0.01),
                            Row(
                              children: [
                                Text(
                                  "1 of 2 workshops done | 56 students"
                                      .tr()
                                      .toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF999999)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 65,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final courseTwo = Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 111,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.20555,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Financial Modelling ".tr().toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF222222)),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.002),
                            Row(
                              children: [
                                Text(
                                  "Instructor: ".tr().toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF999999)),
                                  ),
                                ),
                                Text(
                                  "Ahmed Alsahli".tr().toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFFBD9B60)),
                                  ),
                                ),
                              ],
                            ),
                            // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                            SizedBox(height: height * 0.01),
                            Row(
                              children: [
                                Text(
                                  "1 of 2 workshops done | 56 students"
                                      .tr()
                                      .toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF999999)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 65,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final courseThree = Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 111,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.2055,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Advanced Data Analytics ".tr().toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF222222)),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.002),
                            Row(
                              children: [
                                Text(
                                  "Instructor: ".tr().toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF999999)),
                                  ),
                                ),
                                Text(
                                  "Mohammad Abdulrahman".tr().toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFFBD9B60)),
                                  ),
                                ),
                              ],
                            ),
                            // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                            SizedBox(height: height * 0.01),
                            Row(
                              children: [
                                Text(
                                  "2 of 3 workshops done | 48 students"
                                      .tr()
                                      .toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF999999)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 65,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final courseFour = Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 111,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.2055,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Project Management Essentials ".tr().toString(),
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF222222)),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.002),
                            Row(
                              children: [
                                Text(
                                  "Instructor: ".tr().toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF999999)),
                                  ),
                                ),
                                Text(
                                  "Mohammad Alsoghayer".tr().toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFFBD9B60)),
                                  ),
                                ),
                              ],
                            ),
                            // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                            SizedBox(height: height * 0.01),
                            Row(
                              children: [
                                Text(
                                  "1 of 4 workshops done | 34 students"
                                      .tr()
                                      .toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF999999)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 65,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

// Design starts
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width * 0.003,
            color: Color(0xFFBD9B60),
            // child: Text("we"),
          ),

          // *--------------------------------------------------------Sidebar starts --------------------------------------------------------------------------------------------------------*

          Drawer(
            width: width * 0.2,
            child: Container(
              color: Color(0xFF183028),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: DrawerHeader(
                        padding: EdgeInsets.all(0.0),
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
                  Padding(
                    padding: EdgeInsets.only(
                        right:
                            context.locale == Locale("en") ? width * 0.01 : 0.0,
                        left: context.locale == Locale("en")
                            ? 0.0
                            : width * 0.01),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFBD9B60),
                        //
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              context.locale == Locale("en") ? 0 : 40.0),
                          bottomLeft: Radius.circular(
                              context.locale == Locale("en") ? 0 : 40.0),
                          topRight: Radius.circular(
                              context.locale == Locale("en") ? 40 : 0.0),
                          bottomRight: Radius.circular(
                              context.locale == Locale("en") ? 40 : 0.0),
                        ),
                      ),
                      child: ListTile(
                        leading: SvgPicture.asset("assets/images/home.svg",
                            color: Colors.white),
                        minLeadingWidth: width * 0.02,
                        title: Text(
                          "Home".tr(),
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
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
                                  HomeResponsive(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                            // MaterialPageRoute(builder: (context) => coursesPage()),
                            // transitionDuration: const Duration(seconds: 0),
                          )
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.001, right: width * 0.002),
                        child: Icon(Icons.list,
                            color: Color(0xFFBD9B60), size: 26.2)),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Courses".tr(),
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
                              courseResponsive(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                        // MaterialPageRoute(builder: (context) => coursesPage()),
                        // transitionDuration: const Duration(seconds: 0),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.001, left: width * 0.001),
                      child: SvgPicture.asset("assets/images/admin.svg",
                          color: Color(0xFFBD9B60)),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Administration".tr(),
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
                              adminResponsive(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(left: width * 0.0028),
                      child: SvgPicture.asset("assets/images/admission.svg",
                          color: Color(0xFFBD9B60)),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Admission".tr(),
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
                              admissionResponsive(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                        // MaterialPageRoute(builder: (context) => coursesPage()),
                        // transitionDuration: const Duration(seconds: 0),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 2.0, left: 2),
                      child: SvgPicture.asset("assets/images/settings.svg",
                          color: Color(0xFFBD9B60)),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Settings".tr(),
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
                              settingResponsive(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                        // MaterialPageRoute(builder: (context) => coursesPage()),
                        // transitionDuration: const Duration(seconds: 0),
                      )
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/images/Headphone.svg",
                        color: Color(0xFFBD9B60)),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Help".tr(),
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
                              helpResponsive(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                        // MaterialPageRoute(builder: (context) => coursesPage()),
                        // transitionDuration: const Duration(seconds: 0),
                      )
                    },
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
                  Divider(
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
                          textStyle: TextStyle(
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
                              MessageResponsive(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                        // MaterialPageRoute(builder: (context) => coursesPage()),
                        // transitionDuration: const Duration(seconds: 0),
                      )
                    },
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  Divider(
                    color: Color(0xffFFFFFF),
                    thickness: 0.2,
                    indent: 12,
                    endIndent: 12,
                  ),
                  ListTile(
                    leading: ImageIcon(
                      AssetImage("assets/images/logout.png"),
                      color: Color(0xFFBD9B60),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Logout".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: TextStyle(
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

          // *--------------------------------------------------------Sidebar stops --------------------------------------------------------------------------------------------------------*
          // Expanded(
          //
          //   child: Container(
          //
          //     child: WebSmoothScroll(
          //
          //       controller: _scrollController,
          //       child: SingleChildScrollView(
          //           child: Padding(
          //             padding:  EdgeInsets.only(left: width*0.03,top: 20.0,bottom: 20.0,right: width*0.03),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 SizedBox(height: height*0.02,),
          //                 Container(
          //                   height: height*0.06,
          //
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.end,
          //                     crossAxisAlignment: CrossAxisAlignment.end,
          //
          //                     children: [
          //
          //                       InkWell(
          //                           hoverColor: Colors.transparent,
          //                           onTap: (){
          //                             Navigator.push(
          //                               context,
          //                               MaterialPageRoute(builder: (context) => MessageResponsive()),
          //                             );
          //                           },
          //                           child: SvgPicture.asset("assets/images/message.svg")),
          //                       SizedBox(width: width*0.0152,),
          //                       InkWell(
          //                           hoverColor: Colors.transparent,
          //                           onTap: (){
          //                             Navigator.push(
          //                               context,
          //                               MaterialPageRoute(builder: (context) => settingResponsive()),
          //                             );
          //                           },child: Image.asset("assets/images/pfpIcons.png",scale:4.5,))
          //
          //
          //
          //                     ],
          //                   ),
          //
          //                 ),
          //
          //                 Container(
          //                   height: height*0.13,
          //                   child: Row(
          //                     children: [
          //                       Padding(
          //                         padding: EdgeInsets.only(left: width*0.002),
          //
          //
          //                         child: Text("Administration".tr(),style: GoogleFonts.barlow(
          //                           textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 28),
          //                         ),),
          //                       ),
          //
          //
          //
          //                     ],
          //                   ),
          //
          //                 ),
          //
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //
          //                     Padding(
          //                       padding: EdgeInsets.only(left: width*0.002),
          //
          //                       child: Text("Events".tr(),style: GoogleFonts.barlow(
          //                         textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 20),
          //                       ),),
          //                     ),
          //                     InkWell(
          //                       hoverColor: Colors.transparent,
          //                       onTap: (){
          //                         Navigator.push(
          //                           context,
          //                           MaterialPageRoute(builder: (context) => eventResponsive()),
          //                         );
          //                       },
          //                       child: Row(
          //                         children: [
          //                           Text("View all ".tr(),style: GoogleFonts.barlow(
          //                             textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
          //                           ),),Container(
          //                             child: ImageIcon(
          //                                 AssetImage(context.locale == Locale("en") ? "assets/images/forward.png": "assets/images/arArrow.png" ),
          //
          //                                 color: Color(0xFF215732),
          //                                 size:9
          //                             ),
          //                             padding: EdgeInsets.only(top: 10.0,bottom: 10),
          //                             // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
          //
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //
          //                   ],
          //                 ),
          //                 SizedBox(height: height*0.02),
          //
          //                 SizedBox(height: height*0.02),
          //
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Padding(
          //                       padding: EdgeInsets.only(left: width*0.002),
          //
          //
          //                       child: Text("Announcements".tr(),style: GoogleFonts.barlow(
          //                         textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 20),
          //                       ),),
          //                     ),
          //                     InkWell(
          //                       hoverColor: Colors.transparent,
          //                       onTap: (){
          //
          //                       },
          //                       child: Row(
          //                         children: [
          //                           Text("View all ".tr(),style: GoogleFonts.barlow(
          //                             textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
          //                           ),),Container(
          //                             child: ImageIcon(
          //                                 AssetImage(context.locale == Locale("en") ? "assets/images/forward.png": "assets/images/arArrow.png" ),
          //
          //                                 color: Color(0xFF215732),
          //                                 size:9
          //                             ),
          //                             padding: EdgeInsets.only(top: 10.0,bottom: 10),
          //                             // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
          //
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 SizedBox(height: height*0.02),
          //
          //                 SizedBox(height: height*0.02),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Padding(
          //                       padding: EdgeInsets.only(left: width*0.002),
          //
          //                       child: Text("Users".tr(),style: GoogleFonts.barlow(
          //                         textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 20),
          //                       ),),
          //                     ),
          //                     InkWell(
          //                       hoverColor: Colors.transparent,
          //                       onTap: (){
          //                         Navigator.push(
          //                           context,
          //                           MaterialPageRoute(builder: (context) => userResponsive()),
          //                         );
          //                       },
          //                       child: Row(
          //                         children: [
          //                           Text("View all ".tr(),style: GoogleFonts.barlow(
          //                             textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
          //                           ),),Container(
          //                             child: ImageIcon(
          //                                 AssetImage(context.locale == Locale("en") ? "assets/images/forward.png": "assets/images/arArrow.png" ),
          //
          //                                 color: Color(0xFF215732),
          //                                 size:9
          //                             ),
          //                             padding: EdgeInsets.only(top: 10.0,bottom: 10),
          //                             // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
          //
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 SizedBox(height: height*0.02),
          //
          //               ],
          //             ),
          //           )
          //       ),
          //     ),
          //   ),),
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                "Hi Mohammad!".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 28),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: width * 0.17,
                                    child: Row(
                                      children: [
                                        Text(
                                          "${(DateFormat.yMMMMd(context.locale.toString()).format(DateTime.now()))}  |  "
                                              .tr(),
                                          style: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                color: Color(0xFF999999),
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: width * 0.01),
                                          ),
                                        ),
                                        FutureBuilder(
                                            future: eventsTodayCount,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return InkWell(
                                                  hoverColor:
                                                      Colors.transparent,
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                                animation1,
                                                                animation2) =>
                                                            eventResponsive(),
                                                        transitionDuration:
                                                            Duration(
                                                                seconds: 0),
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        snapshot.data
                                                            .toString()
                                                            .tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFF007A33),
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize:
                                                                  width * 0.01),
                                                        ),
                                                      ),
                                                      Text(
                                                        " events today".tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFF007A33),
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize:
                                                                  width * 0.01),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return Center(
                                                    child: Text(
                                                        "No events today".tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFF999999),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize:
                                                                  width * 0.01),
                                                        ))
                                                    // CircularProgressIndicator()
                                                    );
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                MessageResponsive(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/message.svg")),
                                  SizedBox(
                                    width: width * 0.0152,
                                  ),
                                  FutureBuilder<User>(
                                    future: user,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        pfpImage = Image.network(
                                          '${global.apiAddress}GetImage/${(snapshot.data!.user_img)}',
                                          height: height * 0.1,
                                          fit: BoxFit.scaleDown,
                                        );

                                        return Row(
                                          children: [
                                            InkWell(
                                                hoverColor: Colors.transparent,
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation1,
                                                              animation2) =>
                                                          settingResponsive(),
                                                      transitionDuration:
                                                          Duration(seconds: 0),
                                                    ),
                                                  );
                                                },
                                                child: isSwitched
                                                    ? pfpImage = Image.asset(
                                                        "assets/images/noFace.png",
                                                        width: width * 0.0277,
                                                        height: height * 0.344,
                                                      )
                                                    :
                                                    // nowPfp == null
                                                    //     ?
                                                    pfpImage = Container(
                                                        height: height * 0.344,
                                                        width: width * 0.0277,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                  "${global.apiAddress}GetImage/${(snapshot.data!.user_img)}",
                                                                ))),
                                                      )

                                                // child: isSwitched ? Image.asset("assets/images/noFace.png",scale: 4.5,) :
                                                // Image.asset("assets/images/pfpIcons.png",scale: 4.5,)
                                                ),
                                          ],
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                    // child:
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child: Text(
                          "Overview".tr(),
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
                                color: Color(0xFFBD9B60),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        width: width * 0.9,
                        child: Row(
                          children: [
                            Container(
                                width: width * 0.1776,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        context.locale == Locale("en")
                                            ? "assets/images/students.png"
                                            : "assets/images/ar1.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                height: height * 0.17,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height * 0.045,
                                      ),
                                      Container(
                                        width: width * 0.08,
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text(
                                            "Students enrolled".tr().toString(),
                                            strutStyle: StrutStyle(
                                                forceStrutHeight: true),
                                            style: GoogleFonts.barlow(
                                              textStyle: TextStyle(
                                                  fontFamily: 'Barlow',
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.027,
                                      ),
                                      FutureBuilder(
                                          future: fetchStudentsCountEng(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return InkWell(
                                                hoverColor: Colors.transparent,
                                                onTap: () {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(builder: (context) => eventResponsive()),
                                                  // );
                                                },
                                                child: Text(
                                                  "${snapshot.data.toString().tr()}"
                                                      .tr()
                                                      .toString(),
                                                  strutStyle: StrutStyle(
                                                      forceStrutHeight: true),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(
                                                        fontFamily: 'Barlow',
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color:
                                                            Color(0xffBD9B60)),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          }),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              width: width * 0.0082,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      context.locale == Locale("en")
                                          ? "assets/images/completed.png"
                                          : "assets/images/ar2.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              height: height * 0.17,
                              width: width * 0.1776,
                              //Image.asset(context.locale == Locale("en") ? "assets/images/students.png": "assets/images/ar1.png"
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * 0.045,
                                    ),
                                    Container(
                                      width: width * 0.08,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          " Completed courses ".tr().toString(),
                                          strutStyle: StrutStyle(
                                              forceStrutHeight: true),
                                          style: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: height * 0.027,
                                    ),

                                    FutureBuilder(
                                        future: fetchCompleteCoursesCountEng(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return InkWell(
                                              hoverColor: Colors.transparent,
                                              onTap: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(builder: (context) => eventResponsive()),
                                                // );
                                              },
                                              child: Text(
                                                "${snapshot.data.toString().tr()}"
                                                    .tr()
                                                    .toString(),
                                                strutStyle: StrutStyle(
                                                    forceStrutHeight: true),
                                                style: GoogleFonts.barlow(
                                                  textStyle: TextStyle(
                                                      fontFamily: 'Barlow',
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Color(0xffBD9B60)),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        }),

                                    // Text("48".tr().toString(),strutStyle: StrutStyle(
                                    //     forceStrutHeight: true
                                    // ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 24,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color:Color(0xffBD9B60) ),),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            // Image.asset(context.locale == Locale("en") ? "assets/images/completed.png": "assets/images/ar2.png"  ,width: width*0.1776),
                            SizedBox(
                              width: width * 0.0082,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      context.locale == Locale("en")
                                          ? "assets/images/ongoingCourses.png"
                                          : "assets/images/ar3.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              height: height * 0.17,
                              width: width * 0.1776,
                              //Image.asset(context.locale == Locale("en") ? "assets/images/students.png": "assets/images/ar1.png"
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * 0.045,
                                    ),
                                    Container(
                                      width: width * 0.08,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          " Ongoing courses".tr().toString(),
                                          strutStyle: StrutStyle(
                                              forceStrutHeight: true),
                                          style: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.027,
                                    ),
                                    FutureBuilder(
                                        future: fetchOngoingCoursesCountEng(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return InkWell(
                                              hoverColor: Colors.transparent,
                                              onTap: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(builder: (context) => eventResponsive()),
                                                // );
                                              },
                                              child: Text(
                                                "${snapshot.data.toString().tr()}"
                                                    .tr()
                                                    .toString(),
                                                strutStyle: StrutStyle(
                                                    forceStrutHeight: true),
                                                style: GoogleFonts.barlow(
                                                  textStyle: TextStyle(
                                                      fontFamily: 'Barlow',
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Color(0xffBD9B60)),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            // Image.asset(context.locale == Locale("en") ? "assets/images/ongoingCourses.png": "assets/images/ar3.png" ,width: width*0.1776),
                            SizedBox(
                              width: width * 0.0082,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      context.locale == Locale("en")
                                          ? "assets/images/events.png"
                                          : "assets/images/ar4.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              height: height * 0.17,
                              width: width * 0.1776,
                              //Image.asset(context.locale == Locale("en") ? "assets/images/students.png": "assets/images/ar1.png"
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * 0.045,
                                    ),
                                    Container(
                                      width: width * 0.08,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          " Upcoming events".tr().toString(),
                                          strutStyle: StrutStyle(
                                              forceStrutHeight: true),
                                          style: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.027,
                                    ),
                                    FutureBuilder(
                                        future: fetchUpcomingEventsCountEng(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return InkWell(
                                              hoverColor: Colors.transparent,
                                              onTap: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(builder: (context) => eventResponsive()),
                                                // );
                                              },
                                              child: Text(
                                                "${snapshot.data.toString().tr()}"
                                                    .tr()
                                                    .toString(),
                                                strutStyle: StrutStyle(
                                                    forceStrutHeight: true),
                                                style: GoogleFonts.barlow(
                                                  textStyle: TextStyle(
                                                      fontFamily: 'Barlow',
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Color(0xffBD9B60)),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            // Image.asset(context.locale == Locale("en") ? "assets/images/events.png": "assets/images/ar4.png" ,width: width*0.1776),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.244,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Upcoming Events".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: TextStyle(
                                          color: Color(0xFFBD9B60),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        hoverColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  eventResponsive(),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Manage events ".tr(),
                                          style: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                color: Color(0xFF215732),
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      // Icon(Icons.arrow_forward_ios_rounded,color:Color(0xFF215732),size: 9,),
                                      Container(
                                        child: ImageIcon(
                                            AssetImage(context.locale ==
                                                    Locale("en")
                                                ? "assets/images/forward.png"
                                                : "assets/images/arArrow.png"),
                                            color: Color(0xFF215732),
                                            size: 9),
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.004,
                          ),
                          Container(
                            width: width * 0.483,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Students enrolled".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: TextStyle(
                                          color: Color(0xFFBD9B60),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 0.5,
                                            ),
                                            GroupButton(
                                              spacing: 4,
                                              isRadio: true,
                                              direction: Axis.horizontal,
                                              onSelected: (index, isSelected) =>
                                                  {
                                                print(
                                                    '$index button is ${isSelected ? 'selected' : 'unselected'}'),
                                                setState(() {
                                                  _chartData =
                                                      getChartData(index);
                                                })
                                              },

                                              buttons: [
                                                "1W".tr().toString(),
                                                "1M".tr().toString(),
                                                "1Y".tr().toString(),
                                                "ALL".tr().toString()
                                              ],
                                              selectedButton: 0,

                                              /// [List<int>] after 2.2.1 version
                                              selectedTextStyle:
                                                  GoogleFonts.barlow(
                                                      textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.white,
                                              )),
                                              buttonHeight: 22,
                                              buttonWidth: 40,
                                              unselectedTextStyle:
                                                  GoogleFonts.barlow(
                                                      textStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: Color(0xFF222222),
                                              )),
                                              selectedColor: Color(0xFFBD9B60),
                                              unselectedColor: Colors.white,
                                              selectedBorderColor:
                                                  Color(0xFFBD9B60),
                                              unselectedBorderColor:
                                                  Color(0xFFEEEEEE),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              selectedShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.transparent)
                                              ],
                                              unselectedShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.transparent)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(children: [
                                          InkWell(
                                            hoverColor: Colors.transparent,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation1,
                                                          animation2) =>
                                                      userResponsive(),
                                                  transitionDuration:
                                                      Duration(seconds: 0),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "      Manage all users ".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF215732),
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: ImageIcon(
                                                AssetImage(context.locale ==
                                                        Locale("en")
                                                    ? "assets/images/forward.png"
                                                    : "assets/images/arArrow.png"),
                                                color: Color(0xFF215732),
                                                size: 9),
                                            padding: EdgeInsets.only(
                                                top: 10.0, bottom: 10),
                                            // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Upcoming Events
                          Container(
                            width: width * 0.245,
                            height: 600,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: FutureBuilder<List<EventModel>>(
                                future: context.locale == const Locale('en')
                                    ? eventsEnglish
                                    : eventsArabic,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (_, index) => Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Material(
                                                elevation: 2,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: InkWell(
                                                  hoverColor:
                                                      Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context,
                                                                  animation1,
                                                                  animation2) =>
                                                              webSpecificEvent(
                                                            eventID: snapshot
                                                                .data![index]
                                                                .event_id,
                                                            eventTitle: snapshot
                                                                .data![index]
                                                                .event_title,
                                                          ),
                                                          transitionDuration:
                                                              Duration(
                                                                  seconds: 0),
                                                        ));
                                                  },
                                                  child: Container(
                                                    width: width * 0.355,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                      child: IntrinsicHeight(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  width * 0.04,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFF9F2E7),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "${snapshot.data![index].event_start_date.split(' ')[0]}"
                                                                        .tr()
                                                                        .toString(),
                                                                    strutStyle: StrutStyle(
                                                                        forceStrutHeight:
                                                                            true),
                                                                    style: GoogleFonts
                                                                        .barlow(
                                                                      textStyle: TextStyle(
                                                                          fontFamily:
                                                                              'Barlow',
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontStyle: FontStyle
                                                                              .normal,
                                                                          color:
                                                                              Color(0xFF999999)),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  Text(
                                                                    "${snapshot.data![index].event_start_date.split(' ')[1]}"
                                                                        .tr()
                                                                        .toString(),
                                                                    strutStyle: StrutStyle(
                                                                        forceStrutHeight:
                                                                            true),
                                                                    style: GoogleFonts
                                                                        .barlow(
                                                                      textStyle: TextStyle(
                                                                          fontFamily:
                                                                              'Barlow',
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontStyle: FontStyle
                                                                              .normal,
                                                                          color:
                                                                              Color(0xFFBD9B60)),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.02,
                                                                        ),
                                                                        Text(
                                                                          "${snapshot.data![index].event_title}"
                                                                              .tr()
                                                                              .toString(),
                                                                          strutStyle:
                                                                              StrutStyle(forceStrutHeight: true),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                fontFamily: 'Barlow',
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FontStyle.normal,
                                                                                color: Color(0xFF222222)),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                height * 0.01),
                                                                        Text(
                                                                          DateFormat.yMMMMd(context.locale.toString())
                                                                              .format(DateFormat('MMM dd yyyy').parse(snapshot.data![index].event_start_date))
                                                                              .tr()
                                                                              .toString(),
                                                                          strutStyle:
                                                                              StrutStyle(forceStrutHeight: true),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                fontFamily: 'Barlow',
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FontStyle.normal,
                                                                                color: Color(0xFF999999)),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.02,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // SizedBox(width: 70),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                        child: Text("No Items Found".tr()));
                                  }
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            width: width * 0.008,
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image.asset("assets/images/graph.png",),
                              Container(
                                width: width * 0.482,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      width: width * 0.48,
                                      child: SfCartesianChart(
                                          primaryXAxis: CategoryAxis(),
                                          series: <ChartSeries>[
                                            LineSeries<EnrolledData, String>(
                                                dataSource: _chartData,
                                                // Bind the color for all the data points from the data source
                                                xValueMapper:
                                                    (EnrolledData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (EnrolledData data, _) =>
                                                        data.y)
                                          ])),
                                ),
                              ),

                              SizedBox(
                                height: height * 0.025,
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * 0.482,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Ongoing courses".tr(),
                                            style: GoogleFonts.barlow(
                                              textStyle: TextStyle(
                                                  color: Color(0xFFBD9B60),
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              InkWell(
                                                hoverColor: Colors.transparent,
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation1,
                                                              animation2) =>
                                                          courseResponsive(),
                                                      transitionDuration:
                                                          Duration(seconds: 0),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Manage all courses ".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF215732),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: ImageIcon(
                                                    AssetImage(context.locale ==
                                                            Locale("en")
                                                        ? "assets/images/forward.png"
                                                        : "assets/images/arArrow.png"),
                                                    color: Color(0xFF215732),
                                                    size: 9),
                                                padding: EdgeInsets.only(
                                                    top: 10.0, bottom: 10),
                                                // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Container(
                                    width: width * 0.484,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(19.0),
                                        child: FutureBuilder<List<Course>>(
                                          future: fetchCourse(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 2.75,
                                                        crossAxisSpacing: 2,
                                                        mainAxisSpacing: 2),
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (_, index) =>
                                                    Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Material(
                                                      color: Colors.white,
                                                      elevation: 2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: InkWell(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              PageRouteBuilder(
                                                                pageBuilder: (context,
                                                                        animation1,
                                                                        animation2) =>
                                                                    tabForCourses(
                                                                  course: snapshot
                                                                          .data![
                                                                      index],
                                                                ),
                                                                transitionDuration:
                                                                    Duration(
                                                                        seconds:
                                                                            0),
                                                              ));
                                                        },
                                                        child: Container(
                                                          height: 111,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        150),
                                                          ),
                                                          child: Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      left:
                                                                          12.0,
                                                                      right:
                                                                          12.0),
                                                              child: Container(
                                                                width: width *
                                                                    0.20555,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),

                                                                    Text(
                                                                      "${snapshot.data![index].course_name} "
                                                                          .tr()
                                                                          .toString(),
                                                                      strutStyle:
                                                                          StrutStyle(
                                                                              forceStrutHeight: true),
                                                                      style: GoogleFonts
                                                                          .barlow(
                                                                        textStyle: TextStyle(
                                                                            fontFamily:
                                                                                'Barlow',
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle: FontStyle.normal,
                                                                            color: Color(0xFF222222)),
                                                                      ),
                                                                    ),

                                                                    SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.002),

                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Instructor: "
                                                                              .tr()
                                                                              .toString(),
                                                                          strutStyle:
                                                                              StrutStyle(forceStrutHeight: true),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                fontFamily: 'Barlow',
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FontStyle.normal,
                                                                                color: Color(0xFF999999)),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "${snapshot.data![index].course_instructor}"
                                                                              .tr()
                                                                              .toString(),
                                                                          strutStyle:
                                                                              StrutStyle(forceStrutHeight: true),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                fontFamily: 'Barlow',
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FontStyle.normal,
                                                                                color: Color(0xFFBD9B60)),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                                                    SizedBox(
                                                                        height: height *
                                                                            0.01),

                                                                    Text(
                                                                      "1 of 2 workshops done | ${snapshot.data![index].applicants} students"
                                                                          .tr()
                                                                          .toString(),
                                                                      strutStyle:
                                                                          StrutStyle(
                                                                              forceStrutHeight: true),
                                                                      style: GoogleFonts
                                                                          .barlow(
                                                                        textStyle: TextStyle(
                                                                            fontFamily:
                                                                                'Barlow',
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle: FontStyle.normal,
                                                                            color: Color(0xFF999999)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
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

  List<EnrolledData> getChartData(int i) {
    final List<EnrolledData> chartData = [];
    if (i == 0) {
      chartData.clear();
      chartData.add(EnrolledData('Mon'.tr(), 40.0));
      chartData.add(EnrolledData('Tue'.tr(), 50.0));
      chartData.add(EnrolledData('Wed'.tr(), 80.0));
      chartData.add(EnrolledData('Thu'.tr(), 40.0));
      chartData.add(EnrolledData('Fri'.tr(), 20.0));
      chartData.add(EnrolledData('Sat'.tr(), 60.0));
      chartData.add(EnrolledData('Sun'.tr(), 10.0));
    } else if (i == 1) {
      chartData.clear();
      chartData.add(EnrolledData('1st Week'.tr(), 120.0));
      chartData.add(EnrolledData('2nd Week'.tr(), 300.0));
      chartData.add(EnrolledData('3rd Week'.tr(), 250.0));
      chartData.add(EnrolledData('4th Week'.tr(), 400.0));
    } else if (i == 2) {
      chartData.clear();
      chartData.add(EnrolledData('Jan'.tr(), 500));
      chartData.add(EnrolledData('Feb'.tr(), 700));
      chartData.add(EnrolledData('Mar'.tr(), 200));
      chartData.add(EnrolledData('Apr'.tr(), 300));
      chartData.add(EnrolledData('May'.tr(), 100));
      chartData.add(EnrolledData('Jun'.tr(), 800));
      chartData.add(EnrolledData('Jul'.tr(), 900));
      chartData.add(EnrolledData('Aug'.tr(), 600));
      chartData.add(EnrolledData('Sep'.tr(), 200));
      chartData.add(EnrolledData('Oct'.tr(), 400));
      chartData.add(EnrolledData('Nov'.tr(), 500));
      chartData.add(EnrolledData('Dec'.tr(), 800));
    } else {
      chartData.clear();
      chartData.add(EnrolledData('2011'.tr(), 2500));
      chartData.add(EnrolledData('2012'.tr(), 2700));
      chartData.add(EnrolledData('2013'.tr(), 3200));
      chartData.add(EnrolledData('2014'.tr(), 4300));
      chartData.add(EnrolledData('2015'.tr(), 2100));
      chartData.add(EnrolledData('2016'.tr(), 1800));
      chartData.add(EnrolledData('2017'.tr(), 3900));
      chartData.add(EnrolledData('2018'.tr(), 3600));
      chartData.add(EnrolledData('2019'.tr(), 2200));
      chartData.add(EnrolledData('2020'.tr(), 3400));
      chartData.add(EnrolledData('2021'.tr(), 4500));
      chartData.add(EnrolledData('2022'.tr(), 5800));
    }
    return chartData;
  }
}

class EnrolledData {
  EnrolledData(this.x, this.y);
  final String x;
  final double y;
}
