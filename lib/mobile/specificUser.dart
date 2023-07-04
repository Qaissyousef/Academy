import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class specificUser extends StatefulWidget {
  const specificUser({Key? key}) : super(key: key);

  @override
  State<specificUser> createState() => _specificUserState();
}

class _specificUserState extends State<specificUser> {
  late ScrollController _scrollController;
  bool isSwitched = false;

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
    String img= "assets/mobileImages/faceless.png";

    void toggleSwitch(bool value) {

      if(isSwitched == false)
      {
        setState(() {
          isSwitched = true;
          img = 'assets/mobileImages/faceless.png';

        });
        print('Switch Button is ON');

      }
      else
      {
        setState(() {
          isSwitched = false;
          img = 'assets/mobileImages/mobilepfp.png';

        });
        print('Switch Button is OFF');
      }
    }

    final courseOne = Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {

        },
        child: Container(
          width: width*0.95,
          height: 111,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(150),


          ),

          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(


              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 14),

                      Padding(
                        padding: const EdgeInsets.only(top: 19.0),
                        child: Image.asset('assets/mobileImages/course1.png',height: 80,width: 80,),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,left: 12.0,right: 12.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text("Introduction to Data Analytics ".tr().toString(),strutStyle: StrutStyle(
                                forceStrutHeight: true
                            ),style:
                            GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.002),
                            Row(
                              children: [
                                Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:
                                GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                ),Text("Mohammad Alsugair".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                                ),
                              ],
                            ),
                            // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                            SizedBox(height: height*0.01),
                            Container(width: width*0.63,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("1 of 2 workshops done".tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style:
                                  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                  )
                                  ,
                                  // SizedBox(width: width*0.14),



                                  Text("   52%".tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style:
                                  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              height: 5,
                              width: width*0.63,
                              child:
                              LinearProgressIndicator(
                                backgroundColor: Color(0xFFD9D9D9),
                                color: Color(0xFFBD9B60),
                                minHeight: 5,
                                value: 0.6,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 65,),


                      ],
                    ),
                  ),

                ],
              ),

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

                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,size: 14,color: Colors.white),
                        Text("   User information".tr(),style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 22),
                        ),),
                      ],
                    ),
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
      body: WebSmoothScroll(
        controller: _scrollController,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.02,),

              Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 30.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Administration / Users / ".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                    Text(" Fatemah Khalid".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height*0.01,),

              Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                child: Text("User ID: PIFAC123K56 ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                ),
              ),
              SizedBox(height: height*0.02,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: width*0.05,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width*0.9,
                        child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  width: width*0.9,
                                  height: height*0.35,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: AssetImage("assets/mobileImages/settingsbg.png"),
                                      fit: BoxFit.fill,
                                    ),

                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: height*0.03,),
                                      Image.asset(img,scale: 0.78,),
                                      SizedBox(height: height*0.03,),

                                      Text("Mohammad Alsugair".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 20),
                                      ),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height*0.025,),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),
                                  child: Text("Account type".tr(),style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.03),
                                  ),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),

                                  child: SizedBox(
                                    width: width*0.77,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: TextEditingController(text: "Student".tr()),

                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(3),
                                        suffixIcon: IconButton(

                                            onPressed: (){},
                                            icon: Icon(Icons.expand_more_rounded,size: 14,color: Color(0Xff999999),)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                        ),


                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.025,),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),
                                  child: Text("Account status".tr(),style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.03),
                                  ),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),

                                  child: SizedBox(
                                    width: width*0.77,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: TextEditingController(text: "Active".tr()),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(3),
                                        suffixIcon: IconButton(

                                            onPressed: (){},
                                            icon: Icon(Icons.expand_more_rounded,size: 14,color: Color(0Xff999999),)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                        ),


                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.025,),

                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),
                                  child: Text("Email".tr(),style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.03),
                                  ),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),

                                  child: SizedBox(
                                    width: width*0.77,
                                    height: height*0.05,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                        ),


                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.025,),


                                SizedBox(height: height*0.05,),

                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: width*0.05,),

                ],
              ),
              SizedBox(height: height*0.02,),

              Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ongoing courses".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                    ),
                    SizedBox(height: height*0.02,),

                    courseOne,
                    SizedBox(height: height*0.01,),
                    courseOne,
                    SizedBox(height: height*0.01,),
                    courseOne,
                    SizedBox(height: height*0.01,),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
