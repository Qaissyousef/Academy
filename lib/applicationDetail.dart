import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
import 'models/applicantModel.dart';
import 'package:http/http.dart' as http;
import 'package:pif_admin_dashboard/util/global.dart' as global;

class applicantInfo extends StatefulWidget {
  final String courseid;
  final int userid;
  final String cname;
  final String usertype;

  const applicantInfo(
      {Key? key,
      required this.courseid,
      required this.userid,
      required this.cname,
      required this.usertype})
      : super(key: key);

  @override
  State<applicantInfo> createState() => _applicantInfoState();
}

class _applicantInfoState extends State<applicantInfo>
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

  Future<http.Response> postRequestMyC() async {
    Map data = {
      "user_id": widget.userid,
      "course_id": widget.courseid,
      "course_completion": 0,
      "course_name_eng": "string",
      "finished": 0,
      "email": "string",
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddMyCourse'),
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

  Future<http.Response> deleteRequestMyC() async {
    Map data = {
      "user_id": widget.userid,
      "course_id": widget.courseid,
      "course_completion": 0,
      "course_name_eng": "string",
      "finished": 0
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await http.post(Uri.parse(global.apiAddress + 'DeleteMyCourse'),
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

  Future<http.Response> postRequest() async {
    Map data = {
      "user_id": widget.userid,
      "course_id": widget.courseid,
      "date": "",
      "percentage": 0,
      "attendance_id": 0,
      "email": "string",
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await http.post(Uri.parse(global.apiAddress + 'AddAttendance'),
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


  Future<http.Response> postRequestCert() async {
    Map data = {
      "user_id": widget.userid,

      "course_id": widget.courseid,

      "date": "string",
      "survey_completion": "string",
      "percentage": 0,
      "name": "string",
      "user_img": "string",
      "img": "string",
      "attendance_id": 0,
      "certificate_id": 0,
      "email": "string",
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response =
    await http.post(Uri.parse(global.apiAddress + 'AddCert'),
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

  Future<http.Response> deleteRequest() async {
    Map data = {
      "user_id": widget.userid,
      "course_id": widget.courseid,
      "date": "",
      "percentage": 0
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await http.post(Uri.parse(global.apiAddress + 'DeleteAttendance'),
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

  Future<http.Response> deleteCertificate() async {
    Map data = {
      "user_id": widget.userid,
      "course_id": widget.courseid,
      "date": "string",
      "survey_completion": "string",
      "percentage": 0,
      "name": "string",
      "user_img": "string",
      "img": "string",
      "attendance_id": 0,
      "certificate_id": 0
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response =
    await http.post(Uri.parse(global.apiAddress + 'DeleteParticipantsCertificate'),
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

  Future<List<applicantModel>> fetchApplicant() async {
    final response = await http.get(Uri.parse(
        // 5/09e8f950-cd34-11ed-862f-cb48a3edb4c4
        global.apiAddress + 'GetSpecificApplication/${widget.userid}/${widget.courseid}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<applicantModel>((json) => applicantModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<applicantModel>> futureApplicant;

  late ScrollController _scrollController;
  final _dateTime = DateTime.parse("2022-10-01 00:00:00.000");

  @override
  void initState() {
    futureApplicant = fetchApplicant();

    _scrollController = ScrollController();

    super.initState();
  }

  var items = [
    'Pending',
    'Declined',
    'Accepted',
  ];

  Future<http.Response> updateRole(String status, int uid) async {
    Map data = {
    "course_id": "string",
    "user_id": 0,
    "applicant_title": "string",
    "participants_email": "string",
    "applicant_academy_level": "string",
    "applicant_reason": "string",
    "applicant_ahcievement": "string",
    "applicant_future": "string",
    "status": status,
    "name": "string",
    "email": "string",
    "user_img": "string",
    "submissionTime": "2023-03-28T13:06:36.340Z"

    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress +
            'UpdateApplicatinStatus/$uid/${widget.courseid}/$status'
        ),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                                    "Admission /".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: TextStyle(
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    " Applications".tr(),
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
                                            ));
                                      },
                                      child: SvgPicture.asset(
                                          "images/message.svg")),
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
                            "  ${widget.cname}".tr(),
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
                                        SizedBox(height: height * 0.03),
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: WebSmoothScroll(
                                              controller: _scrollController,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    FutureBuilder<
                                                        List<applicantModel>>(
                                                      future: futureApplicant,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return ListView
                                                              .builder(
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data!.length,
                                                            itemBuilder:
                                                                (_, index) =>
                                                                    Container(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${snapshot.data![index].name}"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFFBD9B60),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 20),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.034,
                                                                      ),
                                                                      Text(
                                                                        "Title"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF999999),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.01,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.349,
                                                                        height: height *
                                                                            0.06,
                                                                        child:
                                                                            TextField(
                                                                          readOnly:
                                                                              true,
                                                                          enableInteractiveSelection:
                                                                              true,
                                                                          controller:
                                                                              TextEditingController(text: "${snapshot.data![index].applicant_title}".tr()),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 16),
                                                                          ),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.02,
                                                                      ),
                                                                      Text(
                                                                        "Highest academic level"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF999999),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.01,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.349,
                                                                        height: height *
                                                                            0.06,
                                                                        child:
                                                                            TextField(
                                                                          readOnly:
                                                                              true,
                                                                          enableInteractiveSelection:
                                                                              true,
                                                                          controller:
                                                                              TextEditingController(text: "${snapshot.data![index].applicant_academy_level}".tr()),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 16),
                                                                          ),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.02,
                                                                      ),
                                                                      Text(
                                                                        "Why do you want to apply to this course?"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF999999),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.01,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.349,
                                                                        child:
                                                                            TextField(
                                                                          readOnly:
                                                                              true,
                                                                          enableInteractiveSelection:
                                                                              true,
                                                                          controller:
                                                                              TextEditingController(text: "${snapshot.data![index].applicant_reason}".tr()),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 16),
                                                                          ),
                                                                          maxLines:
                                                                              6,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.02,
                                                                      ),
                                                                      Text(
                                                                        "How this course will help you with your future career?"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF999999),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.01,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.349,
                                                                        child:
                                                                            TextField(
                                                                          readOnly:
                                                                              true,
                                                                          enableInteractiveSelection:
                                                                              true,
                                                                          controller:
                                                                              TextEditingController(text: "${snapshot.data![index].applicant_future}".tr()),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 16),
                                                                          ),
                                                                          maxLines:
                                                                              6,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.035,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.066,
                                                                      ),
                                                                      Text(
                                                                        "Email"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF999999),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.01,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.349,
                                                                        height: height *
                                                                            0.06,
                                                                        child:
                                                                            TextField(
                                                                          readOnly:
                                                                              true,
                                                                          enableInteractiveSelection:
                                                                              true,
                                                                          controller:
                                                                              TextEditingController(text: "${snapshot.data![index].email}"),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 16),
                                                                          ),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.02,
                                                                      ),
                                                                      Text(
                                                                        "Application status"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF999999),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.01,
                                                                      ),
                                                                      Container(
                                                                        width: width *
                                                                            0.349,
                                                                        height: height *
                                                                            0.06,
                                                                        decoration:
                                                                            BoxDecoration(border: Border.all(color: Color(0xFFEEEEEE))),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: height * 0.015),
                                                                          child:
                                                                              DropdownButtonFormField(
                                                                            decoration:
                                                                                InputDecoration.collapsed(hintText: ''),
                                                                            style:
                                                                                GoogleFonts.barlow(
                                                                              textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                            ),
                                                                            // Initial Value
                                                                            value:
                                                                                snapshot.data![index].status,

                                                                            // Down Arrow Icon
                                                                            icon:
                                                                                Icon(
                                                                              Icons.expand_more_rounded,
                                                                              size: 18,
                                                                              color: Color(0Xff999999),
                                                                            ),

                                                                            // Array list of items
                                                                            items:
                                                                                items.map((String items) {
                                                                              return DropdownMenuItem(
                                                                                value: items.toString(),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(left: 8.0),
                                                                                  child: Text(
                                                                                    items.tr().toString(),
                                                                                    style: GoogleFonts.barlow(
                                                                                      textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }).toList(),
                                                                            // After selecting the desired option,it will
                                                                            // change button value to selected value
                                                                            onChanged:
                                                                                (String? newValue) {
                                                                              setState(() {
                                                                                updateRole(newValue!, widget.userid);

                                                                                if (newValue == 'Accepted'.tr()) {
                                                                                  postRequest();
                                                                                  postRequestMyC();
                                                                                  postRequestCert();
                                                                                } else {
                                                                                  deleteRequest();
                                                                                  deleteRequestMyC();
                                                                                  deleteCertificate();
                                                                                  // return Text("Y is less than 10");
                                                                                }
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.02,
                                                                      ),
                                                                      Text(
                                                                        "What achievement are you most proud of?"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF999999),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.01,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.349,
                                                                        child:
                                                                            TextField(
                                                                          readOnly:
                                                                              true,
                                                                          enableInteractiveSelection:
                                                                              true,
                                                                          controller:
                                                                              TextEditingController(text: "${snapshot.data![index].applicant_ahcievement}".tr()),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 16),
                                                                          ),
                                                                          maxLines:
                                                                              6,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.02,
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.1,
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.035,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.349,
                                                                        height: height *
                                                                            0.06,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.1,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
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
                                                  ],
                                                ),
                                              ),
                                            )),
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
