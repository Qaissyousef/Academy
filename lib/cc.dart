import 'dart:convert';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/main.dart';
import 'package:pif_admin_dashboard/pfpimg.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'courseDetails/courseTabs.dart';
import 'coursesList.dart';
import 'models/course_model.dart';
import 'new/newCourseTab.dart';

class coursesPage extends StatefulWidget {
  const coursesPage({Key? key}) : super(key: key);

  @override
  State<coursesPage> createState() => _coursesPageState();
}

class _coursesPageState extends State<coursesPage> {
  late ScrollController _scrollController;
  late List<bool> _isSelected;

  Future<List<Course>> fetchCourseEng() async {
    List<Course> courses = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        courses.add(Course.fromMap(jsonDecode(response.body)[i]));
      }
      return courses;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Course>> searchCourse(String name) async {
    List<Course> courses = [];
    List<Course> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllCourses'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        courses.add(Course.fromMap(jsonDecode(response.body)[i]));
      }

      if (name.isNotEmpty) {
        courses.forEach((element) {
          if (element.course_name.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(courses);
      }
      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  // Future<List<Course>> fetchCourseEng() async {
  //   final response =
  //   await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesEng'));
  //
  //   if (response.statusCode == 200) {
  //     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
  //
  //     return parsed.map<Course>((json) => Course.fromMap(json)).toList();
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }
  Future<List<Course>> fetchCourseArb() async {
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Course>((json) => Course.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Course>> futureCourseEng;
  late Future<List<Course>> futureCourseArb;
  Random random = new Random();
  late List<Course> courses;
  TextEditingController _searchController = TextEditingController();
  bool _isVisible = false;
  bool hasData = true;
  // int fun()
  // {
  //
  //   return i;
  // }

  Future<http.Response> postCourse(int i) async {
    final myController1 = TextEditingController();
    final myController2 = TextEditingController();
    final myController3 = TextEditingController();
    final myController4 = TextEditingController();

    Map data = {
      "course_id": i,
      "course_name": "string",
      "course_image": "string",
      "course_instructor": "string",
      "applicants": 0,
      "admission": 0,
      "deadline": "Dec 20"
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddCourse'),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials":
              "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();
    futureCourseEng = fetchCourseEng();
    futureCourseArb = fetchCourseArb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isSelected = [false, true];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final courseTwo = Container(
      width: width * 0.243,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.009, vertical: height * 0.027),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: height * 0.3,
                  width: width * 0.21,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/c1.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.006),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          "Instructor: ".tr().toString(),
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
                        Text(
                          "Ahmed Alsahli".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
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
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/u.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " 56 applicants".tr().toString(),
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/calendar.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " May 11, 2022 - June 11, 2022 ".tr().toString(),
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final courseThree = Container(
      width: width * 0.243,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.009, vertical: height * 0.027),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: height * 0.3,
                  width: width * 0.21,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/c2.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.006),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          "Instructor: ".tr().toString(),
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
                        Text(
                          "Mohammad Abdulrahman".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
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
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/u.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " 48 applicants".tr().toString(),
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/calendar.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " May 11, 2022 - June 11, 2022 ".tr().toString(),
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/approval.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " 2 of 3 workshops done ".tr().toString(),
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final courseFour = Container(
      width: width * 0.243,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.009, vertical: height * 0.027),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: height * 0.3,
                  width: width * 0.21,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/c3.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.006),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          "Instructor: ".tr().toString(),
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
                        Text(
                          "Mohammad Alsoghayer".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
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
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/u.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " 34 applicants".tr().toString(),
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/calendar.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " May 11, 2022 - June 11, 2022 ".tr().toString(),
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/approval.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " 1 of 4 workshops done ".tr().toString(),
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final courseFive = Container(
      width: width * 0.243,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.009, vertical: height * 0.027),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: height * 0.3,
                  width: width * 0.21,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/c4.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.006),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Research Skills ".tr().toString(),
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
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          "Instructor: ".tr().toString(),
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
                        Text(
                          " Abdul AlKhaldi".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
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
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/u.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " 56 applicants".tr().toString(),
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/calendar.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " May 11, 2022 - June 11, 2022 ".tr().toString(),
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/approval.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " 2 of 3 workshops done ".tr().toString(),
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final courseSix = Container(
      width: width * 0.243,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.009, vertical: height * 0.027),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: height * 0.3,
                  width: width * 0.21,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/c5.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.006),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Investment Techniques & Tools ".tr().toString(),
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
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          "Instructor: ".tr().toString(),
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
                        Text(
                          "Ahmed Alsahli".tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
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
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/u.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " 56 applicants".tr().toString(),
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/calendar.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " May 11, 2022 - June 11, 2022 ".tr().toString(),
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/approval.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          " 3 of 4 workshops done ".tr().toString(),
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

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
                  ListTile(
                    leading: SvgPicture.asset("assets/images/home.svg",
                        color: Color(0xFFBD9B60)),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Home".tr(),
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
                              HomeResponsive(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      )
                    },
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
                        leading: Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.001, right: width * 0.002),
                            child: Icon(Icons.list,
                                color: Colors.white, size: 26.2)),
                        minLeadingWidth: width * 0.02,
                        title: Text(
                          "Courses".tr(),
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
                                  courseResponsive(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          )
                        },
                      ),
                    ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      )
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MessageResponsive()),
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
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              settingResponsive(),
                                      transitionDuration: Duration(seconds: 0),
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
                      ),
                      Container(
                        height: height * 0.13,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Courses".tr(),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 28),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Visibility(
                                    visible: _isVisible,
                                    child: SizedBox(
                                      height: height * 0.05,
                                      width: width * 0.25,
                                      child: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            futureCourseEng =
                                                searchCourse(value);
                                          });
                                        },
                                        controller: _searchController,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFBD9B60)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFBD9B60)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          hintText: 'Search'.tr().toString(),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 7),
                                          hintStyle: TextStyle(
                                            fontFamily: 'Barlow',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isVisible = !_isVisible;
                                        futureCourseEng = fetchCourseEng();
                                      });
                                    },
                                    icon: Image.asset(
                                      "assets/images/search.png",
                                      color: Color(0xFFBD9B60),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  Container(
                                    height: 45,
                                    child: ToggleButtons(
                                      children: <Widget>[
                                        Icon(Icons.list_outlined),
                                        Icon(Icons.grid_view_rounded),
                                      ],
                                      onPressed: (int index) {
                                        setState(() {
                                          for (int i = 0;
                                              i < _isSelected.length;
                                              i++) {
                                            _isSelected[i] = i == index;
                                          }
                                        });

                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                courseList(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ),
                                        );
                                      },
                                      isSelected: _isSelected,
                                      fillColor: Color(0xFFBD9B60),
                                      disabledColor: Color(0xFF999999),
                                      disabledBorderColor: Color(0xFFEEEEEE),
                                      selectedBorderColor: Color(0xFFBD9B60),
                                      selectedColor: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      int randomNumber = random.nextInt(100);

                                      int r2 = random.nextInt(100);
                                      int r3 = random.nextInt(100);
                                      int i = randomNumber + r2 + r3;
                                      postCourse(i);

                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              newTabForCourses(
                                            cid: i.toString(),
                                          ),
                                          transitionDuration:
                                              Duration(seconds: 0),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 0.6),
                                      child: Text(
                                          'Add new course'.tr().toString(),
                                          strutStyle: StrutStyle(
                                              forceStrutHeight: true),
                                          style: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16),
                                          )),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF215732),
                                      elevation: 0.0,
                                      shadowColor: Colors.transparent,
                                      onPrimary: Color(0xFFFFFFFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      FutureBuilder<List<Course>>(
                        future: context.locale == const Locale("en")
                            ? futureCourseEng
                            : futureCourseArb,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Course>? courses = [];
                            if (context.locale == const Locale("en") &&
                                snapshot.data != null) {
                              courses = snapshot.data!
                                  .where((c) => c.course_name != "")
                                  .toList();
                            } else {
                              courses = snapshot.data;
                            }
                            return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: courses!.length,
                              itemBuilder: (_, index) => Container(
                                child: Column(
                                  children: [
                                    InkWell(
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  tabForCourses(
                                                course: courses![index],
                                              ),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            )).then((value) => {
                                              setState(() {
                                                futureCourseEng =
                                                    fetchCourseEng();
                                                futureCourseArb =
                                                    fetchCourseArb();
                                              })
                                            });
                                      },
                                      child: Container(
                                        width: width * 0.243,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.009,
                                                vertical: height * 0.027),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    height: height * 0.3,
                                                    width: width * 0.21,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(global
                                                                .apiAddress +
                                                            'GetImage/${snapshot.data![index].course_image}'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          width * 0.006),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${courses![index].course_name}"
                                                            .tr()
                                                            .toString(),
                                                        strutStyle: StrutStyle(
                                                            forceStrutHeight:
                                                                true),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              fontFamily:
                                                                  'Barlow',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              color: Color(
                                                                  0xFF222222)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Instructor: "
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
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: Color(
                                                                      0xFF999999)),
                                                            ),
                                                          ),
                                                          Text(
                                                            "${courses[index].course_instructor}"
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
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: Color(
                                                                      0xFFBD9B60)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.015,
                                                      ),

                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/images/u.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          ),
                                                          Text(
                                                            " ${courses[index].applicants} applicants "
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
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: Color(
                                                                      0xFF999999)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     SvgPicture.asset("assets/images/calendar.svg",fit: BoxFit.scaleDown,),
                                                      //     Text(" May 11, 2022 - June 11, 2022 ".tr().toString(),strutStyle: StrutStyle(
                                                      //         forceStrutHeight: true
                                                      //     ), style:
                                                      //     GoogleFonts.barlow(
                                                      //       textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 2 / 2.3),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
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
