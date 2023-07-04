import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/pfpimg.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/faqResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/main.dart';
import 'package:pif_admin_dashboard/settings.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';


class help extends StatefulWidget {
  const help({Key? key}) : super(key: key);

  @override
  State<help> createState() => _helpState();
}

class _helpState extends State<help> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String? dropdownvalue = 'Admin';

    final role = Container(
      height: height * 0.3,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: const InputDecoration.collapsed(hintText: ''),
          icon: const Icon(
            Icons.expand_more_rounded,
            size: 18,
            color: Color(0Xff999999),
          ),

          iconSize: 4.0,

          // Initial Value
          value: dropdownvalue,
          // Down Arrow Icon

          // Array list of items
          items: [
            DropdownMenuItem(
              value: "Admin",
              child: Text(
                '   Admin'.tr().toString(),
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
            const DropdownMenuItem(
              value: "Instructor",
              child: Text('  Instructor'),
            ),
          ],

          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = "ej";
            });
          },
        ),
      ),
    );
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    leading: SvgPicture.asset("assets/images/home.svg",
                        color: const Color(0xFFBD9B60)),
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
                    leading: const Padding(
                        padding: EdgeInsets.only(right: 2.0, left: 2),
                        child: Icon(Icons.list,
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
                  ListTile(
                    leading: SvgPicture.asset("assets/images/admin.svg",
                        color: const Color(0xFFBD9B60)),
                    minLeadingWidth: width * 0.02,
                    title: Text(
                      "Administration".tr(),
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
                              const adminResponsive(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.0028),
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
                              const settings(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right:
                            context.locale == const Locale("en") ? width * 0.01 : 0.0,
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
                        leading: SvgPicture.asset("assets/images/Headphone.svg",
                            color: Colors.white),
                        minLeadingWidth: width * 0.02,
                        title: Text(
                          "Help".tr(),
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
                                  const helpResponsive(),
                              transitionDuration: const Duration(seconds: 0),
                            ),
                          )
                        },
                      ),
                    ),
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
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MyApp(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      )
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        height: height * 0.08,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset("assets/images/message.svg"),
                            SizedBox(
                              width: width * 0.0152,
                            ),
                            pfpImage ??
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
                                      ))
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.005,
                          ),
                          Text(
                            "Help".tr(),
                            style: GoogleFonts.barlow(
                              textStyle: const TextStyle(
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.015),
                      Container(
                        width: width * 0.73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height * 0.25,
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/helpCard.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.06,
                                    left: width * 0.01,
                                    right: width * 0.01),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width * 0.04,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          "Email us".tr(),
                                          style: GoogleFonts.barlow(
                                            textStyle: const TextStyle(
                                                color: Color(0xFF222222),
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.025,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.009),
                                          child: SvgPicture.asset(
                                              "assets/images/message.svg"),
                                        ),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        Container(
                                          width: width * 0.16,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Text(
                                              "contact@pif.gov.sa ".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: const TextStyle(
                                                    color: Color(0xFFBD9B60),
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.025,
                                    ),
                                    Text(
                                      "We will get back to you as soon as we can"
                                          .tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: const TextStyle(
                                            color: Color(0xFF999999),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.25,
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/helpCard.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.06,
                                    left: width * 0.01,
                                    right: width * 0.01),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width * 0.03,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          "Call us".tr(),
                                          style: GoogleFonts.barlow(
                                            textStyle: const TextStyle(
                                                color: Color(0xFF222222),
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.025,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.007),
                                          child: SvgPicture.asset(
                                              "assets/images/Call.svg"),
                                        ),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        Container(
                                          width: width * 0.13,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Text(
                                              "+96626658430 ".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: const TextStyle(
                                                    color: Color(0xFFBD9B60),
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.025,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        " Or submit the form below".tr(),
                        style: GoogleFonts.barlow(
                          textStyle: TextStyle(
                              color: const Color(0xFFBD9B60),
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: width * 0.0125),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Card(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.724,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 20.0,
                                bottom: 5.0),
                            child: Row(
                              children: [
                                Text(
                                  "Name".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: const TextStyle(
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.347,
                                ),
                                Text(
                                  "Your role".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: const TextStyle(
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.008,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.34,
                                  height: height * 0.05,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFEEEEEE),
                                            width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFEEEEEE),
                                            width: 0.0),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Container(
                                    width: width * 0.34,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: const Color(0xFFEEEEEE)),
                                      borderRadius: BorderRadius.circular(4.5),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * 0.015),
                                      child: role,
                                    )),
                                // SizedBox(
                                //   width: width*0.328,
                                //   height: height*0.06,
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //         border: Border.all(color: Color(0xFFEEEEEE),),
                                //       borderRadius: BorderRadius.circular(5)
                                //     ),
                                //     child: DropdownButtonHideUnderline(
                                //       child: DropdownButton(
                                //         iconSize: 4.0,
                                //
                                //         // Initial Value
                                //         value: lang,
                                //         // Down Arrow Icon
                                //
                                //         // Array list of items
                                //         items: [
                                //           DropdownMenuItem( value: "Admin",
                                //             child: Text( '   Admin'.tr().toString(),    style: GoogleFonts.barlow(textStyle:  TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),),),
                                //           DropdownMenuItem( value: "Instructor",
                                //
                                //             child: Text( 'Instructor'),),
                                //
                                //         ], onChanged: (Object? value) {  },
                                //
                                //
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 20.0,
                                bottom: 5.0),
                            child: Row(
                              children: [
                                Text(
                                  "Describe your issue".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: const TextStyle(
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.008,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.328,
                                  height: height * 0.2,
                                  child: const TextField(
                                    maxLines: 15,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFEEEEEE),
                                            width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFEEEEEE),
                                            width: 0.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.04,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.656,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Submit'.tr().toString(),
                                    strutStyle:
                                        const StrutStyle(forceStrutHeight: true)),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF215732),
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minimumSize: Size(width * 0.06, 50),
                                    side: const BorderSide(
                                        width: 0.3, color: Color(0xffF5F0E5))),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
