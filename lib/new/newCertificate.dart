import 'dart:html';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class newcertificate extends StatefulWidget {
  final int Function() onNext;
  const newcertificate({Key? key, required this.onNext}) : super(key: key);

  @override
  State<newcertificate> createState() => _newcertificateState();
}

class _newcertificateState extends State<newcertificate>  with TickerProviderStateMixin{

  late TabController _nestedTabControllerCertificate;
  var img = "assets/images/certificatebg.png";

  @override
  void initState() {
    super.initState();
    _nestedTabControllerCertificate = new TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    _nestedTabControllerCertificate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TabBar(
            controller: _nestedTabControllerCertificate,
            isScrollable: true,
            labelColor: Color(0xFF222222),
            unselectedLabelColor:Color(0xFF999999),
            indicatorColor: Color(0xFFBD9B60),
            indicatorWeight: 5.0,
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
            height: height * 0.8,
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: TabBarView(
              controller: _nestedTabControllerCertificate,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height*0.02,),
                              Text("عنوان الدورة",style: GoogleFonts.barlow(
                                textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                              ),),
                              SizedBox(height: height*0.005,),
                              SizedBox(
                                width: width*0.4,
                                height: height*0.06,
                                child: TextField(
                                  // controller: TextEditingController(text: "المقدمة في تحليلات البيانات"),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                  ),
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

                              SizedBox(height: height*0.02,),
                              SizedBox(height: height*0.02,),
                              Text("نص",style: GoogleFonts.barlow(
                                textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                              ),),

                              SizedBox(height: height*0.005,),
                              SizedBox(
                                width: width*0.4,
                                height: height*0.23,
                                child: TextField(
                                  // controller: TextEditingController(text: "تشهد أكاديمية الصندوق إتمامك الناجح لمقدمة تحليلات البيانات"),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                  ),
                                  maxLines: 40,
                                  maxLength: 100,
                                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
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

                              SizedBox(height: height*0.04,),





                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 1),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Certificate".tr(),style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.01,),
                                  Container(
                                    height:height *0.39,
                                    width: width*0.3,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/images/certificatebg.png"),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  SizedBox(height: height*0.047,),





                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      Text("اسم المدرب",style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                      ),),
                      SizedBox(height: height*0.005,),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width*0.4,
                            height: height*0.06,
                            child: TextField(
                              // controller: TextEditingController(text: "محمد الشمري"),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                              ),
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

                          Padding(
                            padding: const EdgeInsets.only(left: 13.0,right:13.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: () {

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
                                    child: Text('Upload new template'.tr().toString(),strutStyle: StrutStyle(
                                        forceStrutHeight: true
                                    ),style: GoogleFonts.barlow(
                                      textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                    ),),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    primary: Color(0xFFF5F0E5),
                                    onPrimary: Color(0xFF183028),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                  ),
                                ),

                                SizedBox(width: width*0.014,),
                                ElevatedButton(
                                  onPressed: () {

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
                                    child: Text('Preview'.tr().toString(),strutStyle: StrutStyle(
                                        forceStrutHeight: true
                                    ),style: GoogleFonts.barlow(
                                      textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                    ),),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    side: BorderSide(color: Color(0xff999999)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: height*0.04,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width*0.187),
                            child:  ElevatedButton(
                              onPressed: () {

                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
                                child: Text('Save'.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                ),),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                                primary: Color(0xFF215732),
                                onPrimary: Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height*0.02,),
                              Text("Course title",style: GoogleFonts.barlow(
                                textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                              ),),
                              SizedBox(height: height*0.005,),
                              SizedBox(
                                width: width*0.4,
                                height: height*0.06,
                                child: TextField(
                                  // controller: TextEditingController(text: "Introduction to Data Analytics"),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                  ),
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

                              SizedBox(height: height*0.02,),
                              SizedBox(height: height*0.02,),
                              Text("Text",style: GoogleFonts.barlow(
                                textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                              ),),

                              SizedBox(height: height*0.005,),
                              SizedBox(
                                width: width*0.4,
                                height: height*0.23,
                                child: TextField(
                                  // controller: TextEditingController(text: "PIF Academy certifies your successful completition of Introduction To Data Analytics "),
                                  style: GoogleFonts.barlow(
                                    textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                  ),
                                  maxLines: 40,
                                  maxLength: 100,
                                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
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

                              SizedBox(height: height*0.04,),






                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 1),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Certificate".tr(),style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.01,),
                                  Container(
                                    height:height *0.39,
                                    width: width*0.3,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(img),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  SizedBox(height: height*0.047,),




                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      Text("Instructor's name",style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                      ),),
                      SizedBox(height: height*0.005,),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width*0.4,
                            height: height*0.06,
                            child: TextField(
                              // controller: TextEditingController(text: "Mohammad Alsugair"),
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                              ),
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

                          Padding(
                            padding: const EdgeInsets.only(left: 13.0,right:13.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: ()

                                  async{
                                    FileUploadInputElement uploadInput = FileUploadInputElement();
                                    uploadInput.accept = '.csv';
                                    uploadInput.click();

                                    uploadInput.onChange.listen((e) {
                                      // read file content as dataURL
                                      final files = uploadInput.files;
                                      if (files?.length == 1) {
                                        final file = files?[0];
                                        final reader = new FileReader();

                                        reader.onLoadEnd.listen((e) {
                                          print(e);
                                          print('loaded: ${file?.name}');
                                          print('type: ${reader.result.runtimeType}');
                                          print('file size = ${file?.size}');
                                          // _handleResult(reader.result);
                                        });
                                        reader.readAsDataUrl(file!);
                                      }
                                    });
                                    Future.delayed(const Duration(milliseconds: 4000), () {


                                      setState(() {
                                        img = "assets/images/certificate.png";


                                      });

                                    });


                                  },
                                  // {
                                  //
                                  // },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
                                    child: Text('Upload new template'.tr().toString(),strutStyle: StrutStyle(
                                        forceStrutHeight: true
                                    ),style: GoogleFonts.barlow(
                                      textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                    ),),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    primary: Color(0xFFF5F0E5),
                                    onPrimary: Color(0xFF183028),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                  ),
                                ),

                                SizedBox(width: width*0.014,),
                                ElevatedButton(
                                  onPressed: () {

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
                                    child: Text('Preview'.tr().toString(),strutStyle: StrutStyle(
                                        forceStrutHeight: true
                                    ),style: GoogleFonts.barlow(
                                      textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                    ),),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    side: BorderSide(color: Color(0xff999999)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: height*0.04,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width*0.187),
                            child:  ElevatedButton(
                              onPressed: () {
                                widget.onNext();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
                                child: Text('Next'.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                ),),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                                primary: Color(0xFF215732),
                                onPrimary: Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}
