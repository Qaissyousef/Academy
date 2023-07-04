import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class errorpage extends StatefulWidget {
  const errorpage({Key? key}) : super(key: key);

  @override
  State<errorpage> createState() => _errorpageState();
}

class _errorpageState extends State<errorpage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/error.png"),
              fit: BoxFit.fitHeight),
        ),
        child:   Column(
          children: [
            SizedBox(height: height*0.7,),
            ElevatedButton(
              onPressed: () {


              },
              child: Text('Home'.tr().toString(),strutStyle: StrutStyle(
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
                  minimumSize: Size(width*0.1,height*0.07),
                  side: BorderSide(
                      width: 0.4,
                      color: Color(0xFFBD9B60)
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
