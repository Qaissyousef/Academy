// import 'dart:convert';
// import 'dart:html';
// import 'dart:typed_data';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io' as io;
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// class uploadtest extends StatefulWidget {
//   const uploadtest({Key? key}) : super(key: key);
//
//   @override
//   State<uploadtest> createState() => _uploadtestState();
// }
//
// class _uploadtestState extends State<uploadtest> {
//   late List<int> _selectedFile;
//   late Uint8List _bytesData;
//   int current_course_id = 3;
//   final myControllerSubject = TextEditingController();
//   final myControllerTitle = TextEditingController();
//   final myControllerAuthor = TextEditingController();
//
//   void _handleResult(Object? result) {
//     setState(()  {
//       _bytesData = Base64Decoder().convert(result.toString().split(",").last);
//       _selectedFile = _bytesData;
//
//
//
//
//     });
//
//
//   }
//
//   Future<String> makeRequest() async {
//     var url = Uri.parse(
//         global.apiAddress + "AddFile");
//     var request = new http.MultipartRequest("POST", url);
//     request.fields['material_id'] = 'blah';
//     request.fields['title'] = myControllerTitle.text;
//     request.fields['author'] = myControllerAuthor.text;
//     request.fields['file_name'] = 'blah';
//     request.fields['course_id'] = 'blah';
//
//
//     request.files.add(await http.MultipartFile.fromBytes('fileModel', _selectedFile,
//
//         contentType: new MediaType('application', 'octet-stream'),
//         filename: 'hhh'));
//
//     request.send().then((response) {
//       print("i am hereee makerequest");
//       print(response.statusCode);
//       if (response.statusCode == 200) print("Uploaded!");
//     });
//     return "finished";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Column(children: [
//         ElevatedButton(
//           onPressed: () async{
//             FileUploadInputElement uploadInput = FileUploadInputElement();
//
//             uploadInput.click();
//
//             uploadInput.onChange.listen((e) {
//               // read file content as dataURL
//               final files = uploadInput.files;
//               if (files?.length == 1) {
//                 final file = files?[0];
//                 final reader = new FileReader();
//
//                 reader.onLoadEnd.listen((e) async {
//                   print(e);
//                   print('loaded: ${file?.name}');
//                   print('type: ${reader.result.runtimeType}');
//                   print('file size = ${file?.size}');
//                   _handleResult(reader.result);
//                   print("i reached here");
//                   makeRequest();
//
//                 });
//                 reader.readAsDataUrl(file!);
//               }
//             });
//
//
//
//           },
//
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
//
//             child: Text('Select file'.toString(),strutStyle: StrutStyle(
//                 forceStrutHeight: true
//             )),
//           ),
//           style: ElevatedButton.styleFrom(
//             elevation: 0.0,
//             shadowColor: Colors.transparent,
//             primary: Color(0xFFF5F0E5),
//             onPrimary: Color(0xFF183028),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//
//           ),
//         ),
//         SizedBox(
//           height: height*0.05,
//
//           child: ElevatedButton(
//             onPressed: () async{
//               FileUploadInputElement uploadInput = FileUploadInputElement();
//
//               uploadInput.click();
//
//               uploadInput.onChange.listen((e) {
//                 // read file content as dataURL
//                 final files = uploadInput.files;
//                 if (files?.length == 1) {
//                   final file = files?[0];
//                   final reader = new FileReader();
//
//                   reader.onLoadEnd.listen((e) async {
//                     print(e);
//                     print('loaded: ${file?.name}');
//                     print('type: ${reader.result.runtimeType}');
//                     print('file size = ${file?.size}');
//                     _handleResult(reader.result);
//                     print("i reached here");
//
//                   });
//                   reader.readAsDataUrl(file!);
//                   myControllerSubject.text = file.name;
//                 }
//               });
//
//
//
//             },
//             child: Text('Browse'.tr().toString(),strutStyle: StrutStyle(
//                 forceStrutHeight: true
//             ),style: GoogleFonts.barlow(
//               textStyle: TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
//             ),),
//             style: ElevatedButton.styleFrom(
//               elevation: 0.0,
//               shadowColor: Colors.transparent,
//               primary: Color(0xFFF5F0E5),
//               onPrimary: Color(0xFF183028),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(7),
//               ),
//
//             ),
//           ),
//         ),
//         TextField(
//           controller: myControllerSubject,
//           decoration: InputDecoration(
//             hintText: 'Subject',
//             hintStyle: GoogleFonts.barlow(
//               textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
//             ),
//             contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 7),
//
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
//             ),
//
//
//           ),
//         ),
//         QrImage(
//           data: "${current_course_id.toString() } and date: ${DateTime.now().toString()}",
//           version: QrVersions.auto,
//           size: 200.0,
//         ),
//       ],),
//
//     );
//   }
// }
//
// // import 'dart:html';
// // import 'dart:typed_data';
// //
// // import 'package:cross_scroll/cross_scroll.dart';
// // import 'package:easy_localization/easy_localization.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:pif_admin_dashboard/Courses.dart';
// // import 'package:web_smooth_scroll/web_smooth_scroll.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // class testing extends StatefulWidget {
// //   final int cid;
// //
// //
// //   const testing({Key? key, required this.cid}) : super(key: key);
// //
// //   @override
// //   _testingState createState() => _testingState();
// // }
// // class _testingState extends State<testing>
// //     with TickerProviderStateMixin {
// //   late TabController _nestedTabController;
// //   late ScrollController _scrollController;
// //
// //
// //
// //   final myController1 = TextEditingController();
// //   final myController2 = TextEditingController();
// //   final myController3 = TextEditingController();
// //   final myController4 = TextEditingController();
// //
// //   final myControllera1 = TextEditingController();
// //   final myControllera2 = TextEditingController();
// //   final myControllera3 = TextEditingController();
// //   final myControllera4 = TextEditingController();
// //
// //
// //     late List<int> _selectedFile;
// //   late Uint8List _bytesData;
// //   int current_course_id = 3;
// //   bool imgselect = false;
// //
// //
// //   void _handleResult(Object? result) {
// //     setState(()  {
// //       _bytesData = Base64Decoder().convert(result.toString().split(",").last);
// //       _selectedFile = _bytesData;
// //
// //
// //
// //
// //     });
// //
// //
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _nestedTabController = new TabController(length: 2, vsync: this);
// //     _scrollController = ScrollController();
// //     // futureCourse = fetchCourse();
// //
// //   }
// //   @override
// //   void dispose() {
// //     super.dispose();
// //     _nestedTabController.dispose();
// //   }
// //
// //   var fieldVisibility = true;
// //   var fieldVisibility2 = true;
// //   List<Widget> _instructorList = [];
// //
// //   var img = "assets/images/coursebg.png";
// //   @override
// //   Widget build(BuildContext context) {
// //     Future<http.Response> postAboutSection () async {
// //
// //
// //
// //       Map data =
// //       {
// //         "description": myController4.text,
// //         "duration": "15 hours per month etc etc",
// //         "course_name": myController1.text,
// //         "course_instuctor": "string",
// //         "course_image": "string",
// //         "course_id": widget.cid,
// //         "category": myController2.text,
// //         "maxParticipants": myController3.text,
// //
// //
// //       };
// //
// //       //encode Map to JSON
// //       var body = json.encode(data);
// //       var response = await http.post(Uri.parse(global.apiAddress + 'AddAboutC'),
// //
// //           headers: {
// //             'Content-Type': 'application/json',
// //             "Access-Control-Allow-Origin": "*", // Required for CORS support to work
// //             "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
// //             "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
// //             "Access-Control-Allow-Methods": "POST, OPTIONS"
// //           },
// //
// //           body: body
// //       );
// //       print("${response.statusCode}");
// //       print("${response.body}");
// //       return response;
// //     }
// //     Future<http.Response> updateRequestName () async {
// //
// //
// //       Map data = {
// //         "course_name": myController1.text,
// //       };
// //       //encode Map to JSON
// //       var body = json.encode(data);
// //
// //       var response = await http.post(Uri.parse(global.apiAddress + 'UpdateAboutName/22'),
// //           headers: {"Content-Type": "application/json"},
// //           body: body
// //       );
// //       print("${response.statusCode}");
// //       print("${response.body}");
// //       return response;
// //     }
// //
// //
// //     double height = MediaQuery.of(context).size.height;
// //     double width = MediaQuery.of(context).size.width;
// //     Widget _card() {
// //       return  Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Container(
// //             decoration: BoxDecoration(
// //                 border: Border.all(color: Color(0xFFEEEEEE))
// //             ),
// //             width: width*0.449,
// //             height: 45,
// //
// //             child: TextField(
// //               decoration: InputDecoration(
// //                   border: InputBorder.none,
// //                   contentPadding: EdgeInsets.all(10), //Change this value to custom as you like
// //                   hintText: '',
// //                   hintStyle: TextStyle(
// //                     color: Color(0xFFF00),
// //                   )),
// //
// //
// //             ),
// //           ),
// //           SizedBox(width: width*0.005,),
// //           Container(
// //             height: 45,
// //
// //
// //
// //
// //             decoration: BoxDecoration(
// //                 color: Color(0xFFFFE5E6),
// //                 borderRadius: BorderRadius.circular(5)
// //
// //             ),
// //             child: GestureDetector(
// //               onTap: () {
// //                 setState(() {
// //                   _instructorList.removeLast();
// //                 });
// //               },
// //               child:SizedBox(
// //
// //
// //
// //
// //                 child:Padding(
// //                   padding:  EdgeInsets.symmetric(horizontal: 8.0),
// //                   child: SvgPicture.asset("assets/images/red_bin.svg",color: Color(0xFFF64747)),
// //                 ),
// //               ),
// //             ),
// //           )
// //         ],
// //       );
// //     }
// //
// //     return Card(
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         mainAxisAlignment: MainAxisAlignment.start,
// //         children: <Widget>[
// //           TabBar(
// //             controller: _nestedTabController,
// //             isScrollable: true,
// //             labelColor: Color(0xFF222222),
// //             unselectedLabelColor:Color(0xFF999999),
// //             indicatorColor: Color(0xFFBD9B60),
// //             indicatorWeight: 5.0,
// //             indicatorPadding: EdgeInsets.zero,
// //             tabs: <Widget>[
// //               Tab(
// //                 text: "العربية",
// //               ),
// //               Tab(
// //                 text: "English",
// //               ),
// //
// //             ],
// //           ),
// //           Container(
// //             height: height * 0.8,
// //             margin: EdgeInsets.only(left: 16.0, right: 16.0),
// //             child: TabBarView(
// //               controller: _nestedTabController,
// //               children: <Widget>[
// //                 WebSmoothScroll(
// //                     controller: _scrollController,
// //
// //                     child: SingleChildScrollView(
// //                       child:Container(
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.start,
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             SizedBox(height: height*0.02,),
// //
// //                             Container(
// //                               height: height*0.45,
// //
// //                               child: Row(
// //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //
// //                                 children: [
// //                                   Column(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                     children: [
// //
// //                                       Text("عنوان الدورة",style: GoogleFonts.barlow(
// //                                         textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                       ),),
// //                                       SizedBox(height: height*0.005,),
// //                                       SizedBox(
// //                                         width: width*0.476,
// //                                         height: height*0.06,
// //                                         child: TextField(
// //                                           controller: TextEditingController(text: "المقدمة في تحليلات البيانات"),
// //                                           style: GoogleFonts.barlow(
// //                                             textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
// //                                           ),
// //                                           decoration: InputDecoration(
// //                                             contentPadding: EdgeInsets.all(10.0),
// //
// //                                             focusedBorder: OutlineInputBorder(
// //                                               borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                             ),
// //                                             enabledBorder: OutlineInputBorder(
// //                                               borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                             ),
// //
// //
// //                                           ),
// //                                         ),
// //                                       ),
// //
// //                                       SizedBox(height: height*0.02,),
// //                                       Text("الفئة",style: GoogleFonts.barlow(
// //                                         textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                       ),),
// //                                       SizedBox(height: height*0.005,),
// //                                       SizedBox(
// //                                         width: width*0.476,
// //                                         height: height*0.06,
// //
// //                                         child: TextField(
// //                                           controller: TextEditingController(text: "ورشة عمل"),
// //
// //                                           decoration: InputDecoration(
// //                                             suffixIcon: IconButton(
// //                                                 onPressed: (){},
// //                                                 icon: Icon(Icons.expand_more,size: 13,)
// //                                             ),
// //                                             focusedBorder: OutlineInputBorder(
// //                                               borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                             ),
// //                                             enabledBorder: OutlineInputBorder(
// //                                               borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                             ),
// //
// //
// //                                           ),
// //                                         ),
// //                                       ),
// //
// //                                       SizedBox(height: height*0.02,),
// //                                       Text("الوصف",style: GoogleFonts.barlow(
// //                                         textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                       ),),
// //
// //                                       SizedBox(height: height*0.005,),
// //                                       SizedBox(
// //                                         width: width*0.476,
// //                                         height: height*0.15,
// //                                         child: TextField(
// //                                           controller: TextEditingController(text: "برنامج تمهيدي مناسب لجميع موظفي الأكاديمية، لا سيما أولئك الذين لديهم خبرة قليلة أو معدومة في البيانات التي تغطي مبادئ التحليلات وأنواع البيانات وأدوات تحليل البيانات والتقنيات وتصور البيانات ولوحات المعلومات."),
// //                                           style: GoogleFonts.barlow(
// //                                             textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
// //                                           ),
// //                                           maxLines: 20,
// //                                           decoration: InputDecoration(
// //                                             focusedBorder: OutlineInputBorder(
// //                                               borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                             ),
// //                                             enabledBorder: OutlineInputBorder(
// //                                               borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                             ),
// //
// //
// //                                           ),
// //                                         ),
// //                                       ),
// //
// //
// //
// //
// //                                     ],
// //                                   ),
// //                                   // SizedBox(width: width*0.01,),
// //
// //                                   Container(
// //                                     child: Column(
// //                                       mainAxisAlignment: MainAxisAlignment.start,
// //                                       crossAxisAlignment: CrossAxisAlignment.start,
// //                                       children: [
// //                                         Text("Course image",style: GoogleFonts.barlow(
// //                                           textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                         ),),
// //                                         SizedBox(height: height*0.01,),
// //                                         Container(
// //                                           height:height *0.37,
// //                                           width: width*0.2,
// //                                           decoration: BoxDecoration(
// //                                             image: DecorationImage(
// //                                                 image: AssetImage("assets/images/coursebg.png"),
// //                                                 fit: BoxFit.fill),
// //                                           ),
// //                                         ),
// //
// //
// //                                       ],
// //                                     ),
// //                                   ),
// //
// //
// //
// //                                 ],
// //                               ),
// //                             ),
// //
// //
// //                             Text("الحد الأقصى لعدد المشاركين",style: GoogleFonts.barlow(
// //                               textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                             ),),
// //                             SizedBox(height: height*0.005,),
// //                             Row(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Container(
// //
// //                                   child: SizedBox(
// //                                     width: width*0.476,
// //                                     height: height*0.06,
// //
// //                                     child: TextField(
// //                                       controller: TextEditingController(text: "50"),
// //                                       style: GoogleFonts.barlow(
// //                                         textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
// //                                       ),
// //                                       decoration: InputDecoration(
// //                                         suffixIcon: IconButton(
// //                                             onPressed: (){},
// //                                             icon: Icon(Icons.unfold_more,size: 13,)
// //                                         ),
// //                                         focusedBorder: OutlineInputBorder(
// //                                           borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                         ),
// //                                         enabledBorder: OutlineInputBorder(
// //                                           borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                         ),
// //
// //
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 Row(
// //                                   children: [
// //                                     SizedBox(
// //                                       width: width *0.11,
// //
// //
// //                                       child: ElevatedButton(
// //                                         onPressed: () async{
// //                                           FileUploadInputElement uploadInput = FileUploadInputElement();
// //                                           uploadInput.accept = '.csv';
// //                                           uploadInput.click();
// //
// //                                           uploadInput.onChange.listen((e) {
// //                                             // read file content as dataURL
// //                                             final files = uploadInput.files;
// //                                             if (files?.length == 1) {
// //                                               final file = files?[0];
// //                                               final reader = new FileReader();
// //
// //                                               reader.onLoadEnd.listen((e) {
// //                                                 print(e);
// //                                                 print('loaded: ${file?.name}');
// //                                                 print('type: ${reader.result.runtimeType}');
// //                                                 print('file size = ${file?.size}');
// //                                                 // _handleResult(reader.result);
// //                                               });
// //                                               reader.readAsDataUrl(file!);
// //                                             }
// //                                           });
// //
// //
// //                                         },
// //                                         child: Padding(
// //                                           padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
// //
// //                                           child: Text('Select image'.tr().toString(),strutStyle: StrutStyle(
// //                                               forceStrutHeight: true
// //                                           )),
// //                                         ),
// //                                         style: ElevatedButton.styleFrom(
// //                                           elevation: 0.0,
// //                                           shadowColor: Colors.transparent,
// //                                           primary: Color(0xFFF5F0E5),
// //                                           onPrimary: Color(0xFF183028),
// //                                           shape: RoundedRectangleBorder(
// //                                             borderRadius: BorderRadius.circular(8),
// //                                           ),
// //
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     SizedBox(width: width*0.014,),
// //                                     SizedBox(
// //                                       width: width *0.08,
// //
// //
// //
// //                                       child: ElevatedButton(
// //                                         onPressed: () {
// //
// //                                         },
// //                                         child: Padding(
// //                                           padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
// //                                           child: Text('Delete image'.tr().toString(),strutStyle: StrutStyle(
// //                                               forceStrutHeight: true
// //                                           )),
// //                                         ),
// //                                         style: ElevatedButton.styleFrom(
// //                                           primary: Color(0xFFFFE5E5),
// //                                           elevation: 0.0,
// //                                           shadowColor: Colors.transparent,
// //                                           onPrimary: Color(0xFF4A0303),
// //                                           shape: RoundedRectangleBorder(
// //                                             borderRadius: BorderRadius.circular(8),
// //                                           ),
// //
// //                                         ),
// //                                       ),
// //                                     ),
// //
// //                                   ],
// //                                 ),
// //                               ],
// //                             ),
// //                             SizedBox(height: height*0.04,),
// //
// //                             Text("المدربين",style: GoogleFonts.barlow(
// //                               textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                             ),),
// //                             SizedBox(height: height*0.005,),
// //                             ListView.builder(
// //                               shrinkWrap: true,
// //                               itemCount: _instructorList.length,
// //                               itemBuilder: (context, index) {
// //                                 return Column(
// //                                   children: [
// //                                     _instructorList[index],
// //                                     SizedBox(height: height*0.02,),
// //
// //                                   ],
// //                                 );
// //                               },
// //                             ),
// //                             // Visibility(
// //                             //   visible: fieldVisibility,
// //                             //   child: Row(
// //                             //     crossAxisAlignment: CrossAxisAlignment.start,
// //                             //     children: [
// //                             //       Container(
// //                             //         decoration: BoxDecoration(
// //                             //             border: Border.all(color: Color(0xFFEEEEEE))
// //                             //         ),
// //                             //         width: width*0.449,
// //                             //         height: 45,
// //                             //
// //                             //         child: TextField(
// //                             //           decoration: InputDecoration.collapsed(hintText: ''),
// //                             //
// //                             //         ),
// //                             //       ),
// //                             //       SizedBox(width: width*0.005,),
// //                             //       Container(
// //                             //         height: 45,
// //                             //
// //                             //
// //                             //
// //                             //
// //                             //         decoration: BoxDecoration(
// //                             //             color: Color(0xFFFFE5E6),
// //                             //             borderRadius: BorderRadius.circular(5)
// //                             //
// //                             //         ),
// //                             //         child: GestureDetector(
// //                             //           onTap: () {
// //                             //             setState(() {
// //                             //               fieldVisibility = !fieldVisibility;
// //                             //             });
// //                             //           },
// //                             //           child:SizedBox(
// //                             //
// //                             //
// //                             //
// //                             //
// //                             //             child:Padding(
// //                             //               padding:  EdgeInsets.symmetric(horizontal: 8.0),
// //                             //               child: SvgPicture.asset("assets/images/red_bin.svg",color: Color(0xFFF64747)),
// //                             //             ),
// //                             //           ),
// //                             //         ),
// //                             //       )
// //                             //     ],
// //                             //   ),
// //                             // ),
// //
// //                             SizedBox(height: height*0.04,),
// //
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Container(
// //                                   child: ElevatedButton(
// //                                     onPressed: () {
// //                                       setState(() {
// //                                         _instructorList.add(_card());
// //                                       });
// //                                     },
// //                                     child: Padding(
// //                                       padding: EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
// //                                       child: Row(
// //                                         children: [
// //                                           Text('Add new instructor  '.tr().toString(),strutStyle: StrutStyle(
// //                                               forceStrutHeight: true
// //                                           )),
// //                                           Icon(Icons.add_circle_outline,size: 16,)
// //                                         ],
// //                                       ),
// //                                     ),
// //                                     style: ElevatedButton.styleFrom(
// //                                       primary: Color(0xFFF5F0E5),
// //                                       onPrimary: Color(0xFF183028),
// //                                       shape: RoundedRectangleBorder(
// //                                         borderRadius: BorderRadius.circular(4),
// //                                       ),
// //
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 Container(
// //                                   child: ElevatedButton(
// //                                     onPressed: () {
// //                                       postAboutSection();
// //                                       updateRequestName();
// //
// //                                     },
// //                                     child: Padding(
// //                                       padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
// //                                       child: Text('Save changes'.tr().toString(),strutStyle: StrutStyle(
// //                                           forceStrutHeight: true
// //                                       ),style: GoogleFonts.barlow(
// //                                         textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
// //                                       ),),
// //                                     ),
// //                                     style: ElevatedButton.styleFrom(
// //                                       elevation: 0.0,
// //                                       shadowColor: Colors.transparent,
// //                                       primary: Color(0xFF215732),
// //                                       onPrimary: Color(0xFFFFFFFF),
// //                                       shape: RoundedRectangleBorder(
// //                                         borderRadius: BorderRadius.circular(8),
// //                                       ),
// //
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ],
// //
// //                         ),
// //                       ),
// //                     )
// //
// //                 ),
// //                 WebSmoothScroll(
// //                   controller: _scrollController,
// //
// //                   child: SingleChildScrollView(
// //                     child: Container(
// //                       child:Column(
// //                         mainAxisAlignment: MainAxisAlignment.start,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           SizedBox(height: height*0.02,),
// //
// //                           Container(
// //                             height: height*0.45,
// //
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //
// //                               children: [
// //                                 Column(
// //                                   mainAxisAlignment: MainAxisAlignment.start,
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //
// //                                     Text("Course title",style: GoogleFonts.barlow(
// //                                       textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                     ),),
// //                                     SizedBox(height: height*0.005,),
// //                                     SizedBox(
// //                                       width: width*0.476,
// //                                       height: height*0.06,
// //                                       child: TextField(
// //                                         controller: myController1,
// //                                         style: GoogleFonts.barlow(
// //                                           textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
// //                                         ),
// //                                         decoration: InputDecoration(
// //
// //                                           contentPadding: EdgeInsets.all(10.0),
// //
// //                                           focusedBorder: OutlineInputBorder(
// //                                             borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                           ),
// //                                           enabledBorder: OutlineInputBorder(
// //                                             borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                           ),
// //
// //
// //                                         ),
// //                                       ),
// //                                     ),
// //
// //                                     SizedBox(height: height*0.02,),
// //                                     Text("Category",style: GoogleFonts.barlow(
// //                                       textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                     ),),
// //                                     SizedBox(height: height*0.005,),
// //                                     SizedBox(
// //                                       width: width*0.476,
// //                                       height: height*0.06,
// //
// //                                       child: TextField(
// //                                         controller: myController2,
// //
// //                                         decoration: InputDecoration(
// //                                           // hintText: "${snapshot.data![index].category}",
// //                                           focusedBorder: OutlineInputBorder(
// //                                             borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                           ),
// //                                           enabledBorder: OutlineInputBorder(
// //                                             borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                           ),
// //
// //
// //                                         ),
// //                                       ),
// //                                     ),
// //
// //                                     SizedBox(height: height*0.02,),
// //                                     Text("Description",style: GoogleFonts.barlow(
// //                                       textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                     ),),
// //
// //                                     SizedBox(height: height*0.005,),
// //                                     SizedBox(
// //                                       width: width*0.476,
// //                                       height: height*0.15,
// //                                       child: TextField(
// //                                         controller: myController4,
// //                                         style: GoogleFonts.barlow(
// //                                           textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
// //                                         ),
// //                                         maxLines: 20,
// //                                         decoration: InputDecoration(
// //                                           // hintText: ("${snapshot.data![index].description}"),
// //                                           focusedBorder: OutlineInputBorder(
// //                                             borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                           ),
// //                                           enabledBorder: OutlineInputBorder(
// //                                             borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                           ),
// //
// //
// //                                         ),
// //                                       ),
// //                                     ),
// //
// //
// //
// //
// //                                   ],
// //                                 ),
// //                                 // SizedBox(width: width*0.01,),
// //
// //                                 Container(
// //                                   child: Column(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                     children: [
// //                                       Text("Course image",style: GoogleFonts.barlow(
// //                                         textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                       ),),
// //                                       SizedBox(height: height*0.01,),
// //                                       Container(
// //                                         height:height *0.37,
// //                                         width: width*0.2,
// //                                         decoration: BoxDecoration(
// //                                           image: DecorationImage(
// //                                               image: imgselect==false  ? AssetImage(img) as ImageProvider : MemoryImage(_bytesData),
// //                                               fit: BoxFit.fill),
// //                                         ),
// //                                       ),
// //
// //
// //                                     ],
// //                                   ),
// //                                 ),
// //
// //
// //
// //                               ],
// //                             ),
// //                           ),
// //
// //
// //                           Text("Maximum number of participants",style: GoogleFonts.barlow(
// //                             textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                           ),),
// //                           SizedBox(height: height*0.005,),
// //                           Row(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Container(
// //
// //                                 child: SizedBox(
// //                                   width: width*0.476,
// //                                   height: height*0.06,
// //
// //                                   child: TextField(
// //                                     controller: myController3,
// //
// //                                     style: GoogleFonts.barlow(
// //                                       textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
// //                                     ),
// //                                     decoration: InputDecoration(
// //                                       // hintText: "${snapshot.data![index].maxParticipants}",
// //                                       suffixIcon: IconButton(
// //                                           onPressed: (){},
// //                                           icon: Icon(Icons.unfold_more,size: 13,)
// //                                       ),
// //                                       focusedBorder: OutlineInputBorder(
// //                                         borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                       ),
// //                                       enabledBorder: OutlineInputBorder(
// //                                         borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
// //                                       ),
// //
// //
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   SizedBox(
// //                                     width: width *0.11,
// //
// //
// //                                     child: ElevatedButton(
// //                                       onPressed: () async{
// //     FileUploadInputElement uploadInput = FileUploadInputElement();
// //
// //               uploadInput.click();
// //
// //               uploadInput.onChange.listen((e) {
// //                 // read file content as dataURL
// //                 final files = uploadInput.files;
// //                 if (files?.length == 1) {
// //                   final file = files?[0];
// //                   final reader = new FileReader();
// //
// //                   reader.onLoadEnd.listen((e) async {
// //                     print(e);
// //                     print('loaded: ${file?.name}');
// //                     print('type: ${reader.result.runtimeType}');
// //                     print('file size = ${file?.size}');
// //                     _handleResult(reader.result);
// //                     print("i reached here");
// //                     imgselect = true;
// //
// //                   });
// //                   reader.readAsDataUrl(file!);
// //                   // myControllerSubject.text = file.name;
// //                 }
// //               });
// //
// //
// //
// //
// //                                       },
// //                                       child: Padding(
// //                                         padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
// //
// //                                         child: Text('Select image'.tr().toString(),strutStyle: StrutStyle(
// //                                             forceStrutHeight: true
// //                                         )),
// //                                       ),
// //                                       style: ElevatedButton.styleFrom(
// //                                         elevation: 0.0,
// //                                         shadowColor: Colors.transparent,
// //                                         primary: Color(0xFFF5F0E5),
// //                                         onPrimary: Color(0xFF183028),
// //                                         shape: RoundedRectangleBorder(
// //                                           borderRadius: BorderRadius.circular(8),
// //                                         ),
// //
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   SizedBox(width: width*0.014,),
// //                                   SizedBox(
// //                                     width: width *0.08,
// //
// //
// //
// //                                     child: ElevatedButton(
// //                                       onPressed: () {
// //
// //                                       },
// //                                       child: Padding(
// //                                         padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
// //                                         child: Text('Delete image'.tr().toString(),strutStyle: StrutStyle(
// //                                             forceStrutHeight: true
// //                                         )),
// //                                       ),
// //                                       style: ElevatedButton.styleFrom(
// //                                         primary: Color(0xFFFFE5E5),
// //                                         elevation: 0.0,
// //                                         shadowColor: Colors.transparent,
// //                                         onPrimary: Color(0xFF4A0303),
// //                                         shape: RoundedRectangleBorder(
// //                                           borderRadius: BorderRadius.circular(8),
// //                                         ),
// //
// //                                       ),
// //                                     ),
// //                                   ),
// //
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                           SizedBox(height: height*0.04,),
// //
// //                           Text("Instructors",style: GoogleFonts.barlow(
// //                             textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                           ),),
// //                           SizedBox(height: height*0.005,),
// //                           ListView.builder(
// //                             shrinkWrap: true,
// //                             itemCount: _instructorList.length,
// //                             itemBuilder: (context, index) {
// //                               return Column(
// //                                 children: [
// //                                   _instructorList[index],
// //                                   SizedBox(height: height*0.02,),
// //
// //                                 ],
// //                               );
// //                             },
// //                           ),
// //                           SizedBox(height: height*0.04,),
// //
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Container(
// //                                 child: ElevatedButton(
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _instructorList.add(_card());
// //                                     });
// //                                   },
// //                                   child: Padding(
// //                                     padding: EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
// //                                     child: Row(
// //                                       children: [
// //                                         Text('Add new instructor  '.tr().toString(),strutStyle: StrutStyle(
// //                                             forceStrutHeight: true
// //                                         )),
// //                                         Icon(Icons.add_circle_outline,size: 16,)
// //                                       ],
// //                                     ),
// //                                   ),
// //                                   style: ElevatedButton.styleFrom(
// //                                     primary: Color(0xFFF5F0E5),
// //                                     onPrimary: Color(0xFF183028),
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(4),
// //                                     ),
// //
// //                                   ),
// //                                 ),
// //                               ),
// //                               Container(
// //                                 child: ElevatedButton(
// //                                   onPressed: () {
// //                                     postAboutSection();
// //                                     updateRequestName();
// //                                   },
// //                                   child: Padding(
// //                                     padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
// //                                     child: Text('Next'.tr().toString(),strutStyle: StrutStyle(
// //                                         forceStrutHeight: true
// //                                     ),style: GoogleFonts.barlow(
// //                                       textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
// //                                     ),),
// //                                   ),
// //                                   style: ElevatedButton.styleFrom(
// //                                     elevation: 0.0,
// //                                     shadowColor: Colors.transparent,
// //                                     primary: Color(0xFF215732),
// //                                     onPrimary: Color(0xFFFFFFFF),
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(8),
// //                                     ),
// //
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //
// //                       ),
// //
// //                     ),
// //
// //                   ),
// //                 ),
// //
// //
// //               ],
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
