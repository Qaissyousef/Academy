import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/new/newAboutMobile.dart';
import 'package:pif_admin_dashboard/mobile/new/newMobileCertificate.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../courseDetails/courseSchedule.dart';
import '../courseDetails/mobileMaterials.dart';
import '../sideBar.dart';
import 'mobilenewadmissiontab.dart';

class newCourseNav extends StatefulWidget {
  final String cid;
  const newCourseNav({Key? key, required this.cid}) : super(key: key);

  @override
  State<newCourseNav> createState() => _newCourseNavState();
}

class _newCourseNavState extends State<newCourseNav> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        drawer: SideNavBar(),
        appBar: AppBar(

          automaticallyImplyLeading: false,
          // leading:
          title:
          Column(
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

              SizedBox(height: 10),
              Text("Add new course".tr().toString(),style: GoogleFonts.barlow(textStyle:  TextStyle(fontFamily: 'Barlow',fontSize: 22,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFFBFCFC) ),),
              ),],
          ),
          flexibleSpace: Container(

            decoration: BoxDecoration(
                image: DecorationImage(
                  // image: AssetImage(context.locale == Locale("en") ? 'assets/images/bgsmall.png' : 'assets/images/topNavArabic.png'),
                  image: AssetImage('assets/mobileImages/coursebg.png'),
                  fit: BoxFit.fill,

                )

            ),

          ),
          toolbarHeight: height * 0.16,
          bottom: TabBar(
              isScrollable: true,
              labelColor: Color(0xFFBD9B60),
              unselectedLabelColor:Color(0xFFF9F2E7),
              indicatorColor: Color(0xFFBD9B60),
              indicatorWeight: 5.8,

              tabs: [
                Tab(child: Text(
                  "About".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),
                  style: GoogleFonts.barlow(fontSize: 16,fontWeight: FontWeight.w500),
                ), ),
                Tab(child: Text(
                  "Schedule".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),
                  style: GoogleFonts.barlow(fontSize: 16,fontWeight: FontWeight.w500),
                ), ),

                Tab(child: Text(
                  "Materials".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),
                  style: GoogleFonts.barlow(fontSize: 16,fontWeight: FontWeight.w500),
                ), ),


                Tab(child: Text(
                  "Certificate".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),
                  style: GoogleFonts.barlow(fontSize: 16,fontWeight: FontWeight.w500),
                ), ),

                Tab(child: Text(
                  "Admission".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),
                  style: GoogleFonts.barlow(fontSize: 16,fontWeight: FontWeight.w500),
                ), ),



              ]),


        ),
        body: TabBarView(children: [
          WebSmoothScroll(
              controller: _scrollController,

              child: SingleChildScrollView(child: newMobileAboutCourse(cid : widget.cid,))
          ),
          WebSmoothScroll(
              controller: _scrollController,

              child: SingleChildScrollView(child: mobileSchedule(current_course_id: widget.cid))
          ),

          materialDetail(current_course_id: widget.cid),

          WebSmoothScroll(
              controller: _scrollController,

              child: SingleChildScrollView(child:newMobileCertificate()
              )
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0),

            child: mobileNewAdmissionTab(current_course_id: widget.cid),
          ),

        ]),
      ),
    );
  }
}
