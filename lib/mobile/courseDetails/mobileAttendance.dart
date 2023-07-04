import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../../models/attendwebModel.dart';
import 'collectAttend.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pif_admin_dashboard/util/global.dart' as global;

class mobileAttendance extends StatefulWidget {
  final String current_course_id;

  const mobileAttendance({Key? key,required this.current_course_id}) : super(key: key);

  @override
  State<mobileAttendance> createState() => _mobileAttendanceState();
}

class _mobileAttendanceState extends State<mobileAttendance> {

  Future<List<attendwebModel>> fetchatt() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllAttend/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<attendwebModel>((json) => attendwebModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  late Future<List<attendwebModel>> futureatt;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    futureatt = fetchatt();

    super.initState();
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



    final num = SizedBox(
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("08".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                )),
              SizedBox(width: 70,),
              Icon(Icons.expand_more_rounded,size: 16,color: Color(0xFF999999),)
            ],
          ),
          onPressed: (){
            print("You pressed Icon Elevated Button");
          },
          // icon: Icon(Icons.filter_list),
          //  //label text
          style: ElevatedButton.styleFrom(
              elevation: 0,
              side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
              primary: Colors.white ,//elevated btton background color
              onPrimary: Color(0xFF215732),
              minimumSize: Size(135,50)
          ),
        ));
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

    final filter = SizedBox(height: height*0.058,
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

    final present = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFFEEEEEE),width: 0.8),

      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 8,horizontal: width*0.02),
        child: Row(
          children: [
            Text("  Mark present  ".tr(),style: GoogleFonts.barlow(
              textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            ),),

            Image.asset("images/yes.png",color:Color(0xFF215732)),


          ],
        ),
      ),
    );

    final absent = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFFEEEEEE),width: 0.8),

      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 8,horizontal: width*0.02),
        child: Row(
          children: [
            Text("   Mark Absent  ".tr(),style: GoogleFonts.barlow(
              textStyle: TextStyle(color: Color(0xFFD80000), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
            ),),
            Image.asset("images/no.png",color:Color(0xFFD80000)),


          ],
        ),
      ),
    );




    return Scaffold(

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


                  SizedBox(height: height*0.02,),

                  search,
                  SizedBox(height: height*0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    filter,sort
                  ],),
                  SizedBox(height: height*0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                  num,
                   Text("Showing 6 of 6 results".tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                    ),)
                  ],),
                  SizedBox(height: height*0.02,),

                  SizedBox(
                    height: height*0.055,
                    width: width*0.92,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => collect()),
                          );
                        },
                        child: Text("  Collect attendance  ".tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ), style: GoogleFonts.barlow(textStyle:  TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFFBFCFC) ),
                        ),),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF215732),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),

                            side: BorderSide(
                                width: 0.4,
                                color:Color(0xFF215732)
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.02),
                  FutureBuilder<List<attendwebModel>>(

                    future: futureatt ,
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap:true,
                          itemCount: snapshots.data!.length,

                          itemBuilder: (_, index) => Container(

                              child: Column(
                                children :[

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
                                          Row(
                                            children: [

                                              Text("${snapshots.data![index].name}".tr().toString(),strutStyle: StrutStyle(
                                                  forceStrutHeight: true
                                              ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            height: 25,
                                            color: Color(0xffffffff),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [
                                                Container(

                                                  child: Text("Date ".tr().toString(),strutStyle: StrutStyle(
                                                      forceStrutHeight: true
                                                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text("${snapshots.data![index].date} ".tr().toString(),strutStyle: StrutStyle(
                                                      forceStrutHeight: true
                                                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Divider(thickness: 0.2,
                                            color: Color(0xFF999999),
                                          ),
                                          Container(
                                            height: 25,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [
                                                Container(
                                                  // width: ,


                                                  child: Text("Account Type ".tr().toString(),strutStyle: StrutStyle(
                                                      forceStrutHeight: true
                                                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text("${snapshots.data![index].user_type} ".tr().toString(),strutStyle: StrutStyle(
                                                          forceStrutHeight: true
                                                      ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                                                      ),
                                                      SizedBox(width: width*0.02,),

                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10,),

                                          Divider(height: 0.001,thickness: 0.2,
                                            color: Color(0xFF999999),
                                          ),

                                          Container(

                                            height: 35,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [
                                                Container(

                                                  child: Text("Percentage ".tr().toString(),strutStyle: StrutStyle(
                                                      forceStrutHeight: true
                                                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text("${(snapshots.data![index].percentage/3*100).round()}% ".tr().toString(),strutStyle: StrutStyle(
                                                      forceStrutHeight: true
                                                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [present,
                                                absent],
                                            ),
                                          )



                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width*0.015,),





                                ],
                              )
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),







                ],
              ),
            ),
          ),
        ),),
    );
  }
}
