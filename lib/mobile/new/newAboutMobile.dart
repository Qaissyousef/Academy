import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';

import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;

class newMobileAboutCourse extends StatefulWidget {
  final String cid;
  const newMobileAboutCourse({Key? key, required this.cid}) : super(key: key);

  @override
  _newMobileAboutCourseState createState() => _newMobileAboutCourseState();
}
class _newMobileAboutCourseState extends State<newMobileAboutCourse>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;

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

    Future<String> postAboutSection_e() async {
      var url = Uri.parse(
          global.apiAddress + "AddAboutC");
      var request = new http.MultipartRequest("POST", url);

      request.fields['description'] = myControllerDes_e.text;
      request.fields['duration'] = "15 hours per month etc etc";

      request.fields['course_name'] =myControllerTitle_e.text;
      request.fields['course_instuctor'] = myControllerInstructor_e.text;
      request.fields['course_id'] = widget.cid.toString();
      request.fields['course_image'] = '2e0.057';
      request.fields['category'] = myControllerCategory_e.text;
      request.fields['maxParticipants'] = myControllerMaxCount_e.text;




      request.files.add(await http.MultipartFile.fromBytes('fileModel', _selectedFile,

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
      var url = Uri.parse(
          global.apiAddress + "AddAboutCArb");
      var request = new http.MultipartRequest("POST", url);

      request.fields['description'] = myControllerDes_a.text;
      request.fields['duration'] = "15 hours per month etc etc";

      request.fields['course_name'] =myControllerTitle_a.text;
      request.fields['course_instuctor'] = myControllerInstructor_a.text;
      request.fields['course_id'] = widget.cid.toString();
      request.fields['course_image'] = '2e0.057';
      request.fields['category'] = myControllerCategory_a.text;
      request.fields['maxParticipants'] = myControllerMaxCount_a.text;




      request.files.add(await http.MultipartFile.fromBytes('fileModel', _selectedFile,

          contentType: new MediaType('application', 'octet-stream'),
          filename: 'hhh'));

      request.send().then((response) {
        print("i am hereee makerequest");
        print(response.statusCode);
        if (response.statusCode == 200) print("Uploaded!");



      });
      return "finished";
    }
 

    Future<http.Response> postAboutSectionMinusImage_e () async {


      Map data;
      if (myControllerTitle_e.text != "") {
        data = {
          "about_id": 0,
          "description": myControllerDes_e.text,
          "duration": "15 hours per month etc etc",
          "course_name": myControllerTitle_e.text,
          "course_instuctor": myControllerInstructor_e.text,
          "course_image": "C:\\imgUpload\\courses\\c1.png",
          "course_id": widget.cid.toString(),
          "category": myControllerCategory_e.text,
          "maxParticipants": myControllerMaxCount_e.text,
        };
      }
      else {
        data = {
          "about_id": 0,
          "description": "",
          "duration": "15 hours per month etc etc",
          "course_name": "",
          "course_instuctor": "",
          "course_image": "C:\\imgUpload\\courses\\c1.png",
          "course_id": widget.cid.toString(),
          "category": "",
          "maxParticipants": 0,
        };
      }

      var body = json.encode(data);
      var response = await http.post(Uri.parse(global.apiAddress + 'AddAboutCMI'),

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
      return response;
    }

    Future<http.Response> postAboutSectionMinusImage_a () async {
      Map data =
      {


        "about_id": 0,
        "description": myControllerDes_a.text,
        "duration": "15 hours per month etc etc",
        "course_name": myControllerTitle_a.text,
        "course_instuctor": myControllerInstructor_a.text,
        "course_image": "C:\\imgUpload\\courses\\c1.png",
        "course_id": widget.cid.toString(),
        "category": myControllerCategory_a.text,
        "maxParticipants": myControllerMaxCount_a.text,
      };

      //encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(Uri.parse(global.apiAddress + 'AddAboutCMIArb'),

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
      return response;
    }
    Future<http.Response> updateRequestName_e () async {


      Map data = {
        "course_name": myControllerTitle_e.text,
        "course_instuctor": myControllerInstructor_e.text,
      };
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(Uri.parse(global.apiAddress + 'UpdateAboutName/$widget.cid'),
          headers: {"Content-Type": "application/json"},
          body: body
      );
      print("${response.statusCode}");
      print("${response.body}");
      return response;
    }
    Future<http.Response> updateRequestName_a () async {


      Map data = {
        "course_name": myControllerTitle_a.text,
        "course_instuctor": myControllerInstructor_a.text,
      };
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(Uri.parse(global.apiAddress + 'UpdateAboutNameArb/$widget.cid'),
          headers: {"Content-Type": "application/json"},
          body: body
      );
      print("${response.statusCode}");
      print("${response.body}");
      return response;
    }

  bool submitForm() {
    String errorText = "";

    // english section
    if (myControllerTitle_e.text != "") {
      errorText += validator.isValid("English title", myControllerTitle_e.text, "empty");
      errorText += validator.isValid("English category", myControllerCategory_e.text, "empty");
      errorText += validator.isValid("English max count", myControllerMaxCount_e.text, "empty;number");
      errorText += validator.isValid("English description", myControllerDes_e.text, "empty");
      //errorText += validator.isValid("English instructor", myControllerInstructor_e.text, "empty;");
    }

    // arabic section
    errorText += validator.isValid("Arabic title", myControllerTitle_a.text, "empty");
    errorText += validator.isValid("Arabic category", myControllerCategory_a.text, "empty");
    errorText += validator.isValid("Arabic max count", myControllerMaxCount_a.text, "empty;number");
    errorText += validator.isValid("Arabic description", myControllerDes_a.text, "empty");
    //errorText += validator.isValid("Arabic instructor", myControllerInstructor_a.text, "empty;");

    if (errorText != "") {
      validator.mobileAlertDialog(context, errorText.substring(0, errorText.length - 1));
      return false;
    }

    if(imgselect == false) {
        postAboutSectionMinusImage_e();
        postAboutSectionMinusImage_a();
        print("no image selected");
    }
    else {
        postAboutSection_e();
        postAboutSection_a();
        updateRequestName_e();
        updateRequestName_a();
        print(" image selected");

      }

    return true;
  }

  late List<int> _selectedFile;
  late Uint8List _bytesData;
  String current_course_id = 3.toString();
  bool imgselect = false;


  void _handleResult(Object? result) {
    setState(()  {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }
  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 5000,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TabBar(
              controller: _nestedTabController,
              isScrollable: true,
              labelColor: Color(0xFF222222),
              unselectedLabelColor:Color(0xFF999999),
              indicatorColor: Color(0xFFBD9B60),
              indicatorWeight: 3.0,
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
              height: 5000 ,
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              child: TabBarView(
                controller: _nestedTabController,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*0.02,),
                        Text("عنوان الدورة",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),

                        SizedBox(
                          width: width*0.95,
                          height: height*0.05,
                          child: TextField(
                            controller: myControllerTitle_a,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),

                        SizedBox(height: height*0.02,),
                        Text("الفئة",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),

                        SizedBox(
                          width: width*0.95,

                          height: height*0.05,
                          child: TextField(
                            controller: myControllerCategory_a,

                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.expand_more,size: 13,)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),

                        SizedBox(height: height*0.02,),
                        Text("الوصف",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),

                        SizedBox(height: height*0.009,),
                        SizedBox(
                          width: width*0.95,

                          height: height*0.15,
                          child: TextField(
                            controller: myControllerDes_a,
                            maxLines: 20,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),
                        SizedBox(height: height*0.02,),


                        Text("الحد الأقصى لعدد المشاركين",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),

                        SizedBox(
                          width: width*0.95,

                          height: height*0.05,
                          child:TextField(
                            controller: myControllerMaxCount_a,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.unfold_more,size: 13,)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),
                        SizedBox(height: height*0.04,),

                        Text("المدربين",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width*0.77,


                              height: height*0.05,
                              child: TextField(
                                controller: myControllerInstructor_a,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                  ),


                                ),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFE5E6),
                                  borderRadius: BorderRadius.circular(5)

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("images/bin.png",color: Color(0xFFF64747),),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: height*0.04,),

                        SizedBox(
                          height: height*0.058,

                          width: width*0.55,
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text('Add new instructor  '.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                )),
                                Icon(Icons.add_circle_outline,size: 13,)
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                              primary: Color(0xFFF5F0E5),
                              onPrimary: Color(0xFF183028),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),

                            ),
                          ),
                        ),

                        SizedBox(height: height*0.009,),


                        Divider(
                          thickness: 0.2,
                          color: Color(0xFF999999),
                        ),
                        SizedBox(height: height*0.005,),

                        Text("صورة الدورة",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.01,),
                        Center(child: Image.asset("assets/mobileImages/dummyImage.png",height: height*0.4,)),
                        SizedBox(height: height*0.025,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: height*0.058,
                              width: width*0.44,
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Text('Select another image'.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                )),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFF5F0E5),
                                  onPrimary: Color(0xFF183028),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),

                                ),
                              ),
                            ),

                            SizedBox(
                              height: height*0.058,

                              width: width*0.4,
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Text('Delete image'.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                )),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFFE5E5),
                                  onPrimary: Color(0xFF4A0303),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),

                                ),
                              ),
                            ),

                          ],
                        ),

                        SizedBox(height: height*0.08,),

                        Container(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              height: height*0.058,

                              width: width*0.4,
                              child: ElevatedButton(
                                onPressed: () {
                                  submitForm();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0.6),
                                  child: Text('Save'.tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style: GoogleFonts.barlow(
                                    textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                  )),
                                ),

                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF215732),
                                  onPrimary: Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*0.02,),
                        Text("Course title",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),

                        SizedBox(
                          width: width*0.95,
                          height: height*0.05,
                          child: TextField(
                            controller: myControllerTitle_e,

                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),

                        SizedBox(height: height*0.02,),
                        Text("Category",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),

                        SizedBox(
                          width: width*0.95,

                          height: height*0.05,
                          child: TextField(
                            controller: myControllerCategory_e,


                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.expand_more,size: 13,)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),

                        SizedBox(height: height*0.02,),
                        Text("Description",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),

                        SizedBox(height: height*0.009,),
                        SizedBox(
                          width: width*0.95,

                          height: height*0.15,
                          child: TextField(
                            controller: myControllerDes_e,

                            maxLines: 20,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),
                        SizedBox(height: height*0.02,),


                        Text("Maximum number of participants",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),

                        SizedBox(
                          width: width*0.95,

                          height: height*0.05,
                          child:TextField(
                            controller: myControllerMaxCount_e,

                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.unfold_more,size: 13,)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),
                        SizedBox(height: height*0.04,),

                        Text("Instructors",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width*0.77,


                              height: height*0.05,
                              child: TextField(
                                controller: myControllerInstructor_e,

                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                  ),


                                ),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFE5E6),
                                  borderRadius: BorderRadius.circular(5)

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("images/bin.png",color: Color(0xFFF64747),),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: height*0.04,),

                        SizedBox(
                          height: height*0.058,

                          width: width*0.55,
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text('Add new instructor  '.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                )),
                                Icon(Icons.add_circle_outline,size: 13,)
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                              primary: Color(0xFFF5F0E5),
                              onPrimary: Color(0xFF183028),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),

                            ),
                          ),
                        ),

                        SizedBox(height: height*0.009,),


                        Divider(
                          thickness: 0.2,

                          color: Color(0xFF999999),
                        ),
                        SizedBox(height: height*0.005,),

                        Text("Course image",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.01,),

                        Container(
                          height:height *0.37,
                          width: width*0.8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imgselect==false  ? AssetImage(img) as ImageProvider : MemoryImage(_bytesData),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(height: height*0.025,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: height*0.058,
                              width: width*0.44,
                              child: ElevatedButton(
                                onPressed: () async{
                                  FileUploadInputElement uploadInput = FileUploadInputElement();

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
                                        print('type: ${reader.result.runtimeType}');
                                        print('file size = ${file?.size}');
                                        _handleResult(reader.result);
                                        print("i reached here");
                                        imgselect = true;

                                      });
                                      reader.readAsDataUrl(file!);
                                      // myControllerSubject.text = file.name;
                                    }
                                  });


                                },
                                child: Text('Select another image'.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                )),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFF5F0E5),
                                  onPrimary: Color(0xFF183028),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),

                                ),
                              ),
                            ),

                            SizedBox(
                              height: height*0.058,

                              width: width*0.4,
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Text('Delete image'.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                )),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFFE5E5),
                                  onPrimary: Color(0xFF4A0303),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),

                                ),
                              ),
                            ),

                          ],
                        ),

                        SizedBox(height: height*0.08,),
                        Container(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              height: height*0.058,

                              width: width*0.4,
                              child: ElevatedButton(
                                onPressed: () {
                                  submitForm();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0.6),
                                  child: Text('Next'.tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style: GoogleFonts.barlow(
                                    textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                  )),
                                ),

                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF215732),
                                  onPrimary: Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
