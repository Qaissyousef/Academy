import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;

import '../models/applicantModel.dart';

import 'package:pif_admin_dashboard/util/global.dart' as global;

class mobileApplicantDetail extends StatefulWidget {
  final String courseid;
  final int userid;
  final String cname;
  final String usertype;
  const mobileApplicantDetail({Key? key,required this.courseid,required this.userid,required this.cname,required this.usertype}) : super(key: key);

  @override
  State<mobileApplicantDetail> createState() => _mobileApplicantDetailState();
}


class _mobileApplicantDetailState extends State<mobileApplicantDetail> {

  Future<http.Response> postRequestMyC () async {


    Map data =
    {
      "user_id": widget.userid,
      "course_id": widget.courseid,
      "course_completion": 0,
      "finished": 0
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddMyCourse'),

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

  Future<http.Response> postRequest () async {


    Map data =
    {
      "user_id": widget.userid,
      "course_id": widget.courseid,
      "date": "",
      "percentage": 0
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddAttendance'),

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

  Future<List<applicantModel>> fetchApplicant() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetSpecificApplication/1/${widget.courseid}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<applicantModel>((json) => applicantModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<applicantModel>> futureApplicant;

  late ScrollController _scrollController;
  final _dateTime = DateTime.parse("2022-10-01 00:00:00.000");

  @override
  void initState() {
    futureApplicant = fetchApplicant();


    _scrollController = ScrollController();

    super.initState();
  }

  var items = [
    'Pending'.tr(),
    'Declined'.tr(),
    'Accepted'.tr(),

  ];

  Future<http.Response> updateRole (String status, int uid,String cid) async {


    Map data = {
      "course_id": 0,
      "user_id": 0,
      "applicant_title": "string",
      "participants_email": "string",
      "applicant_academy_level": "string",
      "applicant_reason": "string",
      "applicant_ahcievement": "string",
      "applicant_future": "string",
      "status": status,
      "name": "string",
      "email": "string",
      "user_img": "string",
      "submissionTime": "2022-11-01T09:48:49.153Z"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'UpdateApplicatinStatus/$uid/$cid'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  // late ScrollController _scrollController;
  //
  // @override
  // void initState() {
  //   // initialize scroll controllers
  //   _scrollController = ScrollController();
  //
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;








    return Scaffold(
      drawer: SideNavBar(),
      appBar: AppBar(
          toolbarHeight: height*0.15,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(

                      child: GestureDetector( onTap: () {Navigator.of(context).pop();}, child: Icon(Icons.arrow_back_ios,size: 15) )),

                  Builder(
                    builder: (context) => IconButton(
                      icon: new Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.02),


              Text("Introduction To Data Analytics".tr().toString(),style: GoogleFonts.barlow(textStyle:  TextStyle(fontFamily: 'Barlow',fontSize: 22,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFFBFCFC) ),),
              ),
              SizedBox(height: 10),],
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

                )

            ),

          )
      ),
      body:  Container(
        height: height,
        width: width,
        child: WebSmoothScroll(
          controller: _scrollController,
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.02),
              child: Container(
                child:
                FutureBuilder<List<applicantModel>>(

                  future: futureApplicant ,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap:true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height*0.02,),

                            Text("${snapshot.data![index].name}".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 22),
                            ),),

                            SizedBox(height: height*0.02,),
                            Text("Title".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                            SizedBox(height: height*0.009,),
                            Text("${snapshot.data![index].applicant_title}".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),

                            SizedBox(height: height*0.02,),
                            Text("Email".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                            SizedBox(height: height*0.009,),
                            Text("${snapshot.data![index].email}",style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),

                            SizedBox(height: height*0.02,),
                            Text("Highest academic level".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),

                            SizedBox(height: height*0.009,),
                            Text("${snapshot.data![index].applicant_academy_level}".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),

                            SizedBox(height: height*0.02,),


                            Text("Status".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                            SizedBox(height: height*0.009,),
                            SizedBox(
                              width: width*0.25,
                              height: height*0.04,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFEEEEEE),),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: DropdownButtonHideUnderline(
                                  child:DropdownButtonFormField(
                                    decoration :InputDecoration.collapsed(hintText: ''),
                                    style: GoogleFonts.barlow(
                                      textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                    ),
                                    // Initial Value
                                    value: snapshot.data![index].status,

                                    // Down Arrow Icon
                                    icon:Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),

                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: Text(items,style: GoogleFonts.barlow(
                                            textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                          ),),
                                        ),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        updateRole(newValue!,1,1.toString());
                                        //'Pending'.tr(),
                                        //     'Declined'.tr(),
                                        //     'Accepted'.tr(),
                                        if(newValue == 'Accepted'.tr() ){
                                          postRequest();
                                          postRequestMyC();
                                        }else{
                                          // return Text("Y is less than 10");
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height*0.04,),

                            Text("Why do you want to apply to this course?".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                            SizedBox(height: height*0.009,),
                            SizedBox(
                              width: width*0.95,

                              height: height*0.15,
                              child: TextField(
                                controller: TextEditingController(text: "${snapshot.data![index].applicant_reason}".tr()),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                ),
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
                            SizedBox(height: height*0.04,),

                            Text("What achievement are you most proud of?".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                            SizedBox(height: height*0.009,),
                            SizedBox(
                              width: width*0.95,

                              height: height*0.15,
                              child: TextField(
                                controller: TextEditingController(text: "${snapshot.data![index].applicant_ahcievement}".tr()),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                ),
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

                            SizedBox(height: height*0.04,),

                            Text("How this course will help you with your future career?".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                            SizedBox(height: height*0.009,),
                            SizedBox(
                              width: width*0.95,

                              height: height*0.15,
                              child: TextField(
                                controller: TextEditingController(text: "${snapshot.data![index].applicant_future}".tr()),
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                ),
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




                            SizedBox(height: height*0.08,),

                            Container(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  height: height*0.058,

                                  width: width*0.3,
                                  child: ElevatedButton(
                                    onPressed: () {

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0.6),
                                      child: Text('Save changes'.tr().toString(),strutStyle: StrutStyle(
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
                            SizedBox(height: height*0.04,),

                          ],
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),



              ),
            ),
          ),
        ),),
    );
  }
}
