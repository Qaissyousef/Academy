import 'dart:convert';
import 'dart:html';
import 'package:pif_admin_dashboard/util/global.dart' as global;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:html' as ht;

import '../models/certificateModel.dart';

class certificate extends StatefulWidget {
  final String current_course_id;

  const certificate({Key? key, required this.current_course_id})
      : super(key: key);

  @override
  State<certificate> createState() => _certificateState();
}

class _certificateState extends State<certificate>
    with TickerProviderStateMixin {
  String dropdownvalue = 'participants';
  String dropdownvalue1 = 'instructor';

  // List of items in our dropdown menu
  var items = [
    'participants',
    'instructor',
    'admin',
  ];
  String s = '0';

  late List<int> _selectedFile;
  late Uint8List _bytesData;

  Future<List<certificateModel>> searchcertificate(String name) async {
    List<certificateModel> courses = [];
    List<certificateModel> results = [];
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAllCertificate/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        courses.add(certificateModel.fromMap(jsonDecode(response.body)[i]));
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
  bool isHighest = true;

  TextEditingController _searchController = TextEditingController();

  Future<List<certificateModel>> fetchcertificate(bool isHighest) async {
    List<certificateModel> events = [];
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAllCertificate/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        events.add(certificateModel.fromMap(jsonDecode(response.body)[i]));
      }
      if (isHighest == true) {
        print("no");

        events.sort((a, b) => b.percentage.compareTo(a.percentage));
      } else if (isHighest == false) {
        print("frr");
        events.sort((a, b) => a.percentage.compareTo(b.percentage));
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<String> fetchScheCount() async {
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetScheduleCount/' + widget.current_course_id));

    if (response.statusCode == 200) {
      print("Todays events body: ${response.body.toString()}");
      s = response.body.toString();
      return response.body.toString();
    } else {
      throw Exception('Failed to load album');
    }
  }


  Future<String> postRequest(int u) async {
//    await http.get(Uri.parse(global.apiAddress + 'GetAllCertificate/${widget.current_course_id}'));
    var url = Uri.parse(global.apiAddress + 'UpdateCertificate/${u}/${widget.current_course_id}');
    // var url = Uri.parse(
    //     "https://192.168.156.1:7040/api/PIF/UpdateCertificate");
    var request = new http.MultipartRequest("POST", url);

    request.files.add(await http.MultipartFile.fromBytes(
        'fileModel', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: 'hhh'));

    request.send().then((response) {
      print("i am hereee posting img cert");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");

      setState(() {
        futurecertificate = fetchcertificate(isHighest);
      });
    });
    return "finished";

    // Map data =
    // {
    //   "course_id": widget.current_course_id,
    //
    //   "duration": myControllerduration.text,
    //   "date": myControllersdate.text,
    //   "time": myControllerstime.text,
    //   "location": myControllerloc.text,
    //   "material": "string",
    //   "instructor": val
    // };
    //
    // //encode Map to JSON
    // var body = json.encode(data);
    // var response = await http.post(Uri.parse('https://192.168.156.1:7040/api/PIF/AddSchedule'),
    //
    //     headers: {
    //       'Content-Type': 'application/json',
    //       "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    //       "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
    //       "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    //       "Access-Control-Allow-Methods": "POST, OPTIONS"
    //     },
    //
    //     body: body
    // );
    // print("${response.statusCode}");
    // print("${response.body}");

    // setState(() {
    //   futureSchedule = fetchSchedule();
    // });
    //
    // return response;
  }

  void _handleResult(Object? result, int user_id) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
    postRequest(user_id);
  }

  Future<http.Response> deleteRequestCert(int uid) async {
    Map data = {
      "user_id": 0,
      "course_id": "string",
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
////    await http.get(Uri.parse(global.apiAddress + 'GetAllCertificate/${widget.current_course_id}'));
    var response = await http.post(
        Uri.parse(global.apiAddress + 'DeleteCertificate/${uid}/${widget.current_course_id}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    setState(() {
      futurecertificate = fetchcertificate(isHighest);
    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  late Future<List<certificateModel>> futurecertificate;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    futurecertificate = fetchcertificate(isHighest);

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
      child: TextField(
        onChanged: (value) {
          setState(() {
            futurecertificate = searchcertificate(value);
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
          contentPadding: EdgeInsets.only(top: 7),
          hintStyle: GoogleFonts.barlow(
              textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFF999999))),

          // enabledBorder: const OutlineInputBorder(
          //   // borderSide: const BorderSide(color: Color(0xFFEEEEEE),),
          // ),
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
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Percentage".tr(),
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
                                          });
                                          futurecertificate =
                                              fetchcertificate(isHighest);
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
                                width: width * 0.1,
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
                                            print("i reached heee");
                                          });
                                          futurecertificate =
                                              fetchcertificate(isHighest);
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


    final absent = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFFEEEEEE), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
        child: Row(
          children: [
            Text(
              "   Absent  ".tr(),
              style: GoogleFonts.barlow(
                textStyle: TextStyle(
                    color: Color(0xFFD80000),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
              ),
            ),
            SvgPicture.asset(
              "assets/images/close.svg",
              fit: BoxFit.scaleDown,
            ),
          ],
        ),
      ),
    );
    final num = SizedBox(
        child: ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("08       ".tr().toString(),
              strutStyle: StrutStyle(forceStrutHeight: true)),
          SizedBox(
            width: 25,
          ),
          Icon(
            Icons.expand_more_rounded,
            size: 18,
            color: Color(0xFF999999),
          )
        ],
      ),
      onPressed: () {
        print("You pressed Icon Elevated Button");
      },
      // icon: Icon(Icons.filter_list),
      //  //label text
      style: ElevatedButton.styleFrom(
          elevation: 0,
          side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // <-- Radius
          ),
          primary: Colors.white, //elevated btton background color
          onPrimary: Colors.black,
          minimumSize: Size(120, 50)),
    ));

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
                                    width: width * 0.013,
                                  ),
                                  Container(
                                    width: width * 0.06,
                                    child: Text(
                                      "   Picture".tr(),
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
                                      "Name".tr(),
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
                                    width: width * 0.1,
                                    child: Text(
                                      "Date".tr(),
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
                                    width: width * 0.12,
                                    child: Text(
                                      "Course Completion".tr(),
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
                                    width: width * 0.12,
                                    child: Text(
                                      "Survey Completion".tr(),
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
                            // d3,

                            FutureBuilder<List<certificateModel>>(
                              future: futurecertificate,
                              builder: (context, snapshots) {
                                if (snapshots.hasData) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshots.data!.length,
                                    itemBuilder: (_, index) => Container(
                                        child: Column(
                                      children: [
                                        Material(
                                          elevation: 1,
                                          color: Colors.white,
                                          child: Container(
                                            width: width * 0.92,
                                            height: height * 0.08,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: width * 0.0125,
                                                ),
                                                Container(
                                                  width: width *
                                                      0.06,
                                                  height: height*0.07,
                                                  child: Image.network(global.apiAddress + 'GetImage/${snapshots.data![index].user_img}',),
                                                ),
                                                Container(
                                                  width: width * 0.15,
                                                  child: Text(
                                                    "${snapshots.data![index].name}"
                                                        .tr(),
                                                    style: GoogleFonts.barlow(
                                                      textStyle: TextStyle(
                                                          color:
                                                              Color(0xFF222222),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.1,
                                                  child: Text(
                                                    "${snapshots.data![index].date} "
                                                        .tr(),
                                                    style: GoogleFonts.barlow(
                                                      textStyle: TextStyle(
                                                          color:
                                                              Color(0xFF222222),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                                FutureBuilder(
                                                    future: fetchScheCount(),
                                                    //${(snapshots.data![index].percentage/3*100).round()}
                                                    builder:
                                                        (context, snapshotc) {
                                                      if (snapshotc.hasData) {
                                                        return Row(
                                                          children: [
                                                            Container(
                                                              width: width * 0.10,
                                                              child: Text(
                                                                "${(snapshots.data![index].percentage / int.parse(s) * 100).round()} %"
                                                                    .tr(),
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
                                                                      fontSize:
                                                                      16),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: width * 0.02,
                                                            ),

                                                            Container(
                                                              width: snapshots.data![index]
                                                                  .img ==
                                                                  ''
                                                                  ? width * 0.11
                                                                  : width * 0.15,
                                                              child: Text(
                                                                "${snapshots.data![index].survey_completion} "
                                                                    .tr(),
                                                                style: GoogleFonts.barlow(
                                                                  textStyle: TextStyle(
                                                                      color:
                                                                      Color(0xFF222222),
                                                                      fontWeight:
                                                                      FontWeight.w400,
                                                                      fontStyle:
                                                                      FontStyle.normal,
                                                                      fontSize: 16),
                                                                ),
                                                              ),
                                                            ),

                                                            // Text("${snapshots.data![index].percentage / int.parse(s) * 100}"),
                                                            if (snapshots
                                                                .data![index].img ==
                                                                '') ...[
                                                              if ((snapshots.data![index].percentage / int.parse(s) * 100) ==
                                                                  100 &&
                                                                  snapshots.data![index]
                                                                      .survey_completion ==
                                                                      'Yes') ...[
                                                                InkWell(
                                                                  hoverColor:
                                                                  Colors.transparent,
                                                                  onTap: () {
                                                                    FileUploadInputElement
                                                                    uploadInput =
                                                                    FileUploadInputElement();

                                                                    uploadInput.click();

                                                                    uploadInput.onChange
                                                                        .listen((e) {
                                                                      // read file content as dataURL
                                                                      final files =
                                                                          uploadInput.files;
                                                                      if (files?.length ==
                                                                          1) {
                                                                        final file =
                                                                        files?[0];
                                                                        final reader =
                                                                        new FileReader();

                                                                        reader.onLoadEnd
                                                                            .listen((e) {
                                                                          print(e);
                                                                          print(
                                                                              'loaded: ${file?.name}');

                                                                          print(
                                                                              'type: ${reader.result.runtimeType}');
                                                                          print(
                                                                              'file size = ${file?.size}');
                                                                          _handleResult(
                                                                              reader
                                                                                  .result,snapshots.data![index].user_id);
                                                                          print(
                                                                              "i reached here");
                                                                        });
                                                                        reader
                                                                            .readAsDataUrl(
                                                                            file!);
                                                                      }
                                                                    });

                                                                    // postRequest ( 'png');
                                                                  },
                                                                  child: Container(
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(4),
                                                                      border: Border.all(
                                                                          color: Color(
                                                                              0xFFEEEEEE),
                                                                          width: 1),
                                                                    ),
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                          vertical: 8,
                                                                          horizontal:
                                                                          13),
                                                                      child: Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets
                                                                                .symmetric(
                                                                                horizontal:
                                                                                3.15,
                                                                                vertical:
                                                                                5.0),
                                                                            child: Icon(
                                                                              Icons
                                                                                  .add_circle_outline,
                                                                              size: 14,
                                                                              color: Color(
                                                                                  0Xff999999),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "  Upload certificate  "
                                                                                .tr(),
                                                                            style:
                                                                            GoogleFonts
                                                                                .barlow(
                                                                              textStyle: TextStyle(
                                                                                  color: Color(
                                                                                      0xFF215732),
                                                                                  fontWeight:
                                                                                  FontWeight
                                                                                      .w400,
                                                                                  fontStyle:
                                                                                  FontStyle
                                                                                      .normal,
                                                                                  fontSize:
                                                                                  16),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ] else ...[
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(4),
                                                                    border: Border.all(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width: 1),
                                                                  ),
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical: 8,
                                                                        horizontal: 13),
                                                                    child: Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal:
                                                                              3.15,
                                                                              vertical:
                                                                              5.0),
                                                                          child: Icon(
                                                                            Icons
                                                                                .add_circle_outline,
                                                                            size: 14,
                                                                            color: Color(
                                                                                0Xff999999),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "  Upload certificate  "
                                                                              .tr(),
                                                                          style: GoogleFonts
                                                                              .barlow(
                                                                            textStyle: TextStyle(
                                                                                color: Colors
                                                                                    .grey,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w400,
                                                                                fontStyle:
                                                                                FontStyle
                                                                                    .normal,
                                                                                fontSize:
                                                                                16),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                              // InkWell(
                                                              //   hoverColor: Colors.transparent,
                                                              //
                                                              //   onTap: (){
                                                              //     FileUploadInputElement uploadInput = FileUploadInputElement();
                                                              //
                                                              //     uploadInput.click();
                                                              //
                                                              //     uploadInput.onChange.listen((e) {
                                                              //       // read file content as dataURL
                                                              //       final files = uploadInput.files;
                                                              //       if (files?.length == 1) {
                                                              //         final file = files?[0];
                                                              //         final reader = new FileReader();
                                                              //
                                                              //         reader.onLoadEnd.listen((e)  {
                                                              //           print(e);
                                                              //           print('loaded: ${file?.name}');
                                                              //
                                                              //           print('type: ${reader.result.runtimeType}');
                                                              //           print('file size = ${file?.size}');
                                                              //           _handleResult(reader.result);
                                                              //           print("i reached here");
                                                              //
                                                              //         });
                                                              //         reader.readAsDataUrl(file!);
                                                              //
                                                              //       }
                                                              //     });
                                                              //
                                                              //     // postRequest ( 'png');
                                                              //
                                                              //
                                                              //   },
                                                              //   child: Container(
                                                              //     decoration: BoxDecoration(
                                                              //       borderRadius: BorderRadius.circular(4),
                                                              //       border: Border.all(color: Color(0xFFEEEEEE),width:1),
                                                              //
                                                              //     ),
                                                              //     child: Padding(
                                                              //       padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 13),
                                                              //       child: Row(
                                                              //         children: [
                                                              //           Padding(
                                                              //             padding: const EdgeInsets.symmetric(horizontal: 3.15,vertical: 5.0),
                                                              //             child:                                 Icon(Icons.add_circle_outline,size: 14,color: Color(0Xff999999),),
                                                              //
                                                              //           ),
                                                              //           Text("  Upload certificate  ".tr(),style: GoogleFonts.barlow(
                                                              //             textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                              //           ),),
                                                              //
                                                              //
                                                              //
                                                              //         ],
                                                              //       ),
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                            ] else ...[
                                                              InkWell(
                                                                hoverColor:
                                                                Colors.transparent,
                                                                onTap: () {
                                                                  FileUploadInputElement
                                                                  uploadInput =
                                                                  FileUploadInputElement();

                                                                  uploadInput.click();

                                                                  uploadInput.onChange
                                                                      .listen((e) {
                                                                    // read file content as dataURL
                                                                    final files =
                                                                        uploadInput.files;
                                                                    if (files?.length ==
                                                                        1) {
                                                                      final file =
                                                                      files?[0];
                                                                      final reader =
                                                                      new FileReader();

                                                                      reader.onLoadEnd
                                                                          .listen((e) {
                                                                        print(e);
                                                                        print(
                                                                            'loaded: ${file?.name}');
                                                                        print(
                                                                            'type: ${reader.result.runtimeType}');
                                                                        print(
                                                                            'file size = ${file?.size}');
                                                                        _handleResult(
                                                                            reader.result,snapshots.data![index].user_id);
                                                                        print(
                                                                            "i reached here");
                                                                      });
                                                                      reader.readAsDataUrl(
                                                                          file!);
                                                                    }
                                                                  });

                                                                  // postRequest ( 'png');
                                                                },
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(4),
                                                                    border: Border.all(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width: 1),
                                                                  ),
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical: 8,
                                                                        horizontal: 13),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "  Uploaded  "
                                                                              .tr(),
                                                                          style: GoogleFonts
                                                                              .barlow(
                                                                            textStyle: TextStyle(
                                                                                color: Color(
                                                                                    0xFF215732),
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w400,
                                                                                fontStyle:
                                                                                FontStyle
                                                                                    .normal,
                                                                                fontSize:
                                                                                16),
                                                                          ),
                                                                        ),
                                                                        SvgPicture.asset(
                                                                          "assets/images/approve.svg",
                                                                          fit: BoxFit
                                                                              .scaleDown,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ],
                                                        );
                                                      } else {
                                                        return Center(
                                                            child:
                                                            CircularProgressIndicator());
                                                      }
                                                    }),


                                                PopupMenuButton(
                                                  onSelected: (result) {
                                                    // your logic
                                                    if (result == 0) {
                                                      print("delete");

                                                      deleteRequestCert(
                                                          snapshots.data![index]
                                                              .user_id);
                                                      // deleteRequestMaterials(snapshots.data![index].material_id);
                                                      setState(() {
                                                        futurecertificate =
                                                            fetchcertificate(
                                                                isHighest);
                                                      });
                                                    } else if (result == 1) {
                                                      print("edit");

                                                      FileUploadInputElement
                                                          uploadInput =
                                                          FileUploadInputElement();

                                                      uploadInput.click();

                                                      uploadInput.onChange
                                                          .listen((e) {
                                                        // read file content as dataURL
                                                        final files =
                                                            uploadInput.files;
                                                        if (files?.length ==
                                                            1) {
                                                          final file =
                                                              files?[0];
                                                          final reader =
                                                              new FileReader();

                                                          reader.onLoadEnd
                                                              .listen((e) {
                                                            print(e);
                                                            print(
                                                                'loaded: ${file?.name}');
                                                            print(
                                                                'type: ${reader.result.runtimeType}');
                                                            print(
                                                                'file size = ${file?.size}');
                                                            _handleResult(
                                                                reader.result,snapshots.data![index].user_id);
                                                            print(
                                                                "i reached here");
                                                          });
                                                          reader.readAsDataUrl(
                                                              file!);
                                                          // myControllerSubject.text = file.name;

                                                        }
                                                      });

                                                      // deleteRequestMaterials(snapshots.data![index].material_id);
                                                      setState(() {
                                                        futurecertificate =
                                                            fetchcertificate(
                                                                isHighest);
                                                      });
                                                    } else if (result == 2) {
                                                      print("Download");

                                                      if ((snapshots
                                                              .data![index]
                                                              .img !=
                                                          '')) {
                                                        // await http.get(Uri.parse(global.apiAddress + 'GetAllCertificate/${widget.current_course_id}'));

                                                        ht.window.open(
                                                            global.apiAddress +
                                                                'downloadc/${snapshots.data![index].img}',
                                                            "_self");
                                                      } else {
                                                        print('no image');
                                                      }
                                                    }
                                                  },
                                                  itemBuilder:
                                                      (BuildContext bc) {
                                                    return const [
                                                      PopupMenuItem(
                                                        child: Text("Delete"),
                                                        value: 0,
                                                      ),
                                                      PopupMenuItem(
                                                        child: Text("Edit"),
                                                        value: 1,
                                                      ),
                                                      PopupMenuItem(
                                                        child: Text("Download"),
                                                        value: 2,
                                                      ),
                                                    ];
                                                  },
                                                ),

                                                // Container(
                                                //
                                                //   decoration: BoxDecoration(
                                                //       borderRadius: BorderRadius.circular(12),
                                                //       border: Border.all(color: Color(0xFF999999),width: 1)
                                                //   ),
                                                //   child: Row(
                                                //     children: [
                                                //       Padding(
                                                //         padding: const EdgeInsets.symmetric(horizontal: 3.15,vertical: 10.0),
                                                //         child:                                 Icon(Icons.add_circle_outline,size: 14,color: Color(0Xff999999),),
                                                //
                                                //       ),
                                                //
                                                //       Padding(
                                                //         padding: const EdgeInsets.symmetric(horizontal: 1.15,vertical: 10.0),
                                                //
                                                //         child:  Text("  Upload certificate  ".tr(),style: GoogleFonts.barlow(
                                                //           textStyle: TextStyle(color: Color(0Xff222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                //         ),),
                                                //       ),
                                                //
                                                //     ],
                                                //   ),
                                                // )
                                                // SizedBox(width: width*0.02,),
                                                // absent
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                  );
                                } else {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No Certificate".tr(),
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
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.1),

                      // Row(
                      //   children: [
                      //
                      //
                      //
                      //     num,
                      //     SizedBox(width: width*0.007,),
                      //     Text("Showing 6 of 6 results",style: GoogleFonts.barlow(
                      //       textStyle: TextStyle(color: Color(0Xff999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                      //     ),),
                      //   ],
                      // ),
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
