import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class mobileHelp extends StatefulWidget {
  const mobileHelp({Key? key}) : super(key: key);

  @override
  State<mobileHelp> createState() => _mobileHelpState();
}

class _mobileHelpState extends State<mobileHelp> {
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

    bool isSwitched = false;

    void toggleSwitch(bool value) {

      if(isSwitched == false)
      {
        setState(() {
          isSwitched = true;
        });
        print('Switch Button is ON');
        // img = 'assets/images/femaleuser.png';

      }
      else
      {
        setState(() {
          isSwitched = false;
        });
        print('Switch Button is OFF');
        // img = 'assets/images/pfp.png';
      }
    }

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

                    child: Text("Help".tr(),style: GoogleFonts.barlow(
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
                      SizedBox(height: height*0.015,),

                      Container(
                        height: height*0.25,
                        width: width*0.9,
                        decoration: BoxDecoration(

                          image:  DecorationImage(
                            image: AssetImage("assets/images/helpCard.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(top: height*0.06,left: width*0.03,right: width*0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(

                                child: Text("Email us".tr(),style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                ),),
                              ),

                              SizedBox(height: height*0.025,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top: height*0.009),
                                    child: SvgPicture.asset("assets/images/message.svg"),
                                  ),
                                  SizedBox(width: width*0.01,),
                                  Container(


                                    child: Text("contact@pif.gov.sa ".tr(),style: GoogleFonts.barlow(
                                      textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,fontSize: 24),
                                    ),),
                                  ),



                                ],

                              ),
                              SizedBox(height: height*0.025,),


                              Text("We will get back to you as soon as we can".tr(),style: GoogleFonts.barlow(
                                textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                              ),),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.015,),
                      Container(
                        height: height*0.25,
                        width: width*0.9,
                        decoration: BoxDecoration(

                          image:  DecorationImage(
                            image: AssetImage("assets/images/helpCard.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(top: height*0.06,left: width*0.03,right: width*0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(

                                child: Text("Call us".tr(),style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                ),),
                              ),

                              SizedBox(height: height*0.025,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top: height*0.009),
                                    child: SvgPicture.asset("images/Call.svg"),
                                  ),
                                  SizedBox(width: width*0.01,),
                                  Container(


                                    child: Text("+96626658430 ".tr(),style: GoogleFonts.barlow(
                                      textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,fontSize: 24),
                                    ),),
                                  ),



                                ],

                              ),
                              SizedBox(height: height*0.025,),


                              Text("We will get back to you as soon as we can".tr(),style: GoogleFonts.barlow(
                                textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                              ),),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.05,),
                      Text(" Or submit the form below".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                      ),),
                      SizedBox(height: height*0.01,),

                      Container(
                        width: width*0.9,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(height: height*0.025,),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),
                                  child: Text("Name".tr(),style: GoogleFonts.barlow(
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
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),
                                  child: Text("Your role ".tr(),style: GoogleFonts.barlow(
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

                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),
                                  child: Text("Description ".tr(),style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.03),
                                  ),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.04,bottom: height*0.01),

                                  child: SizedBox(
                                    width: width*0.77,
                                    height: height*0.05,
                                    child: TextField(
                                      maxLines: 5,
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
                                  padding: EdgeInsets.only(left: width*0.063,right: width*0.045,bottom: height*0.01),
                                  child: SizedBox(
                                    height: height*0.055,
                                    width: width*0.77,
                                    child: ElevatedButton(
                                      onPressed: () {

                                      },
                                      child: Text("Submit".tr().toString(),strutStyle: StrutStyle(
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
                                          )
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
                                //         primary: Color(0xff215732),
                                //         onPrimary: Colors.white ,
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(3),
                                //         ),
                                //         minimumSize: Size(width*0.8,44),
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
