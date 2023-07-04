import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:html' as ht;
import '../models/MaterialCourse.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/util/fieldValidator.dart' as validator;

import 'package:url_launcher/url_launcher.dart';

class forums extends StatefulWidget {
  final String current_course_id;
  final int Function() onNext;

  const forums(
      {Key? key, required this.current_course_id, required this.onNext})
      : super(key: key);

  @override
  State<forums> createState() => _forumsState();
}

class _forumsState extends State<forums> {
  var _dateTime = DateTime.parse("2022-10-01 00:00:00.000");

  final myControllerSubject = TextEditingController();
  final myControllerTitle = TextEditingController();
  final myControllerAuthor = TextEditingController();

  late ScrollController _scrollController;

  late List<int> _selectedFile;
  late Uint8List _bytesData;

  void _handleResult(Object? result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  Future<String> makeRequest() async {
    var url = Uri.parse(global.apiAddress + "AddFile");
    var request = new http.MultipartRequest("POST", url);
    request.fields['material_id'] = 'blah';
    request.fields['title'] = myControllerTitle.text;
    request.fields['author'] = "ddd";
    request.fields['file_name'] = 'blah';
    request.fields['subject'] = myControllerSubject.text;

    request.fields['course_id'] = widget.current_course_id.toString();
    request.fields['time'] = '2022-11-26 14:15:00.057';

    request.files.add(await http.MultipartFile.fromBytes(
        'fileModel', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: 'hhh'));

    request.send().then((response) {
      print("i am hereee makerequest");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");

      setState(() {
        futureMaterial = fetchMaterial(isAscending);
      });
    });
    return "finished";
  }

  void submitForm() {
    String errorText = "";

    errorText += validator.isValid("title", myControllerTitle.text, "empty");
    errorText +=
        validator.isValid("subject", myControllerSubject.text, "empty");

    if (errorText != "") {
      validator.alertDialog(
          context, errorText.substring(0, errorText.length - 1));
      return;
    }
    makeRequest();
    Navigator.pop(context);
    myControllerTitle.clear();
    myControllerSubject.clear();
  }

  //downloadmaterial
  // void downloadmaterial(filepath) async {
  //   final response = await http.get(Uri.parse(global.apiAddress + 'download'));
  // }

  Future<void> downloadmaterial(filepath) async {
    final Uri _url = Uri.parse(global.apiAddress + 'download');
    if (!await launchUrl(_url)) {
      throw 'Could not launch https://192.168.156.1:7040/api/PIF/download';
    }
  }

  late Future<List<MaterialsModel>> futureMaterial;

  Future<http.Response> deleteRequestMaterials(String uid) async {
    Map data = {
      "material_id": uid,
      "title": "string",
      "time": "string",
      "author": "string",
      "file_name": "string",
      "course_id": "string"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'DeleteMat'),
        headers: {"Content-Type": "application/json"}, body: body);
    setState(() {
      futureMaterial = fetchMaterial(isAscending);
    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<List<MaterialsModel>> searchMaterials(String name) async {
    List<MaterialsModel> courses = [];
    List<MaterialsModel> results = [];
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetMaterial/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        courses.add(MaterialsModel.fromMap(jsonDecode(response.body)[i]));
      }

      if (name.isNotEmpty) {
        courses.forEach((element) {
          if (element.title.toLowerCase().contains(name.toLowerCase())) {
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

  Future<List<MaterialsModel>> fetchMaterial(bool isAscending) async {
    List<MaterialsModel> events = [];
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetMaterial/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        events.add(MaterialsModel.fromMap(jsonDecode(response.body)[i]));
      }
      // events.sort((a, b) => DateFormat('yMd')
      //     .parse(a.time)
      //     .compareTo(DateFormat('yMd').parse(b.time)));

      // if (isAscending) {
      //   events.sort((a, b) => DateFormat('yMd')
      //       .parse(a.time)
      //       .compareTo(DateFormat('yMd').parse(b.time)));
      // } else {
      //   events.sort((a, b) => DateFormat('yMd')
      //       .parse(b.time)
      //       .compareTo(DateFormat('yMd').parse(a.time)));
      // }

      var now = new DateTime.now();
      var now_1w = now.subtract(const Duration(days: 7));
      var now_1m = now.subtract(const Duration(days: 30));

      // if (events.isEmpty) {
      //   hasData = false;
      // } else {
      //   hasData = true;
      // }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }

  bool hasData = true;
  bool isAscending = true;

  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    futureMaterial = fetchMaterial(isAscending);
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
            futureMaterial = searchMaterials(value);
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
                                "Date".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
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
                                            isAscending = false;
                                          });
                                          futureMaterial =
                                              fetchMaterial(isAscending);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Newest to Oldest".tr(),
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
                                            isAscending = true;
                                          });
                                          futureMaterial =
                                              fetchMaterial(isAscending);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Oldest to Newest".tr(),
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

    final detailrow = Material(
      elevation: 1,
      child: Container(
        color: Color(0xffEEEEEE),
        height: height * 0.05,
        child: Row(
          children: [
            SizedBox(
              width: width * 0.0125,
            ),
            Row(
              children: [
                Container(
                  width: width * 0.17,
                  child: Text(
                    "Data analytics part 1".tr(),
                    style: GoogleFonts.barlow(
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
            Container(
              width: width * 0.15,
              child: Text(
                "16/06/22   3:25 PM".tr(),
                style: GoogleFonts.barlow(
                  textStyle: TextStyle(
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                ),
              ),
            ),
            Container(
              width: width * 0.18,
              child: Row(
                children: [
                  Text(
                    "course subject 1".tr(),
                    style: GoogleFonts.barlow(
                      textStyle: TextStyle(
                          color: Color(0xFF222222),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.006,
                  ),
                  Icon(
                    Icons.expand_more_rounded,
                    size: 18,
                    color: Color(0Xff999999),
                  ),
                ],
              ),
            ),
            Container(
              width: width * 0.165,
              child: Text(
                "Mohammad Abdulrahman".tr(),
                style: GoogleFonts.barlow(
                  textStyle: TextStyle(
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                ),
              ),
            ),
            Icon(
              Icons.more_vert_outlined,
              size: 18,
              color: Color(0Xff999999),
            ),
            SizedBox(
              width: width * 0.01,
            )
          ],
        ),
      ),
    );
    final detailrow1 = Container(
      color: Colors.white,
      height: height * 0.05,
      child: Row(
        children: [
          SizedBox(
            width: width * 0.0125,
          ),
          Row(
            children: [
              Container(
                width: width * 0.17,
                child: Text(
                  "Data analytics part 1".tr(),
                  style: GoogleFonts.barlow(
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
          Container(
            width: width * 0.15,
            child: Text(
              "16/06/22   3:25 PM".tr(),
              style: GoogleFonts.barlow(
                textStyle: TextStyle(
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
              ),
            ),
          ),
          Container(
            width: width * 0.18,
            child: Row(
              children: [
                Text(
                  "course subject 1".tr(),
                  style: GoogleFonts.barlow(
                    textStyle: TextStyle(
                        color: Color(0xFF222222),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: width * 0.006,
                ),
                Icon(
                  Icons.expand_more_rounded,
                  size: 18,
                  color: Color(0Xff999999),
                ),
              ],
            ),
          ),
          Container(
            width: width * 0.165,
            child: Text(
              "Mohammad Abdulrahman".tr(),
              style: GoogleFonts.barlow(
                textStyle: TextStyle(
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
              ),
            ),
          ),
          Icon(
            Icons.more_vert_outlined,
            size: 18,
            color: Color(0Xff999999),
          ),
          SizedBox(
            width: width * 0.01,
          )
        ],
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
                        children: [
                          SizedBox(
                            width: width * 0.004,
                          ),
                          searchtab,
                          SizedBox(
                            width: width * 0.005,
                          ),
                          sortbtn,
                        ],
                      ),
                      SizedBox(height: height * 0.035),
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
                                    width: width * 0.0125,
                                  ),
                                  Container(
                                    width: width * 0.17,
                                    child: Text(
                                      "Title".tr(),
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
                                      "Upload time".tr(),
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
                                      "Type".tr(),
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
                                      "Author".tr(),
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
                            FutureBuilder<List<MaterialsModel>>(
                              future: futureMaterial,
                              builder: (context, snapshots) {
                                if (snapshots.hasData) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshots.data!.length,
                                    itemBuilder: (_, index) => Container(
                                        child: Column(
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          height: height * 0.05,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width * 0.0125,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: width * 0.17,
                                                    child: Text(
                                                      "${snapshots.data![index].title}"
                                                          .tr(),
                                                      style: GoogleFonts.barlow(
                                                        textStyle: TextStyle(
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
                                                ],
                                              ),
                                              Container(
                                                width: width * 0.15,
                                                child: Text(
                                                  //'MMM dd yyyy'
                                                  DateFormat.yMMMMd(context
                                                          .locale
                                                          .toString())
                                                      .format(DateFormat(
                                                              'd/MM/yyyy')
                                                          .parse(snapshots
                                                              .data![index]
                                                              .time)),

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
                                                width: width * 0.18,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "course subject 1".tr(),
                                                      style: GoogleFonts.barlow(
                                                        textStyle: TextStyle(
                                                            color: Color(
                                                                0xFF222222),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.165,
                                                child: Text(
                                                  "Mohammad Alsugair".tr(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              PopupMenuButton(
                                                onSelected: (result) {
                                                  // your logic
                                                  if (result == 0) {
                                                    print("delete");

                                                    deleteRequestMaterials(
                                                        snapshots.data![index]
                                                            .material_id);
                                                    setState(() {
                                                      futureMaterial =
                                                          fetchMaterial(
                                                              isAscending);
                                                    });
                                                  } else if (result == 1) {
                                                    ht.window.open(
                                                        global.apiAddress +
                                                            'download/${snapshots.data![index].file_name}',
                                                        "_self");
                                                  }
                                                },
                                                itemBuilder: (BuildContext bc) {
                                                  return const [
                                                    PopupMenuItem(
                                                      child: Text("Delete"),
                                                      value: 0,
                                                    ),
                                                    PopupMenuItem(
                                                      child: Text("Download"),
                                                      value: 1,
                                                    )
                                                  ];
                                                },
                                              ),
                                              SizedBox(
                                                width: width * 0.001,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    )),
                                  );
                                } else {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No Materials".tr(),
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
                            SizedBox(height: height * 0.04),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.616,
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
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            Icon(Icons.close))),
                                                Center(
                                                  child: Text(
                                                    "Upload".tr(),
                                                    style: GoogleFonts.barlow(
                                                      textStyle: TextStyle(
                                                          color:
                                                              Color(0xFF222222),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FontStyle.normal,
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
                                                        "Browse to upload the files"
                                                            .tr(),
                                                        style:
                                                            GoogleFonts.barlow(
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
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.07),
                                                    // Padding(
                                                    //   padding:
                                                    //   EdgeInsets.only( right:context.locale == Locale("en") ?width*0.04: 0,left:  context.locale == Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                                    //   child: Text("Title".tr(),style: GoogleFonts.barlow(
                                                    //     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                    //   ),),
                                                    // ),
                                                    Center(
                                                      child: SizedBox(
                                                        width: width * 0.3,
                                                        height: height * 0.07,
                                                        child: TextField(
                                                          maxLength: 50,
                                                          controller:
                                                              myControllerTitle,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: 'Title',
                                                            hintStyle:
                                                                GoogleFonts
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
                                                    ),

                                                    SizedBox(
                                                        height: height * 0.02),

                                                    Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: width * 0.22,
                                                            height:
                                                                height * 0.07,
                                                            child: TextField(
                                                              readOnly: true,
                                                              controller:
                                                                  myControllerSubject,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Subject',
                                                                hintStyle:
                                                                    GoogleFonts
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
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            3,
                                                                        horizontal:
                                                                            7),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0xFFEEEEEE),
                                                                      width:
                                                                          0.0),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0xFFEEEEEE),
                                                                      width:
                                                                          0.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * 0.05,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                FileUploadInputElement
                                                                    uploadInput =
                                                                    FileUploadInputElement();

                                                                uploadInput
                                                                    .click();

                                                                uploadInput
                                                                    .onChange
                                                                    .listen(
                                                                        (e) {
                                                                  // read file content as dataURL
                                                                  final files =
                                                                      uploadInput
                                                                          .files;
                                                                  if (files
                                                                          ?.length ==
                                                                      1) {
                                                                    final file =
                                                                        files?[
                                                                            0];
                                                                    final reader =
                                                                        new FileReader();

                                                                    reader
                                                                        .onLoadEnd
                                                                        .listen(
                                                                            (e) async {
                                                                      print(e);
                                                                      print(
                                                                          'loaded: ${file?.name}');
                                                                      print(
                                                                          'type: ${reader.result.runtimeType}');
                                                                      print(
                                                                          'file size = ${file?.size}');

                                                                      // If file is >10MB, do not allow uploading
                                                                      if (file!
                                                                              .size >
                                                                          14 *
                                                                              1024 *
                                                                              1024) {
                                                                        myControllerTitle
                                                                            .clear();
                                                                        myControllerSubject
                                                                            .clear();
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content: Text(
                                                                          "Please upload files less than 14MB",
                                                                          style:
                                                                              TextStyle(color: Colors.red[600]),
                                                                        )));
                                                                      } else {
                                                                        _handleResult(
                                                                            reader.result);
                                                                        print(
                                                                            "i reached here");
                                                                        myControllerSubject.text =
                                                                            file.name;
                                                                      }
                                                                    });
                                                                    reader.readAsDataUrl(
                                                                        file!);
                                                                  }
                                                                });
                                                              },
                                                              child: Text(
                                                                'Browse'
                                                                    .tr()
                                                                    .toString(),
                                                                strutStyle:
                                                                    const StrutStyle(
                                                                        forceStrutHeight:
                                                                            true),
                                                                style:
                                                                    GoogleFonts
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
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                elevation: 0.0,
                                                                shadowColor: Colors
                                                                    .transparent,
                                                                primary: Color(
                                                                    0xFFF5F0E5),
                                                                onPrimary: Color(
                                                                    0xFF183028),
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

                                                    SizedBox(
                                                        height: height * 0.04),

                                                    Center(
                                                      child: SizedBox(
                                                        width: width * 0.3,
                                                        child: ElevatedButton(
                                                          onPressed: submitForm,
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Color(
                                                                0xFF215732),
                                                            elevation: 0.0,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            onPrimary: Color(
                                                                0xFFFFFFFF),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        14,
                                                                    horizontal:
                                                                        25),
                                                            child: Text(
                                                                'Upload Files'
                                                                    .tr()
                                                                    .toString(),
                                                                strutStyle:
                                                                    StrutStyle(
                                                                        forceStrutHeight:
                                                                            true),
                                                                style:
                                                                    GoogleFonts
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
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.02),
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
                                            color: Color(0xFF999999),
                                            width: 1)),
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
                                            "  Upload new file  ".tr(),
                                            style: GoogleFonts.barlow(
                                              textStyle: TextStyle(
                                                  color: Color(0Xff222222),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.04),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.645,
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
                                      strutStyle: const StrutStyle(
                                          forceStrutHeight: true),
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
                      ),
                      SizedBox(height: height * 0.01),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.616,
                          )
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
