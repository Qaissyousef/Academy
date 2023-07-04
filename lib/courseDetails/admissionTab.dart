import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;

import '../admissionPage.dart';
import '../models/course_model.dart';

import 'package:pif_admin_dashboard/util/global.dart' as global;

class admissionTab extends StatefulWidget {
  final Course course;

  const admissionTab({Key? key, required this.course}) : super(key: key);

  @override
  State<admissionTab> createState() => _admissionTabState();
}

class _admissionTabState extends State<admissionTab> {
  var _dateTime = DateTime.parse("2022-10-01 00:00:00.000");

  late ScrollController _scrollController;

  final myController1 = TextEditingController();

  Future<List<Course>> fetchCourse() async {
    final response = await http.get(
        Uri.parse(global.apiAddress + 'GetACourse/${widget.course.course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Course>((json) => Course.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Course>> futureCourse;

  Future<http.Response> updateDeadline(changedVal) async {
    Map data = {
      "course_id": 1,
      "course_name": "string",
      "course_image": "string",
      "course_instructor": "string",
      "applicants": 0,
      "deadline": changedVal,
      "starttime": ""
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(
            global.apiAddress + 'UpdateDeadline/${widget.course.course_id}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> updatestartline(changedVal) async {
    Map data = {
      "course_id": 1,
      "course_name": "string",
      "course_image": "string",
      "course_instructor": "string",
      "applicants": 0,
      "starttime": changedVal,
      "deadline": "vdss"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(
            global.apiAddress + 'UpdateStartLine/${widget.course.course_id}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> updatemaxparticipants() async {
    Map data = {
      "about_id": 0,
      "description": "string",
      "duration": "string",
      "course_name": "string",
      "course_instuctor": "string",
      "course_image": "string",
      "course_id": 0,
      "category": "string",
      "maxParticipants": myController1.text
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress +
            'UpdateMaxParticipants/${widget.course.course_id}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> updateRequest(int u) async {
    Map data = {
      "course_id": "string",
      "course_name": "string",
      "course_name_eng": "string",
      "course_image": "string",
      "course_instructor": "string",
      "applicants": 0,
      "admission": u,
      "applied": 0,
      "deadline": "string"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(
            global.apiAddress + 'UpdateAdmission/${widget.course.course_id}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    futureCourse = fetchCourse();

    super.initState();
  }

  bool buttonActive = false;
  bool buttonActiveClose = true;
  bool opentext = false;
  bool closetext = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final applications = SizedBox(
      width: width * 0.1,
      height: height * 0.047,
      child: ElevatedButton(
        onPressed: buttonActive
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => admissionDetail(
                            course: widget.course,
                          )),
                );
              }
            : null,
        child: Text("View application".tr().toString(),
            strutStyle: StrutStyle(forceStrutHeight: true),
            style: GoogleFonts.barlow(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 16),
            )),
        style: ElevatedButton.styleFrom(
            onSurface: Colors.grey,
            primary: Colors.white,
            onPrimary: buttonActive ? Colors.black : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // maximumSize: Size(width*0.07,height*0.1),
            side: BorderSide(color: Color(0xff999999))),
      ),
    );

    final close = SizedBox(
      width: width * 0.1,
      // height: height*0.047,

      child: ElevatedButton(
        onPressed: buttonActive
            ? () {
                updateRequest(0);

                setState(() {
                  buttonActive = !buttonActive;
                  buttonActiveClose = !buttonActiveClose;
                  closetext = !closetext;
                  opentext = !opentext;
                });
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
          child: Text("Close admission".tr().toString(),
              strutStyle: StrutStyle(forceStrutHeight: true),
              style: GoogleFonts.barlow(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
              )),
        ),
        style: ElevatedButton.styleFrom(
            onSurface: Colors.grey,
            primary: Color(0xFF215732),
            onPrimary: buttonActive ? Colors.white : Color(0xFF999999),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // maximumSize: Size(width*0.07,height*0.1),
            side: BorderSide(color: Colors.transparent)),
      ),
    );

    final open = SizedBox(
      width: width * 0.1,
      child: ElevatedButton(
        onPressed: buttonActiveClose
            ? () {
                updateRequest(1);
                setState(() {
                  buttonActive = !buttonActive;
                  buttonActiveClose = !buttonActiveClose;
                  closetext = !closetext;
                  opentext = !opentext;
                });
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
          child: Text("Open admission".tr().toString(),
              strutStyle: StrutStyle(forceStrutHeight: true),
              style: GoogleFonts.barlow(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
              )),
        ),
        style: ElevatedButton.styleFrom(
            onSurface: Colors.grey,
            primary: Color(0xFF215732),
            onPrimary: buttonActiveClose ? Colors.white : Color(0xFF999999),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // maximumSize: Size(width*0.07,height*0.1),
            side: BorderSide(color: Colors.transparent)),
      ),
    );

    final open2 = SizedBox(
      width: width * 0.1,
      child: ElevatedButton(
        onPressed: buttonActive
            ? () {
                updateRequest(1);
                setState(() {
                  buttonActive = !buttonActive;
                  buttonActiveClose = !buttonActiveClose;
                  closetext = !closetext;
                  opentext = !opentext;
                });
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
          child: Text("Open admission".tr().toString(),
              strutStyle: StrutStyle(forceStrutHeight: true),
              style: GoogleFonts.barlow(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
              )),
        ),
        style: ElevatedButton.styleFrom(
            onSurface: Colors.grey,
            primary: Color(0xFF215732),
            onPrimary: buttonActiveClose ? Colors.white : Color(0xFF999999),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // maximumSize: Size(width*0.07,height*0.1),
            side: BorderSide(color: Colors.transparent)),
      ),
    );
    final close2 = SizedBox(
      width: width * 0.1,
      // height: height*0.047,

      child: ElevatedButton(
        onPressed: buttonActiveClose
            ? () {
                updateRequest(0);

                setState(() {
                  buttonActive = !buttonActive;
                  buttonActiveClose = !buttonActiveClose;
                  closetext = !closetext;
                  opentext = !opentext;
                });
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
          child: Text("Close admission".tr().toString(),
              strutStyle: StrutStyle(forceStrutHeight: true),
              style: GoogleFonts.barlow(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
              )),
        ),
        style: ElevatedButton.styleFrom(
            onSurface: Colors.grey,
            primary: Color(0xFF215732),
            onPrimary: buttonActive ? Colors.white : Color(0xFF999999),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // maximumSize: Size(width*0.07,height*0.1),
            side: BorderSide(color: Colors.transparent)),
      ),
    );

    return Card(
      child: Container(
        height: height,
        width: width * 0.92,
        child: WebSmoothScroll(
          controller: _scrollController,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: FutureBuilder<List<Course>>(
                future: futureCourse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                        child: (snapshot.data![index].admission == 0)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height * 0.1),

                                  Visibility(
                                    visible: opentext,
                                    child: Center(
                                      child: Text(
                                        "Admission for this course is currently open."
                                            .tr(),
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFF999999),
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Visibility(
                                    visible: closetext,
                                    child: Center(
                                      child: Text(
                                        "Admission for this course is currently closed."
                                            .tr(),
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFF999999),
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: height * 0.06),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Duration of the recruitment".tr(),
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFF999999),
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.1,
                                        height: height * 0.047,
                                        child: ElevatedButton(
                                          onPressed: buttonActive
                                              ? () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            admissionDetail(
                                                              course:
                                                                  widget.course,
                                                            )),
                                                  );
                                                }
                                              : null,
                                          child: Text(
                                              "View application"
                                                  .tr()
                                                  .toString(),
                                              strutStyle: StrutStyle(
                                                  forceStrutHeight: true),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16),
                                              )),
                                          style: ElevatedButton.styleFrom(
                                              onSurface: Colors.grey,
                                              primary: Colors.white,
                                              onPrimary: buttonActive
                                                  ? Colors.black
                                                  : Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              // maximumSize: Size(width*0.07,height*0.1),
                                              side: BorderSide(
                                                  color: Color(0xff999999))),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      // WebDatePicker(
                                      //   initialDate: DateTime.now(),
                                      //   onChange: (value) {},
                                      // ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      // WebDatePicker(
                                      //   initialDate: DateTime.now(),
                                      //   onChange: (value) {
                                      //     updateDeadline(DateTimeFormat.format(
                                      //             value!,
                                      //             format: 'D, M j')
                                      //         .toString());
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.07,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      open,
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      close,
                                    ],
                                  ),
                                  //
                                  // Row(
                                  //   children: <Widget>[
                                  //
                                  //     open2,
                                  //     SizedBox(width: width*0.02,),
                                  //     close2,
                                  //
                                  //
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: height * 0.2,
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height * 0.1),
                                  Visibility(
                                    visible: opentext,
                                    child: Center(
                                      child: Text(
                                        "Admission for this course is currently closed."
                                            .tr(),
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFF999999),
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: closetext,
                                    child: Center(
                                      child: Text(
                                        "Admission for this course is currently open."
                                            .tr(),
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFF999999),
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.06),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Duration of the recruitment".tr(),
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFF999999),
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.1,
                                        height: height * 0.047,
                                        child: ElevatedButton(
                                          onPressed: buttonActiveClose
                                              ? () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            admissionDetail(
                                                              course:
                                                                  widget.course,
                                                            )),
                                                  );
                                                }
                                              : null,
                                          child: Text(
                                              "View application"
                                                  .tr()
                                                  .toString(),
                                              strutStyle: StrutStyle(
                                                  forceStrutHeight: true),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16),
                                              )),
                                          style: ElevatedButton.styleFrom(
                                              onSurface: Colors.grey,
                                              primary: Colors.white,
                                              onPrimary: buttonActive
                                                  ? Colors.black
                                                  : Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              // maximumSize: Size(width*0.07,height*0.1),
                                              side: BorderSide(
                                                  color: Color(0xff999999))),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      // WebDatePicker(
                                      //   initialDate: DateTime.now(),
                                      //   onChange: (value) {},
                                      // ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      // WebDatePicker(
                                      //   initialDate: DateTime.now(),
                                      //   onChange: (value) {
                                      //     updateDeadline(DateTimeFormat.format(
                                      //             value!,
                                      //             format: 'D, M j')
                                      //         .toString());
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.07,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      open2,
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      close2,
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
