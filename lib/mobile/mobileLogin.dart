import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../responsiveness/homeResponsive.dart';

class mobileLogin extends StatefulWidget {
  // const MyHomePage() : super(key: key);



  @override
  State<mobileLogin> createState() => _mobileLoginState();
}

class _mobileLoginState extends State<mobileLogin> {

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
    return Scaffold(

      body: Container(
        // width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
          image: DecorationImage(
              image: MediaQuery.of(context).size.width <= 450 ? AssetImage('assets/mobileImages/mobileloginbg.png') : AssetImage('assets/mobileImages/mobileloginbg2.png'),

              fit: BoxFit.cover),
        ),
        child:  WebSmoothScroll(
          controller: _scrollController,
          child: SingleChildScrollView(
              child: Container(


                child: Column(
                children: [
                  SizedBox(
                      height: height*0.2
                  ),Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*0.1,horizontal: width*0.07),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      height: height*0.6,
                      width: width*0.9,
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: height*0.05,),
                          Center(
                            child: Text("Welcome to PIF Academy App".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: width*0.06),
                            ),),
                          ),
                          SizedBox(height: height*0.05),
                          Padding(
                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04,bottom: height*0.01),

                            child: Text("Email".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04,bottom: height*0.01),

                            child: SizedBox(
                              width: width*0.77,
                              height: height*0.05,
                              child: TextField(
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 0.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color:Colors.black, width: 0.0),
                                  ),


                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height*0.02),
                          Padding(
                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04,bottom: height*0.01),

                            child: Text("Password".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize:14),
                            ),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                            child: SizedBox(
                              width: width*0.77,
                              height: height*0.05,
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 0.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 0.0),
                                  ),


                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height*0.05),
                          Padding(
                            padding: EdgeInsets.only(left: width*0.03,right: width*0.04,bottom: height*0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               Container(
                                 child: Row(
                                   children: [
                                     Checkbox(
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(2.0),
                                         ),
                                         side: MaterialStateBorderSide.resolveWith(
                                               (states) => BorderSide(width: 0.0, color: Colors.black),
                                         ),
                                         value: false, onChanged: (bool? value) {  }),
                                     Text("Remember me".tr(),style: GoogleFonts.barlow(
                                       textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                     ),),
                                   ],
                                 )
                               ),

                                Text("Forgot password?".tr(),style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                ),),
                              ],
                            ),

                          ),
                          SizedBox(height: height*0.02),

                          Padding(
                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04,bottom: height*0.01),

                            child: SizedBox(
                              width: width*0.77,
                              height: height*0.05,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  HomeResponsive()),
                                  );
                                },
                                child: Text('Log In'.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
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
                          SizedBox(height: height*0.02),


                        ],
                      ),
                    ),
                  ),

                ],
            ),
              ),

          )

        ),
      ),
      // body:
    );
  }
}
