import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;

import '../models/attendwebModel.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;

class attendance extends StatefulWidget {
  final String current_course_id;
  final int Function() onNext;

  const attendance(
      {Key? key, required this.current_course_id, required this.onNext})
      : super(key: key);

  @override
  State<attendance> createState() => _attendanceState();
}

class _attendanceState extends State<attendance> {
  final _dateTime = DateTime.parse("2022-10-01 00:00:00.000");
  String dropdownvalue = 'participants';
  String dropdownvalue1 = 'instructor';

  String s = '0';
  // List of items in our dropdown menu
  var items = [
    'participants',
    'instructor',
    'admin',
  ];

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
  // Future<List<attendwebModel>> filterEventPost( bool isHighest) async {
  //   List<attendwebModel> events = [];
  //   List<attendwebModel> results = [];
  //   final response =  await http.get(Uri.parse(global.apiAddress + 'GetAllAttend/${widget.current_course_id}'));
  //
  //
  //   if (response.statusCode == 200) {
  //     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
  //     var list = json.decode(response.body);
  //     for (int i = 0; i < list.length; i++) {
  //       events.add(attendwebModel.fromMap(jsonDecode(response.body)[i]));
  //     }
  //
  //     events.sort((a, b) => b.percentage.compareTo(a.percentage));
  //
  //     // if (isHighest) {
  //     //   events.sort((a, b) => b.percentage.compareTo(a.percentage));
  //     // } else {
  //     //   events.sort((a, b) => a.percentage.compareTo(b.percentage));
  //     // }
  //
  //
  //
  //
  //     if (events.isEmpty) {
  //       hasData = false;
  //     } else {
  //       hasData = true;
  //     }
  //
  //     return events;
  //
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future<List<attendwebModel>> fetchatt(bool isHighest) async {
    List<attendwebModel> events = [];
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAllAttend/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        events.add(attendwebModel.fromMap(jsonDecode(response.body)[i]));
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

  Future<http.Response> updateInfo (int uid) async {


    Map data = {
      "ann_id": 0,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse('https://piftestwebapi3.azurewebsites.net/api/PIF/Updateattend/${widget.current_course_id}/${uid}'),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    print("${response.statusCode}");
    print(response.body);
    setState(() {  futureatt = fetchatt(isHighest); });


    return response;
  }

  Future<http.Response> updateInfoAbsence (int uid) async {


    Map data = {
      "ann_id": 0,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse('https://piftestwebapi3.azurewebsites.net/api/PIF/Updateabsence/${widget.current_course_id}/${uid}'),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    print("${response.statusCode}");
    print(response.body);
    setState(() {  futureatt = fetchatt(isHighest); });


    return response;
  }


  Future<List<attendwebModel>> searchAttendance(String name) async {
    List<attendwebModel> courses = [];
    List<attendwebModel> results = [];
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAllAttend/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        courses.add(attendwebModel.fromMap(jsonDecode(response.body)[i]));
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

  final TextEditingController _searchController = TextEditingController();

  late Future<List<attendwebModel>> futureatt;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    futureatt = fetchatt(isHighest);

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
          border: Border.all(color: const Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(4)),
      child: TextField(
        onChanged: (value) {
          setState(() {
            futureatt = searchAttendance(value);
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
          contentPadding: const EdgeInsets.only(top: 7),
          hintStyle: GoogleFonts.barlow(
              textStyle: const TextStyle(
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
                                width: width * 0.14,
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
                                          futureatt = fetchatt(isHighest);
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
                                width: width * 0.14,
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
                                          futureatt = fetchatt(isHighest);
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

    final present = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
        child: Row(
          children: [
            Text(
              "  Present  ".tr(),
              style: GoogleFonts.barlow(
                textStyle: const TextStyle(
                    color: Color(0xFF215732),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
              ),
            ),
            SvgPicture.asset(
              "assets/images/approve.svg",
              fit: BoxFit.scaleDown,
            ),
          ],
        ),
      ),
    );

    final absent = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
        child: Row(
          children: [
            Text(
              "   Absent  ".tr(),
              style: GoogleFonts.barlow(
                textStyle: const TextStyle(
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
              strutStyle: const StrutStyle(forceStrutHeight: true)),
          const SizedBox(
            width: 25,
          ),
          const Icon(
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
          side: const BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // <-- Radius
          ),
          primary: Colors.white, //elevated btton background color
          onPrimary: Colors.black,
          minimumSize: const Size(120, 50)),
    ));
    final collect = ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,

                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Icon(Icons.open_in_new),
                              // SizedBox(width: 25,),
                              // Icon(Icons.open_in_full_sharp),
                              // SizedBox(width: 25,),
                              InkWell(
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.close)),
                            ],
                          )),
                    ),
                  ],
                ),
                content: Row(
                  children: [
                    Container(
                      width: 400,
                      color: Colors.blue,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container(
                              //   height: 20,
                              //   color: Colors.blue,
                              // ),
                              Text(
                                DateTime.now().toString().tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 24),
                                ),
                              ),

                              Center(
                                child: SizedBox(
                                  height: 300,
                                  width: 250,
                                  child: QrImageView(
                                    data: widget.current_course_id,
                                    version: QrVersions.auto,
                                    size: 150.0,
                                  ),
                                ),
                              ),


                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Please register your attendance using this QR code"
                                    .tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 24),
                                ),
                              ),
                              Container(
                                height: 60,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        )),
                    Container(
                      width: 400,
                      color: Colors.blue,
                    ),
                  ],
                ),
              );
              // return SimpleDialog(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20.0),
              //   ),
              //   children: [
              //     SizedBox(
              //       height: 100,
              //       width: 200,
              //       child: QrImage(
              //         data: "1234567890",
              //         version: QrVersions.auto,
              //         size: 50.0,
              //       ),
              //     ),
              //   ],
              // );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0.6),
        child: Text('  Collect attendance  '.tr().toString(),
            strutStyle: const StrutStyle(forceStrutHeight: true),
            style: GoogleFonts.barlow(
              textStyle: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 16),
            )),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        primary: const Color(0xFF215732),
        onPrimary: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );

    final d1 = Material(
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
              width: width * 0.06,
              child: Image.asset("assets/images/p1.png", scale: 4),
            ),
            Container(
              width: width * 0.15,
              child: Text(
                "Saad Alkroud".tr(),
                style: GoogleFonts.barlow(
                  textStyle: const TextStyle(
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                ),
              ),
            ),
            Container(
              width: width * 0.1,
              child: Text(
                "May 11, 2022".tr(),
                style: GoogleFonts.barlow(
                  textStyle: const TextStyle(
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                ),
              ),
            ),
            Container(
              width: width * 0.07,
              child: DropdownButtonFormField(
                decoration: const InputDecoration.collapsed(hintText: ''),
                style: GoogleFonts.barlow(
                  textStyle: const TextStyle(
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                ),
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(
                  Icons.expand_more_rounded,
                  size: 18,
                  color: Color(0Xff999999),
                ),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            // Container(
            //
            //   width: width*0.09,
            //   child: Row(
            //     children: [
            //       Text("Student".tr(),style: GoogleFonts.barlow(
            //         textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //       ),),
            //       Icon(Icons.expand_more_rounded,size: 18,color: Color(0xFF999999),)
            //     ],
            //   ),
            // ),
            Container(
              width: width * 0.12,
              child: Text(
                "85%".tr(),
                style: GoogleFonts.barlow(
                  textStyle: const TextStyle(
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                ),
              ),
            ),
            present,
            SizedBox(
              width: width * 0.02,
            ),
            absent
          ],
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
                                searchtab,
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                sortbtn,
                              ],
                            ),
                          ),
                          collect
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
                              decoration: const BoxDecoration(
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
                                        textStyle: const TextStyle(
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
                                        textStyle: const TextStyle(
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
                                        textStyle: const TextStyle(
                                            color: Color(0xFFBD9B60),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.09,
                                    child: Text(
                                      "Account type".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: const TextStyle(
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
                                      "Percentage".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: const TextStyle(
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

                            FutureBuilder<List<attendwebModel>>(
                              future: futureatt,
                              builder: (context, snapshots) {
                                if (snapshots.hasData) {
                                  if (!hasData) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Students not recorded".tr(),
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
                                      physics: const NeverScrollableScrollPhysics(),
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
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // SizedBox(
                                                  //   width: width * 0.0125,
                                                  // ),
                                                  Row(
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
                                                          snapshots.data![index].name
                                                              .tr(),
                                                          style: GoogleFonts.barlow(
                                                            textStyle: const TextStyle(
                                                                color: Color(
                                                                    0xFF222222),
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontStyle: FontStyle
                                                                    .normal,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: width * 0.1,
                                                        child: Text(
                                                            snapshots.data![index].date,
                                                          // "${DateFormat.Hm(context.locale.toString()).format(DateFormat('HH:mm').parse((snapshots.data![index].date)))}",
                                                          // (snapshots.data![index].date == '') ? "N/A" :  DateFormat.yMMMMd(context.locale.toString()).add_jm().format(DateFormat('MMM d yyyy  h:mma').parse(snapshots.data![index].date)) ,
                                                          //DateFormat.yMMMMd(context.locale.toString()).add_jm().format(DateFormat('MMM d yyyy  h:mma').parse(snapshots.data![index].date))2
                                                          //DateFormat.yMMMMd(context.locale.toString()).add_jm().format(DateFormat('MMM d yyyy  h:mma').parse(snapshots.data![index].date))2


                                                          // "${snapshots.data![index].date} "
                                                          //     .tr(),
                                                          style: GoogleFonts.barlow(
                                                            textStyle: const TextStyle(
                                                                color: Color(
                                                                    0xFF222222),
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontStyle: FontStyle
                                                                    .normal,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: width * 0.07,
                                                        child: Text(
                                                          snapshots.data![index].user_type
                                                              .tr(),
                                                          style: GoogleFonts.barlow(
                                                            textStyle: const TextStyle(
                                                                color: Color(
                                                                    0xFF222222),
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontStyle: FontStyle
                                                                    .normal,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.02,
                                                      ),
                                                    ],
                                                  ),
                                                  // Container(
                                                  //
                                                  //   width: width*0.09,
                                                  //   child: Row(
                                                  //     children: [
                                                  //       Text("Student".tr(),style: GoogleFonts.barlow(
                                                  //         textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                  //       ),),
                                                  //       Icon(Icons.expand_more_rounded,size: 18,color: Color(0xFF999999),)
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                  FutureBuilder(
                                                      future: fetchScheCount(),
                                                      //${(snapshots.data![index].percentage/3*100).round()}
                                                      builder:
                                                          (context, snapshotc) {
                                                        if (snapshotc.hasData) {
                                                          return Container(
                                                            width: width * 0.12,
                                                            child: Text(
                                                              "${(snapshots.data![index].percentage / int.parse(s) * 100).round()} %"
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
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }
                                                      }),
                                                  // Text("${snapshots.data![index].date.characters.take(11)}"),
                                                  if(snapshots.data![index].date == '')...[

                                                    absent,
                                                    PopupMenuButton(
                                                      onSelected: (result) {
                                                        // your logic
                                                        if (result == 0) {
                                                          print("delete");

                                                          updateInfo(snapshots.data![index].user_id);
                                                        } else if (result == 1) {

                                                        }
                                                      },
                                                      itemBuilder: (BuildContext bc) {
                                                        return const [
                                                          PopupMenuItem(
                                                            child: Text("Present"),
                                                            value: 0,
                                                          ),

                                                        ];
                                                      },
                                                    ),

                                                  ]
                                                  else...[
                                                    present,
                                                    PopupMenuButton(
                                                      onSelected: (result) {
                                                        // your logic
                                                        if (result == 0) {
                                                          print("here");
                                                          updateInfoAbsence(snapshots.data![index].user_id);



                                                        } else if (result == 1) {

                                                        }
                                                      },
                                                      itemBuilder: (BuildContext bc) {
                                                        return const [
                                                          PopupMenuItem(
                                                            child: Text("Absent"),
                                                            value: 0,
                                                          ),

                                                        ];
                                                      },
                                                    ),

                                                  ],

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
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Student not recorded".tr(),
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

                                // if (snapshots.hasData) {
                                //   return ListView.builder(
                                //     physics: NeverScrollableScrollPhysics(),
                                //     shrinkWrap:true,
                                //     itemCount: snapshots.data!.length,
                                //
                                //     itemBuilder: (_, index) => Container(
                                //
                                //         child: Column(
                                //           children :[
                                //
                                //
                                //             Material(
                                //               elevation: 1,
                                //               color: Colors.white,
                                //               child: Container(
                                //                 width: width*0.92,
                                //                 height: height*0.08,
                                //
                                //                 child: Row(
                                //
                                //                   children: [
                                //                     SizedBox(width: width*0.0125,),
                                //                     Container(
                                //                       width: width*0.06,
                                //                       child:    Image.asset("assets/images/f1.png",scale:4),
                                //                     ),
                                //                     Container(
                                //                       width: width*0.15,
                                //
                                //                       child: Text("${snapshots.data![index].name}".tr(),style: GoogleFonts.barlow(
                                //                         textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                //                       ),),
                                //                     ),
                                //                     Container(
                                //                       width: width*0.1,
                                //
                                //
                                //                       child: Text("${snapshots.data![index].date} ".tr(),style: GoogleFonts.barlow(
                                //                         textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                //                       ),),
                                //                     ),
                                //                     Container(
                                //                       width: width*0.07,
                                //
                                //                       child: Text("${snapshots.data![index].user_type}".tr(),style: GoogleFonts.barlow(
                                //                         textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                //                       ),),
                                //
                                //                     ),
                                //                     SizedBox(width: width*0.02,),
                                //                     // Container(
                                //                     //
                                //                     //   width: width*0.09,
                                //                     //   child: Row(
                                //                     //     children: [
                                //                     //       Text("Student".tr(),style: GoogleFonts.barlow(
                                //                     //         textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                //                     //       ),),
                                //                     //       Icon(Icons.expand_more_rounded,size: 18,color: Color(0xFF999999),)
                                //                     //     ],
                                //                     //   ),
                                //                     // ),
                                //                     Container(
                                //                       width: width*0.12,
                                //                       child:  Text("${(snapshots.data![index].percentage/3*100).round()} %".tr(),style: GoogleFonts.barlow(
                                //                         textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                //                       ),),
                                //                     ),
                                //                     present,
                                //                     SizedBox(width: width*0.02,),
                                //                     absent
                                //
                                //
                                //
                                //
                                //
                                //
                                //                   ],
                                //                 ),
                                //               ),
                                //             )
                                //
                                //
                                //
                                //
                                //
                                //           ],
                                //         )
                                //     ),
                                //   );
                                // } else {
                                //   return Center(
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Text(
                                //         "No Attendance".tr(),
                                //         style: GoogleFonts.barlow(
                                //           textStyle: const TextStyle(
                                //               color: Color(0xFF222222),
                                //               fontWeight: FontWeight.w400,
                                //               fontStyle: FontStyle.normal,
                                //               fontSize: 16),
                                //         ),
                                //       ),
                                //     ),
                                //   );
                                // }
                              },
                            ),

                            SizedBox(height: height * 0.04),
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
