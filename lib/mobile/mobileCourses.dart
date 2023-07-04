import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pif_admin_dashboard/mobile/courseDetails/courseNav.dart';
import 'package:pif_admin_dashboard/mobile/new/newCourseNav.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import '../models/course_model.dart';
import 'package:http/http.dart' as http;

import 'package:pif_admin_dashboard/util/global.dart' as global;

class mobileCourses extends StatefulWidget {
  const mobileCourses({Key? key}) : super(key: key);

  @override
  State<mobileCourses> createState() => _mobileCoursesState();
}

class _mobileCoursesState extends State<mobileCourses> {
  late ScrollController _scrollController;
  Future<List<Course>> searchCourse(String name) async {
    List<Course> courses = [];
    List<Course> results = [];
    final response = await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesEng'));


    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        courses.add(Course.fromMap(jsonDecode(response.body)[i]));
      }

      if (name.isNotEmpty) {
        courses.forEach((element) {
          if (element.course_name.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(courses);
        hasData = true;
      }
      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }
  TextEditingController _searchController = TextEditingController();

  Future<http.Response> postCourse (int i) async {

    final myController1 = TextEditingController();
    final myController2 = TextEditingController();
    final myController3 = TextEditingController();
    final myController4 = TextEditingController();

    Map data =
    {

      "course_id": i,
      "course_name": "string",
      "course_image": "string",
      "course_instructor": "string",
      "applicants": 0,
      "admission": 0,
      "deadline": "Dec 20"

    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddCourse'),

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

  Future<List<Course>> fetchCourseEng() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Course>((json) => Course.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Course>> fetchCourseArb() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Course>((json) => Course.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  late Future<List<Course>> futureCourse;
  late Future<List<Course>> futureCourseArb;
  Random random = new Random();
  bool hasData = true;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();
    futureCourse = fetchCourseEng();
    futureCourseArb = fetchCourseArb();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;



    final sort =
    SizedBox(
        height: height*0.058,

        width: width*0.44,
        child: ElevatedButton.icon(
          onPressed: (){
            showMaterialModalBottomSheet(
              useRootNavigator: true,

              context: context,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.4,

                child: Container(

                  height: 600,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon:  Icon(Icons.arrow_back_ios_new,size: 18),
                              onPressed: () {  Navigator.of(context).pop(); },
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Text("Sort".tr(),style: GoogleFonts.barlow(
                                textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color: Color(0xff222222) ),)),

                              ],
                            ),
                            SizedBox(width: 1,)

                          ],
                        ),
                        SizedBox(height: height*0.05,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width*0.9,
                              height: height*0.07,

                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {

                                    //
                                    // isVisible = !isVisible;
                                    // isVisibleButton = !isVisibleButton;

                                  });
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Newest to Oldest'.tr().toString(),strutStyle: StrutStyle(
                                        forceStrutHeight: true
                                    ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),),
                                    SizedBox(width: 5,),SvgPicture.asset('assets/images/tick.svg',), SizedBox(width: 5),],),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    side: BorderSide(
                                        width: 1,
                                        color: Color(0xff999999)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: height*0.02,),
                            SizedBox(
                              width: width*0.9,
                              height: height*0.07,

                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text('Oldest to Newest'.tr().toString(),strutStyle: StrutStyle(
                                        forceStrutHeight: true
                                    ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),)],),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    side: BorderSide(
                                        width: 1,
                                        color: Color(0xff999999)
                                    )
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
            );
          },
          icon: Icon(Icons.filter_list),  //icon data for elevated button
          label: Text("Sort".tr().toString(),strutStyle: StrutStyle(
              forceStrutHeight: true
          )), //label text
          style: ElevatedButton.styleFrom(
              elevation: 0,
              side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7), // <-- Radius
              ),
              primary: Colors.white ,//elevated btton background color
              onPrimary: Colors.black,
              minimumSize: Size(width*0.45,50)
          ),
        ));

    final search = SizedBox(
      height: height*0.055,
      width: width*0.92,
      child: Container(
        // margin: const EdgeInsets.all(1.0),
        // padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
            color: Colors.white,

            border: Border.all(color: Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              futureCourse = searchCourse(value);
            });
          },
          controller: _searchController,

          decoration: InputDecoration(
            prefixIcon:  SvgPicture.asset("images/search.svg",fit: BoxFit.scaleDown,),
            border: InputBorder.none,

            hintText: 'Search'.tr().toString(),
            contentPadding: EdgeInsets.only(top:10),
            hintStyle:  GoogleFonts.barlow(textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ) ),
            
            // enabledBorder: const OutlineInputBorder(
            //   // borderSide: const BorderSide(color: Color(0xFFEEEEEE),),
            // ),



          ),



        ),
      ),
    );

    final filter = SizedBox(      height: height*0.058,

        width: width*0.44,
        child : ElevatedButton.icon(
          onPressed: ()async {

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
            print(picked);

          },
          icon: ImageIcon(
            AssetImage("assets/mobileImages/funnel.png"),
            size: 24,
          ),  //icon data for elevated button
          label: Text("Filter".tr().toString(),strutStyle: StrutStyle(
              forceStrutHeight: true
          )), //label text
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7), // <-- Radius
            ),
            primary: Colors.white ,//elevated btton background color
            onPrimary: Colors.black,


          ),
        )
    );

    // final courseOne = InkWell(
    //   hoverColor: Colors.transparent,
    //
    //   onTap: (){
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => courseNav()),
    //     );
    //   },
    //   child:
    //   Card(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(8.0),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(15.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text("Introduction to Data Analytics ".tr().toString(),strutStyle: StrutStyle(
    //               forceStrutHeight: true
    //           ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
    //           ),SizedBox(height: MediaQuery.of(context).size.height*0.005),
    //           Row(
    //             children: [
    //               Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
    //                   forceStrutHeight: true
    //               ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
    //               ),Text("Mohammad Alsugair".tr().toString(),strutStyle: StrutStyle(
    //                   forceStrutHeight: true
    //               ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: height*0.01,),
    //
    //           Row(
    //             children: [
    //               SvgPicture.asset("images/u.svg",fit: BoxFit.scaleDown,),
    //
    //               Text(" 34 students ".tr().toString(),strutStyle: StrutStyle(
    //                   forceStrutHeight: true
    //               ), style:
    //               GoogleFonts.barlow(
    //                 textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: height*0.01,),
    //           Row(
    //             children: [
    //               SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),
    //
    //               Text(" May 11, 2022 - June 11, 2022 ".tr().toString(),strutStyle: StrutStyle(
    //                   forceStrutHeight: true
    //               ), style:
    //               GoogleFonts.barlow(
    //                 textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: height*0.01,),
    //           Row(
    //             children: [
    //               SvgPicture.asset("images/approval.svg",fit: BoxFit.scaleDown,),
    //
    //               Text(" 1 of 2 workshops done ".tr().toString(),strutStyle: StrutStyle(
    //                   forceStrutHeight: true
    //               ), style:
    //               GoogleFonts.barlow(
    //                 textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
    //               ),
    //             ],
    //           ),
    //
    //         ],
    //
    //       ),
    //     ),
    //   ),
    // );

    final courseTwo = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Financial Modelling ".tr().toString(),strutStyle: StrutStyle(
                forceStrutHeight: true
            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
            ),SizedBox(height: MediaQuery.of(context).size.height*0.002),
            Row(
              children: [
                Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),Text("Ahmed Alsahli".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),

            Row(
              children: [
                SvgPicture.asset("images/u.svg",fit: BoxFit.scaleDown,),

                Text(" 56 students ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),

                Text(" May 11, 2022 - June 11, 2022 ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SvgPicture.asset("images/approval.svg",fit: BoxFit.scaleDown,),

                Text(" 1 of 2 workshops done ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),

          ],

        ),
      ),
    );

    final courseThree= Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Advanced Data Analytics ".tr().toString(),strutStyle: StrutStyle(
                forceStrutHeight: true
            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
            ),SizedBox(height: MediaQuery.of(context).size.height*0.002),
            Row(
              children: [
                Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),Text("Mohammad Abdulrahman".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),

            Row(
              children: [
                SvgPicture.asset("images/u.svg",fit: BoxFit.scaleDown,),

                Text(" 48 students ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),

                Text(" May 11, 2022 - June 11, 2022 ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SvgPicture.asset("images/approval.svg",fit: BoxFit.scaleDown,),

                Text(" 2 of 3 workshops done ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),

          ],

        ),
      ),
    );

    final courseFour = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 15,),
            Text("Project Management Essentials ".tr().toString(),strutStyle: StrutStyle(
                forceStrutHeight: true
            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
            ),SizedBox(height: MediaQuery.of(context).size.height*0.002),
            Row(
              children: [
                Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),Text("Mohammad Alsoghayer".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),

            Row(
              children: [
                SvgPicture.asset("images/u.svg",fit: BoxFit.scaleDown,),

                Text(" 34 students ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),

                Text(" May 11, 2022 - June 11, 2022 ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SvgPicture.asset("images/approval.svg",fit: BoxFit.scaleDown,),

                Text(" 1 of 4 workshops done ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),

          ],

        ),
      ),
    );

    final courseFive = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 15,),
            Text("Research Skills ".tr().toString(),strutStyle: StrutStyle(
                forceStrutHeight: true
            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
            ),SizedBox(height: MediaQuery.of(context).size.height*0.002),
            Row(
              children: [
                Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),Text(" Abdul AlKhaldi".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),

            Row(
              children: [
                SvgPicture.asset("images/u.svg",fit: BoxFit.scaleDown,),

                Text(" 88 students ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),

                Text(" May 11, 2022 - June 11, 2022 ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SvgPicture.asset("images/approval.svg",fit: BoxFit.scaleDown,),

                Text(" 2 of 3 workshops done ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),

          ],

        ),
      ),
    );

    final courseSix = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 15,),
            Text("Investment Techniques & Tools ".tr().toString(),strutStyle: StrutStyle(
                forceStrutHeight: true
            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
            ),SizedBox(height: MediaQuery.of(context).size.height*0.002),
            Row(
              children: [
                Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),Text("Ahmed Alsahli".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),

            Row(
              children: [
                SvgPicture.asset("images/u.svg",fit: BoxFit.scaleDown,),

                Text(" 34 students ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),

                Text(" May 11, 2022 - June 11, 2022 ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SvgPicture.asset("images/approval.svg",fit: BoxFit.scaleDown,),

                Text(" 3 of 4 workshops done ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ), style:
                GoogleFonts.barlow(
                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ],
            ),

          ],

        ),
      ),
    );

    return Scaffold(
      drawer: SideNavBar(),
      appBar: AppBar(
          toolbarHeight: height*0.15,
          automaticallyImplyLeading: false,
          title: Column(

            children: [
              SizedBox(height: height*0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(

                    child: Text("Courses".tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 22),
                    ),),
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
              padding: const EdgeInsets.only(left: 20.0,right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: height*0.03,),
                  // Padding(
                  //   padding: EdgeInsets.only(left: width*0.04,right: width*0.04,bottom: height*0.01),
                  //
                  //   child: SizedBox(
                  //     width: width*0.9,
                  //     height: height*0.05,
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => newCourseNav()),
                  //         );
                  //       },
                  //       child: Text("Add new course".tr().toString(),strutStyle: StrutStyle(
                  //           forceStrutHeight: true
                  //       )),
                  //       style: ElevatedButton.styleFrom(
                  //           primary: Color(0xFF215732),
                  //           onPrimary: Colors.white,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8),
                  //           ),
                  //           side: BorderSide(
                  //             width: 0.4,
                  //
                  //           )
                  //       ),
                  //     ),
                  //   ),
                  // ),



                      SizedBox(
                        width: width*0.89,
                        height: height*0.05,
                        child: ElevatedButton(
                          onPressed: () {
                            int randomNumber = random.nextInt(100);

                            int r2 = random.nextInt(100);
                            int r3 = random.nextInt(100);
                            int i = randomNumber+r2+r3;
                            postCourse(i);


                            Navigator.push(
                              context,
                              PageRouteBuilder(pageBuilder: (context, animation1, animation2) => newCourseNav( cid: i.toString(),), transitionDuration: Duration(seconds: 0),),

                            );
                          },
                          child: Text("Add new course".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(
                            textStyle: TextStyle(color:Colors.white, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                          )),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF215732),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),

                              side: BorderSide(
                                  width: 0.4,
                                color:  Color(0xFF215732)

                              )
                          ),
                        ),
                      ),


                  SizedBox(height: height*0.02,),
                  search,
                  SizedBox(height: height*0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    filter,sort
                  ],),

                  SizedBox(height: height*0.02,),
                  FutureBuilder<List<Course>>(
                    future: context.locale == const Locale("en") ? futureCourse : futureCourseArb,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Course>? courses = [];
                        if (context.locale == const Locale("en") && snapshot.data != null) {
                          courses = snapshot.data!.where((c) => c.course_name != "").toList(); 
                        } else {
                          courses = snapshot.data;
                        }

                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),

                          shrinkWrap:true,
                          itemCount: courses!.length,
                          itemBuilder: (_, index) => Container(

                            child: Column(
                              children: [
                                InkWell(
                                  hoverColor: Colors.transparent,

                                  onTap: (){
                                    Navigator.push(context,
                                        PageRouteBuilder(pageBuilder: (context, animation1, animation2) => courseNav(course : courses![index],), transitionDuration: Duration(seconds: 0),)).
                                        then((value) => {
                                                  setState(() {
                                                    futureCourse = fetchCourseEng();
                                                    futureCourseArb = fetchCourseArb();
                                                  })
                                                });
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => courseNav()),
                                    // );
                                  },
                                  child:
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${courses![index].course_name} ".tr().toString(),strutStyle: StrutStyle(
                                              forceStrutHeight: true
                                          ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                                          ),SizedBox(height: MediaQuery.of(context).size.height*0.005),
                                          Row(
                                            children: [
                                              Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
                                                  forceStrutHeight: true
                                              ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                              ),Text("${courses[index].course_instructor}".tr().toString(),strutStyle: StrutStyle(
                                                  forceStrutHeight: true
                                              ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: height*0.01,),

                                          Row(
                                            children: [
                                              SvgPicture.asset("images/u.svg",fit: BoxFit.scaleDown,),

                                              Text(" ${courses[index].applicants} applicants ".tr().toString(),strutStyle: StrutStyle(
                                                  forceStrutHeight: true
                                              ), style:
                                              GoogleFonts.barlow(
                                                textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(height: height*0.01,),
                                          // Row(
                                          //   children: [
                                          //     SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),
                                          //
                                          //     Text(" May 11, 2022 - June 11, 2022 ".tr().toString(),strutStyle: StrutStyle(
                                          //         forceStrutHeight: true
                                          //     ), style:
                                          //     GoogleFonts.barlow(
                                          //       textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                          //     ),
                                          //   ],
                                          // ),
                                          SizedBox(height: height*0.01,),
                                          // Row(
                                          //   children: [
                                          //     SvgPicture.asset("images/approval.svg",fit: BoxFit.scaleDown,),
                                          //
                                          //     Text(" 1 of 2 workshops done ".tr().toString(),strutStyle: StrutStyle(
                                          //         forceStrutHeight: true
                                          //     ), style:
                                          //     GoogleFonts.barlow(
                                          //       textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                          //     ),
                                          //   ],
                                          // ),

                                        ],

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.017),
                                // courseOne,

                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),

                  // SizedBox(height: height*0.017),
                  // courseOne,
                  // SizedBox(width: width*0.015,),
                  // courseTwo,
                  // SizedBox(width: width*0.015,),
                  // courseThree,
                  // courseFour,
                  // SizedBox(width: width*0.015,),
                  // courseFive,
                  // SizedBox(width: width*0.015,),
                  // courseSix





                ],
              ),
            ),
          ),
        ),),
    );
  }
}
