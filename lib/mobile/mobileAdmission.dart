import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'dart:convert';
import '../models/course_model.dart';
import 'mobileAdmissionDetails.dart';
import 'package:http/http.dart' as http;
import 'package:pif_admin_dashboard/util/global.dart' as global;

class mobileAdmissions extends StatefulWidget {
  const mobileAdmissions({Key? key}) : super(key: key);

  @override
  State<mobileAdmissions> createState() => _mobileAdmissionsState();
}

class _mobileAdmissionsState extends State<mobileAdmissions> {

  late List<bool> _isSelected;
  late ScrollController _scrollController;

  Future<List<Course>> fetchCourseEng() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesAEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Course>((json) => Course.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Course>> fetchCourseArb() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllCoursesAArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Course>((json) => Course.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  late Future<List<Course>> futureCourseEng;
  late Future<List<Course>> futureCourseArb;
 


  @override
  void initState() {
    _scrollController = ScrollController();
    _isSelected = [false, true];
    futureCourseEng = fetchCourseEng();
    futureCourseArb = fetchCourseArb();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;



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
                SvgPicture.asset("images/addmision.svg",fit: BoxFit.scaleDown,),

                Text(" Open till May 6, 2022 ".tr().toString(),strutStyle: StrutStyle(
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
                SvgPicture.asset("images/addmision.svg",fit: BoxFit.scaleDown,),

                Text(" Open till May 6, 2022 ".tr().toString(),strutStyle: StrutStyle(
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
                SvgPicture.asset("images/addmision.svg",fit: BoxFit.scaleDown,),

                Text(" Open till May 6, 2022 ".tr().toString(),strutStyle: StrutStyle(
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
                SvgPicture.asset("images/addmision.svg",fit: BoxFit.scaleDown,),

                Text(" Open till May 6, 2022 ".tr().toString(),strutStyle: StrutStyle(
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
                SvgPicture.asset("images/addmision.svg",fit: BoxFit.scaleDown,),

                Text(" Open till May 6, 2022 ".tr().toString(),strutStyle: StrutStyle(
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

                    child: Text("Admission".tr(),style: GoogleFonts.barlow(
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

                  search,

                  SizedBox(height: height*0.017),
                  FutureBuilder<List<Course>>(

                    future:  context.locale == const Locale("en") ? futureCourseEng : futureCourseArb,
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
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(pageBuilder: (context, animation1, animation2) => mobileAdmissionPage(course : courses![index]), transitionDuration: Duration(seconds: 0),),
                                        // mobileAdmissionPage
                                    );
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => mobileAdmissionPage()),
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
                                          SizedBox(height: height*0.01,),

                                          Row(
                                            children: [
                                              SvgPicture.asset("images/addmision.svg",fit: BoxFit.scaleDown,),

                                              Text(" Open till ${courses[index].deadline} ".tr().toString(),strutStyle: StrutStyle(
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
                                  ),
                                ),
                                SizedBox(width: width*0.015,),

                              ],
                            ),
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
