import 'dart:html';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;
import '../models/instructorModel.dart';

class newaboutCourse extends StatefulWidget {
  final String cid;
  final int Function() onNext;

  const newaboutCourse({Key? key, required this.onNext, required this.cid})
      : super(key: key);

  @override
  _newaboutCourseState createState() => _newaboutCourseState();
}

class _newaboutCourseState extends State<newaboutCourse>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  late ScrollController _scrollController;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<http.Response> postRequestinstructor() async {
    Map data = {
      "course_id": widget.cid,
      "name": myControllerInst.text,
      "name_id": 0
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(
        Uri.parse(global.apiAddress + 'AddInstructors/${widget.cid}'),
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

  Future<http.Response> updateRequestinstructor(int nid) async {
    Map data = {
      "course_id": widget.cid,
      "name": myControllerInstUpdate.text,
      "name_id": nid
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await http.post(Uri.parse(global.apiAddress + 'UpdateInstructor'),
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

  final myControllerInst = TextEditingController();
  final myControllerInstUpdate = TextEditingController();

  final myControllerTitle_e = TextEditingController();
  final myControllerCategory_e = TextEditingController();
  final myControllerMaxCount_e = TextEditingController();
  final myControllerDes_e = TextEditingController();
  final myControllerInstructor_e = TextEditingController();

  final myControllerTitle_a = TextEditingController();
  final myControllerCategory_a = TextEditingController();
  final myControllerMaxCount_a = TextEditingController();
  final myControllerDes_a = TextEditingController();
  final myControllerInstructor_a = TextEditingController();

  late List<int> _selectedFile;
  late Uint8List _bytesData;
  String current_course_id = 3.toString();
  bool imgselect = false;

  void _handleResult(Object? result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  List allControllerList = [];

  Future<http.Response> deleteInstructors(int nid) async {
    Map data = {
      "course_id": widget.cid,
      "name": "string",
      "name_id": nid,
    };
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(global.apiAddress + 'DeleteInstuctor'),
        headers: {"Content-Type": "application/json"},
        body: body);

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<List<InstructorModel>> fetchInst() async {
    final responseEng = await http
        .get(Uri.parse(global.apiAddress + 'GetInstructors/${widget.cid}'));

    if (responseEng.statusCode == 200) {
      final parsedEng =
          json.decode(responseEng.body).cast<Map<String, dynamic>>();

      return parsedEng
          .map<InstructorModel>((json) => InstructorModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<InstructorModel>> FInstructor;

  @override
  void initState() {
    FInstructor = fetchInst();
    super.initState();

    _nestedTabController = new TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    // futureCourse = fetchCourse();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  var fieldVisibility = true;
  var fieldVisibility2 = true;
  List<Widget> _instructorList = [];

  var img = "assets/images/coursebg.png";
  @override
  Widget build(BuildContext context) {
    Future<String> postAboutSection_e() async {
      var url = Uri.parse(global.apiAddress + "AddAboutC");
      var request = new http.MultipartRequest("POST", url);

      request.fields['description'] = myControllerDes_e.text;
      request.fields['duration'] = "15 hours per month etc etc";

      request.fields['course_name'] = myControllerTitle_e.text;
      request.fields['course_instuctor'] = "jj";
      request.fields['course_id'] = widget.cid.toString();
      request.fields['course_image'] = '2e0.057';
      request.fields['category'] = myControllerCategory_a.text;
      request.fields['maxParticipants'] = myControllerMaxCount_a.text;
      request.fields['applied'] = "0";

      request.files.add(await http.MultipartFile.fromBytes(
          'fileModel', _selectedFile,
          contentType: new MediaType('application', 'octet-stream'),
          filename: 'hhh'));

      request.send().then((response) {
        print("i am hereee makerequest");
        print(response.statusCode);
        if (response.statusCode == 200) print("Uploaded!");
      });
      return "finished";
    }

    Future<String> postAboutSection_a() async {
      var url = Uri.parse(global.apiAddress + "AddAboutCArb");
      var request = new http.MultipartRequest("POST", url);

      request.fields['description'] = myControllerDes_a.text;
      request.fields['duration'] = "15 hours per month etc etc";

      request.fields['course_name'] = myControllerTitle_a.text;
      request.fields['course_instuctor'] = "jj";
      request.fields['course_id'] = widget.cid.toString();
      request.fields['course_image'] = '2e0.057';
      request.fields['category'] = myControllerCategory_a.text;
      request.fields['maxParticipants'] = myControllerMaxCount_a.text;
      request.fields['applied'] = "0";

      request.files.add(await http.MultipartFile.fromBytes(
          'fileModel', _selectedFile,
          contentType: new MediaType('application', 'octet-stream'),
          filename: 'hhh'));

      request.send().then((response) {
        print("i am hereee makerequest");
        print(response.statusCode);
        if (response.statusCode == 200) print("Uploaded!");
      });
      return "finished";
    }

    Future<http.Response> postAboutSectionMinusImage_e() async {
      Map data;
      if (myControllerTitle_e.text != "") {
        data = {
          "about_id": 0,
          "description": myControllerDes_e.text,
          "duration": "15 hours per month etc etc",
          "course_name": myControllerTitle_e.text,
          "course_instuctor": "jj",
          "course_image": "C:\\imgUpload\\courses\\c1.png",
          "course_id": widget.cid.toString(),
          "category": myControllerCategory_a.text,
          "maxParticipants": myControllerMaxCount_e.text,
          "applied": 0,
          "status": "string",
        };
      } else {
        data = {


          "about_id": 0,
          "description": "",
          "duration": "15 hours per month etc etc",
          "course_name": "",
          "status": "string",
          "course_instuctor": "",
          "course_image": "C:\\imgUpload\\courses\\c1.png",
          "course_id": widget.cid.toString(),
          "category": "",
          "maxParticipants": 0
        };
      }

      var body = json.encode(data);
      var response =
          await http.post(Uri.parse(global.apiAddress + 'AddAboutCMI'),
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

    Future<http.Response> postAboutSectionMinusImage_a() async {
      Map data = {
        "status": "string",
        "about_id": 0,
        "description": myControllerDes_a.text,
        "duration": "15 hours per month etc etc",
        "course_name": myControllerTitle_a.text,
        "course_instuctor": "jj",
        "course_image": "C:\\imgUpload\\courses\\c1.png",
        "course_id": widget.cid.toString(),
        "category": myControllerCategory_a.text,
        "maxParticipants": myControllerMaxCount_a.text,
        "applied": 0,
      };

      //encode Map to JSON
      var body = json.encode(data);
      var response =
          await http.post(Uri.parse(global.apiAddress + 'AddAboutCMIArb'),
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

    Future<http.Response> updateRequestName_e() async {
      Map data = {
        "course_name": myControllerTitle_e.text,
        "course_instuctor": "jj",
      };
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(
          Uri.parse(global.apiAddress + 'UpdateAboutName/$widget.cid'),
          headers: {"Content-Type": "application/json"},
          body: body);
      print("${response.statusCode}");
      print("${response.body}");
      return response;
    }

    Future<http.Response> updateRequestName_a() async {
      Map data = {
        "course_name": myControllerTitle_a.text,
        "course_instuctor": "jj",
      };
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(
          Uri.parse(global.apiAddress + 'UpdateAboutNameArb/$widget.cid'),
          headers: {"Content-Type": "application/json"},
          body: body);
      print("${response.statusCode}");
      print("${response.body}");
      return response;
    }

    bool submitForm() {
      String errorText = "";

      // english section
      if (myControllerTitle_e.text != "") {
        errorText += validator.isValid(
            "English title", myControllerTitle_e.text, "empty");
        errorText += validator.isValid(
            "English category", myControllerCategory_a.text, "empty");
        errorText += validator.isValid(
            "English max count", myControllerMaxCount_a.text, "empty;number");
        errorText += validator.isValid(
            "English description", myControllerDes_e.text, "empty");
        //errorText += validator.isValid("English instructor", myControllerInstructor_e.text, "empty;");
      }

      // arabic section
      errorText +=
          validator.isValid("Arabic title", myControllerTitle_a.text, "empty");
      errorText += validator.isValid(
          "Arabic category", myControllerCategory_a.text, "empty");
      errorText += validator.isValid(
          "Arabic max count", myControllerMaxCount_a.text, "empty;number");
      errorText += validator.isValid(
          "Arabic description", myControllerDes_a.text, "empty");
      //errorText += validator.isValid("Arabic instructor", myControllerInstructor_a.text, "empty;");

      if (errorText != "") {
        validator.alertDialog(
            context, errorText.substring(0, errorText.length - 1));
        return false;
      }

      if (imgselect == false) {
        postAboutSectionMinusImage_e();
        postAboutSectionMinusImage_a();
        print("no image selected");
      } else {
        postAboutSection_e();
        postAboutSection_a();
        updateRequestName_e();
        updateRequestName_a();
        print(" image selected");
      }

      return true;
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Future<void> _showAlertDialog() async {
      return showDialog<void>(
        context: context,
        // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(20), // <-- SEE HERE
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
                Center(
                  child: Text(
                    "Add Instructor".tr(),
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
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: TextField(
                      maxLength: 15,
                      controller: myControllerInst,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              SizedBox(
                height: height * 0.05,
                child: ElevatedButton(
                  onPressed: () {
                    postRequestinstructor();
                    setState(() {
                      FInstructor = fetchInst();
                      myControllerInst.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add Instructor'.tr().toString(),
                    strutStyle: StrutStyle(forceStrutHeight: true),
                    style: GoogleFonts.barlow(
                      textStyle: TextStyle(
                          color: Color(0xFF183028),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16),
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
            ],
          );
        },
      );
    }

    Future<void> _showUpdateAlertDialog(int nameid, String s) async {
      return showDialog<void>(
        context: context,
        // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(20), // <-- SEE HERE
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
                Center(
                  child: Text(
                    "Update Instructor".tr(),
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
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: TextField(
                      maxLength: 15,
                      controller: myControllerInstUpdate..text = s,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              SizedBox(
                height: height * 0.05,
                child: ElevatedButton(
                  onPressed: () {
                    updateRequestinstructor(nameid);
                    setState(() {
                      FInstructor = fetchInst();
                      myControllerInstUpdate.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Update Instructor'.tr().toString(),
                    strutStyle: StrutStyle(forceStrutHeight: true),
                    style: GoogleFonts.barlow(
                      textStyle: TextStyle(
                          color: Color(0xFF183028),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16),
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
            ],
          );
        },
      );
    }

    return Card(
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
          Container(
            height: height * 0.8,
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                WebSmoothScroll(
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),

                            Container(
                              height: height * 0.45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "عنوان الدورة",
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFF999999),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.005,
                                      ),
                                      SizedBox(
                                        width: width * 0.476,
                                        height: height * 0.08,
                                        child: TextField(
                                          maxLength: 50,
                                          controller: myControllerTitle_a,
                                          style: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16),
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.all(10.0),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFEEEEEE),
                                                  width: 1.5),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFEEEEEE),
                                                  width: 1.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Text(
                                        "الفئة",
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFF999999),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.005,
                                      ),
                                      SizedBox(
                                        width: width * 0.476,
                                        height: height * 0.08,
                                        child: TextField(
                                          maxLength: 50,
                                          controller: myControllerCategory_a,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.expand_more,
                                                  size: 13,
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFEEEEEE),
                                                  width: 1.5),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFEEEEEE),
                                                  width: 1.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Text(
                                        "الوصف",
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFF999999),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.005,
                                      ),
                                      SizedBox(
                                        width: width * 0.476,
                                        height: height * 0.15,
                                        child: TextField(
                                          maxLength: 255,
                                          controller: myControllerDes_a,
                                          style: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16),
                                          ),
                                          maxLines: 20,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFEEEEEE),
                                                  width: 1.5),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFEEEEEE),
                                                  width: 1.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(width: width*0.01,),

                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Course image".tr(),
                                          style: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                color: Color(0xFFBD9B60),
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Container(
                                          height: height * 0.37,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imgselect == false
                                                    ? AssetImage(img)
                                                        as ImageProvider
                                                    : MemoryImage(_bytesData),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              "الحد الأقصى لعدد المشاركين",
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: SizedBox(
                                    width: width * 0.476,
                                    height: height * 0.08,
                                    child: TextField(
                                      maxLength: 3,
                                      controller: myControllerMaxCount_a,
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16),
                                      ),
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.unfold_more,
                                              size: 13,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFEEEEEE),
                                              width: 1.5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFEEEEEE),
                                              width: 1.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.11,
                                      child: ElevatedButton(
                                        onPressed: () async {
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
                                                print('loaded: ${file?.name}');
                                                print(
                                                    'type: ${reader.result.runtimeType}');
                                                print(
                                                    'file size = ${file?.size}');
                                                //if image is greater than 2MB, do not allow
                                                if (file!.size >
                                                    2 * 1024 * 1024) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                    "Please select a photo less than 2MB size",
                                                    style: TextStyle(
                                                        color: Colors.red[600]),
                                                  )));
                                                } else {
                                                  _handleResult(reader.result);
                                                  print("i reached here");
                                                  imgselect = true;
                                                }
                                              });
                                              reader.readAsDataUrl(file!);
                                              // myControllerSubject.text = file.name;
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14, horizontal: 0.6),
                                          child: Text(
                                              'Select image'.tr().toString(),
                                              strutStyle: StrutStyle(
                                                  forceStrutHeight: true)),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          shadowColor: Colors.transparent,
                                          primary: Color(0xFFF5F0E5),
                                          onPrimary: Color(0xFF183028),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.014,
                                    ),
                                    SizedBox(
                                      width: width * 0.08,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          imgselect = false;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14, horizontal: 0.6),
                                          child: Text(
                                              'Delete image'.tr().toString(),
                                              strutStyle: StrutStyle(
                                                  forceStrutHeight: true)),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFFFFE5E5),
                                          elevation: 0.0,
                                          shadowColor: Colors.transparent,
                                          onPrimary: Color(0xFF4A0303),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),

                            Text(
                              "المدربين",
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            FutureBuilder<List<InstructorModel>>(
                              future: fetchInst(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (_, index) => Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFFEEEEEE))),
                                                width: width * 0.42,
                                                height: 45,
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Text(
                                                        '${snapshot.data![index].name}')),
                                              ),
                                              SizedBox(
                                                width: width * 0.005,
                                              ),
                                              Container(
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFFFE5E6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    deleteInstructors(snapshot
                                                        .data![index].name_id);
                                                    setState(() {
                                                      FInstructor = fetchInst();
                                                    });
                                                  },
                                                  child: SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      child: SvgPicture.asset(
                                                          "assets/images/red_bin.svg",
                                                          color: Color(
                                                              0xFFF64747)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.005,
                                              ),
                                              Container(
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFF5F0E5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _showUpdateAlertDialog(
                                                        snapshot.data![index]
                                                            .name_id,
                                                        snapshot
                                                            .data![index].name);
                                                  },
                                                  child: SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      child: SvgPicture.asset(
                                                          "assets/images/pen.svg"),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              },
                            ),

                            // Visibility(
                            //   visible: fieldVisibility,
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //         decoration: BoxDecoration(
                            //             border: Border.all(color: Color(0xFFEEEEEE))
                            //         ),
                            //         width: width*0.449,
                            //         height: 45,
                            //
                            //         child: TextField(
                            //           decoration: InputDecoration.collapsed(hintText: ''),
                            //
                            //         ),
                            //       ),
                            //       SizedBox(width: width*0.005,),
                            //       Container(
                            //         height: 45,
                            //
                            //
                            //
                            //
                            //         decoration: BoxDecoration(
                            //             color: Color(0xFFFFE5E6),
                            //             borderRadius: BorderRadius.circular(5)
                            //
                            //         ),
                            //         child: GestureDetector(
                            //           onTap: () {
                            //             setState(() {
                            //               fieldVisibility = !fieldVisibility;
                            //             });
                            //           },
                            //           child:SizedBox(
                            //
                            //
                            //
                            //
                            //             child:Padding(
                            //               padding:  EdgeInsets.symmetric(horizontal: 8.0),
                            //               child: SvgPicture.asset("assets/images/red_bin.svg",color: Color(0xFFF64747)),
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),

                            SizedBox(
                              height: height * 0.04,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: ElevatedButton(
                                    onPressed: _showAlertDialog,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 0.6),
                                      child: Row(
                                        children: [
                                          Text(
                                              'Add new instructor  '
                                                  .tr()
                                                  .toString(),
                                              strutStyle: StrutStyle(
                                                  forceStrutHeight: true)),
                                          Icon(
                                            Icons.add_circle_outline,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFF5F0E5),
                                      onPrimary: Color(0xFF183028),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                WebSmoothScroll(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            height: height * 0.45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Course title",
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFF999999),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.005,
                                    ),
                                    SizedBox(
                                      width: width * 0.476,
                                      height: height * 0.08,
                                      child: TextField(
                                        maxLength: 50,
                                        controller: myControllerTitle_e,
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16),
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFEEEEEE),
                                                width: 1.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFEEEEEE),
                                                width: 1.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Text(
                                      "Category",
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFF999999),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.005,
                                    ),
                                    SizedBox(
                                      width: width * 0.476,
                                      height: height * 0.08,
                                      child: TextField(
                                        maxLength: 50,
                                        controller: myControllerCategory_a,
                                        decoration: InputDecoration(
                                          // hintText: "${snapshot.data![index].category}",
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFEEEEEE),
                                                width: 1.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFEEEEEE),
                                                width: 1.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Text(
                                      "Description",
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFF999999),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.005,
                                    ),
                                    SizedBox(
                                      width: width * 0.476,
                                      height: height * 0.15,
                                      child: TextField(
                                        maxLength: 255,
                                        controller: myControllerDes_e,
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16),
                                        ),
                                        maxLines: 20,
                                        decoration: InputDecoration(
                                          // hintText: ("${snapshot.data![index].description}"),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFEEEEEE),
                                                width: 1.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFEEEEEE),
                                                width: 1.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(width: width*0.01,),

                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Course image".tr(),
                                        style: GoogleFonts.barlow(
                                          textStyle: TextStyle(
                                              color: Color(0xFFBD9B60),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Container(
                                        height: height * 0.37,
                                        width: width * 0.2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imgselect == false
                                                  ? AssetImage(img)
                                                      as ImageProvider
                                                  : MemoryImage(_bytesData),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Maximum number of participants",
                            style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                  color: Color(0xFF999999),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: SizedBox(
                                  width: width * 0.476,
                                  height: height * 0.08,
                                  child: TextField(
                                    maxLength: 3,
                                    controller: myControllerMaxCount_a,
                                    style: GoogleFonts.barlow(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    ),
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.unfold_more,
                                            size: 13,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFEEEEEE),
                                            width: 1.5),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFEEEEEE),
                                            width: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.11,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        FileUploadInputElement uploadInput =
                                            FileUploadInputElement();

                                        uploadInput.click();

                                        uploadInput.onChange.listen((e) {
                                          // read file content as dataURL
                                          final files = uploadInput.files;
                                          if (files?.length == 1) {
                                            final file = files?[0];
                                            final reader = new FileReader();

                                            reader.onLoadEnd.listen((e) async {
                                              print(e);
                                              print('loaded: ${file?.name}');
                                              print(
                                                  'type: ${reader.result.runtimeType}');
                                              print(
                                                  'file size = ${file?.size}');
                                              if (file!.size >
                                                  2 * 1024 * 1024) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                  "Please select a photo less than 2MB size",
                                                  style: TextStyle(
                                                      color: Colors.red[600]),
                                                )));
                                              } else {
                                                _handleResult(reader.result);
                                                print("i reached here");
                                                imgselect = true;
                                              }
                                            });
                                            reader.readAsDataUrl(file!);
                                            // myControllerSubject.text = file.name;
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14, horizontal: 0.6),
                                        child: Text(
                                            'Select image'.tr().toString(),
                                            strutStyle: StrutStyle(
                                                forceStrutHeight: true)),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent,
                                        primary: Color(0xFFF5F0E5),
                                        onPrimary: Color(0xFF183028),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.014,
                                  ),
                                  SizedBox(
                                    width: width * 0.08,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        imgselect = false;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14, horizontal: 0.6),
                                        child: Text(
                                            'Delete image'.tr().toString(),
                                            strutStyle: StrutStyle(
                                                forceStrutHeight: true)),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFFFFE5E5),
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent,
                                        onPrimary: Color(0xFF4A0303),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Text(
                            "Instructors",
                            style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                  color: Color(0xFF999999),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          FutureBuilder<List<InstructorModel>>(
                            future: fetchInst(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (_, index) => Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Color(0xFFEEEEEE))),
                                              width: width * 0.42,
                                              height: 45,
                                              child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Text(
                                                      '${snapshot.data![index].name}')),
                                            ),
                                            SizedBox(
                                              width: width * 0.005,
                                            ),
                                            Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFFE5E6),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  deleteInstructors(snapshot
                                                      .data![index].name_id);
                                                  setState(() {
                                                    FInstructor = fetchInst();
                                                  });
                                                },
                                                child: SizedBox(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: SvgPicture.asset(
                                                        "assets/images/red_bin.svg",
                                                        color:
                                                            Color(0xFFF64747)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.005,
                                            ),
                                            Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFF5F0E5),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _showUpdateAlertDialog(
                                                        snapshot.data![index]
                                                            .name_id,
                                                        snapshot
                                                            .data![index].name);
                                                  });
                                                },
                                                child: SizedBox(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: SvgPicture.asset(
                                                        "assets/images/pen.svg"),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Text("");
                              }
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: ElevatedButton(
                                  onPressed: _showAlertDialog,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 0.6),
                                    child: Row(
                                      children: [
                                        Text(
                                            'Add new instructor  '
                                                .tr()
                                                .toString(),
                                            strutStyle: StrutStyle(
                                                forceStrutHeight: true)),
                                        Icon(
                                          Icons.add_circle_outline,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFF5F0E5),
                                    onPrimary: Color(0xFF183028),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (submitForm()) {
                                      widget.onNext();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 0.6),
                                    child: Text(
                                      'Next'.tr().toString(),
                                      strutStyle:
                                          StrutStyle(forceStrutHeight: true),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    primary: Color(0xFF215732),
                                    onPrimary: Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
