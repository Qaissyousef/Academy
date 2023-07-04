import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/settings.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import 'main.dart';

import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';

class webspecmessages extends StatefulWidget {
  const webspecmessages({Key? key}) : super(key: key);

  @override
  State<webspecmessages> createState() => _webspecmessagesState();
}

class _webspecmessagesState extends State<webspecmessages> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }

  bool? CheckBoxValue = false;
  bool? CheckBoxValue1 = false;
  bool? CheckBoxValue2 = false;
  bool? CheckBoxValue3 = false;
  bool? CheckBoxValue4 = false;
  bool? CheckBoxValue5 = false;
  bool? CheckBoxValue6 = false;
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

    final searchtab = Container(
      height: height * 0.05,
      width: width * 0.31,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 18.0, right: 20.0, top: 5, bottom: 5),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/images/search.svg",
              fit: BoxFit.scaleDown,
            ),

            SizedBox(
              width: width * 0.009,
            ),
            Text(
              "  Search".tr().toString(),
              style: GoogleFonts.barlow(
                textStyle: TextStyle(
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: width * 0.01),
              ),
            ),
            SizedBox(
              width: width * 0.15,
            ),
            SvgPicture.asset(
              "assets/images/mic.svg",
              fit: BoxFit.scaleDown,
            ),

            SizedBox(
              width: width * 0.007,
            ),
            Image.asset("assets/images/Separator.png"),
            // SvgPicture.asset("assets/images/Separator.svg",fit: BoxFit.scaleDown,),

            InkWell(
              hoverColor: Colors.transparent,
              onTap: () async {
                DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 5),
                    lastDate: DateTime(DateTime.now().year + 5),
                    builder: (context, child) {
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
                                maxWidth: 400.0,
                                maxHeight: height * 0.7,
                              ),
                              child: child,
                            )
                          ],
                        ),
                      );
                    });
                print(picked);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.012,
                  ),
                  SvgPicture.asset(
                    "assets/images/filter.svg",
                    fit: BoxFit.scaleDown,
                  ),
                  Text(
                    "  Filter".tr(),
                    style: GoogleFonts.barlow(
                      textStyle: TextStyle(
                          color: Color(0xFF215732),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: width * 0.01),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    final sortbtn = Container(
      height: height * 0.05,
      width: width * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/sort.svg",
            fit: BoxFit.scaleDown,
          ),
          Text(
            "  Sort".tr(),
            style: GoogleFonts.barlow(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: width * 0.01),
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      body: Container(
        child: Row(
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
                      leading: SvgPicture.asset("assets/images/home.svg",
                          color: Color(0xFFBD9B60)),
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
                          MaterialPageRoute(
                              builder: (context) => HomeResponsive()),
                        )
                      },
                    ),
                    ListTile(
                      leading: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.001, right: width * 0.002),
                        child: Icon(Icons.list,
                            color: Color(0xFFBD9B60), size: 26.2),
                      ),
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
                          MaterialPageRoute(
                              builder: (context) => courseResponsive()),
                        )
                      },
                    ),
                    ListTile(
                      leading: Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.001, left: width * 0.001),
                        child: SvgPicture.asset("assets/images/admin.svg",
                            color: Color(0xFFBD9B60)),
                      ),
                      minLeadingWidth: width * 0.02,
                      title: Text(
                        "Administration".tr(),
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
                          MaterialPageRoute(
                              builder: (context) => adminResponsive()),
                        )
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
                          MaterialPageRoute(
                              builder: (context) => admissionResponsive()),
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
                          MaterialPageRoute(builder: (context) => settings()),
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
                          MaterialPageRoute(
                              builder: (context) => helpResponsive()),
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
                    Padding(
                      padding: EdgeInsets.only(
                          right: context.locale == Locale("en")
                              ? width * 0.01
                              : 0.0,
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
                          leading: SvgPicture.asset("assets/images/message.svg",
                              color: Colors.white),
                          minLeadingWidth: width * 0.02,
                          title: Text(
                            "Messages".tr(),
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
                              MaterialPageRoute(
                                  builder: (context) => MessageResponsive()),
                            )
                          },
                        ),
                      ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
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
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              settingResponsive()),
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/images/pfpIcons.png",
                                    scale: 4.5,
                                  ))
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
                              SizedBox(
                                width: width * 0.002,
                              ),
                              Text(
                                "Messages".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 28),
                                ),
                              ),
                            ],
                          ),
                        ),
                        eventCard,
                        SizedBox(height: height * 0.05),
                        Card(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.672,
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
                                    width: width * 0.01,
                                  ),
                                  Container(
                                    height: 20.0,
                                    width: 20.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: SizedBox(
                                      height: 24.0,
                                      width: 24.0,
                                      child: Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: Color(0xFFBD9B60),
                                          side: BorderSide(
                                            color: Color(
                                                0xFFEEEEEE), //your desire colour here
                                            width: 1.5,
                                          ),
                                          value: CheckBoxValue,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              CheckBoxValue = value;
                                              CheckBoxValue1 = value;
                                              CheckBoxValue2 = value;
                                              CheckBoxValue3 = value;
                                              CheckBoxValue4 = value;
                                              CheckBoxValue5 = value;
                                              CheckBoxValue6 = value;
                                            });
                                          }),
                                    ),
                                  ),
                                  Text(
                                    "  Select all".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: TextStyle(
                                          color: Color(0xFFBD9B60),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: width * 0.01),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  SvgPicture.asset("assets/images/red_bin.svg",
                                      color: Color(0xFFBD9B60)),
                                  SizedBox(
                                    width: width * 0.008,
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/openmessage.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  searchtab,
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  sortbtn
                                ],
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
                                            MessageResponsive(),
                                    transitionDuration: Duration(seconds: 0),
                                  ),
                                  // MaterialPageRoute(builder: (context) => coursesPage()),
                                  // transitionDuration: const Duration(seconds: 0),
                                );
                              },
                              child: Container(
                                width: width * 0.672,
                                height: height * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(9.0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(9.0),
                                      bottomLeft: Radius.circular(0)),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Container(
                                      height: 20.0,
                                      width: 20.0,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: SizedBox(
                                        height: 24.0,
                                        width: 24.0,
                                        child: Checkbox(
                                            checkColor: Colors.white,
                                            activeColor: Color(0xFFBD9B60),
                                            side: BorderSide(
                                              color: Color(
                                                  0xFFEEEEEE), //your desire colour here
                                              width: 1.5,
                                            ),
                                            value: CheckBoxValue1,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                CheckBoxValue1 = value;
                                              });
                                            }),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.017,
                                    ),
                                    Image.asset("assets/images/f1.png",
                                        scale: 4),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Container(
                                      width: width * 0.084,
                                      child: Text(
                                        "Preeti".tr(),
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFF222222),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.41,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 0),
                                        //18.0
                                        child: Row(
                                          children: [
                                            Text(
                                              "I have some doubts...".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF222222),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Container(
                                      width: width * 0.08,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 9.0, bottom: 9.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.022,
                                            ),
                                            Image.asset(
                                                "assets/images/star.png",
                                                color: Color(0xFFBD9B60)),
                                            Text(
                                              "  6:00 PM".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF222222),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: width * 0.672,
                              child: Padding(
                                //right:
                                padding: EdgeInsets.only(
                                    right: context.locale == Locale("en")
                                        ? 0
                                        : width * 0.05,
                                    left: context.locale == Locale("en")
                                        ? width * 0.05
                                        : 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "I have some doubts, ".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      "Can you please explain me on how to contact xyz for referral? I also am unable to access"
                                          .tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      "one of my courses and there is a class that is due  "
                                          .tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.46,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 2),
                                            child: Text('Reply'.tr().toString(),
                                                strutStyle: StrutStyle(
                                                    forceStrutHeight: true),
                                                style: GoogleFonts.barlow(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 14),
                                                )),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFFBD9B60),
                                            elevation: 0.0,
                                            shadowColor: Colors.transparent,
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 2),
                                            child: Text(
                                                'Mark as resolved'
                                                    .tr()
                                                    .toString(),
                                                strutStyle: StrutStyle(
                                                    forceStrutHeight: true),
                                                style: GoogleFonts.barlow(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF46574d),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 14),
                                                )),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFFd1ccbd),
                                            elevation: 0.0,
                                            shadowColor: Colors.transparent,
                                            onPrimary: Color(0xFF46574d),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                        eventCard,
                      ],
                    ),
                  )),
                ),
              ),
            ),
            // Container(
            //   height: height,
            //   width: width*0.76,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(height: height*0.02,),
            //         Container(
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               InkWell(
            //                   hoverColor: Colors.transparent,
            //                   onTap: (){
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute(builder: (context) => MessageResponsive()),
            //                     );
            //                   },
            //                   child: SvgPicture.asset("assets/images/message.svg")),
            //               SizedBox(width: width*0.0152,),
            //               InkWell(
            //                   hoverColor: Colors.transparent,
            //                   onTap: (){
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute(builder: (context) => settingResponsive()),
            //                     );
            //                   },child: Image.asset("assets/images/pfpIcons.png",scale:4.5,))
            //             ],
            //           ),
            //         ),
            //         Row(
            //           children: [
            //             SizedBox(width: 60,),
            //             GestureDetector(
            //                 onTap: (){Navigator.pop(context);},
            //                 child: Icon(Icons.arrow_back_ios,size: 17,color: Colors.black,)),
            //             SizedBox(width: width*0.002,),
            //             Text("Messages".tr(),style: GoogleFonts.barlow(
            //               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 28),
            //             ),),
            //           ],
            //         ),
            //         SizedBox(height: height*0.05),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 43.0,right: 43),
            //
            //           child: Card(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Container(
            //                     width: width*0.672,
            //                     height: height*0.07,
            //                     decoration: BoxDecoration(
            //                       color: Color(0xFFF5F0E5),
            //
            //                       borderRadius: BorderRadius.only(
            //                           topRight: Radius.circular(9.0),
            //                           bottomRight: Radius.circular(0),
            //                           topLeft: Radius.circular(9.0),
            //                           bottomLeft: Radius.circular(0)),
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         SizedBox(width: width*0.01,),
            //                         Container(
            //                           height: 20.0,
            //                           width: 20.0,
            //
            //                           decoration: BoxDecoration(
            //                               border: Border.all(color: Colors.grey),
            //                               borderRadius: BorderRadius.circular(3)
            //                           ),
            //                           child: SizedBox(
            //                             height: 24.0,
            //                             width: 24.0,
            //                             child: Checkbox(
            //                                 checkColor: Colors.white,
            //                                 activeColor: Color(0xFFBD9B60),
            //                                 side: BorderSide(
            //                                   color: Color(0xFFEEEEEE), //your desire colour here
            //                                   width: 1.5,
            //                                 ),
            //                                 value: CheckBoxValue, onChanged: (bool? value) {
            //                               setState(() {
            //                                 CheckBoxValue = value;
            //                                 CheckBoxValue1 = value;
            //                                 CheckBoxValue2 = value;
            //                                 CheckBoxValue3 = value;
            //                                 CheckBoxValue4 = value;
            //                                 CheckBoxValue5 = value;
            //                                 CheckBoxValue6 = value;
            //
            //
            //                               });
            //                             }),
            //                           ),
            //                         ),
            //                         Text("  Select all".tr(),style: GoogleFonts.barlow(
            //                           textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
            //                         ),),
            //                         SizedBox(width: width*0.01,),
            //                         SvgPicture.asset("assets/images/red_bin.svg",color: Color(0xFFBD9B60)),
            //                         SizedBox(width: width*0.008,),
            //
            //                         SvgPicture.asset("assets/images/openmessage.svg",fit: BoxFit.scaleDown,),
            //
            //                         SizedBox(width: width*0.05,),
            //
            //                         searchtab,
            //                         SizedBox(width: width*0.01,),
            //                         sortbtn
            //
            //                       ],
            //                     ),
            //                   ),
            //
            //
            //
            //
            //                   InkWell(
            //                     hoverColor: Colors.transparent,
            //                     onTap: (){
            //                       Navigator.push(
            //                         context,
            //                         MaterialPageRoute(builder: (context) => MessageResponsive()),
            //                       );
            //                     },
            //                     child: Container(
            //                       width: width*0.672,
            //
            //                       height: height*0.07,
            //                       decoration: BoxDecoration(
            //
            //
            //                         borderRadius: BorderRadius.only(
            //                             topRight: Radius.circular(9.0),
            //                             bottomRight: Radius.circular(0),
            //                             topLeft: Radius.circular(9.0),
            //                             bottomLeft: Radius.circular(0)),
            //                       ),
            //                       child: Row(
            //                         children: [
            //                           SizedBox(width: width*0.01,),
            //                           Container(
            //                             height: 20.0,
            //                             width: 20.0,
            //
            //                             decoration: BoxDecoration(
            //                                 border: Border.all(color: Colors.grey),
            //                                 borderRadius: BorderRadius.circular(3)
            //                             ),
            //                             child: SizedBox(
            //                               height: 24.0,
            //                               width: 24.0,
            //                               child: Checkbox(
            //                                   checkColor: Colors.white,
            //                                   activeColor: Color(0xFFBD9B60),
            //                                   side: BorderSide(
            //                                     color: Color(0xFFEEEEEE), //your desire colour here
            //                                     width: 1.5,
            //                                   ),
            //                                   value: CheckBoxValue1, onChanged: (bool? value) {
            //                                 setState(() {
            //                                   CheckBoxValue1 = value;
            //                                 });
            //                               }),
            //                             ),
            //                           ),
            //                           SizedBox(width: width*0.017,),
            //
            //                           Image.asset("assets/images/smallpfp.png"),
            //                           SizedBox(width: width*0.01,),
            //
            //                           Container(
            //                             width: width*0.084,
            //                             child: Text("Saad Alkroud".tr(),style: GoogleFonts.barlow(
            //                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                             ),),
            //                           ),
            //
            //
            //                           Container(
            //                             width: width*0.41,
            //
            //                             child: Padding(
            //                               padding: const EdgeInsets.only(right: 0),
            //                               //18.0
            //                               child: Row(
            //                                 children: [
            //                                   Text("This is a message title ".tr(),style: GoogleFonts.barlow(
            //                                     textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                   ),),
            //                                   Container(
            //                                     width: width*0.3,
            //
            //                                     child: Text("Lorem ipsum dolor orem ipsum dolor  orem ipsum dolor  sit amet,Lorem ipsum dolor sit amet,Lorem ipsum dolor sit amet, ".tr(),overflow: TextOverflow.ellipsis,style: GoogleFonts.barlow(
            //                                       textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                     ),),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                           SizedBox(width: width*0.02,),
            //                           Container(
            //                             width: width*0.08,
            //
            //                             child: Padding(
            //                               padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
            //                               child: Row(
            //                                 children: [
            //                                   SizedBox(width: width*0.022,),
            //                                   Image.asset("assets/images/star.png",color:Color(0xFFBD9B60)),
            //                                   Text("  5:30 PM".tr(),style: GoogleFonts.barlow(
            //                                     textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                   ),),
            //
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     width: width*0.672,
            //                     child: Padding(
            //                       //left: 78.0,
            //                       padding:  EdgeInsets.only(left: width*0.05),
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           SizedBox(height: 10,),
            //
            //                           Text("This is a message title ".tr(),style: GoogleFonts.barlow(
            //                             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                           ),),
            //                           SizedBox(height: 20,),
            //                           Text("Lorem ipsum dolor sit amet, consectetur fringilla  adipiscing elit. Ut nec fringilla quam cursus ut.".tr(),style: GoogleFonts.barlow(
            //                             textStyle: TextStyle(color: Color(0xFF222222),  fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                           ),),
            //                           SizedBox(height: 3,),
            //                           Text("Lorem ipsum dolor sit amet, consectetur fringilla  adipiscing elit. Ut nec fringilla quam cursus ut.".tr(),style: GoogleFonts.barlow(
            //                             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                           ),),
            //                           SizedBox(height: 3,),
            //
            //                           Text("Lorem ipsum dolor sit amet, consectetur fringilla  adipiscing elit. Ut nec fringilla quam cursus ut.".tr(),style: GoogleFonts.barlow(
            //                             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                           ),),
            //                           SizedBox(height: 3,),
            //
            //                           Text("Lorem ipsum dolor sit amet, consectetur fringilla  adipiscing elit. Ut nec fringilla quam cursus ut.".tr(),style: GoogleFonts.barlow(
            //                             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                           ),),
            //                           SizedBox(height: 10,),
            //                           Row(
            //                             children: [
            //                               SizedBox(width: width*0.46,),
            //                               ElevatedButton(
            //                                 onPressed: () {
            //
            //                                 },
            //                                 child: Padding(
            //                                   padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 2),
            //                                   child: Text('Reply'.tr().toString(),strutStyle: StrutStyle(
            //                                       forceStrutHeight: true
            //                                   ),style: GoogleFonts.barlow(
            //                                     textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                                   )),
            //                                 ),
            //                                 style: ElevatedButton.styleFrom(
            //                                   primary: Color(0xFFBD9B60),
            //                                   elevation: 0.0,
            //                                   shadowColor: Colors.transparent,
            //                                   onPrimary: Colors.white,
            //                                   shape: RoundedRectangleBorder(
            //                                     borderRadius: BorderRadius.circular(7),
            //                                   ),
            //
            //                                 ),
            //                               ),
            //                               SizedBox(width: 10,),
            //                               ElevatedButton(
            //                                 onPressed: () {
            //
            //                                 },
            //                                 child: Padding(
            //                                   padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 2),
            //                                   child: Text('Mark as resolved'.tr().toString(),strutStyle: StrutStyle(
            //                                       forceStrutHeight: true
            //                                   ),style: GoogleFonts.barlow(
            //                                     textStyle: TextStyle(color: Color(0xFF46574d), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                                   )),
            //                                 ),
            //                                 style: ElevatedButton.styleFrom(
            //                                   primary: Color(0xFFd1ccbd),
            //                                   elevation: 0.0,
            //                                   shadowColor: Colors.transparent,
            //                                   onPrimary: Color(0xFF46574d),
            //                                   shape: RoundedRectangleBorder(
            //                                     borderRadius: BorderRadius.circular(7),
            //                                   ),
            //
            //                                 ),
            //                               ),
            //                             ],
            //                           )
            //
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //
            //
            //                   Container(
            //                     width: width*0.672,
            //
            //                     height: height*0.07,
            //                     decoration: BoxDecoration(
            //
            //
            //                       borderRadius: BorderRadius.only(
            //                           topRight: Radius.circular(9.0),
            //                           bottomRight: Radius.circular(0),
            //                           topLeft: Radius.circular(9.0),
            //                           bottomLeft: Radius.circular(0)),
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         SizedBox(width: width*0.01,),
            //                         Container(
            //                           height: 20.0,
            //                           width: 20.0,
            //
            //                           decoration: BoxDecoration(
            //                               border: Border.all(color: Colors.grey),
            //                               borderRadius: BorderRadius.circular(3)
            //                           ),
            //                           child: SizedBox(
            //                             height: 24.0,
            //                             width: 24.0,
            //                             child: Checkbox(
            //                                 checkColor: Colors.white,
            //                                 activeColor: Color(0xFFBD9B60),
            //                                 side: BorderSide(
            //                                   color: Color(0xFFEEEEEE), //your desire colour here
            //                                   width: 1.5,
            //                                 ),
            //                                 value: CheckBoxValue2, onChanged: (bool? value) {
            //                               setState(() {
            //                                 CheckBoxValue2 = value;
            //                               });
            //                             }),
            //                           ),
            //                         ),
            //                         SizedBox(width: width*0.017,),
            //
            //                         Image.asset("assets/images/smallpfp.png"),
            //                         SizedBox(width: width*0.01,),
            //
            //                         Container(
            //                           width: width*0.084,
            //                           child: Text("Mohammad Al...".tr(),style: GoogleFonts.barlow(
            //                             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                           ),),
            //                         ),
            //
            //                         Container(
            //                           width: width*0.41,
            //
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(right: 0),
            //                             //18.0
            //                             child: Row(
            //                               children: [
            //                                 Text("This is a message title ".tr(),style: GoogleFonts.barlow(
            //                                   textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                 ),),
            //                                 Container(
            //                                   width: width*0.3,
            //
            //                                   child: Text("Lorem ipsum dolor orem ipsum dolor  orem ipsum dolor  sit amet,Lorem ipsum dolor sit amet,Lorem ipsum dolor sit amet, ".tr(),overflow: TextOverflow.ellipsis,style: GoogleFonts.barlow(
            //                                     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                   ),),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(width: width*0.02,),
            //                         Container(
            //                           width: width*0.08,
            //
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
            //                             child: Row(
            //                               children: [
            //                                 SizedBox(width: width*0.022,),
            //                                 Image.asset("assets/images/star.png",color:Color(0xFFBD9B60)),
            //                                 Text("  5:30 PM".tr(),style: GoogleFonts.barlow(
            //                                   textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                 ),),
            //
            //                               ],
            //                             ),
            //                           ),
            //                         )
            //
            //                       ],
            //                     ),
            //                   ),
            //
            //
            //                   Container(
            //                     width: width*0.672,
            //
            //                     height: height*0.07,
            //                     decoration: BoxDecoration(
            //
            //
            //                       borderRadius: BorderRadius.only(
            //                           topRight: Radius.circular(9.0),
            //                           bottomRight: Radius.circular(0),
            //                           topLeft: Radius.circular(9.0),
            //                           bottomLeft: Radius.circular(0)),
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         SizedBox(width: width*0.01,),
            //                         Container(
            //                           height: 20.0,
            //                           width: 20.0,
            //
            //                           decoration: BoxDecoration(
            //                               border: Border.all(color: Colors.grey),
            //                               borderRadius: BorderRadius.circular(3)
            //                           ),
            //                           child: SizedBox(
            //                             height: 24.0,
            //                             width: 24.0,
            //                             child: Checkbox(
            //                               // checkColor: Colors.pink,
            //                                 checkColor: Colors.white,
            //                                 activeColor: Color(0xFFBD9B60),
            //                                 side: BorderSide(
            //                                   color: Color(0xFFEEEEEE), //your desire colour here
            //                                   width: 1.5,
            //                                 ),
            //                                 value: CheckBoxValue3, onChanged: (bool? value) {
            //                               setState(() {
            //                                 CheckBoxValue3 = value;
            //                               });
            //                             }),
            //                           ),
            //                         ),
            //                         SizedBox(width: width*0.017,),
            //
            //                         Image.asset("assets/images/smallpfp1.png"),
            //                         SizedBox(width: width*0.01,),
            //
            //                         Container(
            //                           width: width*0.084,
            //                           child: Text("Fatemah Khalid".tr(),style: GoogleFonts.barlow(
            //                             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                           ),),
            //                         ),
            //
            //
            //                         Container(
            //                           width: width*0.41,
            //
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(right: 0),
            //                             //18.0
            //                             child: Row(
            //                               children: [
            //                                 Text("This is a message title ".tr(),style: GoogleFonts.barlow(
            //                                   textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                 ),),
            //                                 Container(
            //                                   width: width*0.3,
            //
            //                                   child: Text("Lorem ipsum dolor orem ipsum dolor  orem ipsum dolor  sit amet,Lorem ipsum dolor sit amet,Lorem ipsum dolor sit amet, ".tr(),overflow: TextOverflow.ellipsis,style: GoogleFonts.barlow(
            //                                     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                   ),),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(width: width*0.02,),
            //                         Container(
            //                           width: width*0.08,
            //
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
            //                             child: Row(
            //                               children: [
            //                                 SizedBox(width: width*0.022,),
            //                                 Image.asset("assets/images/star.png",color:Color(0xFFBD9B60)),
            //                                 Text("  5:30 PM".tr(),style: GoogleFonts.barlow(
            //                                   textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                 ),),
            //
            //                               ],
            //                             ),
            //                           ),
            //                         )
            //
            //                       ],
            //                     ),
            //                   ),
            //
            //                   Container(
            //                     width: width*0.672,
            //
            //                     height: height*0.07,
            //                     decoration: BoxDecoration(
            //
            //
            //                       borderRadius: BorderRadius.only(
            //                           topRight: Radius.circular(9.0),
            //                           bottomRight: Radius.circular(0),
            //                           topLeft: Radius.circular(9.0),
            //                           bottomLeft: Radius.circular(0)),
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         SizedBox(width: width*0.01,),
            //                         Container(
            //                           height: 20.0,
            //                           width: 20.0,
            //
            //                           decoration: BoxDecoration(
            //                               border: Border.all(color: Colors.grey),
            //                               borderRadius: BorderRadius.circular(3)
            //                           ),
            //                           child: SizedBox(
            //                             height: 24.0,
            //                             width: 24.0,
            //                             child: Checkbox(
            //                                 checkColor: Colors.white,activeColor: Color(0xFFBD9B60),
            //                                 side: BorderSide(
            //                                   color: Color(0xFFEEEEEE), //your desire colour here
            //                                   width: 1.5,
            //                                 ),
            //                                 value: CheckBoxValue4, onChanged: (bool? value) {
            //                               setState(() {
            //                                 CheckBoxValue4 = value;
            //                               });
            //                             }),
            //                           ),
            //                         ),
            //                         SizedBox(width: width*0.017,),
            //
            //                         Image.asset("assets/images/smallpfp2.png"),
            //                         SizedBox(width: width*0.01,),
            //
            //                         Container(
            //                           width: width*0.084,
            //                           child: Text("Ayesha Mohammad".tr(),style: GoogleFonts.barlow(
            //                             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                           ),),
            //                         ),
            //
            //
            //                         Container(
            //                           width: width*0.41,
            //
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(right: 0),
            //                             //18.0
            //                             child: Row(
            //                               children: [
            //                                 Text("This is a message title ".tr(),style: GoogleFonts.barlow(
            //                                   textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                 ),),
            //                                 Container(
            //                                   width: width*0.3,
            //
            //                                   child: Text("Lorem ipsum dolor orem ipsum dolor  orem ipsum dolor  sit amet,Lorem ipsum dolor sit amet,Lorem ipsum dolor sit amet, ".tr(),overflow: TextOverflow.ellipsis,style: GoogleFonts.barlow(
            //                                     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                   ),),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(width: width*0.02,),
            //                         Container(
            //                           width: width*0.08,
            //
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
            //                             child: Row(
            //                               children: [
            //                                 SizedBox(width: width*0.022,),
            //                                 Image.asset("assets/images/star.png",color:Color(0xFFBD9B60)),
            //                                 Text("  5:30 PM".tr(),style: GoogleFonts.barlow(
            //                                   textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                 ),),
            //
            //                               ],
            //                             ),
            //                           ),
            //                         )
            //
            //                       ],
            //                     ),
            //                   ),
            //
            //                   Container(
            //                     width: width*0.672,
            //
            //                     height: height*0.07,
            //                     decoration: BoxDecoration(
            //
            //
            //                       borderRadius: BorderRadius.only(
            //                           topRight: Radius.circular(9.0),
            //                           bottomRight: Radius.circular(0),
            //                           topLeft: Radius.circular(9.0),
            //                           bottomLeft: Radius.circular(0)),
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         SizedBox(width: width*0.01,),
            //                         Container(
            //                           height: 20.0,
            //                           width: 20.0,
            //
            //                           decoration: BoxDecoration(
            //                               border: Border.all(color: Colors.grey),
            //                               borderRadius: BorderRadius.circular(3)
            //                           ),
            //                           child: SizedBox(
            //                             height: 24.0,
            //                             width: 24.0,
            //                             child: Checkbox(
            //                                 checkColor: Colors.white,
            //                                 activeColor: Color(0xFFBD9B60),
            //                                 side: BorderSide(
            //                                   color: Color(0xFFEEEEEE), //your desire colour here
            //                                   width: 1.5,
            //                                 ),
            //                                 value: CheckBoxValue5, onChanged: (bool? value) {
            //                               setState(() {
            //                                 CheckBoxValue5 = value;
            //                               });
            //                             }),
            //                           ),
            //                         ),
            //                         SizedBox(width: width*0.017,),
            //
            //                         Image.asset("assets/images/smallpfp.png"),
            //                         SizedBox(width: width*0.01,),
            //
            //                         Container(
            //                           width: width*0.084,
            //                           child: Text("Mohammad Al...".tr(),style: GoogleFonts.barlow(
            //                             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                           ),),
            //                         ),
            //
            //                         Container(
            //                           width: width*0.41,
            //
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(right: 0),
            //                             //18.0
            //                             child: Row(
            //                               children: [
            //                                 Text("This is a message title ".tr(),style: GoogleFonts.barlow(
            //                                   textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                 ),),
            //                                 Container(
            //                                   width: width*0.3,
            //
            //                                   child: Text("Lorem ipsum dolor orem ipsum dolor  orem ipsum dolor  sit amet,Lorem ipsum dolor sit amet,Lorem ipsum dolor sit amet, ".tr(),overflow: TextOverflow.ellipsis,style: GoogleFonts.barlow(
            //                                     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                   ),),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(width: width*0.02,),
            //                         Container(
            //                           width: width*0.08,
            //
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
            //                             child: Row(
            //                               children: [
            //                                 SizedBox(width: width*0.022,),
            //                                 Image.asset("assets/images/star.png",color:Color(0xFFBD9B60)),
            //                                 Text("  5:30 PM".tr(),style: GoogleFonts.barlow(
            //                                   textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                 ),),
            //
            //                               ],
            //                             ),
            //                           ),
            //                         )
            //
            //                       ],
            //                     ),
            //                   ),
            //
            //
            //
            //                   Container(
            //                     width: width*0.672,
            //
            //                     height: height*0.07,
            //                     decoration: BoxDecoration(
            //
            //
            //                       borderRadius: BorderRadius.only(
            //                           topRight: Radius.circular(9.0),
            //                           bottomRight: Radius.circular(0),
            //                           topLeft: Radius.circular(9.0),
            //                           bottomLeft: Radius.circular(0)),
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         SizedBox(width: width*0.01,),
            //                         Container(
            //                           height: 20.0,
            //                           width: 20.0,
            //
            //                           decoration: BoxDecoration(
            //                               border: Border.all(color: Colors.grey),
            //                               borderRadius: BorderRadius.circular(3)
            //                           ),
            //                           child: SizedBox(
            //                             height: 24.0,
            //                             width: 24.0,
            //                             child: Checkbox(
            //                                 checkColor: Colors.white,
            //                                 activeColor: Color(0xFFBD9B60),
            //                                 side: BorderSide(
            //                                   color: Color(0xFFEEEEEE), //your desire colour here
            //                                   width: 1.5,
            //                                 ),
            //                                 value: CheckBoxValue6, onChanged: (bool? value) {
            //                               setState(() {
            //                                 CheckBoxValue6 = value;
            //                               });
            //                             }),
            //                           ),
            //                         ),
            //                         SizedBox(width: width*0.017,),
            //
            //                         Image.asset("assets/images/smallpfp.png"),
            //                         SizedBox(width: width*0.01,),
            //
            //                         Container(
            //                           width: width*0.084,
            //                           child: Text("Mohammad Al...".tr(),style: GoogleFonts.barlow(
            //                             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
            //                           ),),
            //                         ),
            //
            //
            //                         Container(
            //                           width: width*0.41,
            //
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(right: 0),
            //                             //18.0
            //                             child: Row(
            //                               children: [
            //                                 Text("This is a message title ".tr(),style: GoogleFonts.barlow(
            //                                   textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                 ),),
            //                                 Container(
            //                                   width: width*0.3,
            //
            //                                   child: Text("Lorem ipsum dolor orem ipsum dolor  orem ipsum dolor  sit amet,Lorem ipsum dolor sit amet,Lorem ipsum dolor sit amet, ".tr(),overflow: TextOverflow.ellipsis,style: GoogleFonts.barlow(
            //                                     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                   ),),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(width: width*0.02,),
            //                         Container(
            //                           width: width*0.08,
            //
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
            //                             child: Row(
            //                               children: [
            //                                 SizedBox(width: width*0.022,),
            //                                 Image.asset("assets/images/star.png",color:Color(0xFFBD9B60)),
            //                                 Text("  5:30 PM".tr(),style: GoogleFonts.barlow(
            //                                   textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            //                                 ),),
            //
            //                               ],
            //                             ),
            //                           ),
            //                         )
            //
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               )
            //           ),
            //         ),
            //
            //
            //
            //
            //
            //
            //       ],
            //     ),
            //   ),),
          ],
        ),
      ),
    );
  }
}
