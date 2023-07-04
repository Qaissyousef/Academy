import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class mobileError extends StatefulWidget {
  // const MyHomePage() : super(key: key);



  @override
  State<mobileError> createState() => _mobileErrorState();
}

class _mobileErrorState extends State<mobileError> {

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
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/mobileImages/mobileError.png"),
              fit: BoxFit.fitHeight),
        ),
        child:  WebSmoothScroll(
            controller: _scrollController,
            child: SingleChildScrollView(
              child: Container(
                height: 4000,
                width: width,
                child: Column(
                  children: [
                    SizedBox(height: height*0.65,),

                    SizedBox(
                      height: height*0.05,
                      child: ElevatedButton(
                        onPressed: () {


                        },
                        child: Text('  Home  '.tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ),
                            style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                            )
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFFBD9B60),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),

                            side: BorderSide(
                                width: 0.4,
                                color: Color(0xFFBD9B60)
                            )
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
