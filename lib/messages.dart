
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/main.dart';

import 'package:pif_admin_dashboard/models/user_model.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:pif_admin_dashboard/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:pif_admin_dashboard/pfpimg.dart';
import 'package:http/http.dart' as http;

import 'models/Message.dart';
import 'dart:convert';



import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;

class messages extends StatefulWidget {
  const messages({Key? key}) : super(key: key);

  @override
  State<messages> createState() => _messagesState();
}

class _messagesState extends State<messages> {
  late ScrollController _scrollController;

  bool? CheckBoxValue = false;
  bool? CheckBoxValue1 = false;
  bool? CheckBoxValue2 = false;
  bool? CheckBoxValue3 = false;
  bool? CheckBoxValue4 = false;
  bool? CheckBoxValue5 = false;
  bool? CheckBoxValue6 = false;

  Future<List<Message>> fetchPostEng(bool isAscending) async {
    List<Message> ann = [];
    final response =
    await http.get(Uri.parse('${global.apiAddress}GetMessages'));


    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        ann.add(Message.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        return ann.reversed.toList();
      } else {
        return ann;
      }
    } else {
      throw Exception('Failed to load album');
    }
  }




  Future<List<Message>> deleteMes() async {

    var response = await http.post(Uri.parse('${global.apiAddress}DeleteMessage'));


    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return fetchPostEng(isAscending);
  }

  Future<List<Message>> updateisUnreadAll () async {

    // print('Is Unread val: $value');
    // Map data =
    // {
    //   "message_id": msgId,
    //   "user_id" : 0,
    //   "message_details": "string",
    //   "starred": false,
    //   "isUnread": value,
    //   "time": "string",
    //   "message_title": "string",
    //   "isChecked": false
    // };

    //encode Map to JSON
    // var body = json.encode(data);
    var response = await http.post(Uri.parse('${global.apiAddress}UpdateMessageUnreadAll'));

    print("${response.statusCode}");
    print("${response.body}");

    return fetchPostEng(isAscending);
  }

  Future<List<Message>> deleteSingleMes(int msgId) async {

    var response = await http.post(Uri.parse('${global.apiAddress}DeleteSingleMessage/$msgId'));


    final statCode = jsonDecode(response.body)['StatusCode'];
    // final finParsedEng = parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    print(" Response today: ${statCode} and type: ${statCode.runtimeType}");
    if (statCode == 200) {
      print("Closed");
    }

    print("${response.statusCode}");
    print("${response.body}");
    return fetchPostEng(isAscending);
  }


  Future<List<Message>> changeSelection (int msgId, bool? value) async {


    Map data =
    {
      "message_id": msgId,
      "user_id" : 0,
      "message_details": "string",
      "starred": false,
      "isUnread": true,
      "time": "2023-02-21T12:11:06.950Z",
      "message_title": "string",
      "isChecked": value
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse('${global.apiAddress}UpdateMessageCheck'),

        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },

        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");



    return fetchPostEng(isAscending);
  }

  Future<List<Message>> selectAll (bool? value) async {

    //encode Map to JSON
    var response = await http.post(Uri.parse('${global.apiAddress}UpdateMessageCheckAll/$value'));
    print("${response.statusCode}");
    print("${response.body}");
    return fetchPostEng(isAscending);
  }

  Future<List<Message>> updateStar (int msgId, bool value) async {


    Map data =
    {
      "message_id": msgId,
      "user_id" : 0,
      "message_details": "string",
      "starred": value,
      "isUnread": true,
      "time": "2023-02-21T12:11:06.950Z",
      "message_title": "string",
      "isChecked": false
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse('${global.apiAddress}UpdateMessageStarred'),

        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },

        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");

    return fetchPostEng(isAscending);
  }

  Future<List<Message>> updateisUnread (int msgId, bool value) async {

    print('Is Unread val: $value');
    Map data =
    {
      "message_id": msgId,
      "user_id" : 0,
      "message_details": "string",
      "starred": false,
      "isUnread": value,
      "time": "2023-02-21T12:11:06.950Z",
      "message_title": "string",
      "isChecked": false
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse('${global.apiAddress}UpdateMessageUnread'),

        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },

        body: body
    );

    print("${response.statusCode}");
    print("${response.body}");

    return fetchPostEng(isAscending);
  }

  Future<List<Message>> filterPostEng(bool isAscending, DateTimeRange date) async {
    print("In filter");
    List<Message> messages = [];
    List<Message> results = [];

    final response = await http.get(Uri.parse('${global.apiAddress}GetMessages'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        messages.add(Message.fromMap(jsonDecode(response.body)[i]));
      }

      var startDate = date.start;
      var endD = date.end;
      final endDate = endD.add(Duration(hours: 24));
      print("Start: $startDate");
      print("End: $endDate");

      for (int i = 0; i < messages.length; i++) {
        var msgStart = DateTime.parse(messages[i].time);

        print("Msg: $msgStart");

        if (msgStart.isAfter(startDate) && msgStart.isBefore(endDate)) {
          print("true");
          results.add(messages[i]);
        }
      }

      if (results.isEmpty) {
        hasData = false;
      } else {
        hasData = true;
      }

      print("Results: $results");
      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Message>> searchMessages(String name) async {
    print("enter");
    List<Message> ann = [];
    List<Message> results = [];
    final response =     await http.get(Uri.parse('${global.apiAddress}GetMessages'));



    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        ann.add(Message.fromMap(jsonDecode(response.body)[i]));
      }


      if (name.isNotEmpty) {
        ann.forEach((element) {
          if (element.message_title.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(ann);
      }
      print(results.length);
      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  // Future<List<Message>> searchMessages(String name) async {
  //   List<Message> messages = [];
  //   List<Message> results = [];
  //   List<Message> dummyList = [];
  //   final response =     await http.get(Uri.parse(global.apiAddress + 'GetMessages'));
  //
  //
  //   if (response.statusCode == 200) {
  //     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
  //     var list = json.decode(response.body);
  //     for (int i = 0; i < list.length; i++) {
  //       messages.add(Message.fromMap(jsonDecode(response.body)[i]));
  //     }
  //
  //     if (isAscending) {
  //       messages.sort((a, b) => a.time.compareTo(b.time));
  //     } else {
  //       messages.sort((a, b) => b.time.compareTo(a.time));
  //     }
  //
  //     if (name.isNotEmpty) {
  //       messages.forEach((element) {
  //         if (element.message.toLowerCase().contains(name.toLowerCase())) {
  //           results.add(element);
  //         }
  //       });
  //       if (results.isEmpty) {
  //         hasData = false;
  //       } else {
  //         hasData = true;
  //       }
  //     } else {
  //       results.addAll(messages);
  //     }
  //
  //     return results;
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future<String> fetchUsername(int userID) async {
    //List<User> user = [];

    print("UserID $userID");

    final response = await http.get(Uri.parse('${global.apiAddress}GetUsername/$userID'));

    if (response.statusCode == 200) {
      // var list = json.decode(response.body);
      // print("User: ${list}");
      // user.add(User.fromMap(jsonDecode(response.body)[0]));
      // print("User0: ${user[0]}");
      // return user[0];
      print('Name of getusername: ${response.body.toString()} ');
      return response.body.toString();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<String> fetchEmail(int userID) async {
    //List<User> user = [];

    print("UserID $userID");

    final response = await http.get(Uri.parse('${global.apiAddress}GetEmail/$userID'));

    if (response.statusCode == 200) {
      // var list = json.decode(response.body);
      // print("User: ${list}");
      // user.add(User.fromMap(jsonDecode(response.body)[0]));
      // print("User0: ${user[0]}");
      // return user[0];
      print('Name of getusername: ${response.body.toString()} ');
      return response.body.toString();
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Message>> futurePostEng;
  bool isAscending = false;
  bool hasData = true;
  List<User> users = [];
  TextEditingController _searchController = TextEditingController();

  String email = "";

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();
    futurePostEng = fetchPostEng(isAscending);

    getEml();
    super.initState();
  }

  void getEml() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? route = pref.getString("route");
    print("Route: $route");
    if(route != null){

      pref.remove("route");
    }

    await pref.setString("route", "Messages");

    setState() {
      email = pref.getString("email")!;
      print(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final searchtab = Container(
      height: height*0.05,
      width: width*0.31,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(4)

      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 20.0,top: 5,bottom: 5),
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
              width: width * 0.18,
              height: height * 0.37,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    futurePostEng = searchMessages(value);
                  });
                },
                controller: _searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding:                  EdgeInsets.only(bottom: 20),
                  hintText: 'Search',
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
                            bodyText2:
                            TextStyle(color: Colors.black),
                          ),colorScheme: ColorScheme.fromSwatch().copyWith(
                          //Selected dates background color
                          primary: Color(0xff215732),
                          //Month title and week days color
                          onSurface: Colors.black,
                          //Header elements and selected dates text color
                          //onPrimary: Colors.white,
                        ),),

                        child: Column(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 400.0,
                                maxHeight: height*0.7,
                              ),
                              child: child,
                            )
                          ],
                        ),
                      );
                    });
                setState(() {
                  if (picked != null) {
                    futurePostEng = filterPostEng(isAscending, picked);
                  } else {
                    futurePostEng = filterPostEng(
                        isAscending,
                        DateTimeRange(
                            start: DateTime.now()
                                .subtract(const Duration(days: 365 * 5)),
                            end: DateTime.now()
                                .add((const Duration(days: 365 * 5)))));
                  }
                });
                print(picked);

              },

              child: Row(
                children: [
                  SizedBox(width: width*0.012,),

                  SvgPicture.asset("assets/images/filter.svg",fit: BoxFit.scaleDown,),

                  Text("  Filter".tr(),style: GoogleFonts.barlow(
                    textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
                  ),),
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
                        child: Row(
                          children: [
                            Container(
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

                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isAscending = false;
                                          });
                                          futurePostEng =
                                              fetchPostEng(isAscending);
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
                                        width: width * 0.04,
                                      ),
                                      !isAscending
                                          ? SvgPicture.asset(
                                        "assets/images/sortyes.svg",
                                        fit: BoxFit.scaleDown,
                                      )
                                          : Container(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.012,
                                  ),

                                  // SizedBox(height: ),

                                  Container(
                                    width: width * 0.1,
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
                                              futurePostEng =
                                                  fetchPostEng(isAscending);
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
                                            width: width * 0.04,
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

    return Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height,
              width: width * 0.003,
              color: const Color(0xFFBD9B60),
              // child: Text("we"),
            ),

            //Sidebar start
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
                    ListTile(
                      leading: Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.001, left: width * 0.001),
                        child: SvgPicture.asset("assets/images/admin.svg",
                            color: const Color(0xFFBD9B60)),
                      ),
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
                            const settings(),
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
                    const Divider(
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
                        child: ListTile(
                          leading: SvgPicture.asset("assets/images/message.svg",
                              color: Colors.white),
                          minLeadingWidth: width * 0.02,
                          title: Text(
                            "Messages".tr(),
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
                                const MessageResponsive(),
                                transitionDuration: const Duration(seconds: 0),
                              ),
                            )
                          },
                        ),
                      ),
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

            //Sidebar stop

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
                                            const MessageResponsive(),
                                            transitionDuration:
                                            const Duration(seconds: 0),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/message.svg")
                                  ),
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
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
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
                                      textStyle: const TextStyle(
                                          color: Color(0xFF222222),
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 28),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: height * 0.05),
                            SizedBox(
                              // height: height * 0.8,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width * 0.69,
                                      height: height * 0.07,
                                      decoration: const BoxDecoration(
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
                                            width: width * 0.0279,
                                          ),
                                          Container(
                                            height: 20.0,
                                            width: 20.0,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                            child: SizedBox(
                                              height: 24.0,
                                              width: 24.0,
                                              child: Checkbox(
                                                  checkColor: Colors.white,
                                                  activeColor:
                                                  const Color(0xFFBD9B60),
                                                  side: const BorderSide(
                                                    color: Color(
                                                        0xFFEEEEEE), //your desire colour here
                                                    width: 1.5,
                                                  ),
                                                  value: CheckBoxValue,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      CheckBoxValue = value;
                                                      futurePostEng = selectAll(value);
                                                    });
                                                  }),
                                            ),
                                          ),
                                          Text(
                                            "  Select all".tr(),
                                            style: GoogleFonts.barlow(
                                              textStyle: TextStyle(
                                                  color: const Color(0xFFBD9B60),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: width * 0.01),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),

                                          IconButton(
                                              icon: SvgPicture.asset(
                                                  "assets/images/red_bin.svg",
                                                  color: const Color(0xFFBD9B60)

                                              ),
                                              onPressed: (){
                                                print('Del is pressed');
                                                setState(() {
                                                  futurePostEng = deleteMes();
                                                });
                                              }
                                          ),
                                          SizedBox(
                                            width: width * 0.008,
                                          ),
                                          IconButton(
                                              icon: SvgPicture.asset(
                                                "assets/images/openmessage.svg",
                                                fit: BoxFit.scaleDown,
                                              ),
                                              onPressed: () async {
                                                print('Open message is pressed');
                                                setState((){
                                                  futurePostEng = updateisUnreadAll();
                                                });

                                              }
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

                                    Container(
                                      width: width * 0.690,
                                      // height: height * 0.07,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(9.0),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(9.0),
                                            bottomLeft: Radius.circular(0)),
                                      ),
                                      child: FutureBuilder<List<Message>>(
                                        future: futurePostEng,
                                        builder: ((context, snapshot) {

                                          if (snapshot.hasData) {
                                            return
                                              ListView.builder(
                                                  physics:
                                                  const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                  snapshot.data!.length,
                                                  itemBuilder: (_, index) {
                                                    return Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          width: width * 0.652,
                                                          decoration: BoxDecoration(
                                                            border: Border(
                                                              top: BorderSide(
                                                                color: Colors.black,
                                                                width: 0.05,
                                                              ),
                                                              bottom: BorderSide(
                                                                color: Colors.black,
                                                                width: 0.05,
                                                              ),
                                                            ),
                                                          ),
                                                          child: ConfigurableExpansionTile(

                                                            header:
                                                            Container(
                                                              height: 55,
                                                              child: Row(
                                                                children: [

                                                                  //Checkbox
                                                                  Container(
                                                                    height: 20.0,
                                                                    width: 20.0,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                            Colors.grey),
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(3)),
                                                                    child: SizedBox(
                                                                      height: 24.0,
                                                                      width: 24.0,
                                                                      child: Checkbox(
                                                                          checkColor: Colors.white,
                                                                          activeColor: Color(0xFFBD9B60),
                                                                          side: BorderSide(color: Color(0xFFEEEEEE), width: 1.5,),
                                                                          value: snapshot.data![index].isChecked,
                                                                          onChanged:
                                                                              (bool? val) {
                                                                            setState(() {
                                                                              print("$index is pressed $val");
                                                                              futurePostEng = changeSelection(snapshot.data![index].message_id, val);

                                                                              //futurePostEng = fetchPostEng(isAscending);
                                                                            });
                                                                          }),

                                                                    ),),

                                                                  SizedBox(
                                                                    width: width * 0.017,
                                                                  ),

                                                                  Image.asset(
                                                                      "assets/images/noFace.png",
                                                                     height: 30,
                                                                    width: 30,
                                                                  ),

                                                                  SizedBox(
                                                                    width: width * 0.017,
                                                                  ),

                                                                  Container(
                                                                    width: 80,
                                                                    child: Text(
                                                                      "Muhammad Abdulrahman".tr(),
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style:
                                                                      GoogleFonts.barlow(
                                                                        textStyle: TextStyle(
                                                                            color: Color(0xFF222222),
                                                                            fontWeight: (snapshot.data![index].isUnread) ? FontWeight.w600 : FontWeight.w400,
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: 16
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  SizedBox(
                                                                    width: width * 0.009,
                                                                  ),

                                                                  Container(
                                                                    width: width * 0.11,

                                                                    child: Text(
                                                                      snapshot
                                                                          .data![index]
                                                                          .message_title,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: GoogleFonts
                                                                          .barlow(
                                                                        textStyle: TextStyle(
                                                                            color: Color(
                                                                                0xFF222222),
                                                                            fontWeight: (snapshot.data![index].isUnread) ? FontWeight.w600 : FontWeight.w400,
                                                                            fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                            fontSize:
                                                                            16),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  SizedBox(
                                                                    width: width * 0.005,
                                                                  ),

                                                                  Container(
                                                                    width: width * 0.225,
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .only(right: 0),
                                                                      //18.0
                                                                      child: Text(
                                                                        snapshot
                                                                            .data![index]
                                                                            .message,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: GoogleFonts
                                                                            .barlow(
                                                                          textStyle: TextStyle(
                                                                              color: Color(
                                                                                  0xFF999999),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontStyle:
                                                                              FontStyle
                                                                                  .normal,
                                                                              fontSize:
                                                                              16),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  SizedBox(
                                                                    width: width * 0.005,
                                                                  ),

                                                                  IconButton(
                                                                      icon: SvgPicture.asset(
                                                                        "assets/images/red_bin.svg",

                                                                      ),
                                                                      onPressed: (){
                                                                        print('Del is pressed');
                                                                        setState(() {
                                                                          print("in set state delete");
                                                                          futurePostEng = deleteSingleMes(snapshot.data![index].message_id);
                                                                        });
                                                                      }
                                                                  ),

                                                                  IconButton(
                                                                      icon: SvgPicture.asset(
                                                                          "assets/images/openmessage.svg",
                                                                          color: Colors.black

                                                                      ),
                                                                      onPressed: (){
                                                                        print('Open msg is pressed');
                                                                        setState(() {
                                                                          print("in set state openmes");
                                                                          futurePostEng = updateisUnread(snapshot.data![index].message_id, !snapshot.data![index].isUnread);
                                                                        });
                                                                      }
                                                                  ),


                                                                  Container(
                                                                    width: width * 0.09,

                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                          width * 0.01,
                                                                        ),

                                                                        IconButton(
                                                                          icon: (snapshot.data![index].starred) ? (Icon(Icons.star_rate_rounded, color: Color(0xFFBD9B60),)) : (Icon(Icons.star_outline_rounded, color: Color(0xFFBD9B60),)),
                                                                          // icon: Image.asset(
                                                                          //     (snapshot.data![index].starred) ? "assets/images/staryes.png" : "assets/images/star.png"
                                                                          // ),
                                                                          onPressed: (){
                                                                            print('Star is pressed');
                                                                            setState(() {
                                                                              print("in set state delete");
                                                                              futurePostEng = updateStar(snapshot.data![index].message_id, !snapshot.data![index].starred);
                                                                            });
                                                                          },
                                                                        ),

                                                                        Text(
                                                                          DateTime.parse("${snapshot.data![index].time}").format('M d Y').tr(),
                                                                          style: GoogleFonts
                                                                              .barlow(
                                                                            textStyle: TextStyle(
                                                                                color: Color(
                                                                                    0xFF222222),
                                                                                fontWeight:(snapshot.data![index].isUnread) ? FontWeight.w600 : FontWeight.w400,
                                                                                fontStyle:
                                                                                FontStyle
                                                                                    .normal,
                                                                                fontSize:
                                                                                16),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),

                                                            headerExpanded:
                                                            Flexible(
                                                                child: InkWell(
                                                                  child: Container(
                                                                    height: 55,
                                                                    decoration: BoxDecoration(
                                                                      border: Border(
                                                                        bottom: BorderSide(
                                                                          color: Colors.black,
                                                                          width: 0.05,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width: width * 0.0279,
                                                                        ),
                                                                        Container(
                                                                          height: 20.0,
                                                                          width: 20.0,
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(
                                                                                  color:
                                                                                  Colors.grey),
                                                                              borderRadius:
                                                                              BorderRadius
                                                                                  .circular(3)),
                                                                          child: SizedBox(
                                                                            height: 24.0,
                                                                            width: 24.0,
                                                                            child: Checkbox(
                                                                                checkColor: Colors.white,
                                                                                activeColor: Color(0xFFBD9B60),
                                                                                side: BorderSide(color: Color(0xFFEEEEEE), width: 1.5,),
                                                                                value: snapshot.data![index].isChecked,
                                                                                onChanged:
                                                                                    (bool? val) {
                                                                                  setState(() {
                                                                                    print("$index is pressed $val");
                                                                                    futurePostEng = changeSelection(snapshot.data![index].message_id, val);
                                                                                    //futurePostEng = fetchPostEng(isAscending);
                                                                                  });
                                                                                }),
                                                                          ),),

                                                                        SizedBox(
                                                                          width: width * 0.017,
                                                                        ),

                                                                        Image.asset(
                                                                          "assets/images/noFace.png",
                                                                          height: 30,
                                                                          width: 30,
                                                                        ),




                                                                        SizedBox(
                                                                          width: width * 0.017,
                                                                        ),

                                                                        // FutureBuilder(
                                                                        //     future: fetchUsername(snapshot.data![index].user_id),
                                                                        //     builder: (context1, snapshot1) {
                                                                        //       if(snapshot1.hasData){
                                                                        //         var name = snapshot1.data!.toString().replaceAll(RegExp(r'[^\w\s]+'), '');
                                                                        //         print("Name edit: ${name}");
                                                                        //         return Container(
                                                                        //           width: width * 0.084,
                                                                        //           constraints: BoxConstraints(
                                                                        //             maxHeight: 20,
                                                                        //           ),
                                                                        //           child: Text(
                                                                        //             "${name}".tr(),
                                                                        //             overflow: TextOverflow.ellipsis,
                                                                        //             style:
                                                                        //             GoogleFonts.barlow(
                                                                        //               textStyle: TextStyle(
                                                                        //                   color: Color(0xFF222222),
                                                                        //                   fontWeight: FontWeight.w400,
                                                                        //                   fontStyle: FontStyle.normal,
                                                                        //                   fontSize: 16
                                                                        //               ),
                                                                        //             ),
                                                                        //           ),
                                                                        //         );
                                                                        //       }
                                                                        //       else {
                                                                        //         return Center(child: CircularProgressIndicator());
                                                                        //       }
                                                                        //     }
                                                                        // ),
                                                                        Container(
                                                                          width: width * 0.084,
                                                                          constraints: BoxConstraints(
                                                                            maxHeight: 20,
                                                                          ),
                                                                          child:      Text(
                                                                            "Muhammad Abdulrahman".tr(),
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style:
                                                                            GoogleFonts.barlow(
                                                                              textStyle: TextStyle(
                                                                                  color: Color(0xFF222222),
                                                                                  fontWeight: (snapshot.data![index].isUnread) ? FontWeight.w600 : FontWeight.w400,
                                                                                  fontStyle: FontStyle.normal,
                                                                                  fontSize: 16
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: width * 0.009,
                                                                        ),
                                                                        Text(
                                                                          "akalkhaldi@gdp.pif.gov.sa".tr(),
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style:
                                                                          GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                color: Color(0xFF222222),
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 16
                                                                            ),
                                                                          ),
                                                                        )

                                                                        ,
                                                                        SizedBox(
                                                                          width: width * 0.005,
                                                                        ),

                                                                        IconButton(
                                                                            icon: SvgPicture.asset(
                                                                              "assets/images/red_bin.svg",

                                                                            ),
                                                                            onPressed: (){
                                                                              print('Del is pressed');
                                                                              setState(() {
                                                                                print("in set state delete");
                                                                                futurePostEng = deleteSingleMes(snapshot.data![index].message_id);
                                                                              });
                                                                            }
                                                                        ),

                                                                        IconButton(
                                                                            icon: SvgPicture.asset(
                                                                                "assets/images/openmessage.svg",
                                                                                color: Colors.black

                                                                            ),
                                                                            onPressed: (){
                                                                              print('Open msg is pressed');
                                                                              setState(() {
                                                                                print("in set state delete");
                                                                                futurePostEng = updateisUnread(snapshot.data![index].message_id, !snapshot.data![index].isUnread);
                                                                              });
                                                                            }
                                                                        ),


                                                                        Container(
                                                                          width: width * 0.09,

                                                                          child: Row(
                                                                            children: [

                                                                              SizedBox(
                                                                                width:
                                                                                width * 0.01,
                                                                              ),

                                                                              IconButton(
                                                                                icon: (snapshot.data![index].starred) ? (Icon(Icons.star_rate_rounded, color: Color(0xFFBD9B60),)) : (Icon(Icons.star_outline_rounded, color: Color(0xFFBD9B60),)),

                                                                                onPressed: (){
                                                                                  print('Star is pressed');
                                                                                  setState(() {
                                                                                    print("in set state delete");
                                                                                    futurePostEng = updateStar(snapshot.data![index].message_id, !snapshot.data![index].starred);
                                                                                  });
                                                                                },
                                                                              ),
                                                                              Text(
                                                                                DateTime.parse("${snapshot.data![index].time}").format('M d Y').tr(),
                                                                                style: GoogleFonts
                                                                                    .barlow(
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
                                                                                      16),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    setState(() {
                                                                      futurePostEng = updateisUnread(snapshot.data![index].message_id, false);
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (BuildContext context) => this.widget
                                                                          )
                                                                      );
                                                                    });
                                                                  },
                                                                )
                                                            ),
                                                            childrenBody:
                                                              Container(
                                                                width: width*0.7,
                                                                child: Padding(
                                                                  //right:
                                                                  padding:  EdgeInsets.only(right:context.locale == Locale("en") ? 0: width*0.05,left: context.locale == Locale("en") ? width*0.05:0),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      SizedBox(height: 10,),

                                                                      Padding(
                                                                        padding:  EdgeInsets.symmetric(horizontal: 20.0),

                                                                        child: Container(
                                                                          width: width * 0.2,
                                                                          child: Text("${snapshot.data![index].message_title}".tr(),style: GoogleFonts.barlow(
                                                                            textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                                          ),
                                                                            textAlign: TextAlign.justify,
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      SizedBox(height: 30,),

                                                                      Padding(
                                                                        padding:  EdgeInsets.symmetric(horizontal: 20.0),

                                                                        child: Container(
                                                                          width: width * 0.4,
                                                                          child: Text("${snapshot.data![index].message}".tr(),style: GoogleFonts.barlow(
                                                                            textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                                          ),
                                                                            textAlign: TextAlign.justify,
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      SizedBox(height: 10,),

                                                                      Row(
                                                                        children: [
                                                                          SizedBox(width: width*0.44,),
                                                                          ElevatedButton(
                                                                            onPressed: () {

                                                                            },
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 2),
                                                                              child: Text('Reply'.tr().toString(),strutStyle: StrutStyle(
                                                                                  forceStrutHeight: true
                                                                              ),style: GoogleFonts.barlow(
                                                                                textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                                              )),
                                                                            ),
                                                                            style: ElevatedButton.styleFrom(
                                                                              primary: Color(0xFFBD9B60),
                                                                              elevation: 0.0,
                                                                              shadowColor: Colors.transparent,
                                                                              onPrimary: Colors.white,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(7),
                                                                              ),

                                                                            ),
                                                                          ),

                                                                          SizedBox(width: 10,),

                                                                          ElevatedButton(
                                                                            onPressed: () {

                                                                            },
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 2),
                                                                              child: Text('Mark as resolved'.tr().toString(),strutStyle: StrutStyle(
                                                                                  forceStrutHeight: true
                                                                              ),style: GoogleFonts.barlow(
                                                                                textStyle: TextStyle(color: Color(0xFF46574d), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                                              )),
                                                                            ),
                                                                            style: ElevatedButton.styleFrom(
                                                                              primary: Color(0xFFd1ccbd),
                                                                              elevation: 0.0,
                                                                              shadowColor: Colors.transparent,
                                                                              onPrimary: Color(0xFF46574d),
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(7),
                                                                              ),

                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),

                                                                      SizedBox(height: 10,),

                                                                    ],
                                                                  ),
                                                                ),


                                                              ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                              );

                                          } else {
                                            return Center(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "No Messages".tr(),
                                                  style: GoogleFonts.barlow(
                                                    textStyle:
                                                    const TextStyle(
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
                                          }
                                        }),
                                      ),

                                    ),],),
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
