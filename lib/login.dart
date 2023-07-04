import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../responsiveness/announcementResponsive.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/eventsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/usersResponive.dart';
import '../responsiveness/faqResponsive.dart';
import 'package:http/http.dart' as http;

import 'models/user_model.dart';

class loginPage extends StatefulWidget {
  // const MyHomePage() : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  String? finalEmail;
  late ScrollController _scrollController;
  bool? CheckBoxValue = false;
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  var base = 'dc=example,dc=com';
  startConnect() async {
    var emailtext = nameController.text;
    var emailid = emailtext.replaceAll('@', '%40');

    var bindDN = 'uid=${nameController.text},ou=system';
    var password = passwordController.text; //passController.text;
    var url = Uri.parse('${global.apiAddress}GetLdapVerify/${emailid}/${password}');
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      // The request was successful, parse the JSON response
      if(response.body=='user needs to change password'){
        fetchUser(context).then((data) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder:
                  (context, animation1, animation2) =>
                  HomeResponsive(),
              transitionDuration:
              Duration(seconds: 0),
            ),
          );
        });

        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword(nameController.text,passwordController.text)));
      } else {
        fetchUser(context).then((data) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder:
                  (context, animation1, animation2) =>
                  HomeResponsive(),
              transitionDuration:
              Duration(seconds: 0),
            ),
          );
        });
      }

      print(response.body);
    } else {

      print('Request failed with status: ${response.statusCode}.');
    }

  }

  Future<User> fetchUser(BuildContext context) async {
    var emailtext = nameController.text;
    var emailid = emailtext.replaceAll('@', '%40');
    final response = await http.get(Uri.parse("${global.apiAddress}GetAUserbyemail/${emailid}"));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      final data = jsonDecode(response.body)[0]['user_id'];
      print("hello"+data.toString());
      setState(() {
        global.userID = data;
      });
      return parsed.map<User>((json) => User.fromMap(json)).toList()[0];
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    chkLogin();



    // initialize scroll controllers

    getValidData().whenComplete(() async {
      print("``````````````````~~~~~~~~~~~~~~~~~~~~~~~~");
      print(finalEmail);
      print("``````````````````~~~~~~~~~~~~~~~~~~~~~~~~");
      // Timer(Duration(seconds: 0),
      //     () => Get.to(finalEmail != null ? HomeResponsive() : null));
      if (finalEmail != null) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HomeResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      }
    });
    _scrollController = ScrollController();
    super.initState();
  }

  Future getValidData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var obtainEmail = sp.getString('email');
    setState(() {
      finalEmail = obtainEmail!;
    });
  }

  void chkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("email");
    String? route = pref.getString("route");
    print(val);
    print(route);
    if (val != null) {
      if (route == "Course") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                courseResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else if (route == "Admin") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => adminResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else if (route == "Events") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => eventResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else if (route == "Announcements") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                announcementResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else if (route == "Users") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => userResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else if (route == "Admission") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                admissionResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else if (route == "Settings") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                settingResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else if (route == "Help") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => helpResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else if (route == "FAQ") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => faqResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else if (route == "Messages") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                MessageResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HomeResponsive(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(

          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/loginBackground.png"),
                fit: BoxFit.cover),
          ),
          child: WebSmoothScroll(
            controller: _scrollController,
            child: SingleChildScrollView(
              child: Container(
                height: height,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.25,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        //height: height*0.61,
                        width: width * 0.37,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.08,
                            ),
                            Center(
                              child: Text(
                                "Welcome to PIF Academy App".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 32),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.017,
                                  right: width * 0.02,
                                  bottom: height * 0.01),
                              // padding: EdgeInsets.only(right: width*0.017,left: width*0.04,bottom: height*0.01),

                              child: Text(
                                "Email".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: width * 0.335,
                                height: height * 0.05,
                                child: TextField(
                                  controller: nameController =
                                      TextEditingController(),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 0.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 0.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.017,
                                  right: width * 0.02,
                                  bottom: height * 0.01),
                              // padding: EdgeInsets.only(right: width*0.017,left: width*0.04,bottom: height*0.01),

                              child: Text(
                                "Password".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: width * 0.335,
                                height: height * 0.05,
                                child: TextField(
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      iconSize: 100,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => SimpleDialog(
                                                  title: const Text(
                                                      'Reset Account Password'),
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          "     Contact the PIF IT department to reset your password"),
                                                    ),
                                                    SimpleDialogOption(
                                                      onPressed: () async {
                                                        String email =
                                                            Uri.encodeComponent(
                                                                "contact@pif.gov.sa");
                                                        String subject =
                                                            Uri.encodeComponent(
                                                                "Reset Password");
                                                        String body = "";
                                                        if (nameController.text !=
                                                            "") {
                                                          body = Uri.encodeComponent(
                                                              "Request to reset the password for account: " +
                                                                  nameController
                                                                      .text);
                                                        } else {
                                                          body = Uri
                                                              .encodeComponent(
                                                                  "Request to reset the password for account: {ENTER EMAIL}");
                                                        }

                                                        Uri mail = Uri.parse(
                                                            "mailto:$email?subject=$subject&body=$body");
                                                        if (await launchUrl(
                                                            mail)) {
                                                          print(
                                                              "email app opened");
                                                          Navigator.pop(
                                                              context);
                                                        } else {
                                                          print(
                                                              "email app is not opened");
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Email: contact@pif.gov.sa'),
                                                    ),
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        UrlLauncher.launch(
                                                            'tel:+${"96626658430"}');
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                          'Number: +96626658430'),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      icon: ImageIcon(
                                        AssetImage(context.locale ==
                                                Locale("en")
                                            ? "assets/images/forgotPassDesktop.png"
                                            : "assets/images/arabicForgotPass.png"),
                                        color: Color(0xFF215732),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 0.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 0.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.017,
                                  right: width * 0.02,
                                  bottom: height * 0.01),
                              // padding: EdgeInsets.only(right: width*0.017,left: width*0.04,bottom: height*0.01),

                              child: Row(
                                children: [
                                  Checkbox(
                                      activeColor: Color(0xffBD9B60),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                      side: MaterialStateBorderSide.resolveWith(
                                        (states) => BorderSide(
                                            width: 0.0, color: Colors.black),
                                      ),
                                      value: CheckBoxValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          CheckBoxValue = value;
                                        });
                                      }),
                                  Text(
                                    "Remember me".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: TextStyle(
                                          color: Color(0xFF222222),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Center(
                              child: SizedBox(
                                width: width * 0.335,
                                height: height * 0.05,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (CheckBoxValue != false) {
                                      final SharedPreferences sp =
                                          await SharedPreferences.getInstance();
                                      sp.setString('email', nameController.text);
                                    }
                                  await startConnect();
                                    global.userID = 5;

                                  },
                                  child: Text('Log In'.tr().toString(),
                                      strutStyle:
                                          StrutStyle(forceStrutHeight: true)),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF215732),
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: height * 0.08,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                    ),
                  ],
                ),
              ),
            ),
          )),
      // body:
    );
  }
}
