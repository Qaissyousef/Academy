import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/pfpimg.dart';
import 'package:pif_admin_dashboard/responsiveness/faqResponsive.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:pif_admin_dashboard/main.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'coursePage.dart';
import 'models/faqModel.dart';

import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/util/fieldValidator.dart' as validator;

class faq extends StatefulWidget {
  const faq({Key? key}) : super(key: key);

  @override
  State<faq> createState() => _faqState();
}

class _faqState extends State<faq> with TickerProviderStateMixin {
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
        await http.get(Uri.parse(global.apiAddress + 'GetAllFaqEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<FaqModel>((json) => FaqModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<FaqModel>> fetchAllArb() async {
    final response =
        await http.get(Uri.parse(global.apiAddress + 'GetAllFaqArb'));

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
        await http.get(Uri.parse(global.apiAddress + 'GetFAQEng/${id}'));

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
        await http.get(Uri.parse(global.apiAddress + 'GetFAQArb/${id}'));

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

    var response = await http.post(Uri.parse(global.apiAddress + 'DeleteFAQ'),
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

    var response = await http.post(Uri.parse(global.apiAddress + 'DeleteFAQ'),
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
        Uri.parse(global.apiAddress + 'UpdateFAQEng/$uid'),
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
        Uri.parse(global.apiAddress + 'UpdateFAQArb/$uid'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    setState(() {
      futureArb = fetchAllArb();
    });
    return response;
  }

  final _dateTime = DateTime.parse("2022-10-01 00:00:00.000");

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
    var response = await http.post(Uri.parse(global.apiAddress + 'AddFAQEng'),
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
    var response = await http.post(Uri.parse(global.apiAddress + 'AddFAQEng'),
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
    var response = await http.post(Uri.parse(global.apiAddress + 'AddFAQArb'),
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
    var response = await http.post(Uri.parse(global.apiAddress + 'AddFAQArb'),
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

  void updateListPost(var titleA, var desA, var titleE, var desE) async {
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
                      leading: Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.001, right: width * 0.002),
                          child: SvgPicture.asset("assets/images/home.svg",
                              color: Color(0xFFBD9B60))),
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
                          // MaterialPageRoute(builder: (context) => coursesPage()),
                          // transitionDuration: const Duration(seconds: 0),
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
                                coursesPage(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                          // MaterialPageRoute(builder: (context) => coursesPage()),
                          // transitionDuration: const Duration(seconds: 0),
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
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                adminResponsive(),
                            transitionDuration: Duration(seconds: 0),
                          ),
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
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                admissionResponsive(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                          // MaterialPageRoute(builder: (context) => coursesPage()),
                          // transitionDuration: const Duration(seconds: 0),
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
                          // MaterialPageRoute(builder: (context) => coursesPage()),
                          // transitionDuration: const Duration(seconds: 0),
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
                          // MaterialPageRoute(builder: (context) => coursesPage()),
                          // transitionDuration: const Duration(seconds: 0),
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
                          leading: SvgPicture.asset("assets/images/faqicon.svg",
                              color: Colors.white),
                          minLeadingWidth: width * 0.02,
                          title: Text(
                            "FAQ".tr(),
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
                                        faqResponsive(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                              // MaterialPageRoute(builder: (context) => coursesPage()),
                              // transitionDuration: const Duration(seconds: 0),
                            )
                          },
                        ),
                      ),
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
                          // MaterialPageRoute(builder: (context) => coursesPage()),
                          // transitionDuration: const Duration(seconds: 0),
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
                      onTap: () => {_delete(context)},
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
                            // crossAxisAlignment: CrossAxisAlignment.end,

                            children: [
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
                                                )),
                                    )
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
                                    Text(
                                      "Frequently Asked Questions".tr(),
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
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                Locale? lang = Locale("en");
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.0))),
                                                  scrollable: true,
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
                                                                bottom: height *
                                                                    0.01),
                                                            child: Text(
                                                              "FAQ English"
                                                                  .tr(),
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
                                                          ),
                                                          Center(
                                                            child: SizedBox(
                                                              width:
                                                                  width * 0.25,
                                                              height:
                                                                  height * 0.05,
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
                                                                bottom: height *
                                                                    0.01),
                                                            child: Text(
                                                              "Response English"
                                                                  .tr(),
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
                                                          ),
                                                          Center(
                                                            child: SizedBox(
                                                              width:
                                                                  width * 0.25,
                                                              height:
                                                                  height * 0.1,
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
                                                                bottom: height *
                                                                    0.01),
                                                            child: Text(
                                                              "FAQ Arabic".tr(),
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
                                                          ),
                                                          Center(
                                                            child: SizedBox(
                                                              width:
                                                                  width * 0.25,
                                                              height:
                                                                  height * 0.05,
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
                                                                bottom: height *
                                                                    0.01),
                                                            child: Text(
                                                              "Response Arabic"
                                                                  .tr(),
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
                                                          ),
                                                          Center(
                                                            child: SizedBox(
                                                              width:
                                                                  width * 0.25,
                                                              height:
                                                                  height * 0.1,
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
                                                                  0.07),
                                                          Center(
                                                            child: SizedBox(
                                                              width:
                                                                  width * 0.25,
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
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
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
                                                                        style: GoogleFonts
                                                                            .barlow(
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
                                                                          Colors
                                                                              .transparent,
                                                                      primary:
                                                                          Color(
                                                                              0xFFF5F0E5),
                                                                      onPrimary:
                                                                          Color(
                                                                              0xFF183028),
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
                                                                        () {
                                                                      submitFormPost();
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              14,
                                                                          horizontal:
                                                                              25),
                                                                      child: Text(
                                                                          'Confirm & add'
                                                                              .tr()
                                                                              .toString(),
                                                                          strutStyle: StrutStyle(
                                                                              forceStrutHeight:
                                                                                  true),
                                                                          style:
                                                                              GoogleFonts.barlow(
                                                                            textStyle: TextStyle(
                                                                                color: Color(0xFFFFFFFF),
                                                                                fontWeight: FontWeight.w400,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 16),
                                                                          )),
                                                                    ),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      primary:
                                                                          Color(
                                                                              0xFF215732),
                                                                      elevation:
                                                                          0.0,
                                                                      shadowColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onPrimary:
                                                                          Color(
                                                                              0xFFFFFFFF),
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
                                        },
                                        child: Text('Add FAQ'.tr().toString(),
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
                                    //!!!!!!!!!!
                                    Container(
                                      height: height * 0.8,
                                      margin: EdgeInsets.only(
                                          left: 16.0, right: 16.0),
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
                                                                                Text("${snapshot.data![index].faq_title}")
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
                                                                                  width: width * 0.09,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                                                                width: width * 0.25,
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
                                                                                                                width: width * 0.25,
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
                                                                                                                width: width * 0.25,
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
                                                                                                                width: width * 0.25,
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
                                                                                                                        updateFAQAra(eUID, aUID);
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
                                                                                          )),
                                                                                      InkWell(
                                                                                          onTap: () {
                                                                                            deleteRequest(snapshot.data![index].faq_unique, snapshot.data![index].faq_id);
                                                                                          },
                                                                                          hoverColor: Colors.transparent,
                                                                                          child: SvgPicture.asset("assets/images/red_bin.svg", color: Color(0xFFF64747))),
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
                                                            onReorder: (int
                                                                    oldIndex,
                                                                int newIndex) {
                                                              setState(() {
                                                                if (newIndex >
                                                                    oldIndex) {
                                                                  newIndex -= 1;
                                                                }

                                                                final item = snapshot
                                                                    .data
                                                                    ?.removeAt(
                                                                        oldIndex);

                                                                snapshot.data
                                                                    ?.insert(
                                                                        newIndex,
                                                                        item!);

                                                                var list = [];
                                                                for (int i = 0;
                                                                    i <
                                                                        snapshot
                                                                            .data!
                                                                            .length;
                                                                    i++) {
                                                                  //print(i.toString()+" "+snapshot.data![i].faq_id.toString()+" "+snapshot.data![i].faq_title.toString());
                                                                  list.add(snapshot
                                                                      .data![i]
                                                                      .faq_id);
                                                                }

                                                                list.forEach(
                                                                    (item) {
                                                                  String?
                                                                      titleA;
                                                                  String?
                                                                      titleE;
                                                                  String? desA;
                                                                  String? desE;
                                                                  fetchArb(item)
                                                                      .then(
                                                                    (value) {
                                                                      titleA =
                                                                          value[
                                                                              "faq_title"];
                                                                      desA = value[
                                                                          "faq_description"];
                                                                    },
                                                                  );
                                                                  fetchEng(item)
                                                                      .then(
                                                                    (value) {
                                                                      titleE =
                                                                          value[
                                                                              "faq_title"];
                                                                      desE = value[
                                                                          "faq_description"];
                                                                    },
                                                                  );
                                                                  Timer(
                                                                      const Duration(
                                                                          seconds:
                                                                              3),
                                                                      () {
                                                                    deleteRequestUpdate(
                                                                        item);
                                                                    Timer(
                                                                        const Duration(
                                                                            seconds:
                                                                                2),
                                                                        () async {
                                                                      updateListPost(
                                                                          titleA,
                                                                          desA,
                                                                          titleE,
                                                                          desE);
                                                                    });
                                                                  });
                                                                });

                                                                // for (int i = 0; i < list.length; i++) {
                                                                //   String? titleA;
                                                                //   String? titleE;
                                                                //   String? desA;
                                                                //   String? desE;
                                                                //   fetchArb(list[i]).then((value) {
                                                                //       titleA = value["faq_title"];
                                                                //       //print(titleA! + " ara " +list[i].faq_id);
                                                                //       desA = value["faq_description"];
                                                                //     },
                                                                //   );
                                                                //   fetchEng(list[i]).then((value) {
                                                                //       titleE = value["faq_title"];
                                                                //       //print(titleE! + " eng "+list[i].faq_id);
                                                                //       desE = value["faq_description"];
                                                                //     },
                                                                //   );
                                                                //   Timer(Duration(seconds: 3), () {
                                                                //     // print("Yeah, this line is printed after 1 seconds");
                                                                //     //
                                                                //     // print("````````values received```````````");
                                                                //     // print("the new up");
                                                                //     // print(list[i]);
                                                                //     // print(titleA);
                                                                //     // print(titleE);
                                                                //     // print(desA);
                                                                //     // print(desE);
                                                                //     // print("```````````````````");
                                                                //     //
                                                                //     // print("~~~~~~~~~~~~~~~~~~~");
                                                                //     // print("delete");
                                                                //     // print(list[i].faq_id);
                                                                //     // print(list[i].faq_title);
                                                                //     // print("~~~~~~~deleted~~~~~~~~~~~~");
                                                                //     deleteRequestUpdate(list[i]);
                                                                //
                                                                //     // print("~~~~~~~~~~~~~~~~~~~");
                                                                //     // print("update");
                                                                //     // print("~~~~~~~~~~~~~~~~~~~");
                                                                //     Timer(Duration(seconds: 2), () async {
                                                                //       // await postRequest_eUpdate(titleE, desE);
                                                                //       // await postRequest_aUpdate(titleA, desA);
                                                                //       // // print("````````complete```````````");
                                                                //       // // print("yes");
                                                                //       // // print(list[i].faq_id);
                                                                //       // // print(titleA);
                                                                //       // // print(titleE);
                                                                //       // // print(desA);
                                                                //       // // print(desE);
                                                                //       // // print("```````````````````");
                                                                //       // setState(() {
                                                                //       //   futureEng = fetchAllEng();
                                                                //       //   futureArb = fetchAllArb();
                                                                //       // });
                                                                //       updateListPost(titleA, desA, titleE, desE);
                                                                //     });
                                                                //   });
                                                                // }

                                                                // for (int j = 0;j < list.length;j++) {
                                                                //   print("~~~~~~~~~~~~~~~~~~~");
                                                                //   print("delete");
                                                                //   print(list[j].faq_id);
                                                                //   print(list[j].faq_title);
                                                                //   print("~~~~~~~~~~~~~~~~~~~");
                                                                //   deleteRequestUpdate(list[j].faq_id);
                                                                // }

                                                                // print(list[0].faq_id);
                                                                // print(list[0].faq_title);
                                                                // print(list[1].faq_id);
                                                                // print(list[1].faq_title);

                                                                // for (int j = 0;j < list.length;j++) {
                                                                //   print("~~~~~~~~~~~~~~~~~~~");
                                                                //   print("update");
                                                                //   print(list[j].faq_id);
                                                                //   print(list[j].faq_title);
                                                                //   print("~~~~~~~~~~~~~~~~~~~");
                                                                //   updateListPost(list[j]);
                                                                // }

                                                                // for(int j = 0;j < snapshot.data!.length;j++){
                                                                //   print("~~~~~~~~~~~~~~~~~~~");
                                                                //   print("full list");
                                                                //   print(snapshot.data![j].faq_id);
                                                                //   print(snapshot.data![j].faq_title);
                                                                //   print("~~~~~~~~~~~~~~~~~~~");
                                                                // }

                                                                // print("----------------");
                                                                // print(newIndex);
                                                                // print(snapshot.data![newIndex].faq_id);
                                                                // print(snapshot.data![newIndex].faq_title);
                                                                // print("----------------");
                                                              });
                                                              // print(snapshot
                                                              //     .data![0]
                                                              //     .faq_title);
                                                              // print(snapshot
                                                              //     .data![1]
                                                              //     .faq_title);
                                                              // print(snapshot
                                                              //     .data![2]
                                                              //     .faq_title);
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
                                                                                  width: width * 0.09,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                                                                width: width * 0.25,
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
                                                                                                                width: width * 0.25,
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
                                                                                                                width: width * 0.25,
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
                                                                                                                width: width * 0.25,
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
                                                                                      InkWell(
                                                                                          onTap: () {
                                                                                            deleteRequest(snapshot.data![index].faq_unique, snapshot.data![index].faq_id);
                                                                                          },
                                                                                          hoverColor: Colors.transparent,
                                                                                          child: SvgPicture.asset("assets/images/red_bin.svg", color: Color(0xFFF64747))),
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
                                                            onReorder: (int
                                                                    oldIndex,
                                                                int newIndex) {
                                                              setState(() {
                                                                if (newIndex >
                                                                    oldIndex) {
                                                                  newIndex--;
                                                                }
                                                                final item = snapshot
                                                                    .data
                                                                    ?.removeAt(
                                                                        oldIndex);
                                                                snapshot.data
                                                                    ?.insert(
                                                                        newIndex,
                                                                        item!);

                                                                var list = [];
                                                                for (int i = 0;
                                                                    i <
                                                                        snapshot
                                                                            .data!
                                                                            .length;
                                                                    i++) {
                                                                  //print(i.toString()+" "+snapshot.data![i].faq_id.toString()+" "+snapshot.data![i].faq_title.toString());
                                                                  list.add(snapshot
                                                                      .data![i]
                                                                      .faq_id);
                                                                }

                                                                list.forEach(
                                                                    (item) {
                                                                  String?
                                                                      titleA;
                                                                  String?
                                                                      titleE;
                                                                  String? desA;
                                                                  String? desE;
                                                                  fetchArb(item)
                                                                      .then(
                                                                    (value) {
                                                                      titleA =
                                                                          value[
                                                                              "faq_title"];
                                                                      desA = value[
                                                                          "faq_description"];
                                                                    },
                                                                  );
                                                                  fetchEng(item)
                                                                      .then(
                                                                    (value) {
                                                                      titleE =
                                                                          value[
                                                                              "faq_title"];
                                                                      desE = value[
                                                                          "faq_description"];
                                                                    },
                                                                  );
                                                                  Timer(
                                                                      const Duration(
                                                                          seconds:
                                                                              3),
                                                                      () {
                                                                    deleteRequestUpdate(
                                                                        item);
                                                                    Timer(
                                                                        const Duration(
                                                                            seconds:
                                                                                2),
                                                                        () async {
                                                                      updateListPost(
                                                                          titleA,
                                                                          desA,
                                                                          titleE,
                                                                          desE);
                                                                    });
                                                                  });
                                                                });

                                                                // for (int i = 0; i < list.length; i++) {
                                                                //   String? titleA;
                                                                //   String? titleE;
                                                                //   String? desA;
                                                                //   String? desE;
                                                                //   fetchArb(list[i].faq_id).then((value) {
                                                                //     titleA = value["faq_title"];
                                                                //     print(titleA! + " LO LOLOLOLO");
                                                                //     desA = value["faq_description"];
                                                                //   },
                                                                //   );
                                                                //   fetchEng(list[i].faq_id).then((value) {
                                                                //     titleE = value["faq_title"];
                                                                //     desE = value["faq_description"];
                                                                //   },
                                                                //   );
                                                                //   Timer(Duration(seconds: 5), () {
                                                                //     print("Yeah, this line is printed after 1 seconds");
                                                                //
                                                                //     print("````````values received```````````");
                                                                //     print("the new up");
                                                                //     print(list[i].faq_id);
                                                                //     print(titleA);
                                                                //     print(titleE);
                                                                //     print(desA);
                                                                //     print(desE);
                                                                //     print("```````````````````");
                                                                //
                                                                //     print("~~~~~~~~~~~~~~~~~~~");
                                                                //     print("delete");
                                                                //     print(list[i].faq_id);
                                                                //     print(list[i].faq_title);
                                                                //     print("~~~~~~~deleted~~~~~~~~~~~~");
                                                                //     deleteRequestUpdate(list[i].faq_id);
                                                                //
                                                                //     print("~~~~~~~~~~~~~~~~~~~");
                                                                //     print("update");
                                                                //     print("~~~~~~~~~~~~~~~~~~~");
                                                                //     updateListPost(titleA, desA, titleE, desE);
                                                                //   });
                                                                // }
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
                                    )
                                  ],
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
