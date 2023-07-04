
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:pif_admin_dashboard/main.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/eventsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/usersResponive.dart';

import '../models/ann_model.dart';
import '../responsiveness/faqResponsive.dart';
import '../settings.dart';
import '../pfpimg.dart';
import 'announcements.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;

class specificAnn extends StatefulWidget {
  final int current_ann;
  final String ann_title;

  const specificAnn(
      {Key? key, required this.current_ann, required this.ann_title})
      : super(key: key);

  @override
  State<specificAnn> createState() => _specificAnnState();
}

class _specificAnnState extends State<specificAnn>
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

  late TabController _nestedTabController;
  late ScrollController _scrollController;
  final myControllertitle_e = TextEditingController();
  final myControllerdes_e = TextEditingController();
  final myControllertitle_a = TextEditingController();
  final myControllerdes_a = TextEditingController();

  Future<List<Announcement>> fetchPostEng() async {
    final response = await http.get(
        Uri.parse(global.apiAddress + 'SpecificAnnEng/${widget.current_ann}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<Announcement>((json) => Announcement.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Announcement>> fetchPostArb() async {
    final response = await http.get(
        Uri.parse(global.apiAddress + 'SpecificAnnArb/${widget.current_ann}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<Announcement>((json) => Announcement.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<http.Response> updateRequestEng() async {
    Map data = {
      "ann_id": 0,
      "ann_title": myControllertitle_e.text,
      "ann_description": myControllerdes_e.text,
      "ann_creation_time": "2022-10-31T07:09:33.500Z",
      "ann_image": "C:imgUpload062d1ea5c16c4d99872829f06c441abd.jpeg"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress + 'UpdateAnnEng/${widget.current_ann}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> updateRequestArb() async {
    Map data = {
      "ann_id": 0,
      "ann_title": myControllertitle_a.text,
      "ann_description": myControllerdes_a.text,
      "ann_creation_time": "2022-10-31T07:09:33.500Z",
      "ann_image": "C:imgUpload062d1ea5c16c4d99872829f06c441abd.jpeg"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress + 'UpdateAnnArb/${widget.current_ann}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  bool submitForm() {
    String errorText = "";

    errorText += validator.isValid(
        "English description", myControllerdes_a.text, "empty");
    errorText += validator.isValid(
        "Arabic description", myControllerdes_e.text, "empty");
    errorText +=
        validator.isValid("English title", myControllertitle_a.text, "empty");
    errorText +=
        validator.isValid("Arabic title", myControllertitle_e.text, "empty");

    if (errorText != "") {
      validator.alertDialog(
          context, errorText.substring(0, errorText.length - 1));
      return false;
    }

    updateRequestArb();
    updateRequestEng();
    return true;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _nestedTabController = new TabController(length: 2, vsync: this);

    fetchPostArb().then((value) {
      myControllertitle_a.text = value[0].ann_title;
      myControllerdes_a.text = value[0].ann_description;
    });
    fetchPostEng().then((value) {
      myControllertitle_e.text = value[0].ann_title;
      myControllerdes_e.text = value[0].ann_description;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
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
                              pageBuilder: (context, animation1, animation2) =>
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
                                    context.locale == Locale("en") ? 0 : 40.0),
                                bottomLeft: Radius.circular(
                                    context.locale == Locale("en") ? 0 : 40.0),
                                topRight: Radius.circular(
                                    context.locale == Locale("en") ? 40 : 0.0),
                                bottomRight: Radius.circular(
                                    context.locale == Locale("en") ? 40 : 0.0),
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
                                              announcements(),
                                      transitionDuration: Duration(seconds: 0),
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
                              settings(),
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
                          children: [
                            Container(
                              child: Row(children: [
                                Text(
                                  "Administration / Announcements /".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16),
                                  ),
                                ),
                                Text(
                                  "${widget.ann_title}".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        color: Color(0xFF215732),
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16),
                                  ),
                                ),
                              ]),
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
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MessageResponsive()),
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
                                      child: pfpImage)
                                ]))
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.13,
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
                            Text(
                              "${widget.ann_title}".tr(),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: width * 0.015),
                              ),
                            ),
                          ],
                        ),
                      ),
                      eventCard,
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  TabBar(
                                    controller: _nestedTabController,
                                    isScrollable: true,
                                    labelColor: Color(0xFF222222),
                                    unselectedLabelColor: Color(0xFF999999),
                                    indicatorColor: Color(0xFFBD9B60),
                                    indicatorWeight: 3.0,
                                    tabs: <Widget>[
                                      Tab(
                                        text: "  العربية",
                                      ),
                                      Tab(
                                        text: "English  ",
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: height * 0.8,
                                    margin: EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: TabBarView(
                                      controller: _nestedTabController,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: height * 0.02,
                                                  ),
                                                  Text(
                                                    "العنوان",
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
                                                  SizedBox(
                                                    height: height * 0.005,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.3,
                                                    height: height * 0.07,
                                                    child: TextField(
                                                      maxLength: 255,
                                                      controller:
                                                          myControllertitle_a,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 1.5),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 1.5),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.02,
                                                  ),
                                                  Text(
                                                    "الوصف",
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
                                                  SizedBox(
                                                    height: height * 0.005,
                                                  ),
                                                  Container(
                                                    width: width * 0.3,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFF999999),
                                                            width: 0.3)),
                                                    // height: height*0.4,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: TextField(
                                                            maxLength: 255,
                                                            controller:
                                                                myControllerdes_a,
                                                            maxLines: 10,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: width * 0.22,
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.08,
                                                        height: 43,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            submitForm();
                                                          },
                                                          child: Text(
                                                              'Save changes'
                                                                  .tr()
                                                                  .toString(),
                                                              strutStyle: StrutStyle(
                                                                  forceStrutHeight:
                                                                      true)),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Color(
                                                                0xFF215732),
                                                            onPrimary:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: width * 0.032,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: height * 0.02,
                                                  ),
                                                  Text(
                                                    "Title",
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
                                                  SizedBox(
                                                    height: height * 0.005,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.3,
                                                    height: height * 0.07,
                                                    child: TextField(
                                                      maxLength: 255,
                                                      controller:
                                                          myControllertitle_e,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 1.5),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 1.5),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.02,
                                                  ),
                                                  Text(
                                                    "Description",
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
                                                  SizedBox(
                                                    height: height * 0.005,
                                                  ),
                                                  Container(
                                                    width: width * 0.3,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFF999999),
                                                            width: 0.3)),
                                                    // height: height*0.4,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: TextField(
                                                            maxLength: 255,
                                                            controller:
                                                                myControllerdes_e,
                                                            maxLines: 10,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: width * 0.22,
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.08,
                                                        height: 43,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            submitForm();
                                                          },
                                                          child: Text(
                                                              'Save changes'
                                                                  .tr()
                                                                  .toString(),
                                                              strutStyle: StrutStyle(
                                                                  forceStrutHeight:
                                                                      true)),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Color(
                                                                0xFF215732),
                                                            onPrimary:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: width * 0.032,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
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
    );
  }
}
