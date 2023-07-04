import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/util/fieldValidator.dart' as validator;
import 'package:pif_admin_dashboard/mobile/sideBar.dart';

import '../models/faqModel.dart';

class mobileFaq extends StatefulWidget {
  const mobileFaq({Key? key}) : super(key: key);

  @override
  State<mobileFaq> createState() => _mobileFaqState();
}

class _mobileFaqState extends State<mobileFaq> with TickerProviderStateMixin {
  String dropdownvalue1 = 'Instructor'.tr();
  late TabController _nestedTabController;

  final myControllertitle_e = TextEditingController();
  final myControllerresponse_e = TextEditingController();
  final myControllertitle_a = TextEditingController();
  final myControllerresponse_a = TextEditingController();

  final myControllertitleedit_e = TextEditingController();
  final myControllerresponseedit_e = TextEditingController();
  final myControllertitleedit_a = TextEditingController();
  final myControllerresponseedit_a = TextEditingController();

  var val = "";

  // List of items in our dropdown menu
  Future<List<FaqModel>> fetchAllEng() async {
    final response =
    await http.get(Uri.parse('${global.apiAddress}GetAllFaqEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<FaqModel>((json) => FaqModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<FaqModel>> fetchAllArb() async {
    final response =
    await http.get(Uri.parse('${global.apiAddress}GetAllFaqArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<FaqModel>((json) => FaqModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<FaqModel>> futureEng;
  late Future<List<FaqModel>> futureArb;

  Future<Map<String, dynamic>> fetchEng(int id) async {
    final response =
    await http.get(Uri.parse('${global.apiAddress}GetFAQEng/${id}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      //print("engcool" + data["faq_title"]);
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Map<String, dynamic>> fetchArb(int id) async {
    final response =
    await http.get(Uri.parse('${global.apiAddress}GetFAQArb/${id}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      //print("aracool" + data["faq_title"]);
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Map<String, dynamic> faqEng;
  late Map<String, dynamic> faqArb;

  // List of items in our dropdown menu
  var items = [
    'Instructor'.tr(),
    'Admin'.tr(),
    'Participants'.tr(),
  ];

  Future<http.Response> deleteRequest(String uid, int id) async {
    Map data = {
      "faq_id": id,
      "faq_title": "string",
      "faq_description": "string",
      "faq_unique": uid
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse('${global.apiAddress}DeleteFAQ'),
        headers: {"Content-Type": "application/json"}, body: body);
    setState(() {
      futureEng = fetchAllEng();
      futureArb = fetchAllArb();
    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> deleteRequestUpdate(int id) async {
    Map data = {
      "faq_id": id,
      "faq_title": "string",
      "faq_description": "string",
      "faq_unique": "string"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse('${global.apiAddress}DeleteFAQ'),
        headers: {"Content-Type": "application/json"}, body: body);
    setState(() {
      futureEng = fetchAllEng();
      futureArb = fetchAllArb();
    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  // Future<http.Response> updateRequest (String status, int uid) async {
  //
  //
  //   Map data = {
  //     "user_id": "1",
  //     "name": "q",
  //     "email": "dfg",
  //     "user_type":"s",
  //     "user_img":"d",
  //     "user_status":status
  //   };
  //   //encode Map to JSON
  //   var body = json.encode(data);
  //
  //   var response = await http.post(Uri.parse(global.apiAddress + 'UpdateStatus/$uid'),
  //       headers: {"Content-Type": "application/json"},
  //       body: body
  //   );
  //   print("${response.statusCode}");
  //   print("${response.body}");
  //   setState(() {
  //     futurePostEng = fetchPostEng();
  //
  //
  //
  //
  //   });
  //   return response;
  // }

  Future<http.Response> updateRequest_e(String uid) async {
    Map data = {
      "faq_id": 0,
      "faq_title": myControllertitleedit_e.text,
      "faq_description": myControllerresponseedit_e.text,
      "faq_unique": uid
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse('${global.apiAddress}UpdateFAQEng/$uid'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    setState(() {
      futureEng = fetchAllEng();
    });

    return response;
  }

  Future<http.Response> updateRequest_a(String uid) async {
    Map data = {
      "faq_id": 0,
      "faq_title": myControllertitleedit_a.text,
      "faq_description": myControllerresponseedit_a.text,
      "faq_unique": uid
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse('${global.apiAddress}UpdateFAQArb/$uid'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    setState(() {
      futureArb = fetchAllArb();
    });
    return response;
  }


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
  var uuid = Uuid();

  Future<http.Response> postRequest_e() async {
    Map data = {
      "faq_id": 0,
      "faq_title": myControllertitle_e.text,
      "faq_description": myControllerresponse_e.text,
      "faq_unique": uuid.v4()
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse('${global.apiAddress}AddFAQEng'),
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

  Future<http.Response> postRequest_eUpdate(var title, var des) async {
    Map data = {
      "faq_id": 0,
      "faq_title": title,
      "faq_description": des,
      "faq_unique": uuid.v4()
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse('${global.apiAddress}AddFAQEng'),
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

  Future<http.Response> postRequest_a() async {
    Map data = {
      "faq_id": 0,
      "faq_title": myControllertitle_a.text,
      "faq_description": myControllerresponse_a.text,
      "faq_unique": uuid.v4()
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse('${global.apiAddress}AddFAQArb'),
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

  Future<http.Response> postRequest_aUpdate(var title, var des) async {
    Map data = {
      "faq_id": 0,
      "faq_title": title,
      "faq_description": des,
      "faq_unique": uuid.v4()
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse('${global.apiAddress}AddFAQArb'),
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

  void submitFormPost() async {
    String errorText = "";

    // Arabic fields validity check
    errorText +=
        validator.isValid("english FAQ", myControllertitle_e.text, "empty");
    errorText += validator.isValid(
        "english response", myControllerresponse_e.text, "empty");
    errorText +=
        validator.isValid("arabic FAQ", myControllertitle_a.text, "empty");
    errorText += validator.isValid(
        "arabic response", myControllerresponse_a.text, "empty");

    if (errorText != "") {
      validator.alertDialog(
          context, errorText.substring(0, errorText.length - 1));
      return;
    }

    await postRequest_e();
    await postRequest_a();
    setState(() {
      futureEng = fetchAllEng();
      futureArb = fetchAllArb();
    });
    myControllertitle_e.text = "";
    myControllerresponse_e.text = "";
    myControllertitle_a.text = "";
    myControllerresponse_a.text = "";
  }

  void updateListPost(var titleA,var desA,var titleE,var desE) async {
    // var titleA ;
    // var titleE;
    // var desA;
    // var desE;
    // fetchArb(values.faq_id).then(
    //   (value) {
    //     titleA = value["faq_title"];
    //     print(titleA + " LO LOLOLOLO");
    //     desA = value["faq_description"];
    //   },
    // );
    // fetchEng(values.faq_id).then(
    //   (value) {
    //     titleE = value["faq_title"];
    //     desE = value["faq_description"];
    //   },
    // );

    print("```````````````````");
    print("the new reordered list");
    // print(values.faq_id);
    print(titleA);
    print(titleE);
    print(desA);
    print(desE);
    print("```````````````````");

    await postRequest_eUpdate(titleE, desE);
    await postRequest_aUpdate(titleA, desA);
    setState(() {
      futureEng = fetchAllEng();
      futureArb = fetchAllArb();
    });
  }

  void updateFAQAra(String eUID, String aUID) {
    String errorText = "";

    // Arabic fields validity check
    errorText +=
        validator.isValid("arabic FAQ", myControllertitleedit_a.text, "empty");
    errorText += validator.isValid(
        "arabic response", myControllerresponseedit_a.text, "empty");

    if (errorText != "") {
      validator.alertDialog(
          context, errorText.substring(0, errorText.length - 1));
      return;
    }

    updateRequest_a(aUID);
    updateRequest_e(eUID);
  }

  void updateFAQEng(String eUID, String aUID) {
    String errorText = "";

    // Arabic fields validity check
    errorText +=
        validator.isValid("english FAQ", myControllertitleedit_e.text, "empty");
    errorText += validator.isValid(
        "english response", myControllerresponseedit_e.text, "empty");

    if (errorText != "") {
      validator.alertDialog(
          context, errorText.substring(0, errorText.length - 1));
      return;
    }

    updateRequest_a(aUID);
    updateRequest_e(eUID);
  }

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();
    futureEng = fetchAllEng();
    futureArb = fetchAllArb();
    _nestedTabController = new TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
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
        primary: Colors.white,
        //elevated btton background color
        onPrimary: Colors.black,
        minimumSize: Size(120, 50)),
  ));
  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isSwitched = false;

    void toggleSwitch(bool value) {
      if (isSwitched == false) {
        setState(() {
          isSwitched = true;
        });
        print('Switch Button is ON');
        // img = 'assets/images/femaleuser.png';

      } else {
        setState(() {
          isSwitched = false;
        });
        print('Switch Button is OFF');
        // img = 'assets/images/pfp.png';
      }
    }

    return Scaffold(
        drawer: SideNavBar(),
        appBar: AppBar(
            toolbarHeight: height * 0.15,
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Frequently Asked Questions".tr(),
                        style: GoogleFonts.barlow(
                          textStyle: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 22),
                        ),
                      ),
                    ),
                    // SizedBox(width: width*0.55,),
                    Builder(
                      builder: (context) => IconButton(
                        icon: new Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // actions: <Widget>[
            //
            // ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                // image: AssetImage(context.locale == Locale("en") ? 'assets/images/bgsmall.png' : 'assets/images/topNavArabic.png'),
                image: AssetImage('assets/mobileImages/navbg.png'),
                fit: BoxFit.fill,
              )),
            )),
        body: Row(
          children: [
            WebSmoothScroll(
              controller: _scrollController,
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 20,
                            height: 200.0,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Locale? lang = Locale("en");
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0))),
                                        scrollable: true,
                                        content: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Form(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: height * 0.03),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: context.locale ==
                                                              Locale("en")
                                                          ? width * 0.04
                                                          : 0,
                                                      left: context.locale ==
                                                              Locale("en")
                                                          ? 0
                                                          : width * 0.04,
                                                      bottom: height * 0.01),
                                                  child: Text(
                                                    "FAQ English".tr(),
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
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    width: width * 0.56,
                                                    height: height * 0.05,
                                                    child: TextField(
                                                      controller:
                                                          myControllertitle_e,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 0.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 0.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.02),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: context.locale ==
                                                              Locale("en")
                                                          ? width * 0.04
                                                          : 0,
                                                      left: context.locale ==
                                                              Locale("en")
                                                          ? 0
                                                          : width * 0.04,
                                                      bottom: height * 0.01),
                                                  child: Text(
                                                    "Response English".tr(),
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
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    width: width * 0.56,
                                                    height: height * 0.1,
                                                    child: TextField(
                                                      controller:
                                                          myControllerresponse_e,
                                                      maxLines: 10,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 0.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 0.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.03),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: context.locale ==
                                                              Locale("en")
                                                          ? width * 0.04
                                                          : 0,
                                                      left: context.locale ==
                                                              Locale("en")
                                                          ? 0
                                                          : width * 0.04,
                                                      bottom: height * 0.01),
                                                  child: Text(
                                                    "FAQ Arabic".tr(),
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
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    width: width * 0.56,
                                                    height: height * 0.05,
                                                    child: TextField(
                                                      controller:
                                                          myControllertitle_a,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 0.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 0.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.02),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: context.locale ==
                                                              Locale("en")
                                                          ? width * 0.04
                                                          : 0,
                                                      left: context.locale ==
                                                              Locale("en")
                                                          ? 0
                                                          : width * 0.04,
                                                      bottom: height * 0.01),
                                                  child: Text(
                                                    "Response Arabic".tr(),
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
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    width: width * 0.56,
                                                    height: height * 0.1,
                                                    child: TextField(
                                                      controller:
                                                          myControllerresponse_a,
                                                      maxLines: 10,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 0.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFEEEEEE),
                                                              width: 0.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.05),
                                                SizedBox(
                                                  width: width * 0.70,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'Cancel'
                                                                .tr()
                                                                .toString(),
                                                            strutStyle: StrutStyle(
                                                                forceStrutHeight:
                                                                    true),
                                                            style: GoogleFonts
                                                                .barlow(
                                                              textStyle: TextStyle(
                                                                  color: Color(
                                                                      0xFF183028),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            elevation: 0.0,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            primary: Color(
                                                                0xFFF5F0E5),
                                                            onPrimary: Color(
                                                                0xFF183028),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.050,
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            submitFormPost();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              'Confirm & add'
                                                                  .tr()
                                                                  .toString(),
                                                              strutStyle:
                                                                  StrutStyle(
                                                                      forceStrutHeight:
                                                                          true),
                                                              style: GoogleFonts
                                                                  .barlow(
                                                                textStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFFFFFFFF),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        16),
                                                              )),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Color(
                                                                0xFF215732),
                                                            elevation: 0.0,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            onPrimary: Color(
                                                                0xFFFFFFFF),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.02),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Text('Add FAQ'.tr().toString(),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
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
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  side: BorderSide(
                                    width: 0.4,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                          height: MediaQuery.of(context).size.height - 250,
                          child: WebSmoothScroll(
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              child: Card(
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
                                        indicatorWeight: 5.0,
                                        indicatorPadding: EdgeInsets.zero,
                                        tabs: <Widget>[
                                          Tab(
                                            text: "العربية",
                                          ),
                                          Tab(
                                            text: "English",
                                          ),
                                        ],
                                      ),
                                      //????????????
                                      //!!!!!!!!!!!!!
                                      Container(
                                        height: MediaQuery.of(context).size.height-320,
                                        child: SizedBox(
                                        height: MediaQuery.of(context).size.height-370,
                                        width:width * 0.9,
                                          // height: height * 0.08,
                                          // margin: EdgeInsets.only(
                                          //     left: 16.0, right: 16.0),
                                          child: TabBarView(
                                            controller: _nestedTabController,
                                            children: <Widget>[
                                              WebSmoothScroll(
                                                  controller: _scrollController,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        FutureBuilder<
                                                            List<FaqModel>>(
                                                          future: futureArb,
                                                          builder:
                                                              (context, snapshot) {
                                                            if (snapshot.hasData) {
                                                              return SizedBox(
                                                              // height: 0.05,
                                                              // width: 0.05,
                                                                child: ReorderableListView.builder(
                                                                  physics: NeverScrollableScrollPhysics(),
                                                                  buildDefaultDragHandles: false,
                                                                  shrinkWrap: true,
                                                                  itemCount: snapshot.data!.length,
                                                                  itemBuilder: (_, index) {
                                                                    return Container(
                                                                        key: Key(
                                                                            '$index'),
                                                                        child:
                                                                        Padding(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal:
                                                                              width *
                                                                                  0.01,
                                                                              vertical:
                                                                              height *
                                                                                  0.02),
                                                                          child: Card(
                                                                            child:
                                                                            Padding(
                                                                              padding:
                                                                              EdgeInsets.symmetric(vertical: height * 0.02),
                                                                              child:
                                                                              Column(
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: width * 0.02,
                                                                                      ),
                                                                                      Icon(
                                                                                        Icons.question_answer_outlined,
                                                                                        color: Color(0xffbd9b60),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.028,
                                                                                      ),
                                                                                      Text("${snapshot.data![index].faq_title}")
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: height * 0.03,
                                                                                  ),
                                                                                  //!?!?!?!!!!!
                                                                                  Row(
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: width * 0.02,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.04,
                                                                                      ),
                                                                                      Container(
                                                                                        width: width * 0.52,
                                                                                        child: Text("${snapshot.data![index].faq_description}"),
                                                                                      ),
                                                                                      Container(
                                                                                        width: width * 0.2,
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          children: [
                                                                                            InkWell(
                                                                                                onTap: () {
                                                                                                  print(index);
                                                                                                  print(snapshot.data![index].faq_id);
                                                                                                  print(snapshot.data![index].faq_title);
                                                                                                  print(snapshot.data![index].faq_unique);
                                                                                                  String aUID = "", eUID = "";
                                                                                                  setState(() {
                                                                                                    fetchArb(snapshot.data![index].faq_id).then(
                                                                                                          (value) {
                                                                                                        myControllertitleedit_a.text = value["faq_title"];
                                                                                                        myControllerresponseedit_a.text = value["faq_description"];
                                                                                                        aUID = value["faq_unique"];
                                                                                                      },
                                                                                                    );
                                                                                                    fetchEng(snapshot.data![index].faq_id).then(
                                                                                                          (value) {
                                                                                                        myControllertitleedit_e.text = value["faq_title"];
                                                                                                        myControllerresponseedit_e.text = value["faq_description"];
                                                                                                        eUID = value["faq_unique"];
                                                                                                      },
                                                                                                    );
                                                                                                  });
                                                                                                  showDialog(
                                                                                                      context: context,
                                                                                                      builder: (BuildContext context) {
                                                                                                        Locale? lang = Locale("en");
                                                                                                        return AlertDialog(
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                                                                                          scrollable: true,
                                                                                                          content: Padding(
                                                                                                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                                                                                            child: Form(
                                                                                                              child: Column(
                                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                children: <Widget>[
                                                                                                                  SizedBox(height: height * 0.07),
                                                                                                                  Padding(
                                                                                                                    padding: EdgeInsets.only(right: context.locale == Locale("en") ? width * 0.04 : 0, left: context.locale == Locale("en") ? 0 : width * 0.04, bottom: height * 0.01),
                                                                                                                    child: Text(
                                                                                                                      "English FAQ".tr(),
                                                                                                                      style: GoogleFonts.barlow(
                                                                                                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Center(
                                                                                                                    child: SizedBox(
                                                                                                                      width: width * 0.56,
                                                                                                                      height: height * 0.05,
                                                                                                                      child: TextField(
                                                                                                                        controller: myControllertitleedit_e,
                                                                                                                        decoration: InputDecoration(
                                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                          ),
                                                                                                                          enabledBorder: OutlineInputBorder(
                                                                                                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  SizedBox(height: height * 0.02),
                                                                                                                  Padding(
                                                                                                                    padding: EdgeInsets.only(right: context.locale == Locale("en") ? width * 0.04 : 0, left: context.locale == Locale("en") ? 0 : width * 0.04, bottom: height * 0.01),
                                                                                                                    child: Text(
                                                                                                                      "English Response".tr(),
                                                                                                                      style: GoogleFonts.barlow(
                                                                                                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Center(
                                                                                                                    child: SizedBox(
                                                                                                                      width: width * 0.56,
                                                                                                                      height: height * 0.1,
                                                                                                                      child: TextField(
                                                                                                                        controller: myControllerresponseedit_e,
                                                                                                                        maxLines: 10,
                                                                                                                        decoration: InputDecoration(
                                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                          ),
                                                                                                                          enabledBorder: OutlineInputBorder(
                                                                                                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  SizedBox(height: height * 0.07),
                                                                                                                  Padding(
                                                                                                                    padding: EdgeInsets.only(right: context.locale == Locale("en") ? width * 0.04 : 0, left: context.locale == Locale("en") ? 0 : width * 0.04, bottom: height * 0.01),
                                                                                                                    child: Text(
                                                                                                                      "Arabic FAQ".tr(),
                                                                                                                      style: GoogleFonts.barlow(
                                                                                                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Center(
                                                                                                                    child: SizedBox(
                                                                                                                      width: width * 0.56,
                                                                                                                      height: height * 0.05,
                                                                                                                      child: TextField(
                                                                                                                        controller: myControllertitleedit_a,
                                                                                                                        decoration: InputDecoration(
                                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                          ),
                                                                                                                          enabledBorder: OutlineInputBorder(
                                                                                                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  SizedBox(height: height * 0.02),
                                                                                                                  Padding(
                                                                                                                    padding: EdgeInsets.only(right: context.locale == Locale("en") ? width * 0.04 : 0, left: context.locale == Locale("en") ? 0 : width * 0.04, bottom: height * 0.01),
                                                                                                                    child: Text(
                                                                                                                      "Arabic Response".tr(),
                                                                                                                      style: GoogleFonts.barlow(
                                                                                                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Center(
                                                                                                                    child: SizedBox(
                                                                                                                      width: width * 0.56,
                                                                                                                      height: height * 0.1,
                                                                                                                      child: TextField(
                                                                                                                        controller: myControllerresponseedit_a,
                                                                                                                        maxLines: 10,
                                                                                                                        decoration: InputDecoration(
                                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                          ),
                                                                                                                          enabledBorder: OutlineInputBorder(
                                                                                                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  SizedBox(height: height * 0.05),
                                                                                                                  Center(
                                                                                                                    child: SizedBox(
                                                                                                                      width: width * 10,
                                                                                                                      child: Row(
                                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                                        children: [
                                                                                                                          Container(
                                                                                                                          height: 50,
                                                                                                                          width: width * 0.3,
                                                                                                                            child: ElevatedButton(
                                                                                                                              onPressed: () {
                                                                                                                                Navigator.pop(context);
                                                                                                                              },
                                                                                                                              child: Text(
                                                                                                                                'Cancel'.tr().toString(),
                                                                                                                                strutStyle: StrutStyle(forceStrutHeight: true),
                                                                                                                                style: GoogleFonts.barlow(
                                                                                                                                  textStyle: TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              style: ElevatedButton.styleFrom(
                                                                                                                                elevation: 0.0,
                                                                                                                                shadowColor: Colors.transparent,
                                                                                                                                primary: Color(0xFFF5F0E5),
                                                                                                                                onPrimary: Color(0xFF183028),
                                                                                                                                shape: RoundedRectangleBorder(
                                                                                                                                  borderRadius: BorderRadius.circular(7),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          SizedBox(
                                                                                                                            width: width * 0.030,
                                                                                                                          ),
                                                                                                                          Container(
                                                                                                                          height: 50,
                                                                                                                          width: width * 0.3,
                                                                                                                            child: ElevatedButton(
                                                                                                                              onPressed: () {
                                                                                                                                updateFAQAra(eUID, aUID);
                                                                                                                                Navigator.pop(context);
                                                                                                                              },
                                                                                                                              child: Text('Confirm & add'.tr().toString(),
                                                                                                                                  strutStyle: StrutStyle(forceStrutHeight: true),
                                                                                                                                  style: GoogleFonts.barlow(
                                                                                                                                    textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                                                                                  )),
                                                                                                                              style: ElevatedButton.styleFrom(
                                                                                                                                primary: Color(0xFF215732),
                                                                                                                                elevation: 0.0,
                                                                                                                                shadowColor: Colors.transparent,
                                                                                                                                onPrimary: Color(0xFFFFFFFF),
                                                                                                                                shape: RoundedRectangleBorder(
                                                                                                                                  borderRadius: BorderRadius.circular(7),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  SizedBox(height: height * 0.02),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      });
                                                                                                },
                                                                                                child: SvgPicture.asset(
                                                                                                  "assets/images/pen.svg",
                                                                                                  fit: BoxFit.scaleDown,
                                                                                                )),
                                                                                            SizedBox(width: 11,),
                                                                                            InkWell(
                                                                                                onTap: () {
                                                                                                  deleteRequest(snapshot.data![index].faq_unique, snapshot.data![index].faq_id);
                                                                                                },
                                                                                                hoverColor: Colors.transparent,
                                                                                                child: SvgPicture.asset("assets/images/red_bin.svg", color: Color(0xFFF64747))),
                                                                                            SizedBox(width: 9,),
                                                                                            ReorderableDragStartListener(child: SvgPicture.asset("assets/images/li.svg"), index: index),
                                                                                          ],
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ));
                                                                  },
                                                                  //qwerty
                                                                  onReorder: (int oldIndex, int newIndex) {
                                                                    setState(() {
                                                                      if (newIndex > oldIndex) {
                                                                        newIndex -= 1;
                                                                      }

                                                                      final item = snapshot.data?.removeAt(oldIndex);

                                                                      snapshot.data?.insert(newIndex, item!);

                                                                      var list = [];
                                                                      for (int i = 0; i < snapshot.data!.length; i++) {
                                                                        //print(i.toString()+" "+snapshot.data![i].faq_id.toString()+" "+snapshot.data![i].faq_title.toString());
                                                                        list.add(snapshot.data![i].faq_id);
                                                                      }

                                                                      list.forEach((item) {
                                                                        String? titleA;
                                                                        String? titleE;
                                                                        String? desA;
                                                                        String? desE;
                                                                        fetchArb(item).then((value) {
                                                                          titleA = value["faq_title"];
                                                                          desA = value["faq_description"];
                                                                        },
                                                                        );
                                                                        fetchEng(item).then((value) {
                                                                          titleE = value["faq_title"];
                                                                          desE = value["faq_description"];
                                                                        },
                                                                        );
                                                                        Timer(const Duration(seconds: 3), () {
                                                                          deleteRequestUpdate(item);
                                                                          Timer(const Duration(seconds: 2), () async {
                                                                            updateListPost(titleA, desA, titleE, desE);
                                                                          });
                                                                        });
                                                                      });
                                                                    });
                                                                  },
                                                                ),
                                                              );
                                                            } else {
                                                              return Center(
                                                                  child:
                                                                  CircularProgressIndicator());
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                                  //@@@@@@@@@
                                              WebSmoothScroll(
                                                  controller: _scrollController,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        FutureBuilder<
                                                            List<FaqModel>>(
                                                          future: futureEng,
                                                          builder:
                                                              (context, snapshot) {
                                                            if (snapshot.hasData) {
                                                              return ReorderableListView
                                                                  .builder(
                                                                physics:
                                                                NeverScrollableScrollPhysics(),
                                                                buildDefaultDragHandles:
                                                                false,
                                                                shrinkWrap: true,
                                                                itemCount: snapshot
                                                                    .data!.length,
                                                                itemBuilder:
                                                                    (_, index) {
                                                                  return Container(
                                                                      key: Key(
                                                                          '$index'),
                                                                      child:
                                                                      Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                            width *
                                                                                0.01,
                                                                            vertical:
                                                                            height *
                                                                                0.02),
                                                                        child: Card(
                                                                          child:
                                                                          Padding(
                                                                            padding:
                                                                            EdgeInsets.symmetric(vertical: height * 0.02),
                                                                            child:
                                                                            Column(
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: width * 0.02,
                                                                                    ),
                                                                                    Icon(
                                                                                      Icons.question_answer_outlined,
                                                                                      color: Color(0xffbd9b60),
                                                                                      // ">".tr().toString(),
                                                                                      // strutStyle:
                                                                                      //     StrutStyle(forceStrutHeight: true),
                                                                                      // style:
                                                                                      //     GoogleFonts.barlow(
                                                                                      //   textStyle: TextStyle(fontFamily: 'Barlow', fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, color: Color(0xFFBD9B60)),
                                                                                      // ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: width * 0.028,
                                                                                    ),
                                                                                    Text("${snapshot.data![index].faq_title}"),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: height * 0.03,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: width * 0.02,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: width * 0.04,
                                                                                    ),
                                                                                    Container(
                                                                                      width: width * 0.52,
                                                                                      child: Text("${snapshot.data![index].faq_description}"),
                                                                                    ),
                                                                                    Container(
                                                                                      width: width * 0.2,
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          InkWell(
                                                                                              onTap: () {
                                                                                                print(index);
                                                                                                print(snapshot.data![index].faq_id);
                                                                                                print(snapshot.data![index].faq_title);
                                                                                                print(snapshot.data![index].faq_unique);
                                                                                                String aUID = "", eUID = "";
                                                                                                setState(() {
                                                                                                  fetchArb(snapshot.data![index].faq_id).then(
                                                                                                        (value) {
                                                                                                      myControllertitleedit_a.text = value["faq_title"];
                                                                                                      myControllerresponseedit_a.text = value["faq_description"];
                                                                                                      aUID = value["faq_unique"];
                                                                                                    },
                                                                                                  );
                                                                                                  fetchEng(snapshot.data![index].faq_id).then(
                                                                                                        (value) {
                                                                                                      myControllertitleedit_e.text = value["faq_title"];
                                                                                                      myControllerresponseedit_e.text = value["faq_description"];
                                                                                                      eUID = value["faq_unique"];
                                                                                                    },
                                                                                                  );
                                                                                                });
                                                                                                showDialog(
                                                                                                    context: context,
                                                                                                    builder: (BuildContext context) {
                                                                                                      Locale? lang = Locale("en");
                                                                                                      return AlertDialog(
                                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                                                                                        scrollable: true,
                                                                                                        content: Padding(
                                                                                                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                                                                                          child: Form(
                                                                                                            child: Column(
                                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                              children: <Widget>[
                                                                                                                SizedBox(height: height * 0.07),
                                                                                                                Padding(
                                                                                                                  padding: EdgeInsets.only(right: context.locale == Locale("en") ? width * 0.04 : 0, left: context.locale == Locale("en") ? 0 : width * 0.04, bottom: height * 0.01),
                                                                                                                  child: Text(
                                                                                                                    "English FAQ".tr(),
                                                                                                                    style: GoogleFonts.barlow(
                                                                                                                      textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Center(
                                                                                                                  child: SizedBox(
                                                                                                                    width: width * 0.56,
                                                                                                                    height: height * 0.05,
                                                                                                                    child: TextField(
                                                                                                                      controller: myControllertitleedit_e,
                                                                                                                      decoration: InputDecoration(
                                                                                                                        focusedBorder: OutlineInputBorder(
                                                                                                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                        ),
                                                                                                                        enabledBorder: OutlineInputBorder(
                                                                                                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                SizedBox(height: height * 0.02),
                                                                                                                Padding(
                                                                                                                  padding: EdgeInsets.only(right: context.locale == Locale("en") ? width * 0.04 : 0, left: context.locale == Locale("en") ? 0 : width * 0.04, bottom: height * 0.01),
                                                                                                                  child: Text(
                                                                                                                    "English Response".tr(),
                                                                                                                    style: GoogleFonts.barlow(
                                                                                                                      textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Center(
                                                                                                                  child: SizedBox(
                                                                                                                    width: width * 0.56,
                                                                                                                    height: height * 0.1,
                                                                                                                    child: TextField(
                                                                                                                      controller: myControllerresponseedit_e,
                                                                                                                      maxLines: 10,
                                                                                                                      decoration: InputDecoration(
                                                                                                                        focusedBorder: OutlineInputBorder(
                                                                                                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                        ),
                                                                                                                        enabledBorder: OutlineInputBorder(
                                                                                                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                SizedBox(height: height * 0.07),
                                                                                                                Padding(
                                                                                                                  padding: EdgeInsets.only(right: context.locale == Locale("en") ? width * 0.04 : 0, left: context.locale == Locale("en") ? 0 : width * 0.04, bottom: height * 0.01),
                                                                                                                  child: Text(
                                                                                                                    "Arabic FAQ".tr(),
                                                                                                                    style: GoogleFonts.barlow(
                                                                                                                      textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Center(
                                                                                                                  child: SizedBox(
                                                                                                                    width: width * 0.56,
                                                                                                                    height: height * 0.05,
                                                                                                                    child: TextField(
                                                                                                                      controller: myControllertitleedit_a,
                                                                                                                      decoration: InputDecoration(
                                                                                                                        focusedBorder: OutlineInputBorder(
                                                                                                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                        ),
                                                                                                                        enabledBorder: OutlineInputBorder(
                                                                                                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                SizedBox(height: height * 0.02),
                                                                                                                Padding(
                                                                                                                  padding: EdgeInsets.only(right: context.locale == Locale("en") ? width * 0.04 : 0, left: context.locale == Locale("en") ? 0 : width * 0.04, bottom: height * 0.01),
                                                                                                                  child: Text(
                                                                                                                    "Arabic Response".tr(),
                                                                                                                    style: GoogleFonts.barlow(
                                                                                                                      textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Center(
                                                                                                                  child: SizedBox(
                                                                                                                    width: width * 0.56,
                                                                                                                    height: height * 0.1,
                                                                                                                    child: TextField(
                                                                                                                      controller: myControllerresponseedit_a,
                                                                                                                      maxLines: 10,
                                                                                                                      decoration: InputDecoration(
                                                                                                                        focusedBorder: OutlineInputBorder(
                                                                                                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                        ),
                                                                                                                        enabledBorder: OutlineInputBorder(
                                                                                                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                SizedBox(height: height * 0.07),
                                                                                                                Center(
                                                                                                                  child: SizedBox(
                                                                                                                    width: width * 0.25,
                                                                                                                    child: Row(
                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                                      children: [
                                                                                                                        ElevatedButton(
                                                                                                                          onPressed: () {
                                                                                                                            Navigator.pop(context);
                                                                                                                          },
                                                                                                                          child: Padding(
                                                                                                                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                                                                                                                            child: Text(
                                                                                                                              'Cancel'.tr().toString(),
                                                                                                                              strutStyle: StrutStyle(forceStrutHeight: true),
                                                                                                                              style: GoogleFonts.barlow(
                                                                                                                                textStyle: TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          style: ElevatedButton.styleFrom(
                                                                                                                            elevation: 0.0,
                                                                                                                            shadowColor: Colors.transparent,
                                                                                                                            primary: Color(0xFFF5F0E5),
                                                                                                                            onPrimary: Color(0xFF183028),
                                                                                                                            shape: RoundedRectangleBorder(
                                                                                                                              borderRadius: BorderRadius.circular(7),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        SizedBox(
                                                                                                                          width: width * 0.014,
                                                                                                                        ),
                                                                                                                        ElevatedButton(
                                                                                                                          onPressed: () {
                                                                                                                            updateFAQEng(eUID, aUID);
                                                                                                                            Navigator.pop(context);
                                                                                                                          },
                                                                                                                          child: Padding(
                                                                                                                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
                                                                                                                            child: Text('Confirm & add'.tr().toString(),
                                                                                                                                strutStyle: StrutStyle(forceStrutHeight: true),
                                                                                                                                style: GoogleFonts.barlow(
                                                                                                                                  textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                                                                                                                                )),
                                                                                                                          ),
                                                                                                                          style: ElevatedButton.styleFrom(
                                                                                                                            primary: Color(0xFF215732),
                                                                                                                            elevation: 0.0,
                                                                                                                            shadowColor: Colors.transparent,
                                                                                                                            onPrimary: Color(0xFFFFFFFF),
                                                                                                                            shape: RoundedRectangleBorder(
                                                                                                                              borderRadius: BorderRadius.circular(7),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                SizedBox(height: height * 0.02),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    });
                                                                                              },
                                                                                              child: SvgPicture.asset(
                                                                                                "assets/images/pen.svg",
                                                                                                fit: BoxFit.scaleDown,
                                                                                                // alignment: Alignment.centerRight,
                                                                                              )),
                                                                                              SizedBox(width: 11,),
                                                                                          InkWell(
                                                                                              onTap: () {
                                                                                                deleteRequest(snapshot.data![index].faq_unique, snapshot.data![index].faq_id);
                                                                                              },
                                                                                              hoverColor: Colors.transparent,
                                                                                              child: SvgPicture.asset("assets/images/red_bin.svg", color: Color(0xFFF64747))),
                                                                                          SizedBox(width: 9,),
                                                                                          ReorderableDragStartListener(child: SvgPicture.asset("assets/images/li.svg"), index: index),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ));
                                                                },
                                                                onReorder: (int oldIndex, int newIndex) {
                                                                  setState(() {
                                                                    if (newIndex > oldIndex) {
                                                                      newIndex--;
                                                                    }
                                                                    final item = snapshot.data?.removeAt(oldIndex);
                                                                    snapshot.data?.insert(newIndex, item!);

                                                                    var list = [];
                                                                    for (int i = 0; i < snapshot.data!.length; i++) {
                                                                      //print(i.toString()+" "+snapshot.data![i].faq_id.toString()+" "+snapshot.data![i].faq_title.toString());
                                                                      list.add(snapshot.data![i].faq_id);
                                                                    }

                                                                    list.forEach((item) {
                                                                      String? titleA;
                                                                      String? titleE;
                                                                      String? desA;
                                                                      String? desE;
                                                                      fetchArb(item).then((value) {
                                                                        titleA = value["faq_title"];
                                                                        desA = value["faq_description"];
                                                                      },
                                                                      );
                                                                      fetchEng(item).then((value) {
                                                                        titleE = value["faq_title"];
                                                                        desE = value["faq_description"];
                                                                      },
                                                                      );
                                                                      Timer(const Duration(seconds: 3), () {
                                                                        deleteRequestUpdate(item);
                                                                        Timer(const Duration(seconds: 2), () async {
                                                                          updateListPost(titleA, desA, titleE, desE);
                                                                        });
                                                                      });
                                                                    });
                                                                  });
                                                                },
                                                              );
                                                            } else {
                                                              return Center(
                                                                  child:
                                                                  CircularProgressIndicator());
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ))
                    ],
                  ),

                          ),
            ),
          ],
        ));
  }
}
