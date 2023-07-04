import 'dart:convert';
import 'dart:html';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;
import '../models/AboutCourse.dart';
import '../models/instructorModel.dart';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;

class aboutCourse extends StatefulWidget {
  final String current_course_id;
  final int Function() onNext;

  const aboutCourse(
      {Key? key, required this.current_course_id, required this.onNext})
      : super(key: key);

  @override
  _aboutCourseState createState() => _aboutCourseState();
}

class _aboutCourseState extends State<aboutCourse>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  late ScrollController _scrollController;

  late List<int> _selectedFile;
  late Uint8List _bytesData;
  bool imgselect = false;

  void _handleResult(Object? result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  Future<String> updateRequestName_e() async {
    var url = Uri.parse(
        global.apiAddress + "UpdateAboutName/${widget.current_course_id}");
    var request = new http.MultipartRequest("POST", url);

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

  Future<String> updateRequestName_a() async {
    var url = Uri.parse(
        global.apiAddress + "UpdateAboutNameArb/${widget.current_course_id}");
    var request = new http.MultipartRequest("POST", url);

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

  Future<http.Response> updateRequestEng() async {
    Map data = {
      "about_id": 0,
      "category": myControllerCategory_a.text,
      "description": myControllerDes_e.text,
      "maxParticipants": myControllerMaxCount_a.text,
      "duration": "teghj",
      "course_name": myControllerTitle_e.text,
      "course_instuctor": myControllerInstructor_a.text,
      "course_image": "C:\\imgUpload\\courses\\c1.png",
      "course_id": "string",
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(
            global.apiAddress + 'UpdateAboutEng/${widget.current_course_id}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  late Future<List<AboutCourse>> futureCourse;
  late Future<List<AboutCourse>> futureCoursearb;

  Future<http.Response> updateRequestArb() async {
    Map data = {
      "about_id": 0,
      "category": myControllerCategory_a.text,
      "description": myControllerDes_a.text,
      "maxParticipants": myControllerMaxCount_a.text,
      "duration": "teghj",
      "course_name": myControllerTitle_a.text,
      "course_instuctor": myControllerInstructor_a.text,
      "course_image": "C:\\imgUpload\\courses\\c1.png",
      "course_id": "string",
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(
            global.apiAddress + 'UpdateAboutArb/${widget.current_course_id}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  final myControllerTitle_e = TextEditingController();
  final myControllerCategory_a = TextEditingController();

  final myControllerDes_e = TextEditingController();

  // final myControllerInstructor_e = TextEditingController();

  final myControllerTitle_a = TextEditingController();
  final myControllerMaxCount_a = TextEditingController();
  final myControllerDes_a = TextEditingController();
  final myControllerInstructor_a = TextEditingController();
  String a = 'fff';

  Future<http.Response> postRequestinstructor() async {
    Map data = {
      "course_id": widget.current_course_id,
      "name": myControllerInst.text,
      "name_id": 0
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(
        Uri.parse(
            global.apiAddress + 'AddInstructors/${widget.current_course_id}'),
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
      "course_id": widget.current_course_id,
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

  List allControllerList = [];
  Future<http.Response> deleteInstructors(int nid) async {
    Map data = {
      "course_id": widget.current_course_id,
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
    final responseEng = await http.get(Uri.parse(
        global.apiAddress + 'GetInstructors/${widget.current_course_id}'));

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

  Future<List<AboutCourse>> fetchCourseEng() async {
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAboutEng/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<AboutCourse>((json) => AboutCourse.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<AboutCourse>> fetchCourseArb() async {
    final response = await http.get(Uri.parse(
        global.apiAddress + 'GetAboutArb/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<AboutCourse>((json) => AboutCourse.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  bool submitForm() {
    String errorText = "";

    // english section
    if (myControllerTitle_e.text != "") {
      errorText +=
          validator.isValid("English title", myControllerTitle_e.text, "empty");
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

    updateRequestArb();
    updateRequestEng();
    // deleteInstructors();
    if (imgselect == true) {
      updateRequestName_a();
      updateRequestName_e();
      print("uploaded the image using save button");
    }
    return true;
  }

  var img = "assets/images/coursebg.png";

  @override
  void initState() {
    futureCourse = fetchCourseEng();
    futureCoursearb = fetchCourseArb();
    FInstructor = fetchInst();
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  var fieldVisibility = true;
  var fieldVisibility2 = true;
  List _instructorList = [];
  var arimg;
  @override
  Widget build(BuildContext context) {
    fetchCourseArb().then((value) {
      myControllerCategory_a.text = value[0].category;
      myControllerDes_a.text = value[0].description;
      myControllerTitle_a.text = value[0].course_name;
      myControllerMaxCount_a.text = value[0].maxParticipants.toString();
      myControllerInstructor_a.text = value[0].course_instuctor;
      arimg = value[0].course_image;
    });
    fetchCourseEng().then((value) {
      // myControllerCategory_a.text = value[0].category;
      myControllerDes_e.text = value[0].description;
      myControllerTitle_e.text = value[0].course_name;
      // myControllerMaxCount_a.text = value[0].maxParticipants.toString();
      myControllerInstructor_a.text = value[0].course_instuctor;
    });
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
                          child: FutureBuilder<List<AboutCourse>>(
                        future: futureCoursearb,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) => Container(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "عنوان الدورة",
                                                style: GoogleFonts.barlow(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF999999),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                                                  controller: myControllerTitle_a
                                                    ..text =
                                                        '${snapshot.data![index].course_name}',
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 16),
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 1.5),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                                                  controller: myControllerCategory_a
                                                    ..text =
                                                        '${snapshot.data![index].category}',
                                                  decoration: InputDecoration(
                                                    // hintText: "${snapshot.data![index].category}",
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 1.5),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                                                  controller: myControllerDes_a
                                                    ..text =
                                                        '${snapshot.data![index].description}',
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 16),
                                                  ),
                                                  maxLines: 20,
                                                  decoration: InputDecoration(
                                                    // hintText: ("${snapshot.data![index].description}"),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
                                                          width: 1.5),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFEEEEEE),
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
                                                        color:
                                                            Color(0xFFBD9B60),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                Container(
                                                  height:height *0.37,
                                                  width: width*0.2,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imgselect==false  ? NetworkImage(global.apiAddress + 'GetImage/${snapshot.data![index].course_image}') as ImageProvider : MemoryImage(_bytesData),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: SizedBox(
                                            width: width * 0.476,
                                            height: height * 0.08,
                                            child: TextField(
                                              maxLength: 3,
                                              controller:
                                                  myControllerMaxCount_a,
                                              style: GoogleFonts.barlow(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16),
                                              ),
                                              decoration: InputDecoration(
                                                // hintText: "${snapshot.data![index].maxParticipants}",
                                                suffixIcon: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.unfold_more,
                                                      size: 13,
                                                    )),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFEEEEEE),
                                                      width: 1.5),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
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
                                                  FileUploadInputElement
                                                      uploadInput =
                                                      FileUploadInputElement();

                                                  uploadInput.click();

                                                  uploadInput.onChange
                                                      .listen((e) {
                                                    // read file content as dataURL
                                                    final files =
                                                        uploadInput.files;
                                                    if (files?.length == 1) {
                                                      final file = files?[0];
                                                      final reader =
                                                          new FileReader();

                                                      reader.onLoadEnd
                                                          .listen((e) async {
                                                        print(e);
                                                        print(
                                                            'loaded: ${file?.name}');
                                                        print(
                                                            'type: ${reader.result.runtimeType}');
                                                        print(
                                                            'file size = ${file?.size}');
                                                        _handleResult(
                                                            reader.result);
                                                        print("i reached here");
                                                        imgselect = true;
                                                      });
                                                      reader
                                                          .readAsDataUrl(file!);
                                                      // myControllerSubject.text = file.name;
                                                    }
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 14,
                                                      horizontal: 0.6),
                                                  child: Text(
                                                      'Select another image'
                                                          .tr()
                                                          .toString(),
                                                      strutStyle: StrutStyle(
                                                          forceStrutHeight:
                                                              true)),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0.0,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  primary: Color(0xFFF5F0E5),
                                                  onPrimary: Color(0xFF183028),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                                onPressed: () {},
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 14,
                                                      horizontal: 0.6),
                                                  child: Text(
                                                      'Delete image'
                                                          .tr()
                                                          .toString(),
                                                      strutStyle: StrutStyle(
                                                          forceStrutHeight:
                                                              true)),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color(0xFFFFE5E5),
                                                  elevation: 0.0,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  onPrimary: Color(0xFF4A0303),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (_, index) =>
                                                Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFEEEEEE))),
                                                        width: width * 0.42,
                                                        height: 45,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            child: Text(
                                                                '${snapshot.data![index].name}')),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.005,
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xFFFFE5E6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            deleteInstructors(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .name_id);
                                                            setState(() {
                                                              FInstructor =
                                                                  fetchInst();
                                                            });
                                                          },
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8.0),
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
                                                            color: Color(
                                                                0xFFF5F0E5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _showUpdateAlertDialog(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .name_id,
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .name);
                                                          },
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: SvgPicture
                                                                  .asset(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: _showAlertDialog,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 14,
                                                  horizontal: 0.6),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      'Add new instructor  '
                                                          .tr()
                                                          .toString(),
                                                      strutStyle: StrutStyle(
                                                          forceStrutHeight:
                                                              true)),
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
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (submitForm()) {
                                                // widget.onNext();
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                      horizontal: 0.6),
                                              child: Text(
                                                'Save Change'.tr().toString(),
                                                strutStyle: StrutStyle(
                                                    forceStrutHeight: true),
                                                style: GoogleFonts.barlow(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      )),
                    )),
                WebSmoothScroll(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    child: Container(
                        child: FutureBuilder<List<AboutCourse>>(
                      future: futureCourse,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                controller: myControllerTitle_e
                                                  ..text =
                                                      '${snapshot.data![index].course_name}',
                                                style: GoogleFonts.barlow(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 16),
                                                ),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFEEEEEE),
                                                        width: 1.5),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFEEEEEE),
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
                                                controller: myControllerCategory_a
                                                  ..text =
                                                      '${snapshot.data![index].category}',
                                                decoration: InputDecoration(
                                                  // hintText: "${snapshot.data![index].category}",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFEEEEEE),
                                                        width: 1.5),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFEEEEEE),
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
                                                controller: myControllerDes_e
                                                  ..text =
                                                      '${snapshot.data![index].description}',
                                                style: GoogleFonts.barlow(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 16),
                                                ),
                                                maxLines: 20,
                                                decoration: InputDecoration(
                                                  // hintText: ("${snapshot.data![index].description}"),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFEEEEEE),
                                                        width: 1.5),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFEEEEEE),
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Container(
                                                height:height *0.37,
                                                width: width*0.2,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imgselect==false  ? NetworkImage(global.apiAddress + 'GetImage/${snapshot.data![index].course_image}') as ImageProvider : MemoryImage(_bytesData),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                              // hintText: "${snapshot.data![index].maxParticipants}",
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
                                                FileUploadInputElement
                                                    uploadInput =
                                                    FileUploadInputElement();

                                                uploadInput.click();

                                                uploadInput.onChange
                                                    .listen((e) {
                                                  // read file content as dataURL
                                                  final files =
                                                      uploadInput.files;
                                                  if (files?.length == 1) {
                                                    final file = files?[0];
                                                    final reader =
                                                        new FileReader();

                                                    reader.onLoadEnd
                                                        .listen((e) async {
                                                      print(e);
                                                      print(
                                                          'loaded: ${file?.name}');
                                                      print(
                                                          'type: ${reader.result.runtimeType}');
                                                      print(
                                                          'file size = ${file?.size}');
                                                      _handleResult(
                                                          reader.result);
                                                      print("i reached here");
                                                      imgselect = true;
                                                    });
                                                    reader.readAsDataUrl(file!);
                                                    // myControllerSubject.text = file.name;
                                                  }
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 14,
                                                        horizontal: 0.6),
                                                child: Text(
                                                    'Select another image'
                                                        .tr()
                                                        .toString(),
                                                    strutStyle: StrutStyle(
                                                        forceStrutHeight:
                                                            true)),
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
                                              onPressed: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 14,
                                                        horizontal: 0.6),
                                                child: Text(
                                                    'Delete image'
                                                        .tr()
                                                        .toString(),
                                                    strutStyle: StrutStyle(
                                                        forceStrutHeight:
                                                            true)),
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
                                          physics:
                                              NeverScrollableScrollPhysics(),
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
                                                              color: Color(
                                                                  0xFFEEEEEE))),
                                                      width: width * 0.42,
                                                      height: 45,
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                              '${snapshot.data![index].name}')),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.005,
                                                    ),
                                                    Container(
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFFFFE5E6),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          deleteInstructors(
                                                              snapshot
                                                                  .data![index]
                                                                  .name_id);
                                                          setState(() {
                                                            FInstructor =
                                                                fetchInst();
                                                          });
                                                        },
                                                        child: SizedBox(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8.0),
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
                                                          color:
                                                              Color(0xFFF5F0E5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _showUpdateAlertDialog(
                                                              snapshot
                                                                  .data![index]
                                                                  .name_id,
                                                              snapshot
                                                                  .data![index]
                                                                  .name);
                                                        },
                                                        child: SizedBox(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8.0),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                        forceStrutHeight:
                                                            true)),
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
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (submitForm()) {
                                              // widget.onNext();
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14, horizontal: 0.6),
                                            child: Text(
                                              'Save Change'.tr().toString(),
                                              strutStyle: StrutStyle(
                                                  forceStrutHeight: true),
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
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    )),
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
