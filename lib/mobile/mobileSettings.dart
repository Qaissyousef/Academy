import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import '../pfpimg.dart';

class mobileSettings extends StatefulWidget {
  const mobileSettings({Key? key}) : super(key: key);

  @override
  State<mobileSettings> createState() => _mobileSettingsState();
}

class _mobileSettingsState extends State<mobileSettings> {
  late ScrollController _scrollController;


  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }
  String img= 'assets/mobileImages/mobilepfp.png';
  String? dropdownvalue = 'English';
  Locale? lang = Locale("en");
  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
      });
      print('Switch Button is ON');
      // img = 'assets/images/noFace.png';
      // num = 5.0;
      // num2 = 7.0;

    }
    else
    {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
      // img = "assets/images/pfpIcons.png";
      // num = 1.5;
      // num2 = 4.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final language = Container(
      height: height*0.3,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: InputDecoration.collapsed(hintText: ''),
          icon:Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),

          iconSize: 4.0,

          // Initial Value
          value: lang,
          // Down Arrow Icon

          // Array list of items
          items: [
            DropdownMenuItem( value: Locale( 'en' ),
              child: Text( '   English' , style: GoogleFonts.barlow(textStyle:  TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),),),
            DropdownMenuItem( value: Locale( 'ar' ),

              child: Text( '  العربية'),),

          ],

          onChanged: (Locale? newValue) {
            setState(() {

              dropdownvalue="ej";
              context.setLocale(newValue!);

              context.locale = newValue!;

            });
          },
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

                    child: Text("Settings".tr(),style: GoogleFonts.barlow(
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
      body: WebSmoothScroll(
        controller: _scrollController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: width*0.05,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height*0.05,),
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
                                        fit: BoxFit.fitHeight,
                                      ),

                                    ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: height*0.03,),
                                      Container(
                                        width: width*0.4,
                                        height: height*0.2,
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image:  isSwitched ?  AssetImage("assets/images/noFace.png"):AssetImage("assets/images/pfpIcons.png"),
                                            fit: BoxFit.contain,
                                          ),

                                        ),
                                      ),
                                      // Image.asset(img,scale: 0.78,),
                                      SizedBox(height: height*0.06,),

                                      Text("Mohammad Alsugair".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 20),
                                      ),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height*0.025,),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),
                                  child: Text("Full name".tr(),style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
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
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),
                                  child: Text("Email".tr(),style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
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

                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),
                                  child: Text("Language".tr(),style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),

                                  child: Container(
                                      width: width*0.77,
                                      height: height*0.05,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFFEEEEEE))
                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.only(top: height*0.015),
                                        child: language,
                                      )
                                  ),
                                ),
                                SizedBox(height: height*0.025,),

                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.045,bottom: height*0.01),

                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Color(0xFFEEEEEE))
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Container(

                                          child: Text("  Hide Profile Picture".tr(),style: GoogleFonts.barlow(
                                            textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                          ),),
                                        ),
                                        SizedBox(
                                            height: height* 0.05,
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Switch(
                                                value: isSwitched,
                                                onChanged: toggleSwitch,

                                                activeColor: Colors.white,
                                                activeTrackColor: Color(0xFFBD9B60),
                                                inactiveThumbColor: Color(0xFFBD9B60),
                                                inactiveTrackColor: Color(0xFFE6E6E6),
                                              ),
                                            )

                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.025,),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),

                                  child: SizedBox(
                                    height: height*0.055,
                                    width: width*0.8,
                                    child: ElevatedButton(
                                      onPressed: () {

                                      },
                                      child: Text('Change password'.tr().toString(),strutStyle: StrutStyle(
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
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(left: width*0.063,right: width*0.045,bottom: height*0.01),
                                //
                                //   child:  ElevatedButton(
                                //     onPressed: () {},
                                //     child: Text('Change password'.tr().toString(),strutStyle: StrutStyle(
                                //         forceStrutHeight: true
                                //     )),
                                //     style: ElevatedButton.styleFrom(
                                //         primary: Color(0xffF5F0E5),
                                //         onPrimary: Colors.black ,
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(3),
                                //         ),
                                //         minimumSize: Size(width*0.8,41),
                                //         side: BorderSide(
                                //             width: 0.4,
                                //             color: Color(0xffF5F0E5)
                                //         )
                                //     ),
                                //   ),
                                // ),
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
            ],
          ),
        ),
      ),
    );
  }
}
