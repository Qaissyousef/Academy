import 'dart:async';
import 'dart:html' as ht;
import 'dart:math';
import 'dart:convert' as convert;


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
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:string_validator/string_validator.dart' as sv;

import '../models/user_model.dart';
import '../pfpimg.dart';
import '../responsiveness/faqResponsive.dart';
import '../responsiveness/usersResponive.dart';

import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;
import 'package:pif_admin_dashboard/util/global.dart' as global;

class users extends StatefulWidget {
  const users({Key? key}) : super(key: key);

  @override
  State<users> createState() => _usersState();
}

class _usersState extends State<users> {
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

  // final fnameController = TextEditingController();
  // final myControlleremail = TextEditingController();
  // late String _userType ='Participant';
  String dropdownvalue1 = 'Instructor'.tr();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController uidController = TextEditingController();

  late String _status ='Active';

  late String _userType = "Admin";
  Future<void> addingUser() async {
    var code = generateRandomAlphaNumeric();
    var fname = fnameController.text;
    var lname = lnameController.text;
    var email = emailController.text;
    var emailid = email.replaceAll('@', '%40');
    var url = Uri.parse('${global.apiAddress}AddLdapEntry/Participant/testing/${emailid}/${code}/testing/oneTime/Active');
    final response = await http
        .get(url);
    if (response.statusCode == 200) {
      // The request was successful, parse the JSON response
      print(response.body);
    } else {
      // The request failed with an error code
      print('Request failed with status: ${response.statusCode}.');
    }
  }



  String generateRandomAlphaNumeric() {
    const _chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final _random = Random();

    return String.fromCharCodes(Iterable.generate(
        4, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))));
  }

  sendPassword(code) async {
    // var url =
    // Uri.https('http://ldap.nkashqxhet-rz83yqz0p6d7.p.temp-site.link/email.php?email=${emailController.text}&uid=${uidController.text}&password=$code');
    var url = Uri.http(
        'ldap.nkashqxhet-rz83yqz0p6d7.p.temp-site.link', '/email.php', {
      'email': emailController.text,
      'uid': uidController.text,
      'password': code,
    });

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("User Created."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  bool showerrormsg = false;

  _setRcVisible() {
    // this is new
    String errorText = "";

    errorText += validator.isValid("User name", fnameController.text, "empty");
    errorText +=
        validator.isValid("User email", emailController.text, "empty");

    if (errorText == "" && !sv.isEmail(emailController.text)) {
      errorText += "Please enter a valid email address\n";
    }
    if (errorText != "") {
      validator.alertDialog(
          context, errorText.substring(0, errorText.length - 1));
    }
    this.setState(() {
      showerrormsg = true;
    });
    print("freifujeovev gtriurfjf0");
  }

  // List of items in our dropdown menu
  Future<List<User>> fetchPostEng(bool isAscending) async {
    List<User> users = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllUsers'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        users.add(User.fromMap(jsonDecode(response.body)[i]));
      }
      if (isAscending) {
        users.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      } else {
        users.sort(
            (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      }
      return users;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<User>> filterPost(
      bool isAscending, String status, String role) async {
    List<User> users = [];
    List<User> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllUsers'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        users.add(User.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        users.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      } else {
        users.sort(
            (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      }

      var now = new DateTime.now();
      var now_1w = now.subtract(Duration(days: 7));
      var now_1m = now.subtract(Duration(days: 30));

      if (status.compareTo("All") == 0) {
        for (int i = 0; i < users.length; i++) {
          if (users[i].user_type.compareTo(role) == 0 ||
              role.compareTo("All") == 0) {
            print("Role all: " + role);
            print("User type all: " + users[i].user_type.tr().toString());
            results.add(users[i]);
          }
        }
      } else if (status.compareTo("Active") == 0) {
        for (int i = 0; i < users.length; i++) {
          if ((users[i].user_type.compareTo(role) == 0 &&
                  users[i].user_status.compareTo("Active") == 0) ||
              (role.compareTo("All") == 0 &&
                  users[i].user_status.compareTo("Active") == 0)) {
            print("Role all: " + role);
            print("User type all: " + users[i].user_type.tr().toString());
            results.add(users[i]);
          }
        }
      } else if (status.compareTo("Deactivate") == 0) {
        for (int i = 0; i < users.length; i++) {
          if ((users[i].user_type.compareTo(role) == 0 &&
                  users[i].user_status.compareTo("Deactivate") == 0) ||
              (role.compareTo("All") == 0 &&
                  users[i].user_status.compareTo("Deactivate") == 0)) {
            print("Role all: " + role);
            print("User type all: " + users[i].user_type.tr().toString());
            results.add(users[i]);
          }
        }
      }

      // else {
      //   for (int i = 0; i < 10; i++) {
      //     print("Role ${status}: " + role);
      //     print("user ${users[i].user_status}: ".tr().toString() +
      //         users[i].user_type);
      //     if (users[i].user_status.toLowerCase().compareTo(status) == 0 &&
      //         (users[i].user_type.toLowerCase().compareTo(role) == 0 ||
      //             role.compareTo("All") == 0)) {
      //       results.add(users[i]);
      //     }
      //   }
      // }

      if (results.isEmpty) {
        hasData = false;
      } else {
        hasData = true;
      }

      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<User>> searchPost(String name) async {
    List<User> users = [];
    List<User> results = [];
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllUsers'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        users.add(User.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        users.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      } else {
        users.sort(
            (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      }

      if (name.isNotEmpty) {
        users.forEach((element) {
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
        results.addAll(users);
      }

      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<User>> futurePostEng;
  bool isAscending = true;
  String user_status = "All";
  String user_role = "All";
  late List<User> userList = [];
  TextEditingController _searchController = TextEditingController();
  bool hasData = true;

  // List of items in our dropdown menu
  var items = [
    'Instructor',
    'Admin',
    'Participants',
  ];

  Future<http.Response> deleteRequest(int uid) async {
    Map data = {
      "user_id": uid,
      "name": "q",
      "email": "dfg",
      "user_type": "s",
      "user_img": "d",
      "user_status": "d"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'DeleteUser'),
        headers: {"Content-Type": "application/json"}, body: body);
    setState(() {
      futurePostEng = fetchPostEng(isAscending);
    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> updateRequest(String status, int uid) async {
    Map data = {
      "user_id": "1",
      "name": "q",
      "email": "dfg",
      "user_type": "s",
      "user_img": "d",
      "user_status": status
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress + 'UpdateStatus/$uid'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    setState(() {
      futurePostEng = fetchPostEng(isAscending);
    });
    return response;
  }

  Future<http.Response> updateRole(String type, int uid) async {
    Map data = {
      "user_id": "1",
      "name": "q",
      "email": "dfg",
      "user_type": type,
      "user_img": "d",
      "user_status": "dd"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress + 'UpdateRole/$uid'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    setState(() {
      futurePostEng = fetchPostEng(isAscending);
    });
    return response;
  }

  var _dateTime = DateTime.parse("2022-10-01 00:00:00.000");

  void onSelect(item) {
    switch (item) {
      case 'Home':
        print('Home clicked');
        break;
      case 'Profile':
        print('Profile clicked');
        break;
      case 'Setting':
        print('Setting clicked');
        break;
    }
  }

  late ScrollController _scrollController;

  Future<http.Response> postRequest() async {
    Map data = {
      "name": fnameController.text,
      "email": emailController.text,
      "user_img": 'noFace.png',
      "user_status": "Active",
      "user_type": _userType
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddUser'),
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
    setState(() {
      futurePostEng = fetchPostEng(isAscending);
    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();
    futurePostEng = fetchPostEng(isAscending);

    super.initState();
  }

  bool? checkedValue = true;

  final num = SizedBox(
      child: ElevatedButton(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("08       ".tr().toString(),
            strutStyle: StrutStyle(forceStrutHeight: true)),
        SizedBox(
          width: 25,
        ),
        Icon(
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
        side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // <-- Radius
        ),
        primary: Colors.white, //elevated btton background color
        onPrimary: Colors.black,
        minimumSize: Size(120, 50)),
  ));
  final GlobalKey _menuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final button = PopupMenuButton(
        icon: Icon(Icons.more_vert_rounded, size: 18, color: Color(0xFF999999)),
        key: _menuKey,
        itemBuilder: (_) => const <PopupMenuItem<String>>[
              PopupMenuItem<String>(child: Text('Edit'), value: 'Edit'),
              PopupMenuItem<String>(child: Text('Report'), value: 'Report'),
              PopupMenuItem<String>(
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                  value: 'Report'),
            ],
        onSelected: (_) {});

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String? dropdownvalue = 'Admin';

    final role = Container(
      height: height * 0.3,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: InputDecoration.collapsed(hintText: ''),
          icon: Icon(
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
                  textStyle: TextStyle(
                      fontFamily: 'Barlow',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF222222)),
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Instructor",
              child: Text(
                '   Instructor'.tr().toString(),
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
            DropdownMenuItem(
              value: "Participants",
              child: Text(
                '   Participants'.tr().toString(),
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
          ],

          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },
        ),
      ),
    );

    final filterBtn = AlertDialog(
      shape: RoundedRectangleBorder(
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
                  child: Icon(Icons.close))),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Form(
          child: Row(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Type".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: TextStyle(
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
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  user_role = "All";
                                  futurePostEng = filterPost(
                                      isAscending, user_status, user_role);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "All".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            user_role.compareTo("All") == 0
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
                    Container(
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  user_role = "Admin";
                                  futurePostEng = filterPost(
                                      isAscending, user_status, user_role);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Admin".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            user_role.compareTo("Admin") == 0
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
                    Container(
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  user_role = "Participants";
                                  futurePostEng = filterPost(
                                      isAscending, user_status, user_role);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Participants".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            user_role.compareTo("Participants") == 0
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
                    Container(
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  user_role = "Instructor";
                                  futurePostEng = filterPost(
                                      isAscending, user_status, user_role);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Instructor".tr().toString(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            user_role.compareTo("Instructor") == 0
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
              SizedBox(
                width: width * 0.06,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status".tr(),
                      style: GoogleFonts.barlow(
                        textStyle: TextStyle(
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
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  user_status = "All";
                                  futurePostEng = filterPost(
                                      isAscending, user_status, user_role);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "All".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            user_status.compareTo("All") == 0
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
                    Container(
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  user_status = "Active";
                                  futurePostEng = filterPost(
                                      isAscending, user_status, user_role);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Active".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            user_status.compareTo("Active") == 0
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
                    Container(
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFEEEEEE)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.012,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  user_status = "Deactivate";
                                  futurePostEng = filterPost(
                                      isAscending, user_status, user_role);
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Deactivated".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            user_status.compareTo("Deactivate") == 0
                                ? SvgPicture.asset(
                                    "assets/images/sortyes.svg",
                                    fit: BoxFit.scaleDown,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final searchtab = Container(
      width: width * 0.4,
      height: height * 0.048,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 18.0, right: 20.0, top: 5, bottom: 5),
        child: Row(
          children: [
            Image.asset(
              "assets/images/search.png",
              fit: BoxFit.scaleDown,
            ),
            // SvgPicture.asset("assets/images/search.svg",fit: BoxFit.scaleDown,),

            SizedBox(
              width: width * 0.009,
            ),
            SizedBox(
              width: width * 0.28,
              height: height * 0.4,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    futurePostEng = searchPost(value);
                  });
                },
                controller: _searchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'Search'.tr().toString(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                  hintStyle: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),

            SizedBox(
              width: width * 0.009,
            ),

            SvgPicture.asset(
              "assets/images/Separator.svg",
              fit: BoxFit.scaleDown,
            ),

            InkWell(
              hoverColor: Colors.transparent,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String? dropdownvalue = 'Admin';
                    Locale? lang = Locale("en");
                    return filterBtn;
                  },
                );
              },
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.021,
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
      height: height * 0.047,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black, width: 0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17),
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  Locale? lang = Locale("en");
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
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
                                child: Icon(Icons.close))),
                      ],
                    ),
                    content: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Form(
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.04,
                                  ),

                                  Container(
                                    width: width * 0.1,
                                    decoration: BoxDecoration(
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
                                              futurePostEng = filterPost(
                                                  isAscending,
                                                  user_status,
                                                  user_role);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "A -> Z".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
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
                                  ),
                                  SizedBox(
                                    height: height * 0.012,
                                  ),

                                  // SizedBox(height: ),

                                  Container(
                                    width: width * 0.1,
                                    decoration: BoxDecoration(
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
                                              futurePostEng = filterPost(
                                                  isAscending,
                                                  user_status,
                                                  user_role);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Z -> A".tr(),
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
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
                                  )
                                ],
                              ),
                            ),
                          ],
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
                      color: Color(0xFF222222),
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
                          padding: const EdgeInsets.only(right: 2.0, left: 2),
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
                                pageBuilder:
                                    (context, animation1, animation2) =>
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
                                announcementResponsive(),
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
                                      context.locale == Locale("en")
                                          ? 0
                                          : 40.0),
                                  bottomLeft: Radius.circular(
                                      context.locale == Locale("en")
                                          ? 0
                                          : 40.0),
                                  topRight: Radius.circular(
                                      context.locale == Locale("en")
                                          ? 40
                                          : 0.0),
                                  bottomRight: Radius.circular(
                                      context.locale == Locale("en")
                                          ? 40
                                          : 0.0),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  title: Text(
                                    "Users".tr(),
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
                                                userResponsive(),
                                        transitionDuration:
                                            Duration(seconds: 0),
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
                        ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.end,

                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "Administration /".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFF999999),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Text(
                                      "Users".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFF215732),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
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
                                                  MessageResponsive(),
                                              transitionDuration:
                                                  Duration(seconds: 0),
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
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.13,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
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
                                      "Users".tr(),
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
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 43,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ht.window.open(
                                              global.apiAddress + 'DownloadXML',
                                              "_self");
                                        },
                                        child: Text(
                                            'Export list as spreadsheet'
                                                .tr()
                                                .toString(),
                                            strutStyle: StrutStyle(
                                                forceStrutHeight: true),
                                            style: GoogleFonts.barlow(
                                              textStyle: TextStyle(
                                                  color: Color(0xFF183028),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16),
                                            )),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFFF5F0E5),
                                          elevation: 0.0,
                                          shadowColor: Colors.transparent,
                                          onPrimary: Color(0xFF183028),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Container(
                                      height: 43,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              barrierDismissible: true,
                                              context: context,
                                              builder: (context) {
                                                Locale? lang = Locale("en");
                                                return StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        setState) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12.0))),
                                                    scrollable: true,
                                                    title: Column(
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child:
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .close))),
                                                        Center(
                                                          child: Text(
                                                            "Add New User".tr(),
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
                                                                  fontSize: 28),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0),
                                                      child: Form(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Center(
                                                              child: Text(
                                                                "Enter the details below to add a new user"
                                                                    .tr(),
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
                                                            ),
                                                            SizedBox(
                                                                height: height *
                                                                    0.03),

                                                            SizedBox(
                                                                height: height *
                                                                    0.07),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: context
                                                                              .locale ==
                                                                          Locale(
                                                                              "en")
                                                                      ? width *
                                                                          0.04
                                                                      : 0,
                                                                  left: context
                                                                              .locale ==
                                                                          Locale(
                                                                              "en")
                                                                      ? 0
                                                                      : width *
                                                                          0.04,
                                                                  bottom:
                                                                      height *
                                                                          0.01),
                                                              child: Text(
                                                                "Name".tr(),
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
                                                            ),
                                                            Center(
                                                              child: SizedBox(
                                                                width: width *
                                                                    0.25,
                                                                height: height *
                                                                    0.05,
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                  fnameController,
                                                                  decoration:
                                                                      InputDecoration(
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
                                                            ),
                                                            SizedBox(
                                                                height: height *
                                                                    0.02),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: context
                                                                              .locale ==
                                                                          Locale(
                                                                              "en")
                                                                      ? width *
                                                                          0.04
                                                                      : 0,
                                                                  left: context
                                                                              .locale ==
                                                                          Locale(
                                                                              "en")
                                                                      ? 0
                                                                      : width *
                                                                          0.04,
                                                                  bottom:
                                                                      height *
                                                                          0.01),
                                                              child: Text(
                                                                "Email".tr(),
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
                                                            ),
                                                            Center(
                                                              child: SizedBox(
                                                                width: width *
                                                                    0.25,
                                                                height: height *
                                                                    0.085,
                                                                child:
                                                                    TextField(
                                                                  maxLength: 30,
                                                                  controller:
                                                                  emailController,
                                                                  decoration:
                                                                      InputDecoration(
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
                                                            ),
                                                            SizedBox(height: 4),
                                                            // Visibility(
                                                            //   visible: showerrormsg,
                                                            //   child: Text(
                                                            //     "Invalid email!"
                                                            //         .tr(),
                                                            //     style: GoogleFonts
                                                            //         .barlow(
                                                            //       textStyle: TextStyle(
                                                            //           color: Color(0xFFd90100),
                                                            //           fontWeight: FontWeight.w400,
                                                            //           fontStyle: FontStyle.normal,
                                                            //           fontSize: 14),
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            SizedBox(
                                                                height: height *
                                                                    0.02),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: context
                                                                              .locale ==
                                                                          Locale(
                                                                              "en")
                                                                      ? width *
                                                                          0.04
                                                                      : 0,
                                                                  left: context
                                                                              .locale ==
                                                                          Locale(
                                                                              "en")
                                                                      ? 0
                                                                      : width *
                                                                          0.04,
                                                                  bottom:
                                                                      height *
                                                                          0.01),
                                                              child: Text(
                                                                "Account type"
                                                                    .tr(),
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
                                                            ),
                                                            Center(
                                                              child: Container(
                                                                  width: width *
                                                                      0.25,
                                                                  height:
                                                                      height *
                                                                          0.05,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Color(
                                                                            0xFFEEEEEE)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.5),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: height *
                                                                            0.015),
                                                                    child: role,
                                                                  )),
                                                            ),
                                                            SizedBox(
                                                                height: height *
                                                                    0.07),
                                                            Center(
                                                              child: SizedBox(
                                                                width: width *
                                                                    0.25,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                14,
                                                                            horizontal:
                                                                                50),
                                                                        child:
                                                                            Text(
                                                                          'Cancel'
                                                                              .tr()
                                                                              .toString(),
                                                                          strutStyle:
                                                                              StrutStyle(forceStrutHeight: true),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                color: Color(0xFF183028),
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 16),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      style: ElevatedButton
                                                                          .styleFrom(
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
                                                                          borderRadius:
                                                                              BorderRadius.circular(7),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: width *
                                                                          0.014,
                                                                    ),
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (!sv.isEmail(
                                                                            emailController.text)) {
                                                                          _setRcVisible();
                                                                          // Timer timer = Timer(Duration(seconds: 3), () {
                                                                          //   setState(() {
                                                                          //     showerrormsg = false;
                                                                          //   });
                                                                          // });
                                                                        } else {
                                                                          await addingUser();

                                                                         postRequest();
                                                                          emailController
                                                                              .clear();
                                                                          fnameController
                                                                              .clear();
                                                                          _userType =
                                                                              "Admin";
                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                14,
                                                                            horizontal:
                                                                                25),
                                                                        child: Text(
                                                                            'Confirm & add'
                                                                                .tr()
                                                                                .toString(),
                                                                            strutStyle:
                                                                                StrutStyle(forceStrutHeight: true),
                                                                            style: GoogleFonts.barlow(
                                                                              textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                            )),
                                                                      ),
                                                                      style: ElevatedButton
                                                                          .styleFrom(
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
                                                                          borderRadius:
                                                                              BorderRadius.circular(7),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: height *
                                                                    0.02),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                              });
                                        },
                                        child: Text(
                                            'Add new user'.tr().toString(),
                                            strutStyle: StrutStyle(
                                                forceStrutHeight: true),
                                            style: GoogleFonts.barlow(
                                              textStyle: TextStyle(
                                                  color: Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16),
                                            )),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF215732),
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            side: BorderSide(
                                              width: 0.4,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Container(
                          height: height * 0.9,
                          child: WebSmoothScroll(
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, right: 40.0, top: 18.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          searchtab,
                                          SizedBox(
                                            width: width * 0.005,
                                          ),
                                          sortbtn
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.035,
                                      ),
                                      Card(
                                          child: WebSmoothScroll(
                                        controller: _scrollController,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: width * 0.7,
                                                height: height * 0.07,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF5F0E5),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight: Radius
                                                              .circular(9.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  9.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0)),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: width * 0.01,
                                                    ),
                                                    Text(
                                                      "Picture".tr(),
                                                      style: GoogleFonts.barlow(
                                                        textStyle: TextStyle(
                                                            color: Color(
                                                                0xFFBD9B60),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.023,
                                                    ),
                                                    Container(
                                                      width: width * 0.135,
                                                      child: Text(
                                                        "Name".tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFBD9B60),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: context.locale ==
                                                              Locale("en")
                                                          ? width * 0.158
                                                          : width * 0.19,
                                                      child: Text(
                                                        "Email".tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFBD9B60),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: context.locale ==
                                                              Locale("en")
                                                          ? width * 0.069
                                                          : width * 0.063,
                                                      child: Text(
                                                        "Account type".tr(),
                                                        style:
                                                            GoogleFonts.barlow(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFBD9B60),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: context.locale ==
                                                              Locale("en")
                                                          ? width * 0.07
                                                          : width * 0.045,
                                                    ),
                                                    Text(
                                                      "Status".tr(),
                                                      style: GoogleFonts.barlow(
                                                        textStyle: TextStyle(
                                                            color: Color(
                                                                0xFFBD9B60),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.08,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              FutureBuilder<List<User>>(
                                                future: futurePostEng,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (!hasData) {
                                                      return Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "No Users".tr(),
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
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: snapshot
                                                            .data!.length,
                                                        itemBuilder:
                                                            (_, index) =>
                                                                Container(
                                                          child: InkWell(
                                                            onTap: () {
                                                              // Navigator.push(
                                                              //   context,
                                                              //   MaterialPageRoute(builder: (context) => webSpecificUser()),
                                                              // );
                                                            },
                                                            hoverColor: Colors
                                                                .transparent,
                                                            child: Material(
                                                              elevation: 1,
                                                              color:
                                                                  Colors.white,
                                                              child: Container(
                                                                width: width *
                                                                    0.725,
                                                                height: height *
                                                                    0.07,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              9.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              9.0),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              0)),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: width *
                                                                          0.01,
                                                                    ),
                                                                  Image.network(
                                                                    '${global.apiAddress}GetImage/${(snapshot.data![index].user_img)}',
                                                                    width:40,height:35,
                                                                    fit: BoxFit.scaleDown,
                                                                  ),

                                                                    SizedBox(
                                                                      width: width *
                                                                          0.035,
                                                                    ),
                                                                    Container(
                                                                      width: width *
                                                                          0.135,
                                                                      child:
                                                                          Text(
                                                                        "${snapshot.data![index].name}"
                                                                            .tr(),
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF222222),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: context.locale ==
                                                                              Locale(
                                                                                  "en")
                                                                          ? width *
                                                                              0.158
                                                                          : width *
                                                                              0.19,
                                                                      child:
                                                                          Text(
                                                                        "${snapshot.data![index].email}",
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(0xFF222222),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: context.locale ==
                                                                              Locale(
                                                                                  "en")
                                                                          ? width *
                                                                              0.065
                                                                          : width *
                                                                              0.063,
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            DropdownButtonFormField(
                                                                          decoration:
                                                                              InputDecoration.collapsed(hintText: ''),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                color: Color(0xFF222222),
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 16),
                                                                          ),
                                                                          // Initial Value
                                                                          value: snapshot
                                                                              .data![index]
                                                                              .user_type,

                                                                          // Down Arrow Icon
                                                                          icon:
                                                                              Icon(
                                                                            Icons.expand_more_rounded,
                                                                            size:
                                                                                18,
                                                                            color:
                                                                                Color(0Xff999999),
                                                                          ),

                                                                          // Array list of items
                                                                          items:
                                                                              items.map((String items) {
                                                                            return DropdownMenuItem(
                                                                              value: items,
                                                                              child: Text(
                                                                                items.tr().toString(),
                                                                                style: GoogleFonts.barlow(
                                                                                  textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                          // After selecting the desired option,it will
                                                                          // change button value to selected value
                                                                          onChanged:
                                                                              (String? newValue) {
                                                                            setState(() {
                                                                              updateRole(newValue!, snapshot.data![index].user_id);
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: context.locale ==
                                                                              Locale(
                                                                                  "en")
                                                                          ? width *
                                                                              0.07
                                                                          : width *
                                                                              0.045,
                                                                    ),
                                                                    if (snapshot
                                                                            .data![index]
                                                                            .user_status ==
                                                                        'Active') ...[
                                                                      Container(
                                                                          width: width *
                                                                              0.05,
                                                                          height:
                                                                              height * 0.035,
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(
                                                                                color: Color(0xFF007A33),
                                                                                width: 0.5,
                                                                              ),
                                                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                          child: Center(
                                                                              child: Text(
                                                                            '${snapshot.data![index].user_status}'.tr(),
                                                                            style:
                                                                                GoogleFonts.barlow(
                                                                              textStyle: TextStyle(color: Color(0xFF007A33), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 14),
                                                                            ),
                                                                          ))

                                                                          // ElevatedButton(
                                                                          //   style: ElevatedButton
                                                                          //       .styleFrom(
                                                                          //     primary:
                                                                          //     Colors.white,
                                                                          //     shape:
                                                                          //     RoundedRectangleBorder(
                                                                          //       borderRadius:
                                                                          //       BorderRadius.circular(18.0),
                                                                          //       side:
                                                                          //       BorderSide(
                                                                          //         color:
                                                                          //         Color(0xFF007A33),
                                                                          //         width:
                                                                          //         0.5,
                                                                          //       ),
                                                                          //     ),
                                                                          //   ),
                                                                          //   child:
                                                                          //   Text(
                                                                          //     '${snapshot.data![index].user_status}'
                                                                          //         .tr(),
                                                                          //     style: GoogleFonts
                                                                          //         .barlow(
                                                                          //       textStyle: TextStyle(
                                                                          //           color: Color(0xFF007A33),
                                                                          //           fontWeight: FontWeight.w500,
                                                                          //           fontStyle: FontStyle.normal,
                                                                          //           fontSize: 14),
                                                                          //     ),
                                                                          //   ),
                                                                          //   onPressed:
                                                                          //       () {},
                                                                          // )
                                                                          ),
                                                                    ] else ...[
                                                                      Container(
                                                                          width: width *
                                                                              0.05,
                                                                          height:
                                                                              height * 0.035,
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(
                                                                                color: Colors.grey,
                                                                                width: 0.5,
                                                                              ),
                                                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                          child: Center(
                                                                              child: Text(
                                                                            '${snapshot.data![index].user_status}'.tr(),
                                                                            style:
                                                                                GoogleFonts.barlow(
                                                                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 14),
                                                                            ),
                                                                          )))
                                                                    ],
                                                                    SizedBox(
                                                                        width: width *
                                                                            0.094),
                                                                    PopupMenuButton(
                                                                      onSelected:
                                                                          (result) {
                                                                        // your logic
                                                                        if (result ==
                                                                            0) {
                                                                          print(
                                                                              "delete");
                                                                          deleteRequest(snapshot
                                                                              .data![index]
                                                                              .user_id);
                                                                        } else if (result ==
                                                                            1) {
                                                                          print(
                                                                              "activate");
                                                                          updateRequest(
                                                                              "Active",
                                                                              snapshot.data![index].user_id);
                                                                        } else {
                                                                          print(
                                                                              "Deactivate");
                                                                          updateRequest(
                                                                              "Deactivate",
                                                                              snapshot.data![index].user_id);
                                                                        }
                                                                      },
                                                                      itemBuilder:
                                                                          (BuildContext
                                                                              bc) {
                                                                        return const [
                                                                          PopupMenuItem(
                                                                            child:
                                                                                Text("Delete"),
                                                                            value:
                                                                                0,
                                                                          ),
                                                                          PopupMenuItem(
                                                                            child:
                                                                                Text("Activate"),
                                                                            value:
                                                                                1,
                                                                          ),
                                                                          PopupMenuItem(
                                                                            child:
                                                                                Text("Deactivate"),
                                                                            value:
                                                                                2,
                                                                          )
                                                                        ];
                                                                      },
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          // Column(
                                                          //   children: [
                                                          //     Text("${snapshot.data![index].name}"),
                                                          //     Text("${snapshot.data![index].email}"),
                                                          //     Text("${snapshot.data![index].user_type}"),
                                                          //     Text("${snapshot.data![index].user_id}"),
                                                          //
                                                          //     Text("${snapshot.data![index].user_status}"),
                                                          //
                                                          //
                                                          //
                                                          //     DropdownButtonFormField(
                                                          //       decoration :InputDecoration.collapsed(hintText: ''),
                                                          //       style: GoogleFonts.barlow(
                                                          //         textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                          //       ),
                                                          //       // Initial Value
                                                          //       value: snapshot.data![index].user_type,
                                                          //
                                                          //       // Down Arrow Icon
                                                          //       icon:Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),
                                                          //
                                                          //       // Array list of items
                                                          //       items: items.map((String items) {
                                                          //         return DropdownMenuItem(
                                                          //           value: items,
                                                          //           child: Text(items,style: GoogleFonts.barlow(
                                                          //             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                          //           ),),
                                                          //         );
                                                          //       }).toList(),
                                                          //       // After selecting the desired option,it will
                                                          //       // change button value to selected value
                                                          //       onChanged: (String? newValue) {
                                                          //         setState(() {
                                                          //           updateRole(newValue!,snapshot.data![index].user_id);
                                                          //         });
                                                          //       },
                                                          //     ),
                                                          //     PopupMenuButton(
                                                          //       onSelected: (result) {
                                                          //         // your logic
                                                          //         if (result == 0) {
                                                          //           print("delete");
                                                          //           deleteRequest(snapshot.data![index].user_id);
                                                          //         }
                                                          //         else if (result == 1)
                                                          //         {
                                                          //           print("activate");
                                                          //           updateRequest("active",snapshot.data![index].user_id);
                                                          //         }
                                                          //         else
                                                          //         {
                                                          //           print("deactivate");
                                                          //           updateRequest("inactive",snapshot.data![index].user_id);
                                                          //
                                                          //         }
                                                          //       },
                                                          //       itemBuilder: (BuildContext bc) {
                                                          //         return const [
                                                          //           PopupMenuItem(
                                                          //             child: Text("Delete"),
                                                          //             value: 0,
                                                          //           ),
                                                          //           PopupMenuItem(
                                                          //             child: Text("Activate"),
                                                          //             value: 1,
                                                          //           ),
                                                          //           PopupMenuItem(
                                                          //             child: Text("DeActivate"),
                                                          //             value:2 ,
                                                          //           )
                                                          //         ];
                                                          //       },
                                                          //     )
                                                          //
                                                          //   ],
                                                          // ),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    return Center(
                                                        child: Text(
                                                            "No Items Found",
                                                            style: GoogleFonts.barlow(
                                                                textStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF222222),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        16))));
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                      SizedBox(height: height * 0.2),

                                      // Row(
                                      //   children: [
                                      //
                                      //
                                      //
                                      //     num,
                                      //     SizedBox(width: width*0.007,),
                                      //     Text("Showing 6 of 6 results".tr(),style: GoogleFonts.barlow(
                                      //       textStyle: TextStyle(color: Color(0Xff999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                      //     ),),
                                      //   ],
                                      // ),
                                      SizedBox(height: height * 0.03),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
