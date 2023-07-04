import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/main.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pfpimg.dart';
import '../responsiveness/admissionResponsive.dart';
import '../responsiveness/coursesResponsive.dart';
import '../responsiveness/faqResponsive.dart';
class SideNavBar extends StatefulWidget {
  const SideNavBar({Key? key}) : super(key: key);

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Drawer(
      width: width * 0.6,
      child: Container(
        color: Color(0xFF183028),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 220,
              child: DrawerHeader(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/pifLogo.png",
                          fit: BoxFit.contain,
                          width: 70,
                        ),
                        InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    isSwitched
                        ? Image.asset(
                      "assets/images/noFace.png",
                      fit: BoxFit.contain,
                      width: 80,
                    )
                        : Image.asset(
                      "assets/mobileImages/mobilepfp.png",
                      fit: BoxFit.contain,
                      width: 80,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Mohammad Alsugair".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Color(0xffFFFFFF),
              thickness: 0.2,
              indent: 12,
              endIndent: 12,
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: ListTile(
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
                    MaterialPageRoute(builder: (context) => HomeResponsive()),
                  )
                },
              ),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: Icon(Icons.list, color: Color(0xFFBD9B60), size: 26.2),
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
                  MaterialPageRoute(builder: (context) => courseResponsive()),
                )
              },
            ),
            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: SvgPicture.asset("assets/mobileImages/admissionIcon.svg",
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
              leading: SvgPicture.asset("assets/images/admin.svg",
                  color: Color(0xFFBD9B60)),
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
                  MaterialPageRoute(builder: (context) => adminResponsive()),
                )
              },
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(right: 1.5),
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
                  MaterialPageRoute(builder: (context) => settingResponsive()),
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
                  MaterialPageRoute(builder: (context) => helpResponsive()),
                )
              },
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
                  MaterialPageRoute(builder: (context) => faqResponsive()),
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
              title: Text(
                "Messages".tr(),
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
                  MaterialPageRoute(builder: (context) => MessageResponsive()),
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
              leading: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: ImageIcon(
                  AssetImage("assets/images/logout.png"),
                  color: Color(0xFFBD9B60),
                ),
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
                showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: const Text('Please Confirm'),
                        content: const Text('Are you sure to logout?'),
                        actions: [
                          // The "Yes" button
                          TextButton(
                              onPressed: () async {
                                final SharedPreferences sp =
                                await SharedPreferences.getInstance();
                                sp.remove('email');
                                // Close the dialog
                                Navigator.of(ctx).pop();
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
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
                    })
              },
            ),
          ],
        ),
      ),
    );
  }
}
