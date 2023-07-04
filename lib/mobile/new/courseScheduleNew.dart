import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class mobileScheduleNew extends StatefulWidget {
  const mobileScheduleNew({Key? key}) : super(key: key);

  @override
  State<mobileScheduleNew> createState() => _mobileScheduleNewState();
}

class _mobileScheduleNewState extends State<mobileScheduleNew> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final num = SizedBox(
        width: width*0.5,
        height: height*0.058,
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.add_circle_outline,size: 16,color: Color(0xFF999999),),
              SizedBox(width: 12,),

              Text("Add new section".tr().toString(),strutStyle: StrutStyle(
                  forceStrutHeight: true
              )),
            ],
          ),
          onPressed: (){
            print("You pressed Icon Elevated Button");
          },
          // icon: Icon(Icons.filter_list),
          //  //label text
          style: ElevatedButton.styleFrom(
              elevation: 0,
              side: BorderSide(width: 1, color: Color(0xff999999)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
              primary: Colors.transparent ,//elevated btton background color
              onPrimary: Color(0xff999999),
              minimumSize: Size(60,43)
          ),
        ));

    final card1 = Card(
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

                Text("Subject name ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Colors.black ),),
                ),
                SizedBox(width: 10,),
                ImageIcon(AssetImage("images/pencil.png"),color: Color(0xffBD9B60),),
                SizedBox(width: 250,),
                ImageIcon(AssetImage("images/forward.png"),color: Color(0xff999999),),

              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 25,
              color: Color(0xffffffff),
              child: Row(
                children: [
                  Container(
                    width: width*0.44,
                    child: Text("Schedule".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("11/05/2022 - 16/05/2022".tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                        ),
                        ImageIcon(AssetImage("images/calendar.png"),color: Color(0xff999999),),

                      ],
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
                children: [
                  Container(
                    width: width*0.45,
                    child: Text("Instructor ".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("Mohammad Abdulrahman ".tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                        ),
                        SizedBox(width: width*0.015,),
                        Icon(Icons.expand_more_rounded,size: 13,color: Color(0xFF222222),)
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
                children: [
                  Container(
                    width: width*0.69,
                    child: Text("Attachements ".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10,),

            Container(
              height: 25,
              child: Row(
                children: [

                  Text("doc1.pdf".tr().toString(),strutStyle: StrutStyle(
                      forceStrutHeight: true
                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Colors.black),),
                  ),
                  SizedBox(width: 12,),
                  Image.asset("images/bin.png",color: Color(0xffD80000),),
                  SizedBox(width: 12,),
                  Icon(Icons.add_circle_outline,size: 16,)
                ],
              ),
            ),


          ],
        ),
      ),
    );

    final card2= Card(
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

                Text("Subject name ".tr().toString(),strutStyle: StrutStyle(
                    forceStrutHeight: true
                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Colors.black ),),
                ),
                SizedBox(width: 10,),
                ImageIcon(AssetImage("images/pencil.png"),color: Color(0xffBD9B60),),
                SizedBox(width: 250,),
                ImageIcon(AssetImage("images/forward.png"),color: Color(0xff999999),),

              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 25,
              color: Color(0xffffffff),
              child: Row(
                children: [
                  Container(
                    width: width*0.76,
                    child: Text("EST Duration".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [

                        ImageIcon(AssetImage("images/calendar.png"),color: Color(0xff999999),),

                      ],
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
                children: [
                  Container(
                    width: width*0.75,
                    child: Text("Instructor ".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("-".tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                        ),
                        SizedBox(width: width*0.015,),
                        Icon(Icons.expand_more_rounded,size: 13,color: Color(0xFF222222),)
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
                children: [
                  Container(
                    width: width*0.69,
                    child: Text("Dedicated files ".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10,),

            Container(
              height: 25,
              child: Row(
                children: [

                  Icon(Icons.add_circle_outline,size: 16,)
                ],
              ),
            ),


          ],
        ),
      ),
    );
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0,right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.02,),
                Text("Course Duration".tr(),style: GoogleFonts.barlow(
                  textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 18),
                ),),
                SizedBox(height: height*0.025,),

                Text("Start date".tr(),style: GoogleFonts.barlow(
                  textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                ),),
                SizedBox(height: height*0.009,),

                SizedBox(
                  width: width*0.95,
                  height: height*0.05,
                  child: TextField(
                    controller: TextEditingController(text: "06/23/2022".tr()),
                    decoration: InputDecoration(
                      suffixIcon:  ImageIcon(AssetImage("images/calendar.png"),
                          size: 14,
                          color: Color(0xFF999999)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                      ),


                    ),
                  ),
                ),

                SizedBox(height: height*0.02,),
                Text("End date".tr(),style: GoogleFonts.barlow(
                  textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                ),),
                SizedBox(height: height*0.009,),

                SizedBox(
                  width: width*0.95,

                  height: height*0.05,
                  child: TextField(
                    controller: TextEditingController(text: "06/28/2022".tr()),

                    decoration: InputDecoration(
                      suffixIcon:  ImageIcon(AssetImage("images/calendar.png"),
                          size: 14,
                          color: Color(0xFF999999)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                      ),


                    ),
                  ),
                ),
                SizedBox(height: height*0.02,),

                num,
                SizedBox(height: height*0.2,),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
