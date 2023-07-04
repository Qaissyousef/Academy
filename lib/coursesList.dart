import 'dart:convert';
import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/pfpimg.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/faqResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:easy_localization/easy_localization.dart';
import 'courseDetails/courseTabs.dart';
import 'main.dart';
import 'models/course_model.dart';
import 'new/newCourseTab.dart';
import 'package:http/http.dart' as http;
import 'package:pif_admin_dashboard/util/global.dart' as global;

class courseList extends StatefulWidget {
  const courseList({Key? key}) : super(key: key);

  @override
  State<courseList> createState() => _courseListState();
}

class _courseListState extends State<courseList> {
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

  late List<bool> _isSelected;
  late ScrollController _scrollController;
  Random random = Random();
  Future<List<Course>> fetchCourseEng() async {
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Course>((json) => Course.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

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

  Future<List<Course>> searchCourse(String name) async {
    List<Course> courses = [];
    List<Course> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesEng'));

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
        hasData = true;
      }
      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<http.Response> postCourse(String i) async {
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

  late Future<List<Course>> futureCourseArb;
  late Future<List<Course>> futureCourseEng;

  TextEditingController _searchController = TextEditingController();
  bool hasData = true;

  var uuid = Uuid();
  @override
  void initState() {
    _scrollController = ScrollController();

    futureCourseEng = fetchCourseEng();
    futureCourseArb = fetchCourseArb();

    _isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final eventCard = InkWell(
      hoverColor: Colors.transparent,
      child: Material(
        color: Color(0xFFffffff),
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 0,
          height: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.13,
                  width: width * 0.04,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.007,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "5:30 PM - 6:30 PM".tr().toString(),
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
                            ),

                            SizedBox(
                              height: height * 0.01,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Meet & Greet".tr().toString(),
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
                            ),
                            // SizedBox(height: 5),
                            SizedBox(
                              height: height * 0.007,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              MessageResponsive(),
                                      transitionDuration: Duration(seconds: 0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.25,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFEEEEEE)),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          futureCourseEng = searchCourse(value);
                                        });
                                      },
                                      controller: _searchController,
                                      decoration: InputDecoration(
                                        prefixIcon: SvgPicture.asset(
                                          "images/search.svg",
                                          fit: BoxFit.scaleDown,
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Search'.tr().toString(),
                                        contentPadding:
                                            EdgeInsets.only(top: 11),
                                        hintStyle: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color: Color(0xFF999999))),
                                      ),
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
                                                courseResponsive(),
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
                                      String i = uuid.v1();
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
                      Padding(
                        padding:
                            EdgeInsets.only(left: width * 0.008, top: 15.0),
                        child: eventCard,
                      ),
                      SizedBox(height: height * 0.02),
                      FutureBuilder<List<Course>>(
                        future: futureCourseArb, //context.locale == const Locale("en")
                            
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Course>? courses = [];
                            if (context.locale == const Locale("en") &&
                                snapshot.data != null) {
                              courses = snapshot.data!.where((c) {
                                print(c.course_name);
                                return c.course_name != "";
                              }).toList();
                            } else {
                              courses = snapshot.data;
                            }

                            return ListView.builder(
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
                                                      course: snapshot
                                                          .data![index]),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                '${global.apiAddress}GetImageC/${(courses![index].course_image)}',
                                                height: 80,
                                                width: 80,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Container(
                                                width: width * 0.224,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${courses[index].course_name}"
                                                          .tr()
                                                          .toString(),
                                                      strutStyle: StrutStyle(
                                                          forceStrutHeight:
                                                              true),
                                                      style: GoogleFonts.barlow(
                                                        textStyle: TextStyle(
                                                            fontFamily:
                                                                'Barlow',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color: Color(
                                                                0xFF222222)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.009,
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
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/images/u.svg",
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      Text(
                                                        " ${courses[index].applicants}"
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
                                                        " applicants ".tr(),
                                                        strutStyle: StrutStyle(
                                                            forceStrutHeight:
                                                                true),
                                                        style:
                                                            GoogleFonts.barlow(
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
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.01,
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     SvgPicture.asset("assets/images/calendar.svg",fit: BoxFit.scaleDown,),
                                                  //
                                                  //     Text(" May 11, 2022 - June 11, 2022 ".tr().toString(),strutStyle: StrutStyle(
                                                  //         forceStrutHeight: true
                                                  //     ), style:
                                                  //     GoogleFonts.barlow(
                                                  //       textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  SizedBox(
                                                    height: height * 0.01,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: width * 0.115,
                                              ),
                                              SizedBox(
                                                width: width * 0.09,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
