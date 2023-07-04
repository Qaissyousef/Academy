import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/courseDetails/mobileAnnouncements.dart';
import 'package:pif_admin_dashboard/mobile/mobileEvents.dart';
import 'package:pif_admin_dashboard/mobile/mobileUsers.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;

import '../models/ann_model.dart';
import '../models/event_model.dart';
import '../models/user_model.dart';
import 'dart:convert';

import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:date_time_format/date_time_format.dart';


class adminMobile extends StatefulWidget {
  const adminMobile({Key? key}) : super(key: key);

  @override
  State<adminMobile> createState() => _adminMobileState();
}

class _adminMobileState extends State<adminMobile> {

  Future<List<Announcement>> fetchAnnEng() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllAnnEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Announcement>((json) => Announcement.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Announcement>> fetchAnnArb() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllAnnArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Announcement>((json) => Announcement.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

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

  Future<List<User>> fetchuser() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllUsers'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<User>((json) => User.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  late Future<List<User>> futureuser;


  late ScrollController _scrollController;
  @override
  void initState() {
    futureuser = fetchuser();

    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    annCard(Announcement a) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFFFFFFF),


        ),
        // color: Color(0xFFFFFFFF),

        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width*0.13,


                child:
                Expanded(
                  child:  SvgPicture.asset("images/bell.svg", height: 2, width: 2,
                      fit: BoxFit.scaleDown),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF9F2E7),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Row(

                  children: [
                    Container(

                      width: width*0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.022,),

                          Text(a.ann_title.tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),
                            style:
                            GoogleFonts.barlow(
                              textStyle : TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),

                          ),
                          SizedBox(height: height*0.01),
                          Text("${DateTime.parse(a.ann_creation_time).format('d M, Y').toString()}".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),
                            style:
                            GoogleFonts.barlow(
                              textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ),
                          SizedBox(height: height*0.022,),



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
                height: height*0.09,
                width: width*0.13,
                child:
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(e.event_start_date.substring(0, 3).tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),
                        style:
                        GoogleFonts.barlow(
                          textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                      ),SizedBox(height: 5),
                      Text(e.event_start_date.substring(4, 6).tr().toString(),strutStyle: StrutStyle(
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
                padding:  EdgeInsets.only(left: width*0.02,top:8,right:width*0.02),
                child: Row(
                  children: [
                    Container(

                      width: width*0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.009,),
                          Text("${e.event_start_time} - ${e.event_end_time}".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ), SizedBox(height: height*0.005),
                          Text(e.event_title.tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
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
    return Scaffold(
      drawer: SideNavBar(),
      appBar: AppBar(
          toolbarHeight: height*0.15,
          automaticallyImplyLeading: false,
          title:  Column(

                children: [
                  SizedBox(height: height*0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(

                        child: Text("Administration".tr(),style: GoogleFonts.barlow(
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
        padding: const EdgeInsets.only(left: 20.0,right: 20),
        child: WebSmoothScroll(
          controller: _scrollController,

          child: SingleChildScrollView(
          child: Column(
          children: [
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(



                  child: Text("Events".tr(),style: GoogleFonts.barlow(
                    textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                  ),),
                ),
                InkWell(
                  hoverColor: Colors.transparent,
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => mobileEvents()),
                    );

                  },
                  child: Row(
                    children: [
                      Text("View all".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                      ),),
                      Container(
                        child: ImageIcon(
                            AssetImage(context.locale == Locale("en") ? "images/forward.png": "images/arArrow.png" ),

                            color: Color(0xFF215732),
                            size:9
                        ),
                        padding: EdgeInsets.only(top: 10.0,bottom: 10),
                        // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),

                      ),
                    ],
                  )
                ),

              ],
            ),
            const SizedBox(height: 8,),

            FutureBuilder<List<EventModel>>(

              future: context.locale == const Locale('en') ? fetchEventsEng() : fetchEventsArb(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(

                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap:true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(

                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 2.0),
                        child: Material(
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
                                    height: height*0.09,
                                    width: width*0.13,
                                    child:
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("${snapshot.data![index].event_start_date}".substring(0, 3).tr().toString(),strutStyle: StrutStyle(
                                              forceStrutHeight: true
                                          ),
                                            style:
                                            GoogleFonts.barlow(
                                              textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                          ),SizedBox(height: 5),
                                          Text("${snapshot.data![index].event_start_date}".substring(4, 6).tr().toString(),strutStyle: StrutStyle(
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
                                    padding:  EdgeInsets.only(left: width*0.02,top:8,right:width*0.02),
                                    child: Row(
                                      children: [
                                        Container(

                                          width: width*0.7,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(height: height*0.009,),
                                              Text("${snapshot.data![index].event_start_time} - ${snapshot.data![index].event_end_time}".tr().toString(),strutStyle: StrutStyle(
                                                  forceStrutHeight: true
                                              ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                              ), SizedBox(height: height*0.005),
                                              Text("${snapshot.data![index].event_title}".tr().toString(),strutStyle: StrutStyle(
                                                  forceStrutHeight: true
                                              ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
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
                        )
                      ),
                    ),
                  );

                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )

            // FutureBuilder <List<EventModel>>( future: context.locale == const Locale("en") ? fetchEventsEng() : fetchEventsArb(),
            //         builder: (context, snapshot) {
            //           if (snapshot.hasData){
            //             return Column(
            //               children: [
            //                 for(var event in snapshot.data ?? [])
            //                   Column(
            //                     children: [
            //                       eventCard(event),
            //                       const SizedBox(height:8)
            //                     ],
            //                   )
            //               ],
            //             );
            //           }
            //           return Container();
            //         }
            //       ),
            , SizedBox(height: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Container(



                  child: Text("Announcements".tr(),style: GoogleFonts.barlow(
                    textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                  ),),
                ),
                InkWell(
                  hoverColor: Colors.transparent,
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => mobileAnnouncements()),
                    );

                  },
                  child: Row(
                    children: [
                      Text("View all".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                      ),),
                      Container(
                        child: ImageIcon(
                            AssetImage(context.locale == Locale("en") ? "images/forward.png": "images/arArrow.png" ),

                            color: Color(0xFF215732),
                            size:9
                        ),
                        padding: EdgeInsets.only(top: 10.0,bottom: 10),
                        // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),

                      ),
                    ],
                  )
                ),

              ],
            ),
            FutureBuilder <List<Announcement>>(
              future: context.locale == const Locale("en") ? fetchAnnEng() : fetchAnnArb(),
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return Column(
                    children: [
                      for(var a in snapshot.data ?? [])
                        Column(
                          children: [
                            annCard(a),
                            const SizedBox(height:12)
                          ],
                        )
                    ],
                  );
                }
                return Container();
              }
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Container(

                  child: Text("Users".tr(),style: GoogleFonts.barlow(
                    textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                  ),),
                ),
                InkWell(
                  hoverColor: Colors.transparent,
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => mobileUsers()),
                    );

                  },
                  child: Row(
                    children: [
                      Text("View all".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                      ),),
                      Container(
                        child: ImageIcon(
                            AssetImage(context.locale == Locale("en") ? "images/forward.png": "images/arArrow.png" ),

                            color: Color(0xFF215732),
                            size:9
                        ),
                        padding: EdgeInsets.only(top: 10.0,bottom: 10),
                        // margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),

                      ),
                    ],
                  )
                ),

              ],
            ),
            SizedBox(height: 12,),
            FutureBuilder<List<User>>(
              future: futureuser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                    return ListView.builder(
                      physics:
                      NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot
                          .data!.length,
                      itemBuilder:
                          (_, index) =>
                          Container(
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => webSpecificUser()),
                                // );
                              },
                              hoverColor: Colors
                                  .transparent,
                              child: Material(
                                color: Color(0xFFffffff),
                                elevation: 1,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    height: height*0.1,
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(150),

                                    ),

                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [


                                          Container(
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10,),
                                                Container(
                                                    width: width*0.1,
                                                    child: Image.asset("images/u3.png")),
                                                SizedBox(width: 20,),
                                                Container(

                                                  width: width*0.3,
                                                  child: Column(

                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 15.0),
                                                        child: Text("${snapshot.data![index].name}".tr(),style: GoogleFonts.barlow(
                                                          textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                                        ),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 15.0),

                                                        child: Text("${snapshot.data![index].email}",overflow: TextOverflow.ellipsis,style: GoogleFonts.barlow(
                                                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                                        ),),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(left: 8.0,right: 8),
                                            child: Container(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color(0xFFffffff),

                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(18.0),
                                                    side: BorderSide(
                                                      color: Color(0xFFBD9B60),
                                                      width: 0.5,
                                                    ),

                                                  ),

                                                ),
                                                child: Text('${snapshot.data![index].user_type}'.tr(),style: GoogleFonts.barlow(
                                                  textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                                ),),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              )
                            ),

                            // Column(
                            //   children: [
                            //     Text("${snapshot.data![index].name}"),
                            //     Text("${snapshot.data![index].email}"),
                            //     Text("${snapshot.data![index].user_type}"),
                            //     Text("${snapshot.data![index].user_id}"),
                            //
                            //     Text("${snapshot.data![index].user_status}"),
                            //
                            //
                            //
                            //     DropdownButtonFormField(
                            //       decoration :InputDecoration.collapsed(hintText: ''),
                            //       style: GoogleFonts.barlow(
                            //         textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                            //       ),
                            //       // Initial Value
                            //       value: snapshot.data![index].user_type,
                            //
                            //       // Down Arrow Icon
                            //       icon:Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),
                            //
                            //       // Array list of items
                            //       items: items.map((String items) {
                            //         return DropdownMenuItem(
                            //           value: items,
                            //           child: Text(items,style: GoogleFonts.barlow(
                            //             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            //           ),),
                            //         );
                            //       }).toList(),
                            //       // After selecting the desired option,it will
                            //       // change button value to selected value
                            //       onChanged: (String? newValue) {
                            //         setState(() {
                            //           updateRole(newValue!,snapshot.data![index].user_id);
                            //         });
                            //       },
                            //     ),
                            //     PopupMenuButton(
                            //       onSelected: (result) {
                            //         // your logic
                            //         if (result == 0) {
                            //           print("delete");
                            //           deleteRequest(snapshot.data![index].user_id);
                            //         }
                            //         else if (result == 1)
                            //         {
                            //           print("activate");
                            //           updateRequest("active",snapshot.data![index].user_id);
                            //         }
                            //         else
                            //         {
                            //           print("deactivate");
                            //           updateRequest("inactive",snapshot.data![index].user_id);
                            //
                            //         }
                            //       },
                            //       itemBuilder: (BuildContext bc) {
                            //         return const [
                            //           PopupMenuItem(
                            //             child: Text("Delete"),
                            //             value: 0,
                            //           ),
                            //           PopupMenuItem(
                            //             child: Text("Activate"),
                            //             value: 1,
                            //           ),
                            //           PopupMenuItem(
                            //             child: Text("DeActivate"),
                            //             value:2 ,
                            //           )
                            //         ];
                            //       },
                            //     )
                            //
                            //   ],
                            // ),
                          ),
                    );

                } else {
                  return Center(
                      child: Text(
                          "No Items Found",
                          style: GoogleFonts.barlow(
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
                                  16))));
                }
              },
            ),

            SizedBox(height: 20,),
          ],
          ),
        ),
        ),

      ),
    );
  }
}
