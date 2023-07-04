import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:pif_admin_dashboard/responsiveness/faqResponsive.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/pfpimg.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:pif_admin_dashboard/main.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';

import 'package:http/http.dart' as http;

import 'models/user_model.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController nameController = TextEditingController();

getName() {
  return nameController.text;
}

getEmail() {
  return emailController.text;
}



class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {

  Future<User> fetchUser() async {
    final response = await http.get(Uri.parse(global.apiAddress + 'GetAUser/${global.userID}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<User>((json) => User.fromMap(json)).toList()[0];
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<User> user;

  Future<String> updateProfileImage(user_id, file) async {
    var url = Uri.parse(global.apiAddress + "UpdateProfileImage/$user_id");
    var request = new http.MultipartRequest("POST", url);

    Uint8List bytesData =
        const Base64Decoder().convert(file.toString().split(",").last);
    // to display the updated photo right away
    setState(() {
      nowPfp = bytesData;
    });

    List<int> selectedFile = bytesData;
    request.files.add(http.MultipartFile.fromBytes('fileModel', selectedFile,
        contentType: MediaType('application', 'octet-stream'),
        filename: 'hhh'));

    request.send().then((response) {
      print("i am hereee makerequest");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });
    return "finished";
  }

  Future<http.Response> updateNoFace() async {
    Map data = {
      "user_id": 0,
      "name": "string",
      "email": "string",
      "user_type": "string",
      "user_img": "string",
      "user_status": "string"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(
            global.apiAddress + 'UpdateBlank/1'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

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
                            const MyApp(),
                        transitionDuration: const Duration(seconds: 0),
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
  @override
  void initState() {

    super.initState();
    _scrollController = ScrollController();
    user = fetchUser();
    nowPfp =
        null; // everytime the settings page is clicked, it should reset the nowPfp and only assign once a new image is selected

    super.initState();
  }

  String img = "assets/images/noFace.png";
  double num = 1.5;
  double num2 = 4.5;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      print('Switch Button is ON');
      // img = 'assets/images/noFace.png';
      // num = 5.0;
      // num2 = 7.0;

    } else {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
      // img = "assets/images/pfpIcons.png";
      // num = 1.5;
      // num2 = 4.5;
    }
  }

  void _pickImage() async {
    if (!isSwitched) {
      FileUploadInputElement uploadInput = FileUploadInputElement();
      uploadInput.click();

      uploadInput.onChange.listen((e) {
        final files = uploadInput.files;
        if (files!.length == 1) {
          final file = files[0];
          final reader = FileReader();

          reader.readAsArrayBuffer(file);
          reader.onLoadEnd.listen((e) {
            setState(() {
              nowPfp = Uint8List.fromList(reader.result as List<int>);
            });
          });
        }
      });
    }
  }

  File? file = null;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String? dropdownvalue = 'English';
    // Locale? lang = Locale("en");
    Locale? lang = EasyLocalization.of(context)!.locale;

    // List of items in our dropdown menu
    final eventCard = InkWell(
      hoverColor: Colors.transparent,
      child: Material(
        color: const Color(0xFFffffff),
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
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F2E7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Jun ".tr().toString(),
                          strutStyle: const StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: const TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF999999)),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "16".tr().toString(),
                          strutStyle: const StrutStyle(forceStrutHeight: true),
                          style: GoogleFonts.barlow(
                            textStyle: const TextStyle(
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
                                strutStyle: const StrutStyle(forceStrutHeight: true),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
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
                                strutStyle: const StrutStyle(forceStrutHeight: true),
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

    final language = Container(
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
          value: lang,
          // Down Arrow Icon

          // Array list of items
          items: [
            DropdownMenuItem(
              value: const Locale('en'),
              child: Text(
                '   English',
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
              value: Locale('ar'),
              child: Text('  العربية'),
            ),
          ],

          onChanged: (Locale? newValue) {
            setState(() {
              lang = newValue;
              dropdownvalue = "ej";
              context.setLocale(newValue!);

              context.locale = newValue;
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
                        leading: Padding(
                          padding: EdgeInsets.only(right: width * 0.002),
                          child: SvgPicture.asset("assets/images/settings.svg",
                              color: Colors.white),
                        ),
                        minLeadingWidth: width * 0.02,
                        title: Text(
                          "Settings".tr(),
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
                                  const settingResponsive(),
                              transitionDuration: const Duration(seconds: 0),
                            ),
                          )
                        },
                      ),
                    ),
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
                                              const MessageResponsive(),
                                      transitionDuration: const Duration(seconds: 0),
                                    ),
                                  );
                                },
                                child: SvgPicture.asset(
                                    "assets/images/message.svg")),
                            SizedBox(
                              width: width * 0.0152,
                            ),
                            FutureBuilder<User>(
                              future: user,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  pfpImage = Image.network(
                                    '${global.apiAddress}GetImage/${(snapshot.data!.user_img)}',
                                    height: height * 0.1,
                                    fit: BoxFit.scaleDown,
                                  );

                                  return Row(
                                    children: [
                                      InkWell(
                                        hoverColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const settingResponsive(),
                                                transitionDuration:
                                                    const Duration(seconds: 0),
                                              ));
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           settingResponsive()),
                                          // );
                                        },

                                        child: isSwitched
                                            ? pfpImage = Image.asset(
                                                "assets/images/noFace.png",
                                                width: width * 0.0277,
                                                height: height * 0.344,
                                              )


                                            : nowPfp == null
                                                ? pfpImage = Container(
                                                    height: height * 0.344,
                                                    width: width * 0.0277,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              "${global.apiAddress}GetImage/${(snapshot.data!.user_img)}",
                                                            ))),
                                                  )
                                                : pfpImage = Container(
                                                    width: width * 0.0277,
                                                    height: height * 0.344,
                                                    // child: img,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: MemoryImage(
                                                            nowPfp
                                                                as Uint8List),
                                                        // FileImage(nowPfp as File),
                                                        // image: FileImage(img as File),
                                                      ),
                                                    ),
                                                  ),

                                        // child: isSwitched ? Image.asset("assets/images/noFace.png",scale: 4.5,) :
                                        // Image.asset("assets/images/pfpIcons.png",scale: 4.5,)
                                      ),
                                    ],
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                  // Image.asset(
                                  //   'assets/images/usericon.png',
                                  //   height: height * 0.1,
                                  //   fit: BoxFit.scaleDown,
                                  // );
                                }
                              },
                              // child:
                            )
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
                                "Settings".tr(),
                                style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
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
                      eventCard,
                      SizedBox(height: height * 0.02),
                      Card(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.733,
                            height: height * 0.345,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: const ExactAssetImage(
                                    "assets/images/settingsBanner.png"),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                FutureBuilder<User>(
                                  future: user,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(children: [
                                        InkWell(
                                          onTap: () async {
                                            FileUploadInputElement uploadInput =
                                                FileUploadInputElement();

                                            uploadInput.click();

                                            uploadInput.onChange.listen((e) {
                                              // read file content as dataURL
                                              final files = uploadInput.files;
                                              if (files?.length == 1) {
                                                final file = files?[0];
                                                final reader = new FileReader();

                                                reader.onLoadEnd
                                                    .listen((e) async {
                                                  print(e);
                                                  print(
                                                      'loaded: ${file?.name}');
                                                  print(
                                                      'type: ${reader.result.runtimeType}');
                                                  print(
                                                      'file size = ${file?.size}');

                                                  print(
                                                      'reader = ${reader.result.runtimeType}');

                                                  // if image is >2MB, do not allow upload of image
                                                  if (file!.size >
                                                      2 * 1024 * 1024) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                      "Please select a photo less than 2MB size",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.red[600]),
                                                    )));
                                                  } else {
                                                    updateProfileImage(
                                                        snapshot.data!.user_id,
                                                        reader.result);

                                                    print("i reached here");
                                                  }

                                                  // imgselect = true;
                                                });
                                                reader.readAsDataUrl(file!);
                                                // myControllerSubject.text = file.name;
                                              }
                                            });

                                            setState(() {});
                                          },
                                          // onTap: _pickImage,
                                          child: isSwitched
                                              ? Image.asset(
                                                  "assets/images/noFace.png",
                                                  width: width * 0.1,
                                                  height: height * 0.2,
                                                )
                                              : nowPfp == null
                                                  ? Container(
                                                      width: width * 0.1,
                                                      height: height * 0.2,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                "${global.apiAddress}GetImage/${(snapshot.data!.user_img)}",
                                                              ))),
                                                    )
                                                  // child: Image.network(
                                                  //     "${global.apiAddress}GetImage/${(snapshot.data!.user_img)}",
                                                  //     // 'http://localhost:5041/api/PIF/GetImage/C%3A%5CimgUpload%5Cpfp%5Cpfp.png',
                                                  //     // 'https://10.248.146.17:7040/api/PIF/GetImage/C:/imgUpload/pfp/pfp.png',
                                                  //     width: width * 0.0277,
                                                  //     height: height * 0.344,
                                                  //   ),

                                                  // Image.network(
                                                  //     "${global.apiAddress}GetImage/${(snapshot.data!.user_img)}",
                                                  //     // 'http://localhost:5041/api/PIF/GetImage/C%3A%5CimgUpload%5Cpfp%5Cpfp.png',
                                                  //     // 'https://10.248.146.17:7040/api/PIF/GetImage/C:/imgUpload/pfp/pfp.png',
                                                  //     width: width * 0.1,
                                                  //     height: height * 0.2,
                                                  //   )
                                                  // Image.asset(
                                                  //     "assets/images/noFace.png",
                                                  //     width: width * 0.1,
                                                  //     height: height * 0.2,
                                                  //   )

                                                  : Container(
                                                      width: width * 0.1,
                                                      height: height * 0.2,
                                                      // child: img,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: MemoryImage(
                                                              nowPfp
                                                                  as Uint8List),
                                                          // FileImage(nowPfp as File),
                                                          // image: FileImage(img as File),
                                                        ),
                                                      ),
                                                    ),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        Text(
                                          "${snapshot.data!.name}".tr(),
                                          style: GoogleFonts.barlow(
                                            textStyle: const TextStyle(
                                                color: Color(0xFFBD9B60),
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ]);
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                                // isSwitched
                                //     ? Image.asset(
                                //         "assets/images/noFace.png",
                                //         width: width * 0.1,
                                //         height: height * 0.2,
                                //       )
                                //     : Image.asset(
                                //         "assets/images/pfpIcons.png",
                                //         width: width * 0.1,
                                //         height: height * 0.2,
                                //       ),
                                // Image.asset(img,width: width*0.1,height: height*0.2,),
                              ],
                            ),
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
                                SizedBox(
                                  width: width * 0.34,
                                  child: Text(
                                    "Full name".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.015),
                                SizedBox(
                                  width: width * 0.34,
                                  child: Text(
                                    "Email".tr(),
                                    style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FutureBuilder<User>(
                            future: user,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {


                                return Padding(
                                  padding:
                                  const EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.34,
                                        height: height * 0.05,
                                        child: TextField(
                                          readOnly: true,
                                          controller: nameController..text = "${snapshot.data!.name}",
                                          decoration: const InputDecoration(
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
                                      SizedBox(width: width * 0.015),
                                      SizedBox(
                                        width: width * 0.34,
                                        height: height * 0.05,
                                        child: TextField(
                                          readOnly: true,
                                          controller: emailController..text = "${snapshot.data!.email}",
                                          decoration: const InputDecoration(
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
                                    ],
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                                // Image.asset(
                                //   'assets/images/usericon.png',
                                //   height: height * 0.1,
                                //   fit: BoxFit.scaleDown,
                                // );
                              }
                            },
                            // child:
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
                                  "Language".tr(),
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
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                              children: [
                                Container(
                                    width: width * 0.34,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFFEEEEEE))),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * 0.015),
                                      child: language,
                                    )),
                                SizedBox(
                                  width: width * 0.015,
                                ),
                                Container(
                                  width: width * 0.34,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: const Color(0xFFEEEEEE))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "    Hide Profile Picture    ".tr(),
                                          style: GoogleFonts.barlow(
                                            textStyle: const TextStyle(
                                                color: Color(0xFF222222),
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: height * 0.04,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Switch(
                                              value: isSwitched,
                                              onChanged: toggleSwitch,
                                              activeColor: Colors.white,
                                              activeTrackColor:
                                                  const Color(0xFFBD9B60),
                                              inactiveThumbColor:
                                                  const Color(0xFFBD9B60),
                                              inactiveTrackColor:
                                                  const Color(0xFFE6E6E6),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.608,
                              ),
                              // ElevatedButton(
                              //   onPressed: () {},
                              //   child: Text('Change password'.tr().toString(),strutStyle: StrutStyle(
                              //     forceStrutHeight: true,

                              //   ),
                              //       style: GoogleFonts.barlow(
                              //         textStyle: TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                              //       )),
                              //   style: ElevatedButton.styleFrom(
                              //       primary: Color(0xffF5F0E5),
                              //       onPrimary: Colors.black ,
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(3),
                              //       ),
                              //       minimumSize: Size(width*0.1,50),
                              //       side: BorderSide(
                              //           width: 0.4,
                              //           color: Color(0xffF5F0E5)
                              //       )
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
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
        ],
      ),
    );
  }
}
