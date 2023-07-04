import 'dart:convert';

import 'package:date_time_format/date_time_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/applicationDetail.dart';

import 'package:pif_admin_dashboard/pfpimg.dart';
import 'package:pif_admin_dashboard/responsiveness/faqResponsive.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import '../main.dart';
import '../responsiveness/adminResponsive.dart';
import '../responsiveness/admissionResponsive.dart';
import '../responsiveness/coursesResponsive.dart';
import '../responsiveness/helpResponsive.dart';
import '../responsiveness/homeResponsive.dart';
import '../responsiveness/messageResponsive.dart';
import '../responsiveness/settingsResponsive.dart';
import 'models/admissionModel.dart';
import 'models/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:pif_admin_dashboard/util/global.dart' as global;

class admissionDetail extends StatefulWidget {
  final Course course;

  const admissionDetail({Key? key, required this.course}) : super(key: key);

  @override
  State<admissionDetail> createState() => _admissionDetailState();
}

class _admissionDetailState extends State<admissionDetail>
    with TickerProviderStateMixin {
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

  late ScrollController _scrollController;
  // Future<List<Course>> fetchCourse() async {
  //   final response =
  //   await http.get(Uri.parse(global.apiAddress + 'GetAllCourses'));
  //
  //   if (response.statusCode == 200) {
  //     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
  //
  //     return parsed.map<Course>((json) => Course.fromMap(json)).toList();
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }
  // late Future<List<Course>> futureCourse;
  DateTimeRange? picked = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 365 * 5)),
      end: DateTime.now().add((const Duration(days: 365 * 5))));

  bool isAscending = true;
  var sortstatus = 'All';
  Future<List<admissionModel>> fetchAdmissionInfo() async {
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAllApllicants/${widget.course.course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<admissionModel>((json) => admissionModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<admissionModel>> filterPostEng(
      bool isAscending, DateTimeRange date, var sortstatus) async {
    print("enter");
    List<admissionModel> ann = [];
    List<admissionModel> results = [];
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAllApllicants/${widget.course.course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        ann.add(admissionModel.fromMap(jsonDecode(response.body)[i]));
      }

      // if (isAscending) {
      //   ann.sort((a, b) => DateTime.parse(a.ann_creation_time)
      //       .compareTo(DateTime.parse(b.ann_creation_time)));
      // } else {
      //   ann.sort((a, b) => DateTime.parse(b.ann_creation_time)
      //       .compareTo(DateTime.parse(a.ann_creation_time)));
      // }

      var startDate = date.start;
      var endDate = date.end;

      if (sortstatus.compareTo("All") == 0) {
        for (int i = 0; i < ann.length; i++) {
          var eventStart = DateTime.parse(ann[i].submissionTime);
          print(startDate);
          print(endDate);
          print(eventStart);
          if (eventStart.isAfter(startDate) && eventStart.isBefore(endDate)) {
            print("true");
            results.add(ann[i]);
          }
        }
      } else if (sortstatus.compareTo("Accepted") == 0) {
        for (int i = 0; i < ann.length; i++) {
          var eventStart = DateTime.parse(ann[i].submissionTime);
          print(startDate);
          print(endDate);
          print(eventStart);
          if (eventStart.isAfter(startDate) &&
              eventStart.isBefore(endDate) &&
              ann[i].status.compareTo('Accepted') == 0) {
            print("true");
            results.add(ann[i]);
          }
        }
      } else if (sortstatus.compareTo("Declined") == 0) {
        for (int i = 0; i < ann.length; i++) {
          var eventStart = DateTime.parse(ann[i].submissionTime);
          print(startDate);
          print(endDate);
          print(eventStart);
          if (eventStart.isAfter(startDate) &&
              eventStart.isBefore(endDate) &&
              ann[i].status.compareTo('Declined') == 0) {
            print("true");
            results.add(ann[i]);
          }
        }
      } else if (sortstatus.compareTo("Pending") == 0) {
        for (int i = 0; i < ann.length; i++) {
          var eventStart = DateTime.parse(ann[i].submissionTime);
          print(startDate);
          print(endDate);
          print(eventStart);
          if (eventStart.isAfter(startDate) &&
              eventStart.isBefore(endDate) &&
              ann[i].status.compareTo('Pending') == 0) {
            print("true");
            results.add(ann[i]);
          }
        }
      }

      // for (int i = 0; i < ann.length; i++) {
      //   var eventStart = DateTime.parse(ann[i].submissionTime);
      //   print(startDate);
      //   print(endDate);
      //   print(eventStart);
      //   if (eventStart.isAfter(startDate) && eventStart.isBefore(endDate)) {
      //     print("true");
      //     results.add(ann[i]);
      //   }
      // }
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

  late Future<List<admissionModel>> futurefetchAdmissionInfo;

  Future<List<admissionModel>> searchMaterials(String name) async {
    List<admissionModel> courses = [];
    List<admissionModel> results = [];
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAllApllicants/${widget.course.course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        courses.add(admissionModel.fromMap(jsonDecode(response.body)[i]));
      }

      if (name.isNotEmpty) {
        courses.forEach((element) {
          if (element.name.toLowerCase().contains(name.toLowerCase())) {
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

  bool hasData = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    futurefetchAdmissionInfo = filterPostEng(isAscending, picked!, sortstatus);

    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
            SvgPicture.asset(
              "assets/images/search.svg",
              fit: BoxFit.scaleDown,
            ),
            SizedBox(
              width: width * 0.009,
            ),
            SizedBox(
              width: width * 0.28,
              height: height * 0.4,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    futurefetchAdmissionInfo = searchMaterials(value);
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
                    futurefetchAdmissionInfo =
                        filterPostEng(isAscending, picked!, sortstatus);
                  } else {
                    futurefetchAdmissionInfo =
                        filterPostEng(isAscending, picked!, sortstatus);
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
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  String? dropdownvalue = 'Admin';
                  Locale? lang = Locale("en");
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
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
                                child: Icon(Icons.close))),
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
                                    "Status".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: TextStyle(
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
                                    decoration: BoxDecoration(
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
                                                sortstatus = "All";
                                                futurefetchAdmissionInfo =
                                                    filterPostEng(isAscending,
                                                        picked!, sortstatus);
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "All".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF222222),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.04,
                                          ),
                                          sortstatus.compareTo("All") == 0
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
                                    width: width * 0.14,
                                    decoration: BoxDecoration(
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
                                                sortstatus = "Accepted";
                                                futurefetchAdmissionInfo =
                                                    filterPostEng(isAscending,
                                                        picked!, sortstatus);
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Accepted".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF222222),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.04,
                                          ),
                                          sortstatus.compareTo("Accepted") == 0
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
                                    width: width * 0.14,
                                    decoration: BoxDecoration(
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
                                                sortstatus = "Declined";
                                                futurefetchAdmissionInfo =
                                                    filterPostEng(isAscending,
                                                        picked!, sortstatus);
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Declined".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF222222),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.04,
                                          ),
                                          sortstatus.compareTo("Declined") == 0
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
                                    width: width * 0.14,
                                    decoration: BoxDecoration(
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
                                                sortstatus = "Pending";
                                                futurefetchAdmissionInfo =
                                                    filterPostEng(isAscending,
                                                        picked!, sortstatus);
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Pending".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF222222),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.04,
                                          ),
                                          sortstatus.compareTo("Pending") == 0
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
                      color: Color(0xFF222222),
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

    return Scaffold(
      body: Row(
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
                          child: SvgPicture.asset("assets/images/admission.svg",
                              color: Colors.white),
                        ),
                        minLeadingWidth: width * 0.02,
                        title: Text(
                          "Admission".tr(),
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
                                  admissionResponsive(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          )
                        },
                      ),
                    ),
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
                  // SizedBox(
                  //   height: height * 0.004,
                  // ),
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.0325),
              child: WebSmoothScroll(
                controller: _scrollController,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        height: height * 0.078,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Admission / ".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: TextStyle(
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    "Applications".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: TextStyle(
                                          color: Color(0xFF215732),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(width: width*0.51,),
                            Container(
                              child: Row(
                                children: [
                                  InkWell(onTap: () {
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
                                    child: SvgPicture.asset("assets/images/message.svg")),
                                  SizedBox(
                                    width: width * 0.0152,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                settingResponsive(),
                                        transitionDuration:
                                            Duration(seconds: 0),
                                      ));
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
                                            )),
                                  ),
                                  
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 17,
                                color: Colors.black,
                              )),
                          Text(
                            "  ${widget.course.course_name}".tr(),
                            style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Card(
                        child: Container(
                          height: height,
                          width: width * 0.92,
                          child: WebSmoothScroll(
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: height * 0.02),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  searchtab,
                                                  SizedBox(
                                                    width: width * 0.005,
                                                  ),
                                                  sortbtn,
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: height * 0.03),
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
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF5F0E5),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight: Radius
                                                              .circular(9.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  9.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0)),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: width * 0.013,
                                                    ),
                                                    Container(
                                                      width: width * 0.06,
                                                      child: Text(
                                                        "   Picture".tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFBD9B60),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.15,
                                                      child: Text(
                                                        "Name".tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFBD9B60),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.1,
                                                      child: Text(
                                                        "Submission date".tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFBD9B60),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.14,
                                                      child: Text(
                                                        "Application".tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFBD9B60),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.12,
                                                      child: Text(
                                                        "Status".tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFBD9B60),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
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
                                              FutureBuilder<
                                                  List<admissionModel>>(
                                                future:
                                                    futurefetchAdmissionInfo,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (!hasData) {
                                                      return Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "No Applicants"
                                                                .tr(),
                                                            style: GoogleFonts
                                                                .barlow(
                                                              textStyle: const TextStyle(
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
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: snapshot
                                                            .data!.length,
                                                        itemBuilder: (_,
                                                                index) =>
                                                            Container(
                                                                child: Column(
                                                          children: [
                                                            Material(
                                                              elevation: 1,
                                                              color:
                                                                  Colors.white,
                                                              child: Container(
                                                                width: width *
                                                                    0.92,
                                                                height: height *
                                                                    0.08,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: width *
                                                                          0.0125,
                                                                    ),
                                                                    // Container(
                                                                    //   width: width*0.06,
                                                                    //   child:  Image.network(global.apiAddress + 'GetImage/${snapshot.data![index].user_img}',scale: 4,),

                                                                    // ),
                                                                    Container(
                                                                      width: width *
                                                                          0.06,
                                                                      child: Image.asset(
                                                                          "assets/images/noFace.png",
                                                                          width:30,height:35),
                                                                    ),
                                                                    Container(
                                                                      width: width *
                                                                          0.15,
                                                                      child:
                                                                          Text(
                                                                        "${snapshot.data![index].name}"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF222222),
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
                                                                      child:
                                                                          Text(
                                                                        DateTimeFormat.format(DateTime.parse(snapshot.data![index].submissionTime),
                                                                                format: 'D, M j')
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF222222),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: width *
                                                                          0.14,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          InkWell(
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                context,
                                                                                PageRouteBuilder(
                                                                                  pageBuilder: (context, animation1, animation2) => applicantInfo(courseid: widget.course.course_id, userid: snapshot.data![index].uid, cname: widget.course.course_name, usertype: 'participant'),
                                                                                  transitionDuration: Duration(seconds: 0),
                                                                                ),
                                                                                // MaterialPageRoute(builder: (context) => coursesPage()),
                                                                                // transitionDuration: const Duration(seconds: 0),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              "View application".tr(),
                                                                              style: GoogleFonts.barlow(
                                                                                textStyle: TextStyle(decoration: TextDecoration.underline, color: Color(0xFF222222), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: width *
                                                                          0.12,
                                                                      child:
                                                                          Text(
                                                                        "${snapshot.data![index].status}"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF222222),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                      );
                                                    }
                                                  } else {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: height * 0.1),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
