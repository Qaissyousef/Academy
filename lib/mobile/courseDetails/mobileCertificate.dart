import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class mobileCertificate extends StatefulWidget {
  @override
  _mobileCertificateState createState() => _mobileCertificateState();
}
class _mobileCertificateState extends State<mobileCertificate>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 5000,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TabBar(
              controller: _nestedTabController,
              isScrollable: true,
              labelColor: Color(0xFF222222),
              unselectedLabelColor:Color(0xFF999999),
              indicatorColor: Color(0xFFBD9B60),
              indicatorWeight: 3.0,
              tabs: <Widget>[
                Tab(
                  text: "العربية",
                ),
                Tab(
                  text: "English",
                ),

              ],
            ),
            Container(
              height: 5000 ,
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              child: TabBarView(
                controller: _nestedTabController,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*0.01,),
                        Text("عنوان الدورة",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),
                        SizedBox(
                          width: width*0.95,
                          height: height*0.05,
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),

                        SizedBox(height: height*0.01,),


                        Text("الوصف",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),

                        SizedBox(height: height*0.009,),
                        SizedBox(
                          width: width*0.95,

                          height: height*0.06,
                          child: TextField(
                            maxLines: 2,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),
                        SizedBox(height: height*0.01,),

                        Text("اسم المدرب",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),
                        SizedBox(
                          width: width*0.95,
                          height: height*0.05,
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),
                        SizedBox(height: height*0.01,),

                        Divider(
                          color: Color(0xFF999999),thickness: 0.2,
                        ),

                        SizedBox(height: height*0.01,),
                        Text("الشهادة ",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        Center(child: Image.asset("images/certificate.png",height: height*0.4,)),
                        SizedBox(height: height*0.025,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: height*0.058,
                              width: width*0.4,
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Text('Upload new template'.tr().toString(),strutStyle: StrutStyle(
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

                            SizedBox(
                              height: height*0.058,
                              width: width*0.3,
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Text('Preview'.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                )),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                  side: BorderSide(color: Colors.black,width: 0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),

                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: height*0.162,),
                        Container(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              height: height*0.058,
                              width: width*0.4,
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0.6),
                                  child: Text('Save changes'.tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style: GoogleFonts.barlow(
                                    textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                  )),
                                ),

                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF215732),
                                  onPrimary: Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*0.01,),
                        Text("Course title",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),
                        SizedBox(
                          width: width*0.95,
                          height: height*0.05,
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),

                        SizedBox(height: height*0.01,),


                        Text("Description",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),

                        SizedBox(height: height*0.009,),
                        SizedBox(
                          width: width*0.95,

                          height: height*0.06,
                          child: TextField(
                            maxLines: 2,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),
                        SizedBox(height: height*0.01,),

                        Text("Instructor's name",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        SizedBox(height: height*0.009,),
                        SizedBox(
                          width: width*0.95,
                          height: height*0.05,
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                              ),


                            ),
                          ),
                        ),
                        SizedBox(height: height*0.01,),

                        Divider(
                          color: Color(0xFF999999),thickness: 0.2,
                        ),

                        SizedBox(height: height*0.01,),
                        Text("Certificate",style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                        Center(child: Image.asset("images/certificate.png",height: height*0.4,)),
                        SizedBox(height: height*0.025,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            SizedBox(
                              height: height*0.058,
                              width: width*0.43,
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Text('Upload new template'.tr().toString(),strutStyle: StrutStyle(
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


                            SizedBox(
                              height: height*0.058,
                              width: width*0.3,
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Text('Preview'.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                )),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                  side: BorderSide(color: Colors.black,width: 0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),

                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: height*0.162,),
                        Container(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              height: height*0.058,
                              width: width*0.4,
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0.6),
                                  child: Text('Save changes'.tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style: GoogleFonts.barlow(
                                    textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                  )),
                                ),

                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF215732),
                                  onPrimary: Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
