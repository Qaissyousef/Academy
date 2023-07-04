import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:pif_admin_dashboard/main.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/announcementResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/eventsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/usersResponive.dart';

import '../pfpimg.dart';
import '../responsiveness/faqResponsive.dart';

import 'package:date_time_format/date_time_format.dart';
import 'package:http/http.dart' as http;

import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;

class addEvent extends StatefulWidget {
  const addEvent({Key? key}) : super(key: key);

  @override
  State<addEvent> createState() => _addEventState();
}

class _addEventState extends State<addEvent> with TickerProviderStateMixin {
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
                            const MyApp(),
                        transitionDuration: const Duration(seconds: 0),
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

  var _dateTime1 = DateTime.parse("2022-10-01 00:00:00.000");
  var _dateTime2 = DateTime.parse("2022-02-12 00:00:00.000");

  late TabController _nestedTabController;
  late ScrollController _scrollController;

  final myControllerasdate = TextEditingController();
  final myControlleraedate = TextEditingController();

  final myControlleraetime = TextEditingController();

  final myControlleretime = TextEditingController();
  final myControllerastime = TextEditingController();

  final myControllertitlea = TextEditingController();
  final myControllerdesa = TextEditingController();
  final myControlleracca = TextEditingController();
  final myControllertagsa = TextEditingController();
  final myControllercapa = TextEditingController();
  final myControllerloca = TextEditingController();
  final myControllerlinka = TextEditingController();

  final myControllertitle = TextEditingController();
  final myControllerdes = TextEditingController();
  final myControlleracc = TextEditingController();
  final myControllertags = TextEditingController();
  final myControllercap = TextEditingController();
  final myControllerloc = TextEditingController();
  final myControllerlink = TextEditingController();

  Future<http.Response> postMYEvent() async {
    final myController1 = TextEditingController();
    final myController2 = TextEditingController();
    final myController3 = TextEditingController();
    final myController4 = TextEditingController();

    Map data = {
      "user_id": 0,
      "attending": 0,
      "event_id": 0,
      "event_title": "string",
      "event_start_date": "string",
      "event_end_date": "string",
      "event_start_time": "string",
      "event_end_time": "string",
      "event_description": "string",
      "event_mention_account": "string",
      "event_tags": "string",
      "event_link": "string",
      "event_schedule_time": "string",
      "event_capacity": 0,
      "event_location": "string",
      "rsvp": 0
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddMyEvents'),
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

  Future<http.Response> postRequest(DateTime? picked) async {
    Map data = {
      "event_title": myControllertitle.text,
      "event_start_date": myControllerasdate.text,
      "event_end_date": myControlleraedate.text,
      "event_start_time": myControllerastime.text,
      "event_end_time": myControlleraetime.text,
      "event_description": myControllerdes.text,
      "event_mention_account": myControlleracc.text,
      "event_tags": myControllertags.text,
      "event_link": myControllerlink.text,
      "event_capacity": myControllercap.text,
      "event_schedule_time": "testing",
      "rsvp": 0,
      "event_display": picked.toString(),
      "event_location": myControllerloc.text,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddEvent'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
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

  Future<http.Response> postRequestArb(DateTime? picked) async {
    Map data = {
      "event_title": myControllertitlea.text,
      "event_start_date": myControllerasdate.text,
      "event_end_date": myControlleraedate.text,
      "event_start_time": myControllerastime.text,
      "event_end_time": myControlleraetime.text,
      "event_description": myControllerdesa.text,
      "event_mention_account": myControlleracca.text,
      "event_tags": myControllertagsa.text,
      "event_link": myControllerlinka.text,
      "event_capacity": myControllercapa.text,
      "event_schedule_time": "testing",
      "event_location": myControllerloca.text,
      "rsvp": 0,
      "event_display": picked.toString(),
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await http.post(Uri.parse(global.apiAddress + 'AddArabicEvent'),
            headers: {
              'Content-Type': 'application/json; charset=utf-8',
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

  // used when user tries to submit the form
  // if all text fields are valid, do the post request
  // otherwise alert user of error
  bool submitFormWithDate(DateTime? picked) {
    String errorText = "";

    // Arabic fields validity check
    errorText +=
        validator.isValid("Arabic title", myControllertitlea.text, "empty");
    errorText += validator.isValid(
        "Arabic start time", myControllerastime.text, "empty;time");
    errorText += validator.isValid(
        "Arabic start date", myControllerasdate.text, "empty;date");
    errorText += validator.isValid(
        "Arabic end time", myControlleraetime.text, "empty;time");
    errorText += validator.isValid(
        "Arabic end date", myControlleraedate.text, "empty;date");
    errorText +=
        validator.isValid("Arabic description", myControllerdesa.text, "empty");
    errorText += validator.isValid(
        "Arabic mention accounts", myControlleracca.text, "empty");
    errorText +=
        validator.isValid("Arabic Tags", myControllertagsa.text, "empty");
    errorText +=
        validator.isValid("Arabic location", myControllerloca.text, "empty");
    errorText += validator.isValid(
        "Arabic capacity", myControllercapa.text, "empty;number");
    errorText += validator.isValid(
        "Arabic invitation link", myControllerlinka.text, "empty;link");

    // English fields validity check
    errorText +=
        validator.isValid("English title", myControllertitle.text, "empty");
    errorText += validator.isValid(
        "English start time", myControllerastime.text, "empty;time");
    errorText += validator.isValid(
        "English start date", myControllerasdate.text, "empty;date");
    errorText += validator.isValid(
        "English end time", myControlleraetime.text, "empty;time");
    errorText += validator.isValid(
        "English end date", myControlleraedate.text, "empty;date");
    errorText +=
        validator.isValid("English description", myControllerdes.text, "empty");
    errorText += validator.isValid(
        "English mention accounts", myControlleracc.text, "empty");
    errorText +=
        validator.isValid("English Tags", myControllertags.text, "empty");
    errorText +=
        validator.isValid("English location", myControllerloc.text, "empty");
    errorText += validator.isValid(
        "English capacity", myControllercap.text, "empty;number");
    errorText += validator.isValid(
        "English invitation link", myControllerlink.text, "empty;link");

    // date time start end validators
    // putting it in an if statement cuz if the user get notified that thier date/time can't be greater before
    // they even input the date, that would be wierd
    if (errorText == "") {
      if (!validator.isDateGreater(
          myControllerasdate.text, myControlleraedate.text))
        errorText +=
            "${validator.bullet} English start date can't be greater than end date\n";
      if (!validator.isDateGreater(
          myControllerasdate.text, myControlleraedate.text))
        errorText +=
            "${validator.bullet} Arabic start date can't be greater than end date\n";
      if (!validator.isTimeGreater(
          myControllerastime.text, myControlleraetime.text))
        errorText +=
            "${validator.bullet} English start time can't be greater than end time\n";
      if (!validator.isTimeGreater(
          myControllerastime.text, myControlleraetime.text))
        errorText +=
            "${validator.bullet} Arabic start time can't be greater than end time\n";
    }
    if (errorText != "") {
      validator.alertDialog(
          context, errorText.substring(0, errorText.length - 1));
      return false;
    }

    // posting stuff
    postRequest(picked);
    postRequestArb(picked);
    postMYEvent();
    return true;
  }

  bool submitForm() {
    return submitFormWithDate(DateTime.now());
  }

  @override
  void initState() {
    myControllerastime.text = "";
    myControlleraetime.text = "";
    myControllerastime.text = "";
    myControlleraetime.text = "";

    _scrollController = ScrollController();
    _nestedTabController = new TabController(length: 2, vsync: this);

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
        color: const Color(0xFFffffff),
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
                          strutStyle: const StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: const TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF999999)),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "16".tr().toString(),
                          strutStyle: const StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: const TextStyle(
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
                    color: const Color(0xFFF9F2E7),
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
                                strutStyle: const StrutStyle(forceStrutHeight: true),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
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
                                strutStyle: const StrutStyle(forceStrutHeight: true),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
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
            color: const Color(0xFFBD9B60),
            // child: Text("we"),
          ),
          Drawer(
            width: width * 0.2,
            child: Container(
              color: const Color(0xFF183028),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: DrawerHeader(
                        padding: const EdgeInsets.all(0.0),
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
                    leading: const ImageIcon(
                      AssetImage("assets/images/home.png"),
                      color: Color(0xFFBD9B60),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Home".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
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
                              const HomeResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.001, right: width * 0.002),
                        child: const Icon(Icons.list,
                            color: Color(0xFFBD9B60), size: 26.2)),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Courses".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
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
                              const courseResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: context.locale == const Locale("en")
                            ? width * 0.01
                            : 0.0,
                        left: context.locale == const Locale("en")
                            ? 0.0
                            : width * 0.01),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFBD9B60),
                        //
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              context.locale == const Locale("en") ? 0 : 40.0),
                          bottomLeft: Radius.circular(
                              context.locale == const Locale("en") ? 0 : 40.0),
                          topRight: Radius.circular(
                              context.locale == const Locale("en") ? 40 : 0.0),
                          bottomRight: Radius.circular(
                              context.locale == const Locale("en") ? 40 : 0.0),
                        ),
                      ),
                      child: ListTile(
                        leading: const ImageIcon(
                          AssetImage("assets/images/admin.png"),
                          color: Colors.white,
                        ),
                        minLeadingWidth: width * 0.02,
                        title: Text(
                          "Administration".tr(),
                          style: GoogleFonts.barlow(
                            textStyle: const TextStyle(
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
                                  const adminResponsive(),
                              transitionDuration: const Duration(seconds: 0),
                            ),
                          )
                        },
                      ),
                    ),
                  ),
                  Padding(
                    // padding:  EdgeInsets.only(right: width*0.01,left: ),
                    padding: EdgeInsets.only(
                        right: context.locale == const Locale("en")
                            ? width * 0.01
                            : width * 0.025,
                        left: context.locale == const Locale("en")
                            ? width * 0.025
                            : width * 0.01),

                    child: Row(
                      children: [
                        Container(
                          height: height * 0.06,
                          width: 5,
                          color: const Color(0xFFBD9B60),
                          // child: Text("we"),
                        ),
                        Expanded(
                          child: Container(
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(189, 155, 96, 0.2),
                              //
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    context.locale == const Locale("en")
                                        ? 0
                                        : 40.0),
                                bottomLeft: Radius.circular(
                                    context.locale == const Locale("en")
                                        ? 0
                                        : 40.0),
                                topRight: Radius.circular(
                                    context.locale == const Locale("en")
                                        ? 40
                                        : 0.0),
                                bottomRight: Radius.circular(
                                    context.locale == const Locale("en")
                                        ? 40
                                        : 0.0),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListTile(
                                title: Text(
                                  "Events".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: const TextStyle(
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
                                              const eventResponsive(),
                                      transitionDuration:
                                          const Duration(seconds: 0),
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
                          right: context.locale == const Locale("en")
                              ? 0
                              : width * 0.028,
                          left: context.locale == const Locale("en")
                              ? width * 0.028
                              : 0),
                      child: Text(
                        "Announcements".tr(),
                        style: GoogleFonts.barlow(
                          textStyle: const TextStyle(
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
                              const announcementResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      ),
                    },
                  ),
                  ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(
                          right: context.locale == const Locale("en")
                              ? 0
                              : width * 0.028,
                          left: context.locale == const Locale("en")
                              ? width * 0.028
                              : 0),
                      child: Text(
                        "Users".tr(),
                        style: GoogleFonts.barlow(
                          textStyle: const TextStyle(
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
                              const userResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(left: width * 0.0028),
                      child: SvgPicture.asset("assets/images/admission.svg",
                          color: const Color(0xFFBD9B60)),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Admission".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
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
                              const admissionResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 2.0, left: 2),
                      child: SvgPicture.asset("assets/images/settings.svg",
                          color: const Color(0xFFBD9B60)),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Settings".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
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
                              const settingResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/images/Headphone.svg",
                        color: const Color(0xFFBD9B60)),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Help".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
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
                              const helpResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  SizedBox(
                    height: height * 0.004,
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/images/faqicon.svg",
                        color: const Color(0xFFBD9B60)),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "FAQ".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
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
                              const faqResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                        // MaterialPageRoute(builder: (context) => coursesPage()),
                        // transitionDuration: const Duration(seconds: 0),
                      )
                    },
                  ),
                  SizedBox(
                    height: height * 0.004,
                  ),
                  const Divider(
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
                          textStyle: const TextStyle(
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
                              const MessageResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  const Divider(
                    color: Color(0xffFFFFFF),
                    thickness: 0.2,
                    indent: 12,
                    endIndent: 12,
                  ),
                  ListTile(
                    leading: const ImageIcon(
                      AssetImage("assets/images/logout.png"),
                      color: Color(0xFFBD9B60),
                    ),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Logout".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: const TextStyle(
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
                              child: Row(children: [
                                Text(
                                  "Administration / Events /".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: const TextStyle(
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16),
                                  ),
                                ),
                                Text(
                                  "Add new event".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: const TextStyle(
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
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  const MessageResponsive(),
                                              transitionDuration:
                                                  const Duration(seconds: 0),
                                            ));
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
                                                const settingResponsive(),
                                            transitionDuration:
                                                const Duration(seconds: 0),
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
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 17,
                                  color: Colors.black,
                                )),
                            Text(
                              "  Add new Event".tr(),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: const Color(0xFF222222),
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
                                    labelColor: const Color(0xFF222222),
                                    unselectedLabelColor: const Color(0xFF999999),
                                    indicatorColor: const Color(0xFFBD9B60),
                                    indicatorWeight: 3.0,
                                    tabs: <Widget>[
                                      const Tab(
                                        text: "العربية",
                                      ),
                                      const Tab(
                                        text: "English",
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: height * 0.9,
                                    margin: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: TabBarView(
                                      controller: _nestedTabController,
                                      children: <Widget>[
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: WebSmoothScroll(
                                              controller: _scrollController,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
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
                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "العنوان",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              height:
                                                                  height * 0.07,
                                                              child: TextField(
                                                                maxLength: 50,
                                                                controller:
                                                                    myControllertitlea,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              " تاريخ البدء",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              height:
                                                                  height * 0.07,
                                                              child: TextField(
                                                                maxLength: 14,
                                                                controller:
                                                                    myControllerasdate,
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      IconButton(
                                                                    onPressed:
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
                                                                            (context,
                                                                                child) {
                                                                          return Theme(
                                                                            data:
                                                                                ThemeData(
                                                                              //Header background color
                                                                              primaryColor: const Color(0xff007A33),
                                                                              //Background color
                                                                              scaffoldBackgroundColor: Colors.white,
                                                                              //Divider color
                                                                              dividerColor: Colors.grey,
                                                                              //Non selected days of the month color
                                                                              textTheme: const TextTheme(
                                                                                bodyText2: TextStyle(color: Colors.black),
                                                                              ),
                                                                              colorScheme: ColorScheme.fromSwatch().copyWith(
                                                                                //Selected dates background color
                                                                                primary: const Color(0xff215732),
                                                                                //Month title and week days color
                                                                                onSurface: Colors.black,
                                                                                //Header elements and selected dates text color
                                                                                //onPrimary: Colors.white,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
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
                                                                          _dateTime1 =
                                                                              date!;
                                                                          myControllerasdate.text = date
                                                                              .format('M d Y')
                                                                              .toString();
                                                                        });
                                                                      });
                                                                    },
                                                                    icon: SvgPicture
                                                                        .asset(
                                                                      "assets/images/calendar.svg",
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "وقت البدء",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              height:
                                                                  height * 0.07,
                                                              child: TextField(
                                                                maxLength: 5,
                                                                controller:
                                                                    myControllerastime,
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            TimeOfDay?
                                                                                pickedTime =
                                                                                await showTimePicker(
                                                                              initialTime: TimeOfDay.now(),
                                                                              context: context,
                                                                            );

                                                                            if (pickedTime !=
                                                                                null) {
                                                                              print(pickedTime.format(context)); //output 10:51 PM
                                                                              DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString().replaceAll('م', 'PM').replaceAll('ص', 'AM'));
                                                                              //converting to DateTime so that we can further format on different pattern.
                                                                              print(parsedTime); //output 1970-01-01 22:53:00.000
                                                                              String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                                              print(formattedTime); //output 14:59:00
                                                                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                                              setState(() {
                                                                                myControllerastime.text = formattedTime; //set the value of text field.
                                                                              });
                                                                            } else {
                                                                              print("Time is not selected");
                                                                            }
                                                                          },
                                                                          icon: const Icon(
                                                                              Icons.access_time,
                                                                              size: 18,
                                                                              color: Color(0xFF999999))),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "الوصف",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              // height: height*0.42,/**/
                                                              child: TextField(
                                                                maxLength: 255,
                                                                controller:
                                                                    myControllerdesa,
                                                                maxLines: 16,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.03,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.007,
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
                                                              width:
                                                                  width * 0.349,
                                                              height: height *
                                                                  0.108,
                                                            ),

                                                            // SizedBox(height: height*0.03,),
                                                            SizedBox(
                                                              height: height *
                                                                  0.035,
                                                            ),

                                                            Text(
                                                              "تاريخ الانتهاء",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),

                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              height:
                                                                  height * 0.07,
                                                              child: TextField(
                                                                maxLength: 14,
                                                                controller:
                                                                    myControlleraedate,
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      IconButton(
                                                                    onPressed:
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
                                                                            (context,
                                                                                child) {
                                                                          return Theme(
                                                                            data:
                                                                                ThemeData(
                                                                              //Header background color
                                                                              primaryColor: const Color(0xff007A33),
                                                                              //Background color
                                                                              scaffoldBackgroundColor: Colors.white,
                                                                              //Divider color
                                                                              dividerColor: Colors.grey,
                                                                              //Non selected days of the month color
                                                                              textTheme: const TextTheme(
                                                                                bodyText2: TextStyle(color: Colors.black),
                                                                              ),
                                                                              colorScheme: ColorScheme.fromSwatch().copyWith(
                                                                                //Selected dates background color
                                                                                primary: const Color(0xff215732),
                                                                                //Month title and week days color
                                                                                onSurface: Colors.black,
                                                                                //Header elements and selected dates text color
                                                                                //onPrimary: Colors.white,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
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
                                                                          _dateTime2 =
                                                                              date!;
                                                                          myControlleraedate.text = date
                                                                              .format('M d Y')
                                                                              .toString();
                                                                        });
                                                                      });
                                                                    },
                                                                    icon: SvgPicture
                                                                        .asset(
                                                                      "assets/images/calendar.svg",
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "وقت الانتهاء",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              height:
                                                                  height * 0.07,
                                                              child: TextField(
                                                                maxLength: 5,
                                                                controller:
                                                                    myControlleraetime,
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            TimeOfDay?
                                                                                pickedTime =
                                                                                await showTimePicker(
                                                                              initialTime: TimeOfDay.now(),
                                                                              context: context,
                                                                            );

                                                                            if (pickedTime !=
                                                                                null) {
                                                                              print(pickedTime.format(context)); //output 10:51 PM
                                                                              DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString().replaceAll('م', 'PM').replaceAll('ص', 'AM'));
                                                                              //converting to DateTime so that we can further format on different pattern.
                                                                              print(parsedTime); //output 1970-01-01 22:53:00.000
                                                                              String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                                              print(formattedTime); //output 14:59:00
                                                                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                                              setState(() {
                                                                                myControlleraetime.text = formattedTime; //set the value of text field.
                                                                              });
                                                                            } else {
                                                                              print("Time is not selected");
                                                                            }
                                                                          },
                                                                          icon: const Icon(
                                                                              Icons.access_time,
                                                                              size: 18,
                                                                              color: Color(0xFF999999))),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "اذكر الحسابات",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            Container(
                                                                height: height *
                                                                    0.45,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.01,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.349,
                                                                        child:
                                                                            TextField(
                                                                          maxLength:
                                                                              50,
                                                                          controller:
                                                                              myControlleracca,
                                                                          maxLines:
                                                                              6,
                                                                          decoration:
                                                                              const InputDecoration(
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
                                                                        "العلامات",
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: const TextStyle(
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
                                                                          maxLength:
                                                                              50,
                                                                          controller:
                                                                              myControllertagsa,
                                                                          maxLines:
                                                                              5,
                                                                          decoration:
                                                                              const InputDecoration(
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
                                                                    ])),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                height * 0.032,
                                                          ),
                                                          Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "الموقع",
                                                                  style:
                                                                      GoogleFonts
                                                                          .barlow(
                                                                    textStyle: const TextStyle(
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
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.01,
                                                                ),
                                                                SizedBox(
                                                                  width: width *
                                                                      0.349,
                                                                  height:
                                                                      height *
                                                                          0.07,
                                                                  child:
                                                                      TextField(
                                                                    maxLength:
                                                                        50,
                                                                    controller:
                                                                        myControllerloca,
                                                                    decoration:
                                                                        const InputDecoration(
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
                                                              ]),
                                                          SizedBox(
                                                            width:
                                                                width * 0.007,
                                                          ),
                                                          Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "الاهلية",
                                                                  style:
                                                                      GoogleFonts
                                                                          .barlow(
                                                                    textStyle: const TextStyle(
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
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.01,
                                                                ),
                                                                SizedBox(
                                                                  width: width *
                                                                      0.349,
                                                                  height:
                                                                      height *
                                                                          0.07,
                                                                  child:
                                                                      TextField(
                                                                    maxLength:
                                                                        10,
                                                                    controller:
                                                                        myControllercapa,
                                                                    decoration:
                                                                        const InputDecoration(
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
                                                              ]),
                                                        ]),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    Text(
                                                      "رابط الدعوة",
                                                      style: GoogleFonts.barlow(
                                                        textStyle: const TextStyle(
                                                            color: Color(
                                                                0xFF999999),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
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
                                                                  SizedBox(
                                                                    width: width *
                                                                        0.349,
                                                                    height:
                                                                        height *
                                                                            0.07,
                                                                    child:
                                                                        TextField(
                                                                      maxLength:
                                                                          50,
                                                                      controller:
                                                                          myControllerlinka,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        prefixIcon: IconButton(
                                                                            onPressed:
                                                                                () {},
                                                                            icon:
                                                                                SvgPicture.asset("assets/images/copy.svg", fit: BoxFit.scaleDown)),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Color(0xFFEEEEEE),
                                                                              width: 1.5),
                                                                        ),
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Color(0xFFEEEEEE),
                                                                              width: 1.5),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.007,
                                                            ),
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: width *
                                                                        0.349,
                                                                    height:
                                                                        height *
                                                                            0.06,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () async {
                                                                            DateTimeRange? picked = await showDateRangePicker(
                                                                                context: context,
                                                                                firstDate: DateTime(DateTime.now().year - 5),
                                                                                lastDate: DateTime(DateTime.now().year + 5),
                                                                                builder: (context, child) {
                                                                                  return Theme(
                                                                                    data: ThemeData(
                                                                                      //Header background color
                                                                                      primaryColor: const Color(0xff007A33),
                                                                                      //Background color
                                                                                      scaffoldBackgroundColor: Colors.white,
                                                                                      //Divider color
                                                                                      dividerColor: Colors.grey,
                                                                                      //Non selected days of the month color
                                                                                      textTheme: const TextTheme(
                                                                                        bodyText2: TextStyle(color: Colors.black),
                                                                                      ),
                                                                                      colorScheme: ColorScheme.fromSwatch().copyWith(
                                                                                        //Selected dates background color
                                                                                        primary: const Color(0xff215732),
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
                                                                                            maxWidth: 400.0,
                                                                                            maxHeight: height * 0.7,
                                                                                          ),
                                                                                          child: child,
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                });

                                                                            // it's not exactly clear what implementation is being used
                                                                            // so leave this for later
                                                                            //if (picked != null) submitFormWithDate(picked);
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
                                                                            child:
                                                                                Text(
                                                                              'Schedule for later'.tr().toString(),
                                                                              strutStyle: const StrutStyle(forceStrutHeight: true),
                                                                              style: GoogleFonts.barlow(
                                                                                textStyle: const TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            elevation:
                                                                                0.0,
                                                                            shadowColor:
                                                                                Colors.transparent,
                                                                            primary:
                                                                                const Color(0xFFF5F0E5),
                                                                            onPrimary:
                                                                                const Color(0xFF183028),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width * 0.014,
                                                                        ),
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            bool
                                                                                isValid =
                                                                                submitForm();

                                                                            // if the submitted form is invalid, don't redirect
                                                                            if (!isValid)
                                                                              return;

                                                                            Navigator.push(
                                                                              context,
                                                                              PageRouteBuilder(
                                                                                pageBuilder: (context, animation1, animation2) =>
                                                                                    const eventResponsive(),
                                                                                transitionDuration: const Duration(seconds: 0),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
                                                                            child: Text('Add event now'.tr().toString(),
                                                                                strutStyle: const StrutStyle(forceStrutHeight: true),
                                                                                style: GoogleFonts.barlow(
                                                                                  textStyle: const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                                )),
                                                                          ),
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            primary:
                                                                                const Color(0xFF215732),
                                                                            elevation:
                                                                                0.0,
                                                                            shadowColor:
                                                                                Colors.transparent,
                                                                            onPrimary:
                                                                                const Color(0xFFFFFFFF),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.1,
                                                                  ),
                                                                ]),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: WebSmoothScroll(
                                              controller: _scrollController,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
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
                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "Title",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              height:
                                                                  height * 0.07,
                                                              child: TextField(
                                                                maxLength: 50,
                                                                controller:
                                                                    myControllertitle,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "Start date",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              height:
                                                                  height * 0.07,
                                                              child: TextField(
                                                                maxLength: 14,
                                                                controller:
                                                                    myControllerasdate,
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      IconButton(
                                                                    onPressed:
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
                                                                            (context,
                                                                                child) {
                                                                          return Theme(
                                                                            data:
                                                                                ThemeData(
                                                                              //Header background color
                                                                              primaryColor: const Color(0xff007A33),
                                                                              //Background color
                                                                              scaffoldBackgroundColor: Colors.white,
                                                                              //Divider color
                                                                              dividerColor: Colors.grey,
                                                                              //Non selected days of the month color
                                                                              textTheme: const TextTheme(
                                                                                bodyText2: TextStyle(color: Colors.black),
                                                                              ),
                                                                              colorScheme: ColorScheme.fromSwatch().copyWith(
                                                                                //Selected dates background color
                                                                                primary: const Color(0xff215732),
                                                                                //Month title and week days color
                                                                                onSurface: Colors.black,
                                                                                //Header elements and selected dates text color
                                                                                //onPrimary: Colors.white,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
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
                                                                          _dateTime1 =
                                                                              date!;
                                                                          myControllerasdate.text = date
                                                                              .format('M d Y')
                                                                              .toString();
                                                                        });
                                                                      });
                                                                    },
                                                                    icon: SvgPicture
                                                                        .asset(
                                                                      "assets/images/calendar.svg",
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "Start time",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              height:
                                                                  height * 0.07,
                                                              child: TextField(
                                                                maxLength: 5,
                                                                controller:
                                                                    myControllerastime,
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon: IconButton(
                                                                      onPressed: () async {
                                                                        TimeOfDay?
                                                                            pickedTime =
                                                                            await showTimePicker(
                                                                          initialTime:
                                                                              TimeOfDay.now(),
                                                                          context:
                                                                              context,
                                                                        );

                                                                        if (pickedTime !=
                                                                            null) {
                                                                          print(
                                                                              pickedTime.format(context)); //output 10:51 PM
                                                                          DateTime
                                                                              parsedTime =
                                                                              DateFormat.jm().parse(pickedTime.format(context).toString().replaceAll('م', 'PM').replaceAll('ص', 'AM'));
                                                                          //converting to DateTime so that we can further format on different pattern.
                                                                          print(
                                                                              parsedTime); //output 1970-01-01 22:53:00.000
                                                                          String
                                                                              formattedTime =
                                                                              DateFormat('HH:mm').format(parsedTime);
                                                                          print(
                                                                              formattedTime); //output 14:59:00
                                                                          //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                                          setState(
                                                                              () {
                                                                            myControllerastime.text =
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
                                                                      icon: const Icon(Icons.access_time, size: 18, color: Color(0xFF999999))),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "Description",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              // height: height*0.42,/**/
                                                              child: TextField(
                                                                maxLength: 255,
                                                                controller:
                                                                    myControllerdes,
                                                                maxLines: 16,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.03,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.007,
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
                                                              width:
                                                                  width * 0.349,
                                                              height: height *
                                                                  0.108,
                                                            ),

                                                            SizedBox(
                                                              height: height *
                                                                  0.035,
                                                            ),
                                                            // SizedBox(height: height*0.025,),

                                                            Text(
                                                              "End date",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),

                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              height:
                                                                  height * 0.07,
                                                              child: TextField(
                                                                maxLength: 14,
                                                                controller:
                                                                    myControlleraedate,
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      IconButton(
                                                                    onPressed:
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
                                                                            (context,
                                                                                child) {
                                                                          return Theme(
                                                                            data:
                                                                                ThemeData(
                                                                              //Header background color
                                                                              primaryColor: const Color(0xff007A33),
                                                                              //Background color
                                                                              scaffoldBackgroundColor: Colors.white,
                                                                              //Divider color
                                                                              dividerColor: Colors.grey,
                                                                              //Non selected days of the month color
                                                                              textTheme: const TextTheme(
                                                                                bodyText2: TextStyle(color: Colors.black),
                                                                              ),
                                                                              colorScheme: ColorScheme.fromSwatch().copyWith(
                                                                                //Selected dates background color
                                                                                primary: const Color(0xff215732),
                                                                                //Month title and week days color
                                                                                onSurface: Colors.black,
                                                                                //Header elements and selected dates text color
                                                                                //onPrimary: Colors.white,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
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
                                                                          _dateTime2 =
                                                                              date!;
                                                                          myControlleraedate.text = date
                                                                              .format('M d Y')
                                                                              .toString();
                                                                        });
                                                                      });
                                                                    },
                                                                    icon: SvgPicture
                                                                        .asset(
                                                                      "assets/images/calendar.svg",
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "End time",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.349,
                                                              height:
                                                                  height * 0.07,
                                                              child: TextField(
                                                                maxLength: 5,
                                                                controller:
                                                                    myControlleraetime,
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            TimeOfDay?
                                                                                pickedTime =
                                                                                await showTimePicker(
                                                                              initialTime: TimeOfDay.now(),
                                                                              context: context,
                                                                            );

                                                                            if (pickedTime !=
                                                                                null) {
                                                                              print(pickedTime.format(context)); //output 10:51 PM
                                                                              DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString().replaceAll('م', 'PM').replaceAll('ص', 'AM'));
                                                                              //converting to DateTime so that we can further format on different pattern.
                                                                              print(parsedTime); //output 1970-01-01 22:53:00.000
                                                                              String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                                              print(formattedTime); //output 14:59:00
                                                                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                                              setState(() {
                                                                                myControlleraetime.text = formattedTime; //set the value of text field.
                                                                              });
                                                                            } else {
                                                                              print("Time is not selected");
                                                                            }
                                                                          },
                                                                          icon: const Icon(
                                                                              Icons.access_time,
                                                                              size: 18,
                                                                              color: Color(0xFF999999))),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Text(
                                                              "Mention accounts",
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: const TextStyle(
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
                                                            ),
                                                            Container(
                                                                height: height *
                                                                    0.45,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.01,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.349,
                                                                        child:
                                                                            TextField(
                                                                          maxLength:
                                                                              50,
                                                                          controller:
                                                                              myControlleracc,
                                                                          maxLines:
                                                                              4,
                                                                          decoration:
                                                                              const InputDecoration(
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
                                                                        "Tags",
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: const TextStyle(
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
                                                                          maxLength:
                                                                              50,
                                                                          controller:
                                                                              myControllertags,
                                                                          maxLines:
                                                                              4,
                                                                          decoration:
                                                                              const InputDecoration(
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
                                                                    ])),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                height * 0.032,
                                                          ),
                                                          Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Location",
                                                                  style:
                                                                      GoogleFonts
                                                                          .barlow(
                                                                    textStyle: const TextStyle(
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
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.01,
                                                                ),
                                                                SizedBox(
                                                                  width: width *
                                                                      0.349,
                                                                  height:
                                                                      height *
                                                                          0.07,
                                                                  child:
                                                                      TextField(
                                                                    maxLength:
                                                                        50,
                                                                    controller:
                                                                        myControllerloc,
                                                                    decoration:
                                                                        const InputDecoration(
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
                                                              ]),
                                                          SizedBox(
                                                            width:
                                                                width * 0.007,
                                                          ),
                                                          Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Capacity",
                                                                  style:
                                                                      GoogleFonts
                                                                          .barlow(
                                                                    textStyle: const TextStyle(
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
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.01,
                                                                ),
                                                                SizedBox(
                                                                  width: width *
                                                                      0.349,
                                                                  height:
                                                                      height *
                                                                          0.07,
                                                                  child:
                                                                      TextField(
                                                                    maxLength:
                                                                        10,
                                                                    controller:
                                                                        myControllercap,
                                                                    decoration:
                                                                        const InputDecoration(
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
                                                              ]),
                                                        ]),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    Text(
                                                      "Invitation link",
                                                      style: GoogleFonts.barlow(
                                                        textStyle: const TextStyle(
                                                            color: Color(
                                                                0xFF999999),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
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
                                                                  SizedBox(
                                                                    width: width *
                                                                        0.349,
                                                                    height:
                                                                        height *
                                                                            0.07,
                                                                    child:
                                                                        TextField(
                                                                      maxLength:
                                                                          50,
                                                                      controller:
                                                                          myControllerlink,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        prefixIcon: IconButton(
                                                                            onPressed:
                                                                                () {},
                                                                            icon:
                                                                                SvgPicture.asset("assets/images/copy.svg", fit: BoxFit.scaleDown)),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Color(0xFFEEEEEE),
                                                                              width: 1.5),
                                                                        ),
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Color(0xFFEEEEEE),
                                                                              width: 1.5),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.007,
                                                            ),
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: width *
                                                                        0.349,
                                                                    height:
                                                                        height *
                                                                            0.06,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () async {
                                                                            DateTime? pickedDate = await showDatePicker(
                                                                                context: context,
                                                                                initialDate: DateTime.now(),
                                                                                firstDate: DateTime(1950),
                                                                                //DateTime.now() - not to allow to choose before today.
                                                                                lastDate: DateTime(2100));

                                                                            if (pickedDate !=
                                                                                null) {
                                                                              print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                              setState(() {
                                                                                postRequest(pickedDate);
                                                                              });
                                                                              Navigator.push(
                                                                                context,
                                                                                PageRouteBuilder(
                                                                                  pageBuilder: (context, animation1, animation2) => const eventResponsive(),
                                                                                  transitionDuration: const Duration(seconds: 0),
                                                                                ),
                                                                                // MaterialPageRoute(builder: (context) => coursesPage()),
                                                                                // transitionDuration: const Duration(seconds: 0),
                                                                              );
                                                                            } else {}
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
                                                                            child:
                                                                                Text(
                                                                              'Schedule for later'.tr().toString(),
                                                                              strutStyle: const StrutStyle(forceStrutHeight: true),
                                                                              style: GoogleFonts.barlow(
                                                                                textStyle: const TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            elevation:
                                                                                0.0,
                                                                            shadowColor:
                                                                                Colors.transparent,
                                                                            primary:
                                                                                const Color(0xFFF5F0E5),
                                                                            onPrimary:
                                                                                const Color(0xFF183028),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width * 0.014,
                                                                        ),
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            bool
                                                                                isValid =
                                                                                submitForm();

                                                                            // if the submitted form is invalid, don't redirect
                                                                            if (!isValid)
                                                                              return;

                                                                            // this is a bad idea
                                                                            // if the user presses the back button they'll go back to the form page
                                                                            // instead of the actual page they were previously at
                                                                            // better to do pop if possible
                                                                            Navigator.push(
                                                                              context,
                                                                              PageRouteBuilder(
                                                                                pageBuilder: (context, animation1, animation2) =>
                                                                                    const eventResponsive(),
                                                                                transitionDuration: const Duration(seconds: 0),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
                                                                            child: Text('Add event now'.tr().toString(),
                                                                                strutStyle: const StrutStyle(forceStrutHeight: true),
                                                                                style: GoogleFonts.barlow(
                                                                                  textStyle: const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                                )),
                                                                          ),
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            primary:
                                                                                const Color(0xFF215732),
                                                                            elevation:
                                                                                0.0,
                                                                            shadowColor:
                                                                                Colors.transparent,
                                                                            onPrimary:
                                                                                const Color(0xFFFFFFFF),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.1,
                                                                  ),
                                                                ]),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
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
