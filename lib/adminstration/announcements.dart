import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/adminstration/addAnnouncements.dart';
import 'package:pif_admin_dashboard/adminstration/specificAnn.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/eventsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/usersResponive.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../main.dart';
import '../models/ann_model.dart';
import '../pfpimg.dart';
import '../responsiveness/announcementResponsive.dart';
import '../responsiveness/faqResponsive.dart';
import 'package:http/http.dart' as http;

class announcements extends StatefulWidget {
  const announcements({Key? key}) : super(key: key);

  @override
  State<announcements> createState() => _announcementsState();
}

class _announcementsState extends State<announcements> {
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

  final _dateTime = DateTime.parse("2022-10-01 00:00:00.000");
  late ScrollController _scrollController;
  DateTimeRange? picked = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 365 * 5)),
      end: DateTime.now().add((const Duration(days: 365 * 5))));
  Future<List<Announcement>> fetchPost(bool isAscending) async {
    List<Announcement> ann = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllAnnEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        ann.add(Announcement.fromMap(jsonDecode(response.body)[i]));
      }

      ann.sort((a, b) {
        var adate = DateFormat('ymd').parse(a.ann_creation_time);
        var bdate = DateFormat('ymd').parse(b.ann_creation_time);
        print(adate.toString());
        print(bdate.toString());
        return adate.compareTo(bdate);
      });
      if (isAscending) {
        return ann.reversed.toList();
      } else {
        return ann;
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Announcement>> futurePost;
  late List<Announcement> annList = [];
  final TextEditingController _searchController = TextEditingController();

  Future<List<Announcement>> fetchPostEng(bool isAscending) async {
    List<Announcement> ann = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllAnnEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        ann.add(Announcement.fromMap(jsonDecode(response.body)[i]));
      }

      ann.sort((a, b) {
        var adate = DateTime.parse(a.ann_creation_time);
        var bdate = DateTime.parse(b.ann_creation_time);
        print(adate.toString());
        print(bdate.toString());
        return adate.compareTo(bdate);
      });
      // if (isAscending) {
      //   ann.sort((a, b) => DateTime.parse(a.ann_creation_time)
      //       .compareTo(DateTime.parse(b.ann_creation_time)));
      // } else {
      //   ann.sort((a, b) => DateTime.parse(b.ann_creation_time)
      //       .compareTo(DateTime.parse(a.ann_creation_time)));
      // }

      return ann;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Announcement>> fetchPostArb(bool isAscending) async {
    List<Announcement> ann = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllAnnArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        ann.add(Announcement.fromMap(jsonDecode(response.body)[i]));
      }

      ann.sort((a, b) {
        var adate = DateTime.parse(a.ann_creation_time);
        var bdate = DateTime.parse(b.ann_creation_time);
        print(adate.toString());
        print(bdate.toString());
        return adate.compareTo(bdate);
      });
      // if (isAscending) {
      //   ann.sort((a, b) => DateTime.parse(a.ann_creation_time)
      //       .compareTo(DateTime.parse(b.ann_creation_time)));
      // } else {
      //   ann.sort((a, b) => DateTime.parse(b.ann_creation_time)
      //       .compareTo(DateTime.parse(a.ann_creation_time)));
      // }

      return ann;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Announcement>> filterPostEng(
      bool isAscending, DateTimeRange date) async {
    print("enter");
    List<Announcement> ann = [];
    List<Announcement> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllAnnEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        ann.add(Announcement.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        ann.sort((a, b) => DateTime.parse(a.ann_creation_time)
            .compareTo(DateTime.parse(b.ann_creation_time)));
      } else {
        ann.sort((a, b) => DateTime.parse(b.ann_creation_time)
            .compareTo(DateTime.parse(a.ann_creation_time)));
      }

      var startDate = date.start;
      var endDate = date.end;

      for (int i = 0; i < ann.length; i++) {
        var eventStart = DateTime.parse(ann[i].ann_creation_time);
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

  Future<List<Announcement>> filterPostArb(
      bool isAscending, DateTimeRange date) async {
    print("enter");
    List<Announcement> ann = [];
    List<Announcement> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllAnnArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        ann.add(Announcement.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        ann.sort((a, b) => DateTime.parse(a.ann_creation_time)
            .compareTo(DateTime.parse(b.ann_creation_time)));
      } else {
        ann.sort((a, b) => DateTime.parse(b.ann_creation_time)
            .compareTo(DateTime.parse(a.ann_creation_time)));
      }

      var startDate = date.start;
      var endDate = date.end;

      for (int i = 0; i < ann.length; i++) {
        var eventStart = DateTime.parse(ann[i].ann_creation_time);
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

  Future<List<Announcement>> searchPostEng(String name) async {
    print("enter");
    List<Announcement> ann = [];
    List<Announcement> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllAnnEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        ann.add(Announcement.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        ann.sort((a, b) => DateTime.parse(a.ann_creation_time)
            .compareTo(DateTime.parse(b.ann_creation_time)));
      } else {
        ann.sort((a, b) => DateTime.parse(b.ann_creation_time)
            .compareTo(DateTime.parse(a.ann_creation_time)));
      }

      if (name.isNotEmpty) {
        ann.forEach((element) {
          if (element.ann_title.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(ann);
      }
      print(results.length);
      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Announcement>> searchPostArb(String name) async {
    print("enter");
    List<Announcement> ann = [];
    List<Announcement> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllAnnArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        ann.add(Announcement.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        ann.sort((a, b) => DateTime.parse(a.ann_creation_time)
            .compareTo(DateTime.parse(b.ann_creation_time)));
      } else {
        ann.sort((a, b) => DateTime.parse(b.ann_creation_time)
            .compareTo(DateTime.parse(a.ann_creation_time)));
      }

      if (name.isNotEmpty) {
        ann.forEach((element) {
          if (element.ann_title.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(ann);
      }
      print(results.length);
      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Announcement>> futurePostEng;
  late Future<List<Announcement>> futurePostArb;

  bool isAscending = false;
  DateTimeRange date =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  bool hasData = true;

  Future<http.Response> deleteRequest(int uid) async {
    Map data = {
      "ann_id": uid,
      "ann_title": "string",
      "ann_description": "string",
      "ann_creation_time": "2022-10-30T10:36:11.375Z",
      "ann_image": "string"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'DeleteAnn'),
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    setState(() {
      futurePost = fetchPost(isAscending);
      futurePostArb = fetchPostArb(isAscending);
    });
    return response;
  }

  Future<http.Response> deleteRequestEng(int uid) async {
    Map data = {
      "ann_id": uid,
      "ann_title": "string",
      "ann_description": "string",
      "ann_creation_time": "2022-10-30T10:36:11.375Z",
      "ann_image": "string"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress + 'DeleteAnnEng'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");

    setState(() {
      futurePostEng = fetchPostEng(isAscending);
      futurePostArb = fetchPostArb(isAscending);
    });
    return response;
  }

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();
    futurePost = fetchPost(isAscending);
    futurePostEng = fetchPostEng(isAscending);
    futurePostArb = fetchPostArb(isAscending);

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
                    futurePostEng = searchPostEng(value);
                    futurePostArb = searchPostArb(value);
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
                    futurePostEng = filterPostEng(isAscending, picked!);
                    futurePostArb = filterPostArb(isAscending, picked!);
                  } else {
                    futurePostEng = filterPostEng(isAscending, picked!);
                    futurePostArb = filterPostArb(isAscending, picked!);
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
                                SizedBox(
                                  height: height * 0.04,
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
                                              isAscending = false;
                                              futurePostEng = filterPostEng(
                                                  isAscending, picked!);
                                              futurePostArb = filterPostArb(
                                                  isAscending, picked!);
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Newest to Oldest".tr(),
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
                                          width: width * 0.02,
                                        ),
                                        !isAscending
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
                                              isAscending = true;
                                              futurePostEng = filterPostEng(
                                                  isAscending, picked!);
                                              futurePostArb = filterPostArb(
                                                  isAscending, picked!);
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Oldest to Newest".tr(),
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
                                          width: width * 0.02,
                                        ),
                                        isAscending
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
              },
            );
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
      body: Container(
        child: Row(
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
                                "assets/images/pifLogo.png",
                                fit: BoxFit.contain,
                                width: width * 0.06,
                                //86
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: ImageIcon(
                        AssetImage("assets/images/home.png"),
                        color: Color(0xFFBD9B60),
                      ),
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
                    Padding(
                      padding: EdgeInsets.only(
                          right: context.locale == Locale("en")
                              ? width * 0.01
                              : 0.0,
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
                          leading: ImageIcon(
                            AssetImage("assets/images/admin.png"),
                            color: Colors.white,
                          ),
                          minLeadingWidth: width * 0.02,
                          title: Text(
                            "Administration".tr(),
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
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        adminResponsive(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            )
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: EdgeInsets.only(
                            right: context.locale == Locale("en")
                                ? 0
                                : width * 0.028,
                            left: context.locale == Locale("en")
                                ? width * 0.028
                                : 0),

                        // padding:  EdgeInsets.only(left: ),
                        child: Text(
                          "Events".tr(),
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
                                eventResponsive(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        )
                      },
                    ),
                    Padding(
                      // padding:  EdgeInsets.only(right: width*0.01,left: ),
                      padding: EdgeInsets.only(
                          right: context.locale == Locale("en")
                              ? width * 0.01
                              : width * 0.025,
                          left: context.locale == Locale("en")
                              ? width * 0.025
                              : width * 0.01),

                      child: Row(
                        children: [
                          Container(
                            height: height * 0.06,
                            width: 5,
                            color: Color(0xFFBD9B60),
                            // child: Text("we"),
                          ),
                          Expanded(
                            child: Container(
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(189, 155, 96, 0.2),
                                //
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      context.locale == Locale("en")
                                          ? 0
                                          : 40.0),
                                  bottomLeft: Radius.circular(
                                      context.locale == Locale("en")
                                          ? 0
                                          : 40.0),
                                  topRight: Radius.circular(
                                      context.locale == Locale("en")
                                          ? 40
                                          : 0.0),
                                  bottomRight: Radius.circular(
                                      context.locale == Locale("en")
                                          ? 40
                                          : 0.0),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  title: Text(
                                    "Announcements".tr(),
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
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                announcementResponsive(),
                                        transitionDuration:
                                            Duration(seconds: 0),
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
                            right: context.locale == Locale("en")
                                ? 0
                                : width * 0.028,
                            left: context.locale == Locale("en")
                                ? width * 0.028
                                : 0),
                        child: Text(
                          "Users".tr(),
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
                                userResponsive(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.end,

                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "Administration /".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFF999999),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Text(
                                      "Announcements".tr(),
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
                                    InkWell(
                                        hoverColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  settingResponsive(),
                                              transitionDuration:
                                                  Duration(seconds: 0),
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
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          size: 17,
                                          color: Colors.black,
                                        )),
                                    SizedBox(
                                      width: width * 0.002,
                                    ),
                                    Text(
                                      "Announcements".tr(),
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
                                                addAnn(),
                                        transitionDuration:
                                            Duration(seconds: 0),
                                      ),
                                    );
                                  },
                                  child: Text(
                                      'Add new announcement'.tr().toString(),
                                      strutStyle:
                                          StrutStyle(forceStrutHeight: true),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16),
                                      )),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF215732),
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      side: BorderSide(
                                        width: 0.4,
                                        color: Color(0xFF215732),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        eventCard,
                        SizedBox(height: height * 0.02),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.01,
                                vertical: width * 0.02),
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
                                  height: height * 0.03,
                                ),
                                Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                height: height * 0.08,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF5F0E5),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight: Radius
                                                              .circular(12.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  12.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0)),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: width * 0.0125,
                                                    ),
                                                    Container(
                                                      width: width * 0.08,
                                                      child: Text(
                                                        "Date".tr(),
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
                                                      width: width * 0.08,
                                                      child: Text(
                                                        "Time".tr(),
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
                                                      width: width * 0.5,
                                                      child: Text(
                                                        "Title".tr(),
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
                                              FutureBuilder<List<Announcement>>(
                                                future: context.locale ==
                                                        Locale("en")
                                                    ? futurePostEng
                                                    : futurePostArb,
                                                // context.locale ==
                                                //     Locale("en")
                                                //     ? futurePostEng
                                                //     : futurePost,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (!hasData) {
                                                      return Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "No Announcements"
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
                                                        itemBuilder:
                                                            (_, index) =>
                                                                Container(
                                                          child: Column(
                                                            children: [
                                                              InkWell(
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    PageRouteBuilder(
                                                                      pageBuilder: (context, animation1, animation2) => specificAnn(
                                                                          current_ann: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .ann_id,
                                                                          ann_title: snapshot
                                                                              .data![index]
                                                                              .ann_title),
                                                                      transitionDuration:
                                                                          Duration(
                                                                              seconds: 0),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Material(
                                                                  elevation: 1,
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .white,
                                                                    width:
                                                                        width *
                                                                            0.9,
                                                                    height:
                                                                        height *
                                                                            0.07,
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              width * 0.0125,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              width: width * 0.08,
                                                                              child: Text(
                                                                                DateFormat.yMMMMd(context.locale.toString()).format(DateTime.parse(snapshot.data![index].ann_creation_time)),
                                                                                style: GoogleFonts.barlow(
                                                                                  textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              width * 0.08,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                DateFormat.Hm(context.locale.toString()).format(DateTime.parse("${snapshot.data![index].ann_creation_time}")),
                                                                                style: GoogleFonts.barlow(
                                                                                  textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              width * 0.490,
                                                                          child:
                                                                              Text(
                                                                            "${snapshot.data![index].ann_title}".tr(),
                                                                            style:
                                                                                GoogleFonts.barlow(
                                                                              textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuButton(
                                                                          onSelected:
                                                                              (result) {
                                                                            // your logic
                                                                            if (result ==
                                                                                0) {
                                                                              print("delete");
                                                                              deleteRequest(snapshot.data![index].ann_id);
                                                                              deleteRequestEng(snapshot.data![index].ann_id);
                                                                            }
                                                                          },
                                                                          itemBuilder:
                                                                              (BuildContext bc) {
                                                                            return [
                                                                              PopupMenuItem(
                                                                                child: Text("Delete".tr()),
                                                                                value: 0,
                                                                              ),
                                                                            ];
                                                                          },
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    return Center(
                                                        child: Text(
                                                            "No Items Found"
                                                                .tr(),
                                                            style: GoogleFonts.barlow(
                                                                textStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF222222),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        16))));
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                        eventCard,
                      ],
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
