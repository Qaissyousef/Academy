// import 'dart:convert';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// import '../models/course_model.dart';
//
//
// class applyCourse extends StatefulWidget {
//   final Course course;
//
//   const applyCourse({Key? key,required this.course}) : super(key: key);
//
//   @override
//   State<applyCourse> createState() => _applyCourseState();
// }
//
// class _applyCourseState extends State<applyCourse> {
//   final myController1 = TextEditingController();
//   final myController2 = TextEditingController();
//   final myController3 = TextEditingController();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     final course =Material(
//       elevation: 1,
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         width: width*0.9,
//         // height: height*0.14,
//         decoration:  BoxDecoration(
//           borderRadius: BorderRadius.circular(150),
//
//           // boxShadow: [
//           //   BoxShadow(
//           //     color: Colors.grey.withOpacity(0.95),
//           //       blurRadius: 35.0,
//           //       offset: Offset(0.0, 0.34)
//           //   ),
//           // ],
//         ),
//
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Container(
//
//
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     SizedBox(width: 14),
//
//                     Padding(
//                         padding: const EdgeInsets.only(top: 23.0,bottom: 15),
//                         child: Image.network(global.apiAddress + 'GetImage/${widget.course.course_image}',height: 80,width: 80,)
//                     ),
//                   ],
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 25.0,left: 15.0,right: 15.0),
//                   child: Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 15,),
//                           Text("${widget.course.course_name}".tr().toString(),strutStyle: StrutStyle(
//                               forceStrutHeight: true
//                           ),style: GoogleFonts.barlow(      textStyle:                    TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
//                           ) ,
//                           SizedBox(height: MediaQuery.of(context).size.height*0.002),
//                           Row(
//                             children: [
//                               Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
//                                   forceStrutHeight: true
//                               ),style:
//                               GoogleFonts.barlow(
//                                 textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
//                               ),
//                               Text("${widget.course.course_instructor}".tr().toString(),strutStyle: StrutStyle(
//                                   forceStrutHeight: true
//                               ),style:
//                               GoogleFonts.barlow(
//                                 textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
//                               ),
//                             ],
//                           ),
//
//
//
//                           SizedBox(height: 15,),
//
//                         ],
//
//                       ),
//                       SizedBox(width: 65,),
//
//
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//
//           ),
//         ),
//       ),
//     );
//     String dropdownvalue = 'Masters degree'.tr().toString();
//
//     // List of items in our dropdown menu
//     var items = [
//       'Masters degree'.tr().toString(),
//       'Item 2',
//       'Item 3',
//       'Item 4',
//       'Item 5',
//     ];
//
//     final degree = Container(
//       height: 32,
//       width: width*0.61,
//       decoration: BoxDecoration(
//         border: Border.all(width: 1.4, color: Color(0xFFEEEEEE)),
//
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//       ),
//
//       child: Row(
//         children: [
//           SizedBox(
//             height: height*0.037,
//             width: width*0.56,
//
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 isExpanded: true,
//                 icon:SvgPicture.asset('assets/images/downArrow.svg', height: 16, width: 16) ,
//                 // Initial Value
//                 value: dropdownvalue,
//                 // Down Arrow Icon
//
//                 // Array list of items
//                 items: items.map((String items) {
//                   return DropdownMenuItem(
//                     value: items,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8.0,right:8.0),
//                       child: Text(items.tr().toString(),style: GoogleFonts.barlow(textStyle:  TextStyle(fontSize: 14,fontWeight: FontWeight.w500))),
//                     ),
//                   );
//                 }).toList(),
//                 // After selecting the desired option,it will
//                 // change button value to selected value
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     dropdownvalue = newValue!;
//                   });
//                 },
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//     Future<http.Response> postRequest () async {
//
//
//       Map data = {
//         "course_id": "${widget.course.course_id}",
//         "user_id": "1",
//         "applicant_title": "teee",
//         "participants_email" : "eed",
//         "applicant_academy_level":dropdownvalue,
//         "applicant_reason":myController1.text,
//         "applicant_ahcievement":myController2.text,
//         "applicant_future":myController3.text,
//         "status":"Pending"
//
//       };
//       //encode Map to JSON
//       var body = json.encode(data);
//
//       var response = await http.post(Uri.parse(global.apiAddress + 'AddApplicants'),
//           headers: {"Content-Type": "application/json"},
//           body: body
//       );
//       print("${response.statusCode}");
//       print("${response.body}");
//       return response;
//     }
//
//     Future<http.Response> UpdateRequest () async {
//
//
//       Map data = {
//         "course_id": 0,
//         "course_name": "string",
//         "course_image": "string",
//         "course_instructor": "string",
//         "applicants": 0,
//         "admission": 0,
//         "applied": 0,
//         "deadline": "string"
//       };
//       //encode Map to JSON
//       var body = json.encode(data);
//
//       var response = await http.post(Uri.parse(global.apiAddress + 'UpdateApp/${widget.course.course_id}'),
//           headers: {"Content-Type": "application/json"},
//           body: body
//       );
//       print("${response.statusCode}");
//       print("${response.body}");
//       return response;
//     }
//
//
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(height * 0.09),
//           child: AppBar(
//               automaticallyImplyLeading: false,
//
//               title:Row(
//                 children: [
//                   IconButton(
//                     icon:  Icon(Icons.arrow_back_ios,size: 18),
//                     onPressed: () {  Navigator.of(context).pop(); },
//                   ),
//                   Text("Apply Now".tr().toString(),strutStyle: StrutStyle(
//                       forceStrutHeight: true
//                   ),style: GoogleFonts.barlow(
//                     textStyle : TextStyle(fontFamily: 'Barlow',fontSize: 22,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFFFFFFF) ),),
//                   ),],
//               ),
//
//               flexibleSpace: Container(
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(context.locale == Locale("en") ? 'assets/images/bgsmall.png' : 'assets/images/topNavArabic.png'),
//                       fit: BoxFit.fill,
//
//                     )
//
//                 ),
//
//               )
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(left: 12,right: 14,top: 10,bottom: 10),
//           child: SingleChildScrollView(
//               child:Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(child: course),
//                   SizedBox(height: height*0.025,),
//                   Padding(
//                       padding: const EdgeInsets.only(left: 12.0,bottom: 4.0,right: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Fill the form to apply".tr().toString(),strutStyle: StrutStyle(
//                               forceStrutHeight: true
//                           ),style:
//                           GoogleFonts.barlow(
//                             textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),
//                           ),
//                         ],
//                       )
//                   ),
//
//
//                   Padding(
//                       padding: const EdgeInsets.only(left: 12.0,bottom: 18.0,top: 18,right: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Your highest academic level ".tr().toString(),strutStyle: StrutStyle(
//                               forceStrutHeight: true
//                           ),style:
//                           GoogleFonts.barlow(
//                             textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
//                           ),
//                           SizedBox(height: height*0.018,),
//                           degree,
//                           SizedBox(height: height*0.025,),
//                           Text("Why do you want to apply to this course? ".tr().toString(),strutStyle: StrutStyle(
//                               forceStrutHeight: true
//                           ),style:
//                           GoogleFonts.barlow(
//                             textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
//                           ),
//                           SizedBox(height: height*0.018,),
//
//                           SizedBox(
//                             width: width*0.9,
//
//                             child: TextField(
//                               controller: myController1,
//
//                               decoration: InputDecoration(
//                                 focusedBorder:OutlineInputBorder(
//                                   borderSide: const BorderSide(color: Color(0xff215732), width: 2.0),
//
//                                 ),
//                                 enabledBorder: const OutlineInputBorder(
//                                   // width: 0.0 produces a thin "hairline" border
//                                   borderSide: const BorderSide(color: Color(0xFFEEEEEE),),
//                                 ),
//                                 border: OutlineInputBorder(),
//
//                               ),
//                               maxLength: 300,
//                               maxLines: 5,
//
//                             ),
//                           ),
//                           SizedBox(height: height*0.025,),
//                           Text("What achievement are you most proud of? ".tr().toString(),strutStyle: StrutStyle(
//                               forceStrutHeight: true
//                           ),style:
//                           GoogleFonts.barlow(
//                             textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
//                           ),
//                           SizedBox(height: height*0.018,),
//
//                           TextField(
//                             controller: myController2,
//
//                             decoration: InputDecoration(
//                               focusedBorder:OutlineInputBorder(
//                                 borderSide: const BorderSide(color: Color(0xff215732), width: 2.0),
//
//                               ),
//                               enabledBorder: const OutlineInputBorder(
//                                 // width: 0.0 produces a thin "hairline" border
//                                 borderSide: const BorderSide(color: Color(0xFFEEEEEE),),
//                               ),
//                               border: OutlineInputBorder(
//
//                               ),
//
//                             ),
//                             maxLength: 300,
//                             maxLines: 5,
//
//
//                           ),
//                           SizedBox(height: height*0.025,),
//                           Text("How this course will help you with your future career? ".tr().toString(),strutStyle: StrutStyle(
//                               forceStrutHeight: true
//                           ),style:
//                           GoogleFonts.barlow(
//                             textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
//                           ),
//                           SizedBox(height: height*0.018,),
//
//                           TextField(
//                             controller: myController3,
//
//                             decoration: InputDecoration(
//                               focusedBorder:OutlineInputBorder(
//                                 borderSide: const BorderSide(color: Color(0xff215732), width: 2.0),
//
//                               ),
//                               enabledBorder: const OutlineInputBorder(
//                                 // width: 0.0 produces a thin "hairline" border
//                                 borderSide: const BorderSide(color: Color(0xFFEEEEEE),),
//                               ),
//                               border: OutlineInputBorder(),
//
//                             ),
//                             maxLength: 300,
//                             maxLines: 5,
//
//
//                           ),
//                           SizedBox(height: height*0.03,),
//
//                         ],
//                       )
//                   ),
//
//                 ],
//               )
//           ),
//         ),
//       ),
//     );
//   }
// }
