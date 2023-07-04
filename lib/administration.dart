import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/adminstration/specificAnn.dart';
import 'package:pif_admin_dashboard/adminstration/webSpecificEvent.dart';
import 'package:pif_admin_dashboard/main.dart';
import 'package:pif_admin_dashboard/pfpimg.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/announcementResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/eventsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/faqResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/usersResponive.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import 'adminstration/announcements.dart';

import 'package:http/http.dart' as http;

import 'models/ann_model.dart';
import 'models/event_model.dart';
import 'models/user_model.dart';

import 'package:pif_admin_dashboard/util/global.dart' as global;

class adminstration extends StatefulWidget {
  const adminstration({Key? key}) : super(key: key);

  @override
  State<adminstration> createState() => _adminstrationState();
}

class _adminstrationState extends State<adminstration> {
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

  late ScrollController _scrollController;

  Future<List<Announcement>> fetchAnnEng() async {
    final response =
        await http.get(Uri.parse('${global.apiAddress}GetAllAnnEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<Announcement>((json) => Announcement.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Announcement>> fetchAnnArb() async {
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllAnnArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<Announcement>((json) => Announcement.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> fetchEventsEng() async {
    final responseEng =
        await http.get(Uri.parse(global.apiAddress + 'GetAllEventsEng'));

    if (responseEng.statusCode == 200) {
      final parsedEng =
          json.decode(responseEng.body).cast<Map<String, dynamic>>();

      return parsedEng
          .map<EventModel>((json) => EventModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> fetchEventsArb() async {
    final responseArb =
        await http.get(Uri.parse(global.apiAddress + 'GetAllEventsArb'));

    if (responseArb.statusCode == 200) {
      final parsedArb =
          json.decode(responseArb.body).cast<Map<String, dynamic>>();

      return parsedArb
          .map<EventModel>((json) => EventModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<User>> fetchuser() async {
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllUsers'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<User>((json) => User.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<User>> futureuser;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();
    futureuser = fetchuser();
    getEml();
    super.initState();
  }

  String email = "";

  void getEml() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? route = pref.getString("route");
    print("Route: $route");
    if (route != null) {
      pref.remove("route");
    }

    await pref.setString("route", "Course");

    setState() {
      email = pref.getString("email")!;
      print(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final annCard = InkWell(
      hoverColor: Colors.transparent,
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => specificAnn()),
        // );
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: width * 0.355,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFFFFFF),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.04,
                    child: SvgPicture.asset("assets/images/bell.svg",
                        height: 2, width: 2, fit: BoxFit.scaleDown),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F2E7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(
                                "Update to Our Academy Guidelines: View now"
                                    .tr()
                                    .toString(),
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
                              SizedBox(height: height * 0.01),
                              Text(
                                "10 May, 2022 | 5:29 PM".tr().toString(),
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
                              SizedBox(
                                height: height * 0.02,
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(width: 70),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );


    // final eventCard = InkWell(
    //   hoverColor: Colors.transparent,
    //   onTap: (){
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => webSpecificEvent()),
    //     );
    //   },
    //   child: Material(
    //     color: Color(0xFFffffff),
    //
    //     elevation: 1,
    //     borderRadius: BorderRadius.circular(10),
    //     child: Container(
    //       width: width*0.355,
    //       height: height*0.09,
    //       decoration:  BoxDecoration(
    //         borderRadius: BorderRadius.circular(150),
    //
    //       ),
    //
    //       child: Container(
    //
    //
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Container(
    //               height: height*0.13,
    //
    //               width: width*0.04,
    //
    //               child:
    //               Expanded(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Text("Jun ".tr().toString(),strutStyle: StrutStyle(
    //                         forceStrutHeight: true
    //                     ),
    //                       style:
    //                       GoogleFonts.barlow(
    //                         textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
    //                     ),SizedBox(height: 5),
    //                     Text("16".tr().toString(),strutStyle: StrutStyle(
    //                         forceStrutHeight: true
    //                     ),style:
    //                     GoogleFonts.barlow(
    //                       textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 20,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               decoration: BoxDecoration(
    //                 color: Color(0xFFF9F2E7),
    //                 borderRadius: BorderRadius.circular(10),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Row(
    //                 children: [
    //                   Container(
    //
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: [
    //                         SizedBox(height: height*0.007,),
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 8.0),
    //
    //                           child: Text("5:30 PM - 6:30 PM".tr().toString(),strutStyle: StrutStyle(
    //                               forceStrutHeight: true
    //                           ),
    //                             style:
    //                             GoogleFonts.barlow(
    //                               textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
    //                           ),
    //                         ),
    //
    //                         SizedBox(height: height*0.01,),
    //
    //
    //
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 8.0),
    //                           child: Text("Meet & Greet".tr().toString(),strutStyle: StrutStyle(
    //                               forceStrutHeight: true
    //                           ),
    //                             style:
    //                             GoogleFonts.barlow(
    //                               textStyle : TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
    //
    //                           ),
    //                         ),
    //                         // SizedBox(height: 5),
    //                         SizedBox(height: height*0.007,),
    //
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //
    //                 ],
    //               ),
    //             ),
    //
    //           ],
    //         ),
    //
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        // MaterialPageRoute(builder: (context) => coursesPage()),
                        // transitionDuration: const Duration(seconds: 0),
                      ),
                    },
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
                        "Announcements".tr(),
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
                              announcements(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                        // MaterialPageRoute(builder: (context) => coursesPage()),
                        // transitionDuration: const Duration(seconds: 0),
                      )
                    },
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
                        // MaterialPageRoute(builder: (context) => coursesPage()),
                        // transitionDuration: const Duration(seconds: 0),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.0028),
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              MessageResponsive(),
                                      transitionDuration: Duration(seconds: 0),
                                    ),
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
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              settingResponsive(),
                                      transitionDuration: Duration(seconds: 0),
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
                      ),

                      Container(
                        height: height * 0.13,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.002),
                              child: Text(
                                "Administration".tr(),
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
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.002),
                            child: Text(
                              "Events".tr(),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: Color(0xFFBD9B60),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            eventResponsive(),
                                    transitionDuration: Duration(seconds: 0),
                                  ));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "View all ".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        color: Color(0xFF215732),
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                  child: ImageIcon(
                                      AssetImage(context.locale == Locale("en")
                                          ? "assets/images/forward.png"
                                          : "assets/images/arArrow.png"),
                                      color: Color(0xFF215732),
                                      size: 9),
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10),
                                  // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),

                      Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FutureBuilder<List<EventModel>>(
                            future: context.locale == const Locale('en')
                                ? fetchEventsEng()
                                : fetchEventsArb(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 6 / 1),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (_, index) => Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: InkWell(
                                        hoverColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  webSpecificEvent(
                                                eventID: snapshot
                                                    .data![index].event_id,
                                                eventTitle: snapshot
                                                    .data![index].event_title,
                                              ),
                                              transitionDuration:
                                                  const Duration(seconds: 0),
                                            ),
                                            // MaterialPageRoute(builder: (context) => coursesPage()),
                                            // transitionDuration: const Duration(seconds: 0),
                                          );
                                        },
                                        child: Material(
                                          elevation: 2,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            width: width * 0.355,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: width * 0.04,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data![index].event_start_date}"
                                                                .substring(0, 3)
                                                                .tr()
                                                                .toString(),
                                                            strutStyle: StrutStyle(
                                                                forceStrutHeight:
                                                                    true),
                                                            style: GoogleFonts
                                                                .barlow(
                                                              textStyle: TextStyle(
                                                                  fontFamily:
                                                                      'Barlow',
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: Color(
                                                                      0xFF999999)),
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            "${snapshot.data![index].event_start_date}"
                                                                .substring(4, 6)
                                                                .tr()
                                                                .toString(),
                                                            strutStyle: StrutStyle(
                                                                forceStrutHeight:
                                                                    true),
                                                            style: GoogleFonts
                                                                .barlow(
                                                              textStyle: TextStyle(
                                                                  fontFamily:
                                                                      'Barlow',
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: Color(
                                                                      0xFFBD9B60)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFF9F2E7),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.02,
                                                                ),
                                                                Text(
                                                                  "${snapshot.data![index].event_title}"
                                                                      .tr()
                                                                      .toString(),
                                                                  strutStyle: StrutStyle(
                                                                      forceStrutHeight:
                                                                          true),
                                                                  style:
                                                                      GoogleFonts
                                                                          .barlow(
                                                                    textStyle: TextStyle(
                                                                        fontFamily:
                                                                            'Barlow',
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        color: Color(
                                                                            0xFF222222)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.01),
                                                                Text(
                                                                  DateFormat.yMMMMd(context
                                                                          .locale
                                                                          .toString())
                                                                      .format(DateFormat('MMM dd yyyy').parse(snapshot
                                                                          .data![
                                                                              index]
                                                                          .event_start_date)),
                                                                  strutStyle: StrutStyle(
                                                                      forceStrutHeight:
                                                                          true),
                                                                  style:
                                                                      GoogleFonts
                                                                          .barlow(
                                                                    textStyle: TextStyle(
                                                                        fontFamily:
                                                                            'Barlow',
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        color: Color(
                                                                            0xFF999999)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.02,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          // SizedBox(width: 70),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                    child: Text("No Items Found".tr()));
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.002),
                            child: Text(
                              "Announcements".tr(),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: Color(0xFFBD9B60),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          announcementResponsive(),
                                  transitionDuration: Duration(seconds: 0),
                                ),
                                // MaterialPageRoute(builder: (context) => coursesPage()),
                                // transitionDuration: const Duration(seconds: 0),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "View all ".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        color: Color(0xFF215732),
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                  child: ImageIcon(
                                      AssetImage(context.locale == Locale("en")
                                          ? "assets/images/forward.png"
                                          : "assets/images/arArrow.png"),
                                      color: Color(0xFF215732),
                                      size: 9),
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10),
                                  // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),

                      Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FutureBuilder<List<Announcement>>(
                            future: context.locale == const Locale('en')
                                ? fetchAnnEng()
                                : fetchAnnArb(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 6 / 1),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (_, index) => Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: InkWell(
                                        hoverColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  specificAnn(
                                                      current_ann: snapshot
                                                          .data![index].ann_id,
                                                      ann_title: snapshot
                                                          .data![index]
                                                          .ann_title),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ),
                                          );
                                        },
                                        child: Material(
                                          elevation: 2,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            width: width * 0.355,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: width * 0.04,
                                                      child: SvgPicture.asset(
                                                          "assets/images/bell.svg",
                                                          height: 2,
                                                          width: 2,
                                                          fit:
                                                              BoxFit.scaleDown),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFF9F2E7),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.02,
                                                                ),
                                                                Text(
                                                                  "${snapshot.data![index].ann_title}"
                                                                      .tr()
                                                                      .toString(),
                                                                  strutStyle: StrutStyle(
                                                                      forceStrutHeight:
                                                                          true),
                                                                  style:
                                                                      GoogleFonts
                                                                          .barlow(
                                                                    textStyle: TextStyle(
                                                                        fontFamily:
                                                                            'Barlow',
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        color: Color(
                                                                            0xFF222222)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.01),
                                                                Text(
                                                                  DateFormat.yMMMMd(context
                                                                          .locale
                                                                          .toString())
                                                                      .format(DateTime.parse(snapshot
                                                                          .data![
                                                                              index]
                                                                          .ann_creation_time)),
                                                                  strutStyle: StrutStyle(
                                                                      forceStrutHeight:
                                                                          true),
                                                                  style:
                                                                      GoogleFonts
                                                                          .barlow(
                                                                    textStyle: TextStyle(
                                                                        fontFamily:
                                                                            'Barlow',
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        color: Color(
                                                                            0xFF999999)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.02,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          // SizedBox(width: 70),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                    child: Text("No Items Found".tr()));
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.002),
                            child: Text(
                              "Users".tr(),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: Color(0xFFBD9B60),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            userResponsive(),
                                    transitionDuration: Duration(seconds: 0),
                                  ));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "View all ".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle(
                                        color: Color(0xFF215732),
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                  child: ImageIcon(
                                      AssetImage(context.locale == Locale("en")
                                          ? "assets/images/forward.png"
                                          : "assets/images/arArrow.png"),
                                      color: Color(0xFF215732),
                                      size: 9),
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10),
                                  // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FutureBuilder<List<User>>(
                            future: futureuser,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 6 / 1),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (_, index) => Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: context.locale == Locale("en")
                                              ? width * 0.008
                                              : 0.0,
                                          right: context.locale == Locale("en")
                                              ? 0.0
                                              : width * 0.008,
                                          top: 8.0,
                                          bottom: 8),
                                      child: InkWell(
                                        hoverColor: Colors.transparent,
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => specificAnn()),
                                          // );
                                        },
                                        child: InkWell(
                                          hoverColor: Colors.transparent,
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => webSpecificUser()),
                                            // );
                                          },
                                          child: Material(
                                            color: Color(0xFFffffff),
                                            elevation: 1,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                                width: width * 0.355,
                                                height: height * 0.09,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          150),
                                                ),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                              width:
                                                                  width * 0.05,
                                                              child: Image.asset(
                                                                  "assets/images/smallpfp.png")),
                                                          Container(
                                                            width: width * 0.2,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              // mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          15.0),
                                                                  child: Text(
                                                                    "${snapshot.data![index].name}"
                                                                        .tr(),
                                                                    style: GoogleFonts
                                                                        .barlow(
                                                                      textStyle: TextStyle(
                                                                          color: Color(
                                                                              0xFF222222),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontStyle: FontStyle
                                                                              .normal,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          15.0),
                                                                  child: Text(
                                                                    "${snapshot.data![index].email}",
                                                                    style: GoogleFonts
                                                                        .barlow(
                                                                      textStyle: TextStyle(
                                                                          color: Color(
                                                                              0xFF999999),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontStyle: FontStyle
                                                                              .normal,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 8.0,
                                                                left: 8.0),
                                                        child: Container(
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: Color(
                                                                  0xFFffffff),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18.0),
                                                                side:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFBD9B60),
                                                                  width: 0.5,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '${snapshot.data![index].user_type}'
                                                                  .tr(),
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF222222),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                    child: Text("No Items Found".tr()));
                              }
                            },
                          ),
                        ),
                      ),

                      // Container(
                      //
                      //
                      //   child: Card(
                      //     shape: RoundedRectangleBorder(
                      //       side: BorderSide(color: Colors.white70, width: 1),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Column(
                      //           children: [
                      //             Padding(
                      //               padding:  EdgeInsets.only(left:  context.locale == Locale("en") ? width*0.008: 0.0 ,right:  context.locale == Locale("en") ?  0.0 :width*0.008 ,top: 8.0,bottom:8),
                      //
                      //               child: userCard,
                      //             ),
                      //
                      //
                      //
                      //           ],
                      //         ),
                      //         Column(
                      //           children: [
                      //             Padding(
                      //               padding:  EdgeInsets.only(top: 8.0,left:  context.locale == Locale("en") ?  0.0:width*0.008,right:context.locale == Locale("en") ? width*0.008: 0.0 ,bottom: 8),
                      //
                      //               child: userCard1,
                      //             ),
                      //
                      //
                      //
                      //
                      //           ],
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
