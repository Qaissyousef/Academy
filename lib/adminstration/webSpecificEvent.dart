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

class webSpecificEvent extends StatefulWidget {
  final int eventID;
  final String eventTitle;
  const webSpecificEvent(
      {Key? key, required this.eventID, required this.eventTitle})
      : super(key: key);

  @override
  State<webSpecificEvent> createState() => _webSpecificEventState();
}

class _webSpecificEventState extends State<webSpecificEvent>
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

  var _dateTime1 = DateTime.parse("2022-10-01 00:00:00.000");
  var _dateTime2 = DateTime.parse("2022-02-12 00:00:00.000");

  late TabController _nestedTabController;
  late ScrollController _scrollController;
  final myControllersdate = TextEditingController();
  final myControlleredate = TextEditingController();
  final myControllerasdate = TextEditingController();
  final myControlleraedate = TextEditingController();
  final myControlleraetime = TextEditingController();
  final myControllerstime = TextEditingController();
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

  Future<Map<String, dynamic>> fetchEventEng() async {
    final response = await http
        .get(Uri.parse(global.apiAddress + 'GetEventEng/${widget.eventID}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Map<String, dynamic>> fetchEventArb() async {
    final response = await http
        .get(Uri.parse(global.apiAddress + 'GetEventArb/${widget.eventID}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<http.Response> updateRequest_e() async {
    Map data = {
      "event_title": myControllertitle.text,
      "event_start_date": myControllersdate.text,
      "event_end_date": myControlleredate.text,
      "event_start_time": myControllerstime.text,
      "event_end_time": myControlleretime.text,
      "event_description": myControllerdes.text,
      "event_mention_account": myControlleracc.text,
      "event_tags": myControllertags.text,
      "event_link": myControllerlink.text,
      "event_capacity": myControllercap.text,
      "event_schedule_time": "testing",
      "rsvp": 0,
      "event_location": myControllerloc.text,
    };

    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress + 'UpdateEventEng/${widget.eventID}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    return response;
  }

  Future<http.Response> updateRequest_a() async {
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
      "rsvp": 0,
      "event_location": myControllerloca.text,
    };

    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress + 'UpdateEventArb/${widget.eventID}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    return response;
  }

  // used when user tries to submit the form
  // if all text fields are valid, do the post request
  // otherwise alert user of error
  void submitForm() {
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
        "English start time", myControllerstime.text, "empty;time");
    errorText += validator.isValid(
        "English start date", myControllersdate.text, "empty;date");
    errorText += validator.isValid(
        "English end time", myControlleretime.text, "empty;time");
    errorText += validator.isValid(
        "English end date", myControlleredate.text, "empty;date");
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
    if (errorText == "") {
      if (!validator.isDateGreater(
          myControllersdate.text, myControlleredate.text))
        errorText +=
            "${validator.bullet} English start date can't be greater than end date\n";
      if (!validator.isDateGreater(
          myControllerasdate.text, myControlleraedate.text))
        errorText +=
            "${validator.bullet} Arabic start date can't be greater than end date\n";
      if (!validator.isTimeGreater(
          myControllerstime.text, myControlleretime.text))
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
      return;
    }

    updateRequest_e();
    updateRequest_a();
  }

  @override
  void initState() {
    fetchEventArb().then((value) {
      myControllertitlea.text = value["event_title"];

      myControllerasdate.text = DateFormat.yMMMMd(context.locale.toString())
          .format(DateFormat('MMM dd yyyy').parse(value[
              "event_start_date"])); // format english date based on context

      myControllerastime.text = DateFormat.Hm(context.locale.toString()).format(
          DateFormat('HH:mm').parse(value[
              "event_start_time"])); //format english time based on context

      myControlleraedate.text = DateFormat.yMMMMd(context.locale.toString())
          .format(DateFormat('MMM dd yyyy').parse(
              value["event_end_date"])); // format english date based on context
      myControlleraetime.text = myControllerastime.text = DateFormat.Hm(
              context.locale.toString())
          .format(DateFormat('HH:mm').parse(
              value["event_end_time"])); //format english time based on context

      myControllerdesa.text = value["event_description"];
      myControllertagsa.text = value["event_tags"];
      myControlleracca.text = value["event_mention_account"];
      myControllerloca.text = value["event_location"];
      myControllerlinka.text = value["event_link"];
      myControllercapa.text = value["event_capacity"].toString();
    });
    fetchEventEng().then((value) {
      myControllertitle.text = value["event_title"];
      myControllersdate.text = value["event_start_date"];
      myControllerstime.text = value["event_start_time"];
      myControllerdes.text = value["event_description"];
      myControlleredate.text = value["event_end_date"];
      myControlleretime.text = value["event_end_time"];
      myControllertags.text = value["event_tags"];
      myControlleracc.text = value["event_mention_account"];
      myControllerloc.text = value["event_location"];
      myControllerlink.text = value["event_link"];
      myControllercap.text = value["event_capacity"].toString();
    });
    myControllerstime.text = "";
    myControlleraetime.text = "";
    myControllerastime.text = "";
    myControlleretime.text = "";

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
                                    textStyle: TextStyle(
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16),
                                  ),
                                ),
                                Text(
                                  " ${widget.eventTitle}", //.tr(),
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
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 17,
                                  color: Colors.black,
                                )),
                            Text(
                              " ${widget.eventTitle}", //.tr(),
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
                                        text: "العربية",
                                      ),
                                      Tab(
                                        text: "English",
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: height * 0.9,
                                    margin: EdgeInsets.only(
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
                                                                maxLength: 255,
                                                                controller:
                                                                    myControllertitlea,
                                                                decoration:
                                                                    InputDecoration(
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
                                                                maxLength: 16,
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
                                                              "وقت البدء",
                                                              style: GoogleFonts
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
                                                                              DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
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
                                                                          icon: Icon(
                                                                              Icons.access_time,
                                                                              size: 18,
                                                                              color: Color(0xFF999999))),
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
                                                              "الوصف",
                                                              style: GoogleFonts
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
                                                                    InputDecoration(
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
                                                                maxLength: 16,
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
                                                              "وقت الانتهاء",
                                                              style: GoogleFonts
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
                                                                              DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
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
                                                                          icon: Icon(
                                                                              Icons.access_time,
                                                                              size: 18,
                                                                              color: Color(0xFF999999))),
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
                                                              "العلامات",
                                                              style: GoogleFonts
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
                                                                        "اذكر الحسابات",
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
                                                                          maxLength:
                                                                              50,
                                                                          controller:
                                                                              myControllertagsa,
                                                                          maxLines:
                                                                              5,
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
                                                                  "الاهلية",
                                                                  style:
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
                                                                        InputDecoration(
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
                                                                  "الموقع",
                                                                  style:
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
                                                                        InputDecoration(
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
                                                        textStyle: TextStyle(
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
                                                                            OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Color(0xFFEEEEEE),
                                                                              width: 1.5),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
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
                                                                              () {},
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
                                                                            child:
                                                                                Text(
                                                                              'Schedule for later'.tr().toString(),
                                                                              strutStyle: StrutStyle(forceStrutHeight: true),
                                                                              style: GoogleFonts.barlow(
                                                                                textStyle: TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
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
                                                                                Color(0xFFF5F0E5),
                                                                            onPrimary:
                                                                                Color(0xFF183028),
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
                                                                              submitForm,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
                                                                            child: Text('Add event now'.tr().toString(),
                                                                                strutStyle: StrutStyle(forceStrutHeight: true),
                                                                                style: GoogleFonts.barlow(
                                                                                  textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                                )),
                                                                          ),
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            primary:
                                                                                Color(0xFF215732),
                                                                            elevation:
                                                                                0.0,
                                                                            shadowColor:
                                                                                Colors.transparent,
                                                                            onPrimary:
                                                                                Color(0xFFFFFFFF),
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
                                                                maxLength: 255,
                                                                controller:
                                                                    myControllertitle,
                                                                decoration:
                                                                    InputDecoration(
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
                                                                maxLength: 16,
                                                                controller:
                                                                    myControllersdate,
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
                                                                          myControllersdate.text = date
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
                                                              "Start time",
                                                              style: GoogleFonts
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
                                                                    myControllerstime,
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
                                                                              DateFormat.jm().parse(pickedTime.format(context).toString());
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
                                                                            myControllerstime.text =
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
                                                                      icon: Icon(Icons.access_time, size: 18, color: Color(0xFF999999))),
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
                                                              "Description",
                                                              style: GoogleFonts
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
                                                                    InputDecoration(
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
                                                              "End date",
                                                              style: GoogleFonts
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
                                                                maxLength: 16,
                                                                controller:
                                                                    myControlleredate,
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
                                                                          myControlleredate.text = date
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
                                                              "End time",
                                                              style: GoogleFonts
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
                                                                    myControlleretime,
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
                                                                              DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                                              //converting to DateTime so that we can further format on different pattern.
                                                                              print(parsedTime); //output 1970-01-01 22:53:00.000
                                                                              String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                                              print(formattedTime); //output 14:59:00
                                                                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                                              setState(() {
                                                                                myControlleretime.text = formattedTime; //set the value of text field.
                                                                              });
                                                                            } else {
                                                                              print("Time is not selected");
                                                                            }
                                                                          },
                                                                          icon: Icon(
                                                                              Icons.access_time,
                                                                              size: 18,
                                                                              color: Color(0xFF999999))),
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
                                                              "Mention accounts",
                                                              style: GoogleFonts
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
                                                                        "Tags",
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
                                                                          maxLength:
                                                                              50,
                                                                          controller:
                                                                              myControllertags,
                                                                          maxLines:
                                                                              5,
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
                                                                        InputDecoration(
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
                                                                        InputDecoration(
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
                                                        textStyle: TextStyle(
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
                                                                            OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Color(0xFFEEEEEE),
                                                                              width: 1.5),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
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
                                                                              () {},
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
                                                                            child:
                                                                                Text(
                                                                              'Schedule for later'.tr().toString(),
                                                                              strutStyle: StrutStyle(forceStrutHeight: true),
                                                                              style: GoogleFonts.barlow(
                                                                                textStyle: TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
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
                                                                                Color(0xFFF5F0E5),
                                                                            onPrimary:
                                                                                Color(0xFF183028),
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
                                                                              submitForm,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 14, horizontal: 0.6),
                                                                            child: Text('Save changes'.tr().toString(),
                                                                                strutStyle: StrutStyle(forceStrutHeight: true),
                                                                                style: GoogleFonts.barlow(
                                                                                  textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                                )),
                                                                          ),
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            primary:
                                                                                Color(0xFF215732),
                                                                            elevation:
                                                                                0.0,
                                                                            shadowColor:
                                                                                Colors.transparent,
                                                                            onPrimary:
                                                                                Color(0xFFFFFFFF),
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
