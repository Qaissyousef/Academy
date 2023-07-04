import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;
import '../models/admissionModel.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;

class settingsTab extends StatefulWidget {
  final String current_course_id;

  const settingsTab({Key? key, required this.current_course_id})
      : super(key: key);

  @override
  State<settingsTab> createState() => _settingsTabState();
}

class _settingsTabState extends State<settingsTab> {
  var dropdownvalue;

  Future<http.Response> closeCrs() async {
    Map data = {
      "course_id": widget.current_course_id,
      "description": "string",
      "duration": "string",
      "course_name": "string",
      "course_image": "string",
      "course_instuctor": "string",
      "category": "string",
      "maxParticipants": 100,
      "applicants": 0,
      "deadline": "string",
      "starttime": "string",
      "status": "Closed"
    };

    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(global.apiAddress + 'CloseCourse'),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: body,
    );

    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> DeleteCrs() async {
    Map data = {
      "about_id": 0,
      "description": "string",
      "duration": "string",
      "course_name": "string",
      "course_instuctor": "string",
      "course_image": "string",
      "course_id": widget.current_course_id,
      "category": "string",
      "maxParticipants": 0
    };

    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(global.apiAddress + 'DeleteCourse'),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: body,
    );

    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> DeleteCrsA() async {
    Map data = {
      "about_id": 0,
      "description": "string",
      "duration": "string",
      "course_name": "string",
      "course_instuctor": "string",
      "course_image": "string",
      "course_id": widget.current_course_id,
      "category": "string",
      "maxParticipants": 0
    };

    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(global.apiAddress + 'DeleteCourseA'),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: body,
    );

    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> DeleteCrsT() async {
    Map data = {
      "about_id": 0,
      "description": "string",
      "duration": "string",
      "course_name": "string",
      "course_instuctor": "string",
      "course_image": "string",
      "course_id": widget.current_course_id,
      "category": "string",
      "maxParticipants": 0
    };

    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(global.apiAddress + 'DeleteCourseT'),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: body,
    );

    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> DeleteCrsS() async {
    Map data = {
      "course_id": widget.current_course_id,
      "schedule_id": 0,
      "duration": "string",
      "date": "string",
      "time": "string",
      "location": "string",
      "instructor": "string"
    };

    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(global.apiAddress + 'DeleteCourseSch'),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: body,
    );

    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> DeleteCrsI() async {
    Map data = {
      "course_id": widget.current_course_id,
      "name": "string",
      "name_id": 0
    };

    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(global.apiAddress + 'DeleteCourseInt'),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: body,
    );

    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> DeleteCrsM() async {
    Map data = {
      "course_id": widget.current_course_id,
      "material_id": "135",
      "title": "string",
      "time": "string",
      "author": "string",
      "file_name": "string",
    };

    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(global.apiAddress + 'DeleteCourseMat'),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: body,
    );

    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> DeleteCrsC() async {
    Map data = {
      "course_id": widget.current_course_id,
      "material_id": "string",
      "title": "string",
      "time": "string",
      "author": "string",
      "file_name": "string",
      "subject": "string",
      "fileModel": "string"
    };

    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(global.apiAddress + 'DeleteCourseCert'),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: body,
    );

    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> DeleteCrsPD() async {
    Map data = {
      "course_id": widget.current_course_id,
      "user_id": 0,
      "post_id": 0,
      "post_title": "string",
      "post_description": "string",
      "post_replies": 0,
      "post_time": "2023-03-20T11:06:08.969Z"
    };

    var body = json.encode(data);
    var response = await http.post(
      Uri.parse(global.apiAddress + 'DeleteCoursePD'),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: body,
    );

    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<List<admissionModel>> fetchAdmissionInfo() async {
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAllApllicantsAccepted/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<admissionModel>((json) => admissionModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  late Future<List<admissionModel>> futurefetchAdmissionInfo;


  Future<http.Response> postRequestMyC() async {
    Map data = {
      "user_id": int.parse(dropdownvalue),
      "course_id": widget.current_course_id,
      "course_completion": 0,
      "course_name_eng": "string",
      "finished": 0
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

  Future<http.Response> deleteRequestMyC(int u) async {
    Map data = {
      "user_id": u,
      "course_id": widget.current_course_id,
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
      "user_id": int.parse(dropdownvalue),
      "course_id": widget.current_course_id,
      "date": "",
      "percentage": 0,
      "attendance_id": 0
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
      "user_id": int.parse(dropdownvalue),

      "course_id": widget.current_course_id,

      "date": "string",
      "survey_completion": "string",
      "percentage": 0,
      "name": "string",
      "user_img": "string",
      "img": "string",
      "attendance_id": 0,
      "certificate_id": 0,
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

  Future<http.Response> deleteRequest(int u) async {
    Map data = {
      "user_id": u,
      "course_id": widget.current_course_id,
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
    setState(() { futurefetchAdmissionInfo = fetchAdmissionInfo(); });

    return response;
  }

  Future<http.Response> deleteRequestApplicant(int u) async {
    Map data = {
      "user_id": u,
      "course_id": widget.current_course_id,
      "applicant_title": "string",
      "participants_email": "string",
      "applicant_academy_level": "string",
      "applicant_reason": "string",
      "applicant_ahcievement": "string",
      "applicant_future": "string",
      "status": "string"
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response =
    await http.post(Uri.parse(global.apiAddress + 'DeleteApplication'),
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
    futurefetchAdmissionInfo = fetchAdmissionInfo();

    print("${response.body}");

    return response;
  }

  Future<http.Response> deleteCertificate(int u) async {
    Map data = {
      "user_id": u,
      "course_id": widget.current_course_id,
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

  Future<http.Response> postRequestApplicant () async {


    Map data = {
      // "user_id": myControllername.text,
      // "applicant_title": "string",
      // "participants_email": "string",
      // "applicant_academy_level": "string",
      // "applicant_reason": "string",
      // "applicant_ahcievement": "string",
      // "applicant_future": "string",
      // "status": "string"

      "course_id": "${widget.current_course_id}",

      "user_id": int.parse(dropdownvalue),
      "applicant_title": "string",
      "participants_email": "string",
      "applicant_academy_level": "string",
      "applicant_reason": "string",
      "applicant_ahcievement": "string",
      "applicant_future": "string",
      "status": "Accepted"

    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress +'AddApplicants'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    setState(() { futurefetchAdmissionInfo = fetchAdmissionInfo(); });



    return response;
  }

  late ScrollController _scrollController;
  final myControllername = TextEditingController();
  List categoryItemlist = [];
  Future fetchInst() async {
    final responseEng =
    await http.get(Uri.parse(global.apiAddress + 'GetParticipants'));
    if (responseEng.statusCode == 200) {
      var jsonData = json.decode(responseEng.body);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
    // if (responseEng.statusCode == 200) {
    //   final parsedEng = json.decode(responseEng.body).cast<Map<String, dynamic>>();
    //
    //   return parsedEng.map<InstructorModel>((json) => InstructorModel.fromMap(json)).toList();
    // }
    else {
      throw Exception('Failed to load album');
    }
  }
  @override
  void initState() {
    super.initState();
    fetchInst();
    _scrollController = ScrollController();
    futurefetchAdmissionInfo = fetchAdmissionInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final role = Container(
      height: height * 0.3,
      child: DropdownButtonFormField(
        decoration: InputDecoration.collapsed(hintText: ''),
        style: GoogleFonts.barlow(
          textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
        ),
        // Initial Value

        hint: Text('Select Participants'),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        items: categoryItemlist.map((item) {
          return DropdownMenuItem(
            value: item['user_id'].toString(),
            child: Text(item['name'].toString()),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            dropdownvalue = newVal;
          });
        },
        value: dropdownvalue,
      ),

    );

    bool hasData = true;
    // Future<void> _showAlertDialog() async {
    //   return showDialog<void>(
    //     context: context,
    //     // user must tap button!
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         insetPadding: EdgeInsets.all(20), // <-- SEE HERE
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(12.0))),
    //         scrollable: true,
    //         title: Column(
    //           children: [
    //             Align(
    //                 alignment: Alignment.topRight,
    //                 child: GestureDetector(
    //                     onTap: () {
    //                       Navigator.pop(context);
    //                     },
    //                     child: Icon(Icons.close))),
    //             Center(
    //               child: Text(
    //                 "Add Instructor".tr(),
    //                 style: GoogleFonts.barlow(
    //                   textStyle: TextStyle(
    //                       color: Color(0xFF222222),
    //                       fontWeight: FontWeight.w500,
    //                       fontStyle: FontStyle.normal,
    //                       fontSize: 28),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         content: Container(
    //             width: width * 0.3,
    //             height: height * 0.05,
    //             decoration: BoxDecoration(
    //               border: Border.all(color: Color(0xFFEEEEEE)),
    //               borderRadius: BorderRadius.circular(4.5),
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.only(top: height * 0.015, left: 8),
    //               child: role,
    //             )),
    //         actions: <Widget>[
    //         ],
    //       );
    //     },
    //   );
    // }

    final clsBtn = Container(
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
                builder: (context) => AlertDialog(
                      title: Text("Are you sure?"),
                      content: Text("Do you want to close the course ?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              closeCrs();
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          courseResponsive(),
                                  transitionDuration: Duration(seconds: 0),
                                ),
                              );
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Course Closed"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("OK"))
                                        ],
                                      ));
                            },
                            child: Text("Yes")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No")),
                      ],
                    ));
          },
          child: Row(
            children: [
              // SvgPicture.asset(
              //   "assets/images/sort.svg",
              //   fit: BoxFit.scaleDown,
              // ),
              Text(
                "  Close Course".tr(),
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

    final delBtn = Container(
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
                builder: (context) => AlertDialog(
                      title: Text("Are you sure?"),
                      content: Text("Do you want to delete the course ?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              DeleteCrs();
                              DeleteCrsA();
                              DeleteCrsT();
                              DeleteCrsS();
                              DeleteCrsI();
                              DeleteCrsM();
                              DeleteCrsC();
                              DeleteCrsPD();
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          courseResponsive(),
                                  transitionDuration: Duration(seconds: 0),
                                ),
                              );
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Course Deleted"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("OK"))
                                        ],
                                      ));
                            },
                            child: Text("Yes")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No")),
                      ],
                    ));
          },
          child: Row(
            children: [
              // SvgPicture.asset(
              //   "assets/images/sort.svg",
              //   fit: BoxFit.scaleDown,
              // ),
              Text(
                "  Delete Course".tr(),
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

    // final delUser = Container(
    //   height: height * 0.047,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(4),
    //     border: Border.all(color: Colors.black, width: 0.4),
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.only(left: 17, right: 17),
    //     child: GestureDetector(
    //       onTap: () {
    //         showDialog(
    //             context: context,
    //             builder: (context) => AlertDialog(
    //               title: Text("Are you sure?"),
    //               content: Text("Do you want to delete the user ?"),
    //               actions: [
    //                 TextButton(
    //                     onPressed: () {
    //                       Navigator.pop(context);
    //                       deleteRequest();
    //                       deleteRequestMyC();
    //                       deleteCertificate();
    //                       deleteRequestApplicant();
    //                       showDialog(
    //                           context: context,
    //                           builder: (context) => AlertDialog(
    //                             title: Text("User Deleted"),
    //                             actions: [
    //                               TextButton(
    //                                   onPressed: () {
    //                                     Navigator.pop(context);
    //                                   },
    //                                   child: Text("OK"))
    //                             ],
    //                           ));
    //                     },
    //                     child: Text("Yes")),
    //                 TextButton(
    //                     onPressed: () {
    //                       futurefetchAdmissionInfo = fetchAdmissionInfo();
    //
    //                     },
    //                     child: Text("No")),
    //               ],
    //             ));
    //       },
    //       child: Row(
    //         children: [
    //           // SvgPicture.asset(
    //           //   "assets/images/sort.svg",
    //           //   fit: BoxFit.scaleDown,
    //           // ),
    //           Text(
    //             "  Delete User".tr(),
    //             style: GoogleFonts.barlow(
    //               textStyle: TextStyle(
    //                   color: Color(0xFF222222),
    //                   fontWeight: FontWeight.w400,
    //                   fontStyle: FontStyle.normal,
    //                   fontSize: width * 0.01),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );


    final addUser = Container(
      height: height * 0.047,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black, width: 0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17),
        child: GestureDetector(
          onTap: () {
            showDialog<void>(
              context: context,
              // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  insetPadding: EdgeInsets.all(20), // <-- SEE HERE
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
                      Center(
                        child: Text(
                          "Add Instructor".tr(),
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
                                color: Color(0xFF222222),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 28),
                          ),
                        ),
                      ),
                    ],
                  ),
                  content: Container(
                      width: width * 0.3,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(4.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.015, left: 8),
                        child: role,
                      )),
                  actions: <Widget>[
                    SizedBox(
                      height: height * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          postRequestApplicant();
                          postRequestCert();
                          postRequestMyC();
                          postRequest();

                          setState(() {
                            myControllername.clear();
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Add User'.tr().toString(),
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
                                color: Color(0xFF183028),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          primary: Color(0xFFF5F0E5),
                          onPrimary: Color(0xFF183028),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Row(
            children: [
              // SvgPicture.asset(
              //   "assets/images/sort.svg",
              //   fit: BoxFit.scaleDown,
              // ),
              Text(
                "  Add User".tr(),
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


    return Card(
        child: Container(
      height: height,
      width: width * 0.92,
      child: WebSmoothScroll(
        controller: _scrollController,
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  clsBtn,
                                  SizedBox(
                                    width: width * 0.005,
                                  ),
                                  delBtn,
                                  SizedBox(
                                    width: width * 0.005,
                                  ),
                                  addUser
                                ],
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
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [

                                                                              // Container(
                                                                              //   width: width*0.06,
                                                                              //   child:  Image.network(global.apiAddress + 'GetImage/${snapshot.data![index].user_img}',scale: 4,),

                                                                              // ),
                                                                              Container(
                                                                                child: Row(
                                                                                  children: [
                                                                                    Container(
                                                                                      width: width *
                                                                                          0.07,
                                                                                      height: height*0.07,
                                                                                      child: Image.network(global.apiAddress + 'GetImage/${snapshot.data![index].user_img}',),
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
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Container(
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
                                                                                            builder: (context) => AlertDialog(
                                                                                              title: Text("Are you sure?"),
                                                                                              content: Text("Do you want to delete the user ?"),
                                                                                              actions: [
                                                                                                TextButton(
                                                                                                    onPressed: () {
                                                                                                      Navigator.pop(context);
                                                                                                      deleteRequest(snapshot.data![index].uid);
                                                                                                      deleteRequestMyC(snapshot.data![index].uid);
                                                                                                      deleteCertificate(snapshot.data![index].uid);
                                                                                                      deleteRequestApplicant(snapshot.data![index].uid);
                                                                                                      showDialog(
                                                                                                          context: context,
                                                                                                          builder: (context) => AlertDialog(
                                                                                                            title: Text("User Deleted"),
                                                                                                            actions: [
                                                                                                              TextButton(
                                                                                                                  onPressed: () {
                                                                                                                    Navigator.pop(context);
                                                                                                                  },
                                                                                                                  child: Text("OK"))
                                                                                                            ],
                                                                                                          ));
                                                                                                    },
                                                                                                    child: Text("Yes")),
                                                                                                TextButton(
                                                                                                    onPressed: () {
                                                                                                      futurefetchAdmissionInfo = fetchAdmissionInfo();

                                                                                                    },
                                                                                                    child: Text("No")),
                                                                                              ],
                                                                                            ));
                                                                                      },
                                                                                      child: Row(
                                                                                        children: [
                                                                                          // SvgPicture.asset(
                                                                                          //   "assets/images/sort.svg",
                                                                                          //   fit: BoxFit.scaleDown,
                                                                                          // ),
                                                                                          Text(
                                                                                            "  Delete User".tr(),
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
                                                          Text(
                                                              "No Participants".tr(),
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
                                                              )));
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
                    )
                  ],
                ))),
      ),
    ));
  }
}
