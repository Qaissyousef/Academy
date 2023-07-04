import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/eventsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/usersResponive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import 'dart:convert';
import 'package:pif_admin_dashboard/util/global.dart' as global;

class mobileHome extends StatefulWidget {
  const mobileHome({Key? key}) : super(key: key);

  @override
  State<mobileHome> createState() => _mobileHomeState();
}

class _mobileHomeState extends State<mobileHome> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

      Future<List<EventModel>> fetchEventsEng() async {
    final responseEng =
    await http.get(Uri.parse(global.apiAddress + 'GetAllEventsEng'));

    if (responseEng.statusCode == 200) {
      final parsedEng = json.decode(responseEng.body).cast<Map<String, dynamic>>();

      return parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<EventModel>> fetchEventsArb() async {
    final responseArb =
    await http.get(Uri.parse(global.apiAddress + 'GetAllEventsArb'));

    if (responseArb.statusCode == 200) {
      final parsedArb = json.decode(responseArb.body).cast<Map<String, dynamic>>();

      return parsedArb.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }



  eventCard(EventModel e) {
    return Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height*0.14,
                width: width*0.13,
                decoration: BoxDecoration(
                  color: Color(0xFFF9F2E7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(e.event_start_date.substring(0, 3),strutStyle: const StrutStyle(
                          forceStrutHeight: true
                      ),
                        style:
                        GoogleFonts.barlow(
                          textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                      ),const SizedBox(height: 5),
                      Text(e.event_start_date.substring(4, 6),strutStyle: const StrutStyle(
                          forceStrutHeight: true
                      ),style:
                      GoogleFonts.barlow(
                        textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 20,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(left: width*0.03,top:8,right:width*0.03),
                child: Row(
                  children: [
                    Container(

                      width: width*0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.009,),
                          Text("${e.event_start_time} - ${e.event_end_time}",strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ), SizedBox(height: height*0.005),
                          Text(e.event_title,strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                          ), SizedBox(height: height*0.009),
                          Text(e.event_description,strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style:GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ),
                         SizedBox(height: height*0.005),

                        ],
                      ),
                    ),
                    // SizedBox(width: 70),



                  ],
                ),
              ),

            ],
          ),

        ),
      ),
    );
    }

    final event2 = Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(10),
      child: Container(


        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),


        ),

        child: Container(


          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height*0.12,
                width: width*0.13,


                child:
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Jun ".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),
                        style:
                        GoogleFonts.barlow(
                          textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                      ),SizedBox(height: 5),
                      Text("18".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),style:
                      GoogleFonts.barlow(
                        textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 20,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF9F2E7),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(left: width*0.03,top:8,right:width*0.03),

                child: Row(
                  children: [
                    Container(

                      width: width*0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.009,),
                          Text("5:30-6:30 PM".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ), SizedBox(height: height*0.005),
                          Text("Data Analytics Workshop Meet ".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                          ), SizedBox(height: height*0.009),
                          Text("Practice your skills in a real life scenario.".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style:GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ),
                          SizedBox(height: height*0.005),

                        ],
                      ),
                    ),
                    // SizedBox(width: 70),



                  ],
                ),
              ),

            ],
          ),

        ),
      ),
    );

    final event3 = Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(10),
      child: Container(


        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),


        ),

        child: Container(


          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height*0.16,
                width: width*0.13,


                child:
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("May ".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),
                        style:
                        GoogleFonts.barlow(
                          textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                      ),SizedBox(height: 5),
                      Text("31".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),style:
                      GoogleFonts.barlow(
                        textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 20,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF9F2E7),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(left: width*0.03,top:8,right:width*0.03),

                child: Row(
                  children: [
                    Container(

                      width: width*0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.009,),
                          Text("5:30-6:30 PM".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ), SizedBox(height: height*0.005),
                        Text("Investment Techniques & Tools: Meet-Up ".tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                        ),
                        Text("at Head Quarters ".tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                        )
                          , SizedBox(height: height*0.009),
                          Text("In-person meet-up. Get to know your instructor and ask questions!".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style:GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ),
                          SizedBox(height: height*0.005),

                        ],
                      ),
                    ),
                    // SizedBox(width: 70),



                  ],
                ),
              ),

            ],
          ),

        ),
      ),
    );

    final event4 = Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(10),
      child: Container(


        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),


        ),

        child: Container(


          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height*0.14,
                width: width*0.13,


                child:
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("May ".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),
                        style:
                        GoogleFonts.barlow(
                          textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                      ),SizedBox(height: 5),
                      Text("29".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),style:
                      GoogleFonts.barlow(
                        textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 20,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF9F2E7),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(left: width*0.03,top:8,right:width*0.03),

                child: Row(
                  children: [
                    Container(

                      width: width*0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.009,),
                          Text("5:30-6:30 PM".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ), SizedBox(height: height*0.005),
                          Text("Quizzing your knowledge: Data Analytics ".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                          ), SizedBox(height: height*0.009),
                          Text("Show up and grow what you already know by attending this quiz!".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style:GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ),
                          SizedBox(height: height*0.005),

                        ],
                      ),
                    ),
                    // SizedBox(width: 70),



                  ],
                ),
              ),

            ],
          ),

        ),
      ),
    );

    final courseOne =Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(2),

      child: GestureDetector(
        onTap: (){

        },
        child: Container(

          height: 111,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0Xff999999),width: 0.01),



          ),

          child: Container(


            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(top: 8.0,left: width*0.05,right:width*0.05),
                  child: Row(
                    children: [
                      Container(
                        width:width*0.8,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text("Introduction to Data Analytics".tr().toString(),strutStyle: StrutStyle(
                                forceStrutHeight: true
                            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.006),
                            Row(
                              children: [
                                Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                ),Text("Mohammad Alsugair".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                                ),
                              ],
                            ),
                            // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                            SizedBox(height: height*0.01),
                            Row(
                              children: [
                                Text("1 of 2 workshops done | 34 students".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                )

                              ],
                            ),

                          ],
                        ),
                      ),
                      // SizedBox(width: 65,),


                    ],
                  ),
                ),

              ],
            ),

          ),
        ),
      ),
    );


    final courseTwo =Material(
      color: Colors.white,

      elevation: 1,
      borderRadius: BorderRadius.circular(2),

      child: GestureDetector(
        onTap: (){

        },
        child: Container(

          height: 111,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0Xff999999),width: 0.01),



          ),

          child: Container(


            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(top: 8.0,left: width*0.05,right:width*0.05),
                  child: Row(
                    children: [
                      Container(
                        width:width*0.8,


                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text("Financial Modelling ".tr().toString(),strutStyle: StrutStyle(
                                forceStrutHeight: true
                            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.006),
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
                            // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                            SizedBox(height: height*0.01),
                            Row(
                              children: [
                                Text("1 of 2 workshops done | 56 students".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                )

                              ],
                            ),

                          ],
                        ),
                      ),
                      // SizedBox(width: 65,),


                    ],
                  ),
                ),

              ],
            ),

          ),
        ),
      ),
    );

    final courseThree =Material(
      color: Colors.white,

      elevation: 1,
      borderRadius: BorderRadius.circular(2),

      child: GestureDetector(
        onTap: (){

        },
        child: Container(

          height: 111,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0Xff999999),width: 0.01),



          ),

          child: Container(


            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(top: 8.0,left: width*0.05,right:width*0.05),
                  child: Row(
                    children: [
                      Container(
                        width:width*0.8,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text("Advanced Data Analytics ".tr().toString(),strutStyle: StrutStyle(
                                forceStrutHeight: true
                            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.006),
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
                            // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                            SizedBox(height: height*0.01),
                            Row(
                              children: [
                                Text("2 of 3 workshops done | 48 students".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                )

                              ],
                            ),

                          ],
                        ),
                      ),
                      // SizedBox(width: 65,),


                    ],
                  ),
                ),

              ],
            ),

          ),
        ),
      ),
    );

    final courseFour =Material(
      color: Colors.white,

      elevation: 1,
      borderRadius: BorderRadius.circular(2),

      child: GestureDetector(
        onTap: (){

        },
        child: Container(

          height: 111,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0Xff999999),width: 0.01),



          ),

          child: Container(


            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(top: 8.0,left: width*0.05,right:width*0.05),
                  child: Row(
                    children: [
                      Container(
                        width:width*0.8,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text("Project Management Essentials ".tr().toString(),strutStyle: StrutStyle(
                                forceStrutHeight: true
                            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.006),
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
                            // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                            SizedBox(height: height*0.01),
                            Row(
                              children: [
                                Text("1 of 4 workshops done | 34 students".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                )

                              ],
                            ),

                          ],
                        ),
                      ),
                      // SizedBox(width: 65,),


                    ],
                  ),
                ),

              ],
            ),

          ),
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
                  child: Text("Hi Mohammad!".tr(),style: GoogleFonts.barlow(
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
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: height*0.04,horizontal: width*0.03),

        child: WebSmoothScroll(
          controller: _scrollController,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Overview".tr(),style: GoogleFonts.barlow(
                  textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                ),),
                SizedBox(height: height*0.02),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  // image: AssetImage( context.locale == Locale("en") ? 'assets/mobileImages/en1.png' : 'assets/mobileImages/ma1.png' ),
                                  image: AssetImage( 'assets/mobileImages/blank.png' ),

                                  fit: BoxFit.fill,



                                )

                            ),
                            child: Padding(
                              padding:  EdgeInsets.only(right: 30.0,left: 30,top:  10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height*0.035,),
                                  Text("Students enrolled".tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Colors.black ),),
                                  ),
                                  SizedBox(height: 30,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("375".tr().toString(),strutStyle: StrutStyle(
                                          forceStrutHeight: true
                                      ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 24,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color:Color(0xffBD9B60) ),),
                                      ),
                                      SvgPicture.asset("assets/mobileImages/users.svg",color: Color(0xFFBD9B60))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            width: width*0.455,
                            height: height*0.2,

                          ),
                          // Image.asset("assets/mobileImages/o1.png"),
                          SizedBox(width: width*0.03,),
                          // Image.asset("assets/mobileImages/o2.png"),
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  // image: AssetImage(context.locale == Locale("en") ? 'assets/mobileImages/en2.png' : 'assets/mobileImages/ma2.png'),
                                  image: AssetImage( 'assets/mobileImages/blank.png' ),
                                  fit: BoxFit.fill,

                                )

                            ),
                            width: width*0.455,
                            height: height*0.2,
                            child: Padding(
                              padding:  EdgeInsets.only(right: 30.0,left: 30,top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height*0.035,),
                                  Text("Completed courses ".tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Colors.black ),),
                                  ),
                                  SizedBox(height: 30,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("48".tr().toString(),strutStyle: StrutStyle(
                                          forceStrutHeight: true
                                      ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 24,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color:Color(0xffBD9B60) ),),
                                      ),
                                      SvgPicture.asset("assets/mobileImages/approve.svg",color: Color(0xFFBD9B60))
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ),


                        ],
                      ),
                      SizedBox(height: width*0.03,),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  // image: AssetImage(context.locale == Locale("en") ? 'assets/mobileImages/en3.png' : 'assets/mobileImages/ma3.png'),
                                  image: AssetImage( 'assets/mobileImages/blank.png' ),
                                  fit: BoxFit.fill,


                                )

                            ),
                            width: width*0.455,
                            height: height*0.2,
                            child: Padding(
                              padding:  EdgeInsets.only(right: 30.0,left: 30,top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height*0.035,),
                                  Text("Ongoing courses".tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Colors.black ),),
                                  ),
                                  SizedBox(height: 30,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("12".tr().toString(),strutStyle: StrutStyle(
                                          forceStrutHeight: true
                                      ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 24,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color:Color(0xffBD9B60) ),),
                                      ),
                                      SvgPicture.asset("assets/mobileImages/presentation.svg",color: Color(0xFFBD9B60))
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ),
                          // Image.asset("assets/mobileImages/o1.png"),
                          SizedBox(width: width*0.03,),
                          // Image.asset("assets/mobileImages/o2.png"),
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  // image: AssetImage(context.locale == Locale("en") ? 'assets/mobileImages/en4.png' : 'assets/mobileImages/ma4.png'),
                                  image: AssetImage( 'assets/mobileImages/blank.png' ),
                                  fit: BoxFit.fill,

                                )

                            ),
                            width: width*0.455,
                            height: height*0.2,
                            child: Padding(
                              padding:  EdgeInsets.only(right: 30.0,left: 30,top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height*0.035,),
                                  Text("Upcoming events".tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Colors.black ),),
                                  ),
                                  SizedBox(height: 30,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("05".tr().toString(),strutStyle: StrutStyle(
                                          forceStrutHeight: true
                                      ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 24,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color:Color(0xffBD9B60) ),),
                                      ),
                                      SvgPicture.asset("assets/mobileImages/Events.svg",color: Color(0xFFBD9B60))
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ),


                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: [
                          Text("Upcoming events".tr(),style: GoogleFonts.barlow(
                            textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                          ),),
                          Spacer(),
                          InkWell(
                            hoverColor: Colors.transparent,
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  eventResponsive()),
                              );
                            },
                            child: Text("Manage events  ".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize:14),
                            ),),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,color: Color(0xFF215732),size: 12,),
                          SizedBox(width: width*0.01,),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: height*0.02,),

            FutureBuilder <List<EventModel>>( future: context.locale == const Locale("en") ? fetchEventsEng() : fetchEventsArb(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData){
                        return Column(
                          children: [
                            for(var event in snapshot.data ?? [])
                              Column(
                                children: [
                                  eventCard(event),
                                  const SizedBox(height:8)
                                ],
                              )
                          ],
                        );
                      }
                      return Container();
                    }
                  ),
                SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Text("Students enrolled".tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                    ),),
                    // SizedBox(width: width*0.487,),
                    Spacer(),
                    InkWell(
                      hoverColor: Colors.transparent,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  userResponsive()),
                        );
                      },
                      child:  Text("      Manage all users ".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize:14),
                      ),),
                    ),

                                          Padding(
                      padding: const EdgeInsets.only(top:4.0),
                      child: Icon(Icons.arrow_forward_ios_rounded,color: Color(0xFF215732),size: 12,),
                    ),

                    SizedBox(width: width*0.01,),
                  ],
                ),
                SizedBox(height: height*0.02,),
                Container(
                  width: width*0.94,
                  color : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: width*0.01,top: 5,bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              GroupButton(
                                spacing: 4,
                                isRadio: true,
                                direction: Axis.horizontal,
                                onSelected: (index, isSelected) =>
                                    print('$index button is ${isSelected ? 'selected' : 'unselected'}'),
                                buttons: ["1D".tr().toString(),"1W".tr().toString(),"1M".tr().toString(),"1Y".tr().toString()],
                                // selectedButtons: [0], /// [List<int>] after 2.2.1 version
                                selectedTextStyle:
                                GoogleFonts.barlow(
                                    textStyle:  TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white,
                                    )
                                ),
                                buttonHeight: 20,
                                buttonWidth: 28,
                                unselectedTextStyle:  GoogleFonts.barlow(
                                    textStyle:  TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color:  Color(0xFF222222),
                                    )
                                ),
                                selectedColor: Color(0xFFBD9B60),
                                unselectedColor: Colors.white,
                                selectedBorderColor: Color(0xFFBD9B60),
                                unselectedBorderColor: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(10.0),
                                selectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
                                unselectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
                              )



                            ],
                          ),
                        ),
                        Container(
                            width: width*0.9,
                            child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                series: <ChartSeries>[
                                  LineSeries<ChartData, String>(
                                      dataSource: [
                                        ChartData('Jan'.tr(), 0),
                                        ChartData('Feb'.tr(), 200),
                                        ChartData('Mar'.tr(), 100),
                                        ChartData('Apr'.tr(), 300),
                                        ChartData('May'.tr(), 400),
                                        ChartData('Jun'.tr(), 400),
                                        ChartData('Jul'.tr(), 800),
                                        ChartData('Aug'.tr(), 450),
                                        ChartData('Sept'.tr(), 250),
                                        ChartData('Oct'.tr(), 300),
                                        ChartData('Nov'.tr(), 600),
                                        ChartData('Dec'.tr(), 400),

                                      ],
                                      // Bind the color for all the data points from the data source

                                      xValueMapper: (ChartData data, _) => data.x,
                                      yValueMapper: (ChartData data, _) => data.y
                                  )
                                ]
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage('assets/mobileImages/graph.png'),
                //         fit: BoxFit.fill,
                //
                //       )
                //
                //   ),
                //   child: Padding(
                //     padding:  EdgeInsets.only(left: width*0.05,top: height*0.03),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //
                //       children: [
                //
                //         GroupButton(
                //           spacing: 4,
                //           isRadio: true,
                //           direction: Axis.horizontal,
                //           onSelected: (index, isSelected) =>
                //               print('$index button is ${isSelected ? 'selected' : 'unselected'}'),
                //           buttons: ["1D".tr().toString(),"1W".tr().toString(),"1M".tr().toString(),"1Y".tr().toString()],
                //           // selectedButtons: [0], /// [List<int>] after 2.2.1 version
                //           selectedTextStyle:
                //           GoogleFonts.barlow(
                //               textStyle:  TextStyle(
                //                 fontWeight: FontWeight.w500,
                //                 fontSize: 14,
                //                 color: Colors.white,
                //               )
                //           ),
                //           buttonHeight: 20,
                //           buttonWidth: 28,
                //           unselectedTextStyle:  GoogleFonts.barlow(
                //               textStyle:  TextStyle(
                //                 fontWeight: FontWeight.w400,
                //                 fontSize: 14,
                //                 color:  Color(0xFF222222),
                //               )
                //           ),
                //           selectedColor: Color(0xFFBD9B60),
                //           unselectedColor: Colors.white,
                //           selectedBorderColor: Color(0xFFBD9B60),
                //           unselectedBorderColor: Color(0xFFEEEEEE),
                //           borderRadius: BorderRadius.circular(10.0),
                //           selectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
                //           unselectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
                //         )
                //
                //
                //
                //       ],
                //     ),
                //   ),
                //   width: width*0.94,
                //   height: height*0.4,
                //
                // ),
                SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Container(
                      // width: width*0.665,


                    child: Text("Ongoing Courses".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                      ),),
                    ),
                    Spacer(),

                    InkWell(
                   hoverColor: Colors.transparent,
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  courseResponsive()),
                      );
                    },
                      child:   Text("Manage all courses ".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize:14),
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:4.0),
                      child: Icon(Icons.arrow_forward_ios_rounded,color: Color(0xFF215732),size: 12,),
                    ),
                    SizedBox(width: width*0.01,),

                  ],
                ),
                SizedBox(height: height*0.02,),
                courseOne,
                SizedBox(height: height*0.01,),
                courseTwo,
                SizedBox(height: height*0.01,),
                courseThree,
                SizedBox(height: height*0.01,),
                courseFour,
                SizedBox(height: height*0.02,),

              ],
            ),
          ),
        ),
      )
    );
  }
}
class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;

}