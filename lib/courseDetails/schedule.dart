import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:date_time_format/date_time_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as ht;

import '../models/instructorModel.dart';
import '../models/schedule_model.dart';
import 'package:http_parser/http_parser.dart';

import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/util/fieldValidator.dart' as validator;

class schedule extends StatefulWidget {
  final String current_course_id;
  final int Function() onNext;

  const schedule(
      {Key? key, required this.current_course_id, required this.onNext})
      : super(key: key);

  @override
  State<schedule> createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {

  late List<int> _selectedFile;
  late Uint8List _bytesData;

  // Future<void> _handleResult(Object? result) async {
  //   // setState(() {
  //   _bytesData = Base64Decoder().convert(result.toString().split(",").last);
  //   _selectedFile = _bytesData;

  //   // });
  // }

  Future<void> _getImage() async {
    final completer = Completer<void>();
    final input = FileUploadInputElement(); //..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        final bytesData = reader.result as Uint8List;
        setState(() {
          _selectedFile = bytesData;
        });
        completer.complete();
      });
    });
    await completer.future;
  }

  Future<void> _handleResult(Object? result) async {
    _bytesData = Base64Decoder().convert(result.toString().split(",").last);

    setState(() {
      _selectedFile = _bytesData;
      print('=== _selectedFile length: ${_selectedFile.length}');
    });
  }

  var dropdownvalue;
  var val = "instructor 1";

  final myControllerloc = TextEditingController();
  final myControllerduration = TextEditingController();
  final myControllersdate = TextEditingController();
  final myControllerstime = TextEditingController();
  final myControllerSubject = TextEditingController();

  Future<String> postRequest() async {
    var url = Uri.parse(global.apiAddress + "AddSchedule");
    var request = new http.MultipartRequest("POST", url);
    request.fields['course_id'] = widget.current_course_id.toString();
    request.fields['duration'] = myControllerduration.text;
    request.fields['date'] = myControllersdate.text;
    request.fields['time'] = myControllerstime.text;
    request.fields['location'] = myControllerloc.text;
    request.fields['instructor'] = dropdownvalue;
    request.fields['subject'] = myControllerSubject.text;

    request.fields['subjectpath'] = 'wfe';

    request.files.add(await http.MultipartFile.fromBytes(
        'fileModel', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: 'hhh'));

    request.send().then((response) {
      print("i am hereee makerequest");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");

      setState(() {
        futureSchedule = fetchSchedule();
      });
    });
    return "finished";
  }

  Future<String> addScheduleAttachment({
    required int uid,
    required String newDuration,
    required String newDate,
    required String newTime,
    required String newInstructor,
    required String newLocation,
    required String newSubject,
  }) async {
    var url = Uri.parse(global.apiAddress + "addScheduleAttachment/$uid");
    var request = new http.MultipartRequest("POST", url);
    request.fields['course_id'] = widget.current_course_id.toString();
    request.fields['schedule_id'] = uid.toString();
    request.fields['duration'] = newDuration;
    request.fields['date'] = newDate;
    request.fields['time'] = newTime;
    request.fields['location'] = newLocation;
    request.fields['instructor'] = newInstructor;
    request.fields['subject'] = newSubject;

    request.fields['subjectpath'] = 'wfe';

    request.files.add(await http.MultipartFile.fromBytes(
        'fileModel', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: 'hhh'));

    request.send().then((response) {
      print("===i am hereee makerequest");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");

      setState(() {
        futureSchedule = fetchSchedule();
      });
    });
    return "finished";
  }

  bool submitForm() {
    String errorText = "";

    errorText += validator.isValid("date", myControllersdate.text, "empty");
    errorText +=
        validator.isValid("end time", myControllerduration.text, "empty;time");
    errorText +=
        validator.isValid("start time", myControllerstime.text, "empty;time");
    errorText += validator.isValid("location", myControllerloc.text, "empty");
    errorText +=
        validator.isValid("subject", myControllerSubject.text, "empty");

    print(myControllerstime.text);
    print(myControllerduration.text);
    if (errorText == "") {
      if (!validator.isTimeGreater(
          myControllerstime.text, myControllerduration.text))
        errorText +=
            "${validator.bullet} start time can't be greater than end time\n";
    }

    if (errorText != "") {
      validator.alertDialog(
          context, errorText.substring(0, errorText.length - 1));
      return false;
    }

    postRequest();
    Navigator.pop(context);
    return true;
  }

  late Future<List<InstructorModel>> futurefetchInstructor;
  // DateTime _dateTime = DateTime.now();
  var _dateTime1 = DateTime.parse("2022-10-01 00:00:00.000");
  final _dateTime2 = DateTime.parse("2022-02-12 00:00:00.000");
  final _dateTime3 = DateTime.parse("2022-06-01 00:00:00.000");
  final _dateTime4 = DateTime.parse("2022-04-05 00:00:00.000");
  // String dropdownvalue = 'Mohammad Abdulrahman';

  // List of items in our dropdown menu
  var items = [
    "instructor 1",
    "instructor 2",
    "instructor 3",
  ];

  Future<List<InstructorModel>> fetchInstructor() async {
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAllInstructor/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ScheduleCourse>((json) => ScheduleCourse.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<ScheduleCourse>> fetchSchedule() async {
    List<ScheduleCourse> courses = [];
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetSchedule/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        courses.add(ScheduleCourse.fromMap(jsonDecode(response.body)[i]));
      }

      if (courses.isEmpty) {
        hasData = false;
      } else {
        hasData = true;
      }
      // parsed.map<ScheduleCourse>((json) => ScheduleCourse.fromMap(json)).toList()
      return courses;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<ScheduleCourse>> futureSchedule;

  bool hasData = true;

  Future<http.Response> updateSchedule(
      {required int uid,
      required String newDate,
      required String newTime,
      required String newInstructor}) async {
    Map data = {
      "course_id": "string",
      "schedule_id": uid,
      "duration": "string",
      "date": newDate,
      "time": newTime,
      "location": "string",
      "material": "string",
      "instructor": newInstructor,
      "subject": "string",
      "subjectpath": "string",
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress + 'UpdateSchedule'),
        headers: {"Content-Type": "application/json"},
        body: body);
    setState(() {
      futureSchedule = fetchSchedule();
    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> deleteRequestSchedule(
      int uid, String subjectPath) async {
    Map data = {
      "course_id": "string",
      "schedule_id": uid,
      "duration": "string",
      "date": "string",
      "time": "string",
      "location": "string",
      "material": "string",
      "instructor": "string",
      "subject": "string",
      "subjectpath": subjectPath
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'DeleteSch'),
        headers: {"Content-Type": "application/json"}, body: body);
    setState(() {
      futureSchedule = fetchSchedule();
    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> DeleteScheduleAttachment(
      int uid, String subjectPath) async {
    Map data = {
      "course_id": "string",
      "schedule_id": uid,
      "duration": "string",
      "date": "string",
      "time": "string",
      "location": "string",
      "material": "string",
      "instructor": "string",
      "subject": "string",
      "subjectpath": subjectPath
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress + 'DeleteScheduleAttachment'),
        headers: {"Content-Type": "application/json"},
        body: body);
    setState(() {
      futureSchedule = fetchSchedule();
    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  late ScrollController _scrollController;

  List categoryItemlist = [];
  Future fetchInst() async {
    final responseEng = await http.get(Uri.parse(
        global.apiAddress + 'GetInstructors/${widget.current_course_id}'));
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
    futurefetchInstructor = fetchInstructor();
    futureSchedule = fetchSchedule();
    fetchInst();
    _scrollController = ScrollController();

    super.initState();
  }

  // var dropdownvalue;

  bool rowVisible = false;

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

        hint: Text('Select instructor'),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        items: categoryItemlist.map((item) {
          return DropdownMenuItem(
            value: item['name'].toString(),
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

    // var formate1 = "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}";
    var formate2 = "${_dateTime2.day}-${_dateTime2.month}-${_dateTime2.year}";
    var formate3 = "${_dateTime3.day}-${_dateTime3.month}-${_dateTime3.year}";
    var formate4 = "${_dateTime4.day}-${_dateTime4.month}-${_dateTime4.year}";

    return Card(
      child: Container(
        height: height * 0.9,
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
                  SizedBox(height: height * 0.03),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.67,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.92,
                              height: height * 0.07,
                              decoration: BoxDecoration(
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
                                    width: width * 0.17,
                                    child: Text(
                                      "Schedule".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFFBD9B60),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.15,
                                    child: Text(
                                      "Time".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFFBD9B60),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.18,
                                    child: Text(
                                      "Instructor".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFFBD9B60),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.13,
                                    child: Text(
                                      "Attachments".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFFBD9B60),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
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

                            FutureBuilder<List<ScheduleCourse>>(
                              future: futureSchedule,
                              builder: (context, snapshots) {
                                if (snapshots.hasData) {
                                  if (snapshots.hasData == null) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "No Schedule".tr(),
                                          style: GoogleFonts.barlow(
                                            textStyle: const TextStyle(
                                                color: Color(0xFF222222),
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshots.data!.length,
                                      itemBuilder: (_, index) => Container(
                                          child: Column(
                                        children: [
                                          Material(
                                            elevation: 1,
                                            child: Container(
                                              color: Colors.white,
                                              width: width * 0.9,
                                              height: height * 0.07,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.0125,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: width * 0.17,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  width * 0.12,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    DateFormat.yMMMMd(context
                                                                            .locale
                                                                            .toString())
                                                                        .format(DateFormat('MMM dd yyyy').parse(snapshots
                                                                            .data![index]
                                                                            .date)),
                                                                    // "${snapshots.data![index].date}"
                                                                    //     .toString()
                                                                    //     .tr(),
                                                                    style: GoogleFonts
                                                                        .barlow(
                                                                      textStyle: TextStyle(
                                                                          color: Color(
                                                                              0xFF222222),
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontStyle: FontStyle
                                                                              .normal,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        showDatePicker(
                                                                          context:
                                                                              context,
                                                                          initialDate:
                                                                              DateTime.now(),
                                                                          firstDate:
                                                                              DateTime(2001),
                                                                          lastDate:
                                                                              DateTime(2100),
                                                                          builder:
                                                                              (context, child) {
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
                                                                                  primary: Color(0xff215732),
                                                                                  //Month title and week days color
                                                                                  onSurface: Colors.black,
                                                                                  //Header elements and selected dates text color
                                                                                  //onPrimary: Colors.white,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                children: [
                                                                                  ConstrainedBox(
                                                                                    constraints: BoxConstraints(
                                                                                      maxWidth: 450.0,
                                                                                      maxHeight: height * 0.7,
                                                                                    ),
                                                                                    child: child,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        ).then(
                                                                            (date) {
                                                                          setState(
                                                                              () {
                                                                            // update the date only
                                                                            updateSchedule(
                                                                              uid: snapshots.data![index].schedule_id,
                                                                              newDate: date!.format('M d Y').toString(),
                                                                              newTime: snapshots.data![index].time,
                                                                              newInstructor: snapshots.data![index].instructor,
                                                                            );

                                                                            futureSchedule =
                                                                                fetchSchedule();
                                                                          });
                                                                        });
                                                                      },
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        "assets/images/calendar.svg",
                                                                        fit: BoxFit
                                                                            .scaleDown,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: width * 0.15,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "${DateFormat.Hm(context.locale.toString()).format(DateFormat('HH:mm').parse((snapshots.data![index].time)))}",

                                                          //   DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString().replaceAll('م', 'PM').replaceAll('ص', 'AM'));

                                                          // - ${DateFormat.Hm(context.locale.toString()).format(DateFormat('HH:mm').parse(snapshot.data![index].event_end_time))}",

                                                          // "${snapshots.data![index].time}"
                                                          //     .tr(),
                                                          style: GoogleFonts
                                                              .barlow(
                                                            textStyle: TextStyle(
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
                                                        SizedBox(
                                                          width: width * 0.009,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            TimeOfDay?
                                                                pickedTime =
                                                                await showTimePicker(
                                                              initialTime:
                                                                  TimeOfDay
                                                                      .now(),
                                                              context: context,
                                                            );

                                                            if (pickedTime !=
                                                                null) {
                                                              print(pickedTime
                                                                  .format(
                                                                      context)); //output 10:51 PM
                                                              DateTime parsedTime = DateFormat
                                                                      .jm()
                                                                  .parse(pickedTime
                                                                      .format(
                                                                          context)
                                                                      .toString()
                                                                      .replaceAll(
                                                                          'م',
                                                                          'PM')
                                                                      .replaceAll(
                                                                          'ص',
                                                                          'AM'));
                                                              // DateTime parsedTime = DateFormat
                                                              //         .jm()
                                                              //     .parse(pickedTime
                                                              //         .format(
                                                              //             context)
                                                              //         .toString());
                                                              //converting to DateTime so that we can further format on different pattern.
                                                              print(
                                                                  parsedTime); //output 1970-01-01 22:53:00.000
                                                              String
                                                                  formattedTime =
                                                                  DateFormat(
                                                                          'HH:mm')
                                                                      .format(
                                                                          parsedTime);
                                                              print(
                                                                  "=== new Time : $formattedTime"); //output 14:59:00
                                                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                              setState(() {
                                                                // update the time only
                                                                updateSchedule(
                                                                  uid: snapshots
                                                                      .data![
                                                                          index]
                                                                      .schedule_id,
                                                                  newDate: snapshots
                                                                      .data![
                                                                          index]
                                                                      .date,
                                                                  newTime:
                                                                      formattedTime,
                                                                  newInstructor:
                                                                      snapshots
                                                                          .data![
                                                                              index]
                                                                          .instructor,
                                                                );

                                                                futureSchedule =
                                                                    fetchSchedule();
                                                              });
                                                            } else {
                                                              print(
                                                                  "Time is not selected");
                                                            }
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/pen.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Text(snapshots.data![index].instructor),
                                                  // snapshots.data![index].instructor
                                                  Container(
                                                    width: width * 0.133,
                                                    child:
                                                    Text(
                                                      "${snapshots.data![index].instructor}",
                                                      //   DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString().replaceAll('م', 'PM').replaceAll('ص', 'AM'));

                                                      // - ${DateFormat.Hm(context.locale.toString()).format(DateFormat('HH:mm').parse(snapshot.data![index].event_end_time))}",

                                                      // "${snapshots.data![index].time}"
                                                      //     .tr(),
                                                      style: GoogleFonts
                                                          .barlow(
                                                        textStyle: TextStyle(
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

                                                  // Container(
                                                  //   width: width * 0.133,
                                                  //   child: DropdownButtonFormField(
                                                  //     decoration: InputDecoration.collapsed(hintText: ''),
                                                  //     style: GoogleFonts.barlow(
                                                  //       textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                  //     ),
                                                  //     // Initial Value
                                                  //     // Down Arrow Icon
                                                  //     icon: const Icon(Icons.keyboard_arrow_down),
                                                  //
                                                  //     items: categoryItemlist.map((item) {
                                                  //       return DropdownMenuItem(
                                                  //         value: item['name'].toString(),
                                                  //         child: Text(item['name'].toString()),
                                                  //       );
                                                  //     }).toList(),
                                                  //     onChanged: (newVal) {
                                                  //       setState(() {
                                                  //         dropdownvalue = newVal;
                                                  //       });
                                                  //     },
                                                  //     value: dropdownvalue,
                                                  //   ),
                                                  //
                                                  // ),
                                                  // Container(
                                                  //   width: width * 0.09,
                                                  //   child: Text(
                                                  //     "${snapshots.data![index].instructor}"
                                                  //         .tr(),
                                                  //     overflow:
                                                  //         TextOverflow.ellipsis,
                                                  //     style: GoogleFonts.barlow(
                                                  //       textStyle: TextStyle(
                                                  //           color: Color(
                                                  //               0xFF222222),
                                                  //           fontWeight:
                                                  //               FontWeight.w400,
                                                  //           fontStyle: FontStyle
                                                  //               .normal,
                                                  //           fontSize: 16),
                                                  //     ),
                                                  //   ),
                                                  // ),

                                                  SizedBox(
                                                    width: width * 0.045,
                                                  ),
                                                  Container(
                                                    width: width * 0.13,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: width * 0.09,
                                                          child: Text(
                                                            "${snapshots.data![index].subject}"
                                                                .tr(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .barlow(
                                                              textStyle: TextStyle(
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
                                                        SizedBox(
                                                          width: width * 0.009,
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              DeleteScheduleAttachment(
                                                                  snapshots
                                                                      .data![
                                                                          index]
                                                                      .schedule_id,
                                                                  snapshots
                                                                      .data![
                                                                          index]
                                                                      .subjectpath);
                                                              setState(() {
                                                                futureSchedule =
                                                                    fetchSchedule();
                                                              });
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/images/red_bin.svg",
                                                              color: Color(
                                                                  0xFFF64747),
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                            )),
                                                        SizedBox(
                                                          width: width * 0.006,
                                                        ),
                                                        InkWell(
                                                            onTap: () async {
                                                              final completer =
                                                                  Completer<
                                                                      void>();
                                                              var file;
                                                              final input =
                                                                  FileUploadInputElement();

                                                              input.click();
                                                              input.onChange
                                                                  .listen(
                                                                      (event) {
                                                                file = input
                                                                    .files!
                                                                    .first;
                                                                final reader =
                                                                    FileReader();
                                                                reader
                                                                    .readAsArrayBuffer(
                                                                        file);
                                                                reader.onLoadEnd
                                                                    .listen(
                                                                        (event) {
                                                                  final bytesData =
                                                                      reader.result
                                                                          as Uint8List;
                                                                  setState(() {
                                                                    _selectedFile =
                                                                        bytesData;
                                                                  });
                                                                  completer
                                                                      .complete();
                                                                });
                                                              });
                                                              await completer
                                                                  .future;

                                                              if (file!.size >
                                                                  10 *
                                                                      1024 *
                                                                      1024) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                            content:
                                                                                Text(
                                                                  "Please select a file less than 10MB size",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .red[
                                                                          600]),
                                                                )));
                                                              } else {
                                                                setState(() {
                                                                  addScheduleAttachment(
                                                                    uid: snapshots
                                                                        .data![
                                                                            index]
                                                                        .schedule_id,
                                                                    newDate: snapshots
                                                                        .data![
                                                                            index]
                                                                        .date,
                                                                    newDuration: snapshots
                                                                        .data![
                                                                            index]
                                                                        .duration,
                                                                    newInstructor: snapshots
                                                                        .data![
                                                                            index]
                                                                        .instructor,
                                                                    newLocation: snapshots
                                                                        .data![
                                                                            index]
                                                                        .location,
                                                                    newTime: snapshots
                                                                        .data![
                                                                            index]
                                                                        .time,
                                                                    newSubject:
                                                                        file.name,
                                                                  );

                                                                  futureSchedule =
                                                                      fetchSchedule();
                                                                });
                                                              }
                                                            },
                                                            hoverColor: Colors
                                                                .transparent,
                                                            child: const Icon(
                                                              Icons
                                                                  .add_circle_outline,
                                                              size: 18,
                                                              color: Color(
                                                                  0Xff222222),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  PopupMenuButton(
                                                    onSelected: (result) {
                                                      // your logic
                                                      if (result == 0) {
                                                        setState(() {
                                                          // futureSchedule =
                                                          //     fetchSchedule();

                                                          deleteRequestSchedule(
                                                              snapshots
                                                                  .data![index]
                                                                  .schedule_id,
                                                              snapshots
                                                                  .data![index]
                                                                  .subjectpath);

                                                          futureSchedule =
                                                              fetchSchedule();
                                                        });
                                                      } else if (result == 1) {
                                                        // onTap: () {
                                                        // Uri.parse(global.apiAddress + 'download')
                                                        // downloadmaterial(snapshots.data![index].file_name);
                                                        if (snapshots
                                                            .data![index]
                                                            .subjectpath
                                                            .isEmpty) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                                      content:
                                                                          Text(
                                                            "No file attached. Attach a file first.",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[600]),
                                                          )));
                                                        } else {
                                                          ht.window.open(
                                                              global.apiAddress +
                                                                  'download/${snapshots.data![index].subjectpath}',
                                                              "_self");
                                                        }

                                                        // },
                                                      }
                                                    },
                                                    itemBuilder:
                                                        (BuildContext bc) {
                                                      return [
                                                        PopupMenuItem(
                                                          value: 0,
                                                          child: Text(
                                                              "Delete".tr()),
                                                        ),
                                                        PopupMenuItem(
                                                            value: 1,
                                                            child: Text(
                                                                "Download"
                                                                    .tr()))
                                                      ];
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                    );
                                  }
                                } else {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No Schedule".tr(),
                                        style: GoogleFonts.barlow(
                                          textStyle: const TextStyle(
                                              color: Color(0xFF222222),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            // detailrow,
                            // detailrow1,
                            // detailrow2,
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.584,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    Locale? lang = Locale("en");
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0))),
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
                                              "Add Schedule".tr(),
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
                                      content: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Form(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Center(
                                                child: Text(
                                                  "Enter the details below to add new scheulde"
                                                      .tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF999999),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: height * 0.07),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: context.locale ==
                                                            Locale("en")
                                                        ? width * 0.04
                                                        : 0,
                                                    left: context.locale ==
                                                            Locale("en")
                                                        ? 0
                                                        : width * 0.04,
                                                    bottom: height * 0.01),
                                                child: Text(
                                                  "Date".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF999999),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: TextField(
                                                  maxLength: 15,
                                                  controller: myControllersdate,
                                                  decoration: InputDecoration(
                                                    prefixIcon: IconButton(
                                                      onPressed: () {
                                                        showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2001),
                                                          lastDate:
                                                              DateTime(2100),
                                                          builder:
                                                              (context, child) {
                                                            return Theme(
                                                              data: ThemeData(
                                                                //Header background color
                                                                primaryColor: Color(
                                                                    0xff007A33),
                                                                //Background color
                                                                scaffoldBackgroundColor:
                                                                    Colors
                                                                        .white,
                                                                //Divider color
                                                                dividerColor:
                                                                    Colors.grey,
                                                                //Non selected days of the month color
                                                                textTheme:
                                                                    TextTheme(
                                                                  bodyText2: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                colorScheme:
                                                                    ColorScheme
                                                                            .fromSwatch()
                                                                        .copyWith(
                                                                  //Selected dates background color
                                                                  primary: Color(
                                                                      0xff215732),
                                                                  //Month title and week days color
                                                                  onSurface:
                                                                      Colors
                                                                          .black,
                                                                  //Header elements and selected dates text color
                                                                  //onPrimary: Colors.white,
                                                                ),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  ConstrainedBox(
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      maxWidth:
                                                                          450.0,
                                                                      maxHeight:
                                                                          height *
                                                                              0.7,
                                                                    ),
                                                                    child:
                                                                        child,
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ).then((date) {
                                                          setState(() {
                                                            _dateTime1 = date!;
                                                            myControllersdate
                                                                    .text =
                                                                date
                                                                    .format(
                                                                        'M d Y')
                                                                    .toString();
                                                          });
                                                        });
                                                      },
                                                      icon: SvgPicture.asset(
                                                        "assets/images/calendar.svg",
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 1.5),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 1.5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: height * 0.02),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: context.locale ==
                                                            Locale("en")
                                                        ? width * 0.04
                                                        : 0,
                                                    left: context.locale ==
                                                            Locale("en")
                                                        ? 0
                                                        : width * 0.04,
                                                    bottom: height * 0.01),
                                                child: Text(
                                                  "Start Time".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF999999),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: TextField(
                                                  maxLength: 5,
                                                  controller: myControllerstime,
                                                  decoration: InputDecoration(
                                                    prefixIcon: IconButton(
                                                        onPressed: () async {
                                                          TimeOfDay?
                                                              pickedTime =
                                                              await showTimePicker(
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            context: context,
                                                          );

                                                          if (pickedTime !=
                                                              null) {
                                                            print(pickedTime.format(
                                                                context)); //output 10:51 PM
                                                            DateTime parsedTime = DateFormat
                                                                    .jm()
                                                                .parse(pickedTime
                                                                    .format(
                                                                        context)
                                                                    .toString()
                                                                    .replaceAll(
                                                                        'م',
                                                                        'PM')
                                                                    .replaceAll(
                                                                        'ص',
                                                                        'AM'));
                                                            //converting to DateTime so that we can further format on different pattern.
                                                            print(
                                                                parsedTime); //output 1970-01-01 22:53:00.000
                                                            String
                                                                formattedTime =
                                                                DateFormat(
                                                                        'HH:mm')
                                                                    .format(
                                                                        parsedTime);
                                                            print(
                                                                formattedTime); //output 14:59:00
                                                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                            setState(() {
                                                              myControllerstime
                                                                      .text =
                                                                  formattedTime; //set the value of text field.
                                                            });
                                                          } else {
                                                            print(
                                                                "Time is not selected");
                                                          }
                                                        },
                                                        // {

                                                        //   var selectedTime = showTimePicker(
                                                        //   initialTime: TimeOfDay.now(),
                                                        //   context: context,
                                                        //   builder: (context, child) {
                                                        //     return Theme(
                                                        //       data: ThemeData(
                                                        //         //Header background color
                                                        //         primaryColor: Color(0xff007A33),
                                                        //         //Background color
                                                        //         scaffoldBackgroundColor: Colors.white,
                                                        //         //Divider color
                                                        //         dividerColor: Colors.grey,
                                                        //         //Non selected days of the month color
                                                        //         textTheme: TextTheme(
                                                        //           bodyText2:
                                                        //           TextStyle(color: Colors.black),
                                                        //         ),colorScheme: ColorScheme.fromSwatch().copyWith(
                                                        //         //Selected dates background color
                                                        //         primary: Color(0xff215732),
                                                        //         //Month title and week days color
                                                        //         onSurface: Colors.black,
                                                        //         //Header elements and selected dates text color
                                                        //         //onPrimary: Colors.white,
                                                        //       ),),
                                                        //       child: Column(
                                                        //         children: [
                                                        //           ConstrainedBox(
                                                        //             constraints: BoxConstraints(
                                                        //
                                                        //             ),
                                                        //             child: child,
                                                        //           )
                                                        //         ],
                                                        //       ),
                                                        //     );
                                                        //
                                                        //   },
                                                        // );
                                                        // myControllerstime.text = selectedTime.toString();
                                                        // },
                                                        icon: Icon(
                                                            Icons.access_time,
                                                            size: 18,
                                                            color: Color(
                                                                0xFF999999))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 1.5),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 1.5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: height * 0.02),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: context.locale ==
                                                            Locale("en")
                                                        ? width * 0.04
                                                        : 0,
                                                    left: context.locale ==
                                                            Locale("en")
                                                        ? 0
                                                        : width * 0.04,
                                                    bottom: height * 0.01),
                                                child: Text(
                                                  "End Time".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF999999),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: TextField(
                                                  maxLength: 5,
                                                  controller:
                                                      myControllerduration,
                                                  decoration: InputDecoration(
                                                    prefixIcon: IconButton(
                                                        onPressed: () async {
                                                          TimeOfDay?
                                                              pickedTime =
                                                              await showTimePicker(
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            context: context,
                                                          );

                                                          if (pickedTime !=
                                                              null) {
                                                            print(pickedTime.format(
                                                                context)); //output 10:51 PM
                                                            DateTime parsedTime = DateFormat
                                                                    .jm()
                                                                .parse(pickedTime
                                                                    .format(
                                                                        context)
                                                                    .toString()
                                                                    .replaceAll(
                                                                        'م',
                                                                        'PM')
                                                                    .replaceAll(
                                                                        'ص',
                                                                        'AM'));
                                                            //converting to DateTime so that we can further format on different pattern.
                                                            print(
                                                                parsedTime); //output 1970-01-01 22:53:00.000
                                                            String
                                                                formattedTime =
                                                                DateFormat(
                                                                        'HH:mm')
                                                                    .format(
                                                                        parsedTime);
                                                            print(
                                                                formattedTime); //output 14:59:00
                                                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                            setState(() {
                                                              myControllerduration
                                                                      .text =
                                                                  formattedTime; //set the value of text field.
                                                            });
                                                          } else {
                                                            print(
                                                                "Time is not selected");
                                                          }
                                                        },
                                                        // {

                                                        //   var selectedTime = showTimePicker(
                                                        //   initialTime: TimeOfDay.now(),
                                                        //   context: context,
                                                        //   builder: (context, child) {
                                                        //     return Theme(
                                                        //       data: ThemeData(
                                                        //         //Header background color
                                                        //         primaryColor: Color(0xff007A33),
                                                        //         //Background color
                                                        //         scaffoldBackgroundColor: Colors.white,
                                                        //         //Divider color
                                                        //         dividerColor: Colors.grey,
                                                        //         //Non selected days of the month color
                                                        //         textTheme: TextTheme(
                                                        //           bodyText2:
                                                        //           TextStyle(color: Colors.black),
                                                        //         ),colorScheme: ColorScheme.fromSwatch().copyWith(
                                                        //         //Selected dates background color
                                                        //         primary: Color(0xff215732),
                                                        //         //Month title and week days color
                                                        //         onSurface: Colors.black,
                                                        //         //Header elements and selected dates text color
                                                        //         //onPrimary: Colors.white,
                                                        //       ),),
                                                        //       child: Column(
                                                        //         children: [
                                                        //           ConstrainedBox(
                                                        //             constraints: BoxConstraints(
                                                        //
                                                        //             ),
                                                        //             child: child,
                                                        //           )
                                                        //         ],
                                                        //       ),
                                                        //     );
                                                        //
                                                        //   },
                                                        // );
                                                        // myControllerstime.text = selectedTime.toString();
                                                        // },
                                                        icon: Icon(
                                                            Icons.access_time,
                                                            size: 18,
                                                            color: Color(
                                                                0xFF999999))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 0.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 0.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: height * 0.02),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: context.locale ==
                                                            Locale("en")
                                                        ? width * 0.04
                                                        : 0,
                                                    left: context.locale ==
                                                            Locale("en")
                                                        ? 0
                                                        : width * 0.04,
                                                    bottom: height * 0.01),
                                                child: Text(
                                                  "Location".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF999999),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: TextField(
                                                  maxLength: 20,
                                                  controller: myControllerloc,
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 0.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 0.0),
                                                    ),
                                                  ),
                                                ),

                                                // SizedBox(
                                                //   width: width * 0.25,
                                                //   height: height * 0.07,
                                                //   child: TextField(
                                                //     maxLength: 50,
                                                //     controller: myControllerloc,
                                                //     decoration: InputDecoration(
                                                //       focusedBorder: OutlineInputBorder(
                                                //         borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                //       ),
                                                //       enabledBorder: OutlineInputBorder(
                                                //         borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                              ),
                                              SizedBox(height: height * 0.02),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: context.locale ==
                                                            Locale("en")
                                                        ? width * 0.04
                                                        : 0,
                                                    left: context.locale ==
                                                            Locale("en")
                                                        ? 0
                                                        : width * 0.04,
                                                    bottom: height * 0.01),
                                                child: Text(
                                                  "Instructor".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF999999),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                    width: width * 0.3,
                                                    height: height * 0.05,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0xFFEEEEEE)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.5),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.015,
                                                          left: 8),
                                                      child: role,
                                                    )),
                                              ),
                                              SizedBox(height: height * 0.02),
                                              SizedBox(height: height * 0.02),
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width * 0.22,
                                                      height: height * 0.07,
                                                      child: TextField(
                                                        readOnly: true,
                                                        controller:
                                                            myControllerSubject,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: 'Subject'
                                                              .tr()
                                                              .toString(),
                                                          hintStyle: GoogleFonts
                                                              .barlow(
                                                            textStyle: TextStyle(
                                                                color: Color(
                                                                    0xFF999999),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize: 14),
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          3,
                                                                      horizontal:
                                                                          7),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFFEEEEEE),
                                                                width: 0.0),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFFEEEEEE),
                                                                width: 0.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.05,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          FileUploadInputElement
                                                              uploadInput =
                                                              FileUploadInputElement();

                                                          uploadInput.click();

                                                          uploadInput.onChange
                                                              .listen((e) {
                                                            // read file content as dataURL
                                                            final files =
                                                                uploadInput
                                                                    .files;
                                                            if (files?.length ==
                                                                1) {
                                                              final file =
                                                                  files?[0];
                                                              final reader =
                                                                  new FileReader();

                                                              reader.onLoadEnd
                                                                  .listen(
                                                                      (e) async {
                                                                print(e);
                                                                print(
                                                                    'loaded: ${file?.name}');
                                                                print(
                                                                    'type: ${reader.result.runtimeType}');
                                                                print(
                                                                    'file size = ${file?.size}');
                                                                if (file!.size >
                                                                    10 *
                                                                        1024 *
                                                                        1024) {
                                                                  myControllerSubject
                                                                      .clear();
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          SnackBar(
                                                                              content: Text(
                                                                    "Please select a photo less than 10MB size",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red[600]),
                                                                  )));
                                                                } else {
                                                                  await _handleResult(
                                                                      reader
                                                                          .result);
                                                                  print(
                                                                      "i reached here");
                                                                  myControllerSubject
                                                                          .text =
                                                                      file.name;
                                                                }
                                                              });
                                                              reader
                                                                  .readAsDataUrl(
                                                                      file!);
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          'Browse'
                                                              .tr()
                                                              .toString(),
                                                          strutStyle: StrutStyle(
                                                              forceStrutHeight:
                                                                  true),
                                                          style: GoogleFonts
                                                              .barlow(
                                                            textStyle: TextStyle(
                                                                color: Color(
                                                                    0xFF183028),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 0.0,
                                                          shadowColor: Colors
                                                              .transparent,
                                                          primary:
                                                              Color(0xFFF5F0E5),
                                                          onPrimary:
                                                              Color(0xFF183028),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: height * 0.03),
                                              Center(
                                                child: SizedBox(
                                                  width: width * 0.25,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          myControllerSubject
                                                              .clear();
                                                          myControllerduration
                                                              .clear();
                                                          myControllerloc
                                                              .clear();
                                                          myControllersdate
                                                              .clear();
                                                          myControllerstime
                                                              .clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 14,
                                                                  horizontal:
                                                                      50),
                                                          child: Text(
                                                            'Cancel'
                                                                .tr()
                                                                .toString(),
                                                            strutStyle: StrutStyle(
                                                                forceStrutHeight:
                                                                    true),
                                                            style: GoogleFonts
                                                                .barlow(
                                                              textStyle: TextStyle(
                                                                  color: Color(
                                                                      0xFF183028),
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
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 0.0,
                                                          shadowColor: Colors
                                                              .transparent,
                                                          primary:
                                                              Color(0xFFF5F0E5),
                                                          onPrimary:
                                                              Color(0xFF183028),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.014,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            submitForm();
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 14,
                                                                  horizontal:
                                                                      25),
                                                          child: Text(
                                                              'Confirm & add'
                                                                  .tr()
                                                                  .toString(),
                                                              strutStyle:
                                                                  StrutStyle(
                                                                      forceStrutHeight:
                                                                          true),
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFFFFFFFF),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        16),
                                                              )),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Color(0xFF215732),
                                                          elevation: 0.0,
                                                          shadowColor: Colors
                                                              .transparent,
                                                          onPrimary:
                                                              Color(0xFFFFFFFF),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: height * 0.02),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Color(0xFF999999), width: 1)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.15, vertical: 10.0),
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      size: 14,
                                      color: Color(0Xff999999),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1.15, vertical: 10.0),
                                    child: Text(
                                      "  Add new section  ".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0Xff999999),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.04),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.62,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              widget.onNext();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFFFFFFF),
                              backgroundColor: const Color(0xFF215732),
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 0.6),
                              child: Text(
                                'Next'.tr().toString(),
                                strutStyle:
                                    const StrutStyle(forceStrutHeight: true),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
