// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
// import 'package:flutter_custom_tab_bar/library.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
//
//
// class materialDetail extends StatefulWidget {
//   const materialDetail({Key? key}) : super(key: key);
//
//   @override
//   State<materialDetail> createState() => _materialDetailState();
// }
//
// class _materialDetailState extends State<materialDetail> {
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//
//
//     final num = SizedBox(
//         child: ElevatedButton(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(Icons.add_circle_outline,size: 16,color: Color(0xFF999999),),
//               SizedBox(width: 12,),
//
//               Text("Upload new file".tr().toString(),strutStyle: StrutStyle(
//                   forceStrutHeight: true
//               )),
//             ],
//           ),
//           onPressed: (){
//             print("You pressed Icon Elevated Button");
//           },
//           // icon: Icon(Icons.filter_list),
//           //  //label text
//           style: ElevatedButton.styleFrom(
//               elevation: 0,
//               side: BorderSide(width: 1, color: Color(0xff999999)),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10), // <-- Radius
//               ),
//               primary: Colors.transparent ,//elevated btton background color
//               onPrimary: Color(0xff999999),
//               minimumSize: Size(60,43)
//           ),
//         ));
//
//     final sort =
//     SizedBox(
//         height: height*0.058,
//         width: width*0.44,
//         child: ElevatedButton.icon(
//           onPressed: (){
//             showMaterialModalBottomSheet(
//               useRootNavigator: true,
//
//               context: context,
//               builder: (context) => Container(
//                 height: MediaQuery.of(context).size.height * 0.4,
//
//                 child: Container(
//
//                   height: 600,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                               icon:  Icon(Icons.arrow_back_ios_new,size: 18),
//                               onPressed: () {  Navigator.of(context).pop(); },
//                             ),
//
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [Text("Sort".tr(),style: GoogleFonts.barlow(
//                                 textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color: Color(0xff222222) ),)),
//
//                               ],
//                             ),
//                             SizedBox(width: 1,)
//
//                           ],
//                         ),
//                         SizedBox(height: height*0.05,),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: width*0.9,
//                               height: height*0.07,
//
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//
//                                     //
//                                     // isVisible = !isVisible;
//                                     // isVisibleButton = !isVisibleButton;
//
//                                   });
//                                   Navigator.pop(context);
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text('Newest to Oldest'.tr().toString(),strutStyle: StrutStyle(
//                                         forceStrutHeight: true
//                                     ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),),
//                                     SizedBox(width: 5,),SvgPicture.asset('assets/images/tick.svg',), SizedBox(width: 5),],),
//                                 style: ElevatedButton.styleFrom(
//                                     elevation: 0,
//                                     primary: Colors.white,
//                                     onPrimary: Colors.black,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     side: BorderSide(
//                                         width: 1,
//                                         color: Color(0xff999999)
//                                     )
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: height*0.02,),
//                             SizedBox(
//                               width: width*0.9,
//                               height: height*0.07,
//
//                               child: ElevatedButton(
//                                 onPressed: () {
//
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//
//                                     Text('Oldest to Newest'.tr().toString(),strutStyle: StrutStyle(
//                                         forceStrutHeight: true
//                                     ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),)],),
//                                 style: ElevatedButton.styleFrom(
//                                     elevation: 0,
//                                     primary: Colors.white,
//                                     onPrimary: Colors.black,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     side: BorderSide(
//                                         width: 1,
//                                         color: Color(0xff999999)
//                                     )
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//           icon: Icon(Icons.filter_list),  //icon data for elevated button
//           label: Text("Sort".tr().toString(),strutStyle: StrutStyle(
//               forceStrutHeight: true
//           )), //label text
//           style: ElevatedButton.styleFrom(
//               elevation: 0,
//               side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(7), // <-- Radius
//               ),
//               primary: Colors.white ,//elevated btton background color
//               onPrimary: Colors.black,
//               minimumSize: Size(width*0.45,50)
//           ),
//         ));
//
//     final search = SizedBox(
//       height: height*0.055,
//       width: width*0.92,
//       child: Container(
//         // margin: const EdgeInsets.all(1.0),
//         // padding: const EdgeInsets.all(1.0),
//         decoration: BoxDecoration(
//             color: Colors.white,
//
//             border: Border.all(color: Color(0xFFEEEEEE)),
//             borderRadius: BorderRadius.circular(10.0)
//         ),
//         child: TextField(
//           decoration: InputDecoration(
//             prefixIcon:  SvgPicture.asset("images/search.svg",fit: BoxFit.scaleDown,),
//             border: InputBorder.none,
//
//             hintText: 'Search'.tr().toString(),
//             contentPadding: EdgeInsets.only(top:10),
//             hintStyle:  GoogleFonts.barlow(textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ) ),
//             
//             // enabledBorder: const OutlineInputBorder(
//             //   // borderSide: const BorderSide(color: Color(0xFFEEEEEE),),
//             // ),
//
//
//
//           ),
//
//
//
//         ),
//       ),
//     );
//
//     final filter = SizedBox(height: height*0.058,
//         width: width*0.44,
//         child : ElevatedButton.icon(
//           onPressed: ()async {
//
//             DateTimeRange? picked = await showDateRangePicker(
//                 context: context,
//                 firstDate: DateTime(DateTime.now().year - 5),
//                 lastDate: DateTime(DateTime.now().year + 5),
//
//                 builder: (context, child) {
//                   return Theme(
//                     data: ThemeData(
//                       //Header background color
//                       primaryColor: Color(0xff007A33),
//                       //Background color
//                       scaffoldBackgroundColor: Colors.white,
//                       //Divider color
//                       dividerColor: Colors.grey,
//                       //Non selected days of the month color
//                       textTheme: TextTheme(
//                         bodyText2:
//                         TextStyle(color: Colors.black),
//                       ),colorScheme: ColorScheme.fromSwatch().copyWith(
//                       //Selected dates background color
//                       primary: Color(0xff215732),
//                       //Month title and week days color
//                       onSurface: Colors.black,
//                       //Header elements and selected dates text color
//                       //onPrimary: Colors.white,
//                     ),),
//
//                     child: Column(
//                       children: [
//                         ConstrainedBox(
//                           constraints: BoxConstraints(
//                             maxWidth: 400.0,
//                             maxHeight: height*0.7,
//                           ),
//                           child: child,
//                         )
//                       ],
//                     ),
//                   );
//                 });
//             print(picked);
//
//           },
//           icon: ImageIcon(
//             AssetImage("assets/mobileImages/funnel.png"),
//             size: 24,
//           ),  //icon data for elevated button
//           label: Text("Filter".tr().toString(),strutStyle: StrutStyle(
//               forceStrutHeight: true
//           )), //label text
//           style: ElevatedButton.styleFrom(
//             elevation: 0,
//             side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(7), // <-- Radius
//             ),
//             primary: Colors.white ,//elevated btton background color
//             onPrimary: Colors.black,
//
//
//           ),
//         )
//     );
//
//
//     final materialInfo = Container(
//       child: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: Column(
//           children: [
//             Image.asset("assets/mobileImages/paper.png"),
//             SizedBox(height: height* 0.008,),
//             Text("Data analytics... 2",style: GoogleFonts.barlow(textStyle:  TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) )),),
//             SizedBox(height: height* 0.005,),
//             Text("course subject 1",style: GoogleFonts.barlow(textStyle:  TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF222222) )),),
//             SizedBox(height: height* 0.005,),
//             Text("M. Abdulrahman",style: GoogleFonts.barlow(textStyle:  TextStyle(fontSize: 11,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF9C9FA1) )),),
//             SizedBox(height: height* 0.005,),
//             Text("16/06/22   3:25 PM",style: GoogleFonts.barlow(textStyle:  TextStyle(fontSize: 11,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF9C9FA1) )),),
//
//           ],
//         ),
//       ),
//     );
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//
//
//             SizedBox(height: height*0.02,),
//
//             search,
//             SizedBox(height: height*0.02,),
//
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                filter,sort]
//             ),
//             SizedBox(height: height*0.02,),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//               children: [
//               Text("Recently Viewed".tr(),style: GoogleFonts.barlow(
//                 textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 12),
//               ),),num
//             ],),
//             SizedBox(height: height*0.02,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//
//               children: [
//                 materialInfo,
//                 materialInfo,
//                 materialInfo,
//
//               ],
//             ),
//             SizedBox(height: height*0.02,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//
//               children: [
//                 materialInfo,
//                 materialInfo,
//                 materialInfo,
//
//               ],
//             ),
//             // SizedBox(height: height*0.02,),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //
//             //   children: [
//             //     materialInfo,
//             //     materialInfo,
//             //     materialInfo,
//             //
//             //   ],
//             // ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'dart:convert';
import 'dart:html';
import 'dart:html' as ht;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import '../../models/MaterialCourse.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;

class materialDetail extends StatefulWidget {
  final String current_course_id;

  const materialDetail({Key? key,required this.current_course_id}) : super(key: key);

  @override
  State<materialDetail> createState() => _materialDetailState();
}

class _materialDetailState extends State<materialDetail> {
  late List<int> _selectedFile;

  Future<List<MaterialsModel>> fetchMaterial() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetMaterial/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<MaterialsModel>((json) => MaterialsModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  late Future<List<MaterialsModel>> futureMaterial;

  final myControllerSubject = TextEditingController();
  final myControllerTitle = TextEditingController();
  final myControllerAuthor = TextEditingController();


  Future<String> makeRequest() async {
    var url = Uri.parse(global.apiAddress + "AddFile");
    var request = new http.MultipartRequest("POST", url);
    request.fields['material_id'] = 'blah';
    request.fields['title'] = myControllerTitle.text;
    request.fields['author'] = myControllerAuthor.text;
    request.fields['file_name'] = 'blah';
    request.fields['course_id'] = widget.current_course_id.toString();
    request.fields['time'] = '2022-11-26 14:15:00.057';

    request.files.add(await http.MultipartFile.fromBytes('fileModel', _selectedFile, contentType: new MediaType('application', 'octet-stream'), filename: 'hhh'));

    request.send().then((response) {
      print("i am hereee makerequest");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");

      setState(() {
        futureMaterial = fetchMaterial();
      });
    });
    return "finished";
  }

  void submitForm() {
    String errorText = "";

    errorText += validator.isValid("title", myControllerTitle.text, "empty");
    errorText += validator.isValid("subject", myControllerSubject.text, "empty");
    errorText += validator.isValid("author", myControllerAuthor.text, "empty");

    if (errorText != "") {
      validator.mobileAlertDialog(context, errorText.substring(0, errorText.length - 1));
      return;
    }
    makeRequest();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    futureMaterial = fetchMaterial();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final myControllerSubject = TextEditingController();
    final myControllerTitle = TextEditingController();
    final myControllerAuthor = TextEditingController();
    late List<int> _selectedFile;
    late Uint8List _bytesData;

    Future<void> downloadmaterial(filepath) async {
      final Uri _url = Uri.parse(global.apiAddress + 'download');
      if (!await launchUrl(_url)) {
        throw 'Could not launch https://192.168.156.1:7040/api/PIF/download';
      }
    }

    void _handleResult(Object? result) {
      setState(()  {
        _bytesData = Base64Decoder().convert(result.toString().split(",").last);
        _selectedFile = _bytesData;




      });


    }

    // Future<String> makeRequest() async {
    //   var url = Uri.parse(
    //       "https://192.168.156.1:7040/api/PIF/AddFile");
    //   var request = new http.MultipartRequest("POST", url);
    //   request.fields['material_id'] = 'blah';
    //   request.fields['title'] = myControllerTitle.text;
    //   request.fields['author'] = myControllerAuthor.text;
    //   request.fields['file_name'] = 'blah';
    //   request.fields['course_id'] = widget.current_course_id.toString();
    //   request.fields['time'] = '2022-11-26 14:15:00.057';
    //
    //
    //
    //
    //   request.files.add(await http.MultipartFile.fromBytes('fileModel', _selectedFile,
    //
    //       contentType: new MediaType('application', 'octet-stream'),
    //       filename: 'hhh'));
    //
    //   request.send().then((response) {
    //     print("i am hereee makerequest");
    //     print(response.statusCode);
    //     if (response.statusCode == 200) print("Uploaded!");
    //
    //     setState(() {
    //       futureMaterial = fetchMaterial();
    //
    //     });
    //
    //   });
    //   return "finished";
    // }
    final num = SizedBox(
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.add_circle_outline,size: 16,color: Color(0xFF999999),),
              SizedBox(width: 12,),

              Text("Upload new file".tr().toString(),strutStyle: StrutStyle(
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
        final sort =
    SizedBox(
        height: height*0.058,
        width: width*0.44,
        child: ElevatedButton.icon(
          onPressed: (){
            showMaterialModalBottomSheet(
              useRootNavigator: true,

              context: context,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.4,

                child: Container(

                  height: 600,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon:  Icon(Icons.arrow_back_ios_new,size: 18),
                              onPressed: () {  Navigator.of(context).pop(); },
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Text("Sort".tr(),style: GoogleFonts.barlow(
                                textStyle :TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color: Color(0xff222222) ),)),

                              ],
                            ),
                            SizedBox(width: 1,)

                          ],
                        ),
                        SizedBox(height: height*0.05,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width*0.9,
                              height: height*0.07,

                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {

                                    //
                                    // isVisible = !isVisible;
                                    // isVisibleButton = !isVisibleButton;

                                  });
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Newest to Oldest'.tr().toString(),strutStyle: StrutStyle(
                                        forceStrutHeight: true
                                    ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),),
                                    SizedBox(width: 5,),SvgPicture.asset('assets/images/tick.svg',), SizedBox(width: 5),],),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    side: BorderSide(
                                        width: 1,
                                        color: Color(0xff999999)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: height*0.02,),
                            SizedBox(
                              width: width*0.9,
                              height: height*0.07,

                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text('Oldest to Newest'.tr().toString(),strutStyle: StrutStyle(
                                        forceStrutHeight: true
                                    ),style: GoogleFonts.barlow(textStyle:TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),)],),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    side: BorderSide(
                                        width: 1,
                                        color: Color(0xff999999)
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          icon: Icon(Icons.filter_list),  //icon data for elevated button
          label: Text("Sort".tr().toString(),strutStyle: StrutStyle(
              forceStrutHeight: true
          )), //label text
          style: ElevatedButton.styleFrom(
              elevation: 0,
              side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7), // <-- Radius
              ),
              primary: Colors.white ,//elevated btton background color
              onPrimary: Colors.black,
              minimumSize: Size(width*0.45,50)
          ),
        ));

    final search = SizedBox(
      height: height*0.055,
      width: width*0.92,
      child: Container(
        // margin: const EdgeInsets.all(1.0),
        // padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
            color: Colors.white,

            border: Border.all(color: Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon:  SvgPicture.asset("images/search.svg",fit: BoxFit.scaleDown,),
            border: InputBorder.none,

            hintText: 'Search'.tr().toString(),
            contentPadding: EdgeInsets.only(top:10),
            hintStyle:  GoogleFonts.barlow(textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ) ),
            
            // enabledBorder: const OutlineInputBorder(
            //   // borderSide: const BorderSide(color: Color(0xFFEEEEEE),),
            // ),



          ),



        ),
      ),
    );

    final filter = SizedBox(height: height*0.058,
        width: width*0.44,
        child : ElevatedButton.icon(
          onPressed: ()async {

            DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),

                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      //Header background color
                      primaryColor: Color(0xff007A33),
                      //Background color
                      scaffoldBackgroundColor: Colors.white,
                      //Divider color
                      dividerColor: Colors.grey,
                      //Non selected days of the month color
                      textTheme: TextTheme(
                        bodyText2:
                        TextStyle(color: Colors.black),
                      ),colorScheme: ColorScheme.fromSwatch().copyWith(
                      //Selected dates background color
                      primary: Color(0xff215732),
                      //Month title and week days color
                      onSurface: Colors.black,
                      //Header elements and selected dates text color
                      //onPrimary: Colors.white,
                    ),),

                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 400.0,
                            maxHeight: height*0.7,
                          ),
                          child: child,
                        )
                      ],
                    ),
                  );
                });
            print(picked);

          },
          icon: ImageIcon(
            AssetImage("assets/mobileImages/funnel.png"),
            size: 24,
          ),  //icon data for elevated button
          label: Text("Filter".tr().toString(),strutStyle: StrutStyle(
              forceStrutHeight: true
          )), //label text
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7), // <-- Radius
            ),
            primary: Colors.white ,//elevated btton background color
            onPrimary: Colors.black,


          ),
        )
    );



    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              search,
              SizedBox(height: height*0.02,),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    // SizedBox(width: width*0.003,),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                      child: filter,
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                    // SizedBox(width: width*0.065,),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),

                      child: sort,
                    )
                  ],
                ),
              ),

          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
              Text("Recently Viewed".tr(),style: GoogleFonts.barlow(
                textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 12),
              ),),SizedBox(
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
                        showDialog(

                            context: context,
                            builder: (BuildContext context) {

                              Locale? lang = Locale("en");
                              return Container(
                                height: height ,
                                width: width ,
                                child:  AlertDialog(
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0))),
                              scrollable: true,
                              title: Column(
                              children: [
                              Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                              onTap: (){
                              Navigator.pop(context);
                              },
                              child: Icon(Icons.close))),
                              Center(child: Text("Upload".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 28),
                              ),),),
                              ],
                              ),
                              content: Form(
                              child:

                              Column(

                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                              Center(
                              child: Text("Browse to upload the files".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                              ),),
                              ),
                              SizedBox(height: height*0.07),
                              // Padding(
                              //   padding:
                              //   EdgeInsets.only( right:context.locale == Locale("en") ?width*0.04: 0,left:  context.locale == Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                              //   child: Text("Title".tr(),style: GoogleFonts.barlow(
                              //     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                              //   ),),
                              // ),
                                Center(
                                  child: TextField(
                                    controller: myControllerTitle,

                                    decoration: InputDecoration(
                                      hintText: 'Title',

                                      hintStyle: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 7),

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                      ),


                                    ),
                                  ),
                                ),
                              // Center(
                              // child:
                              // SizedBox(
                              // width: width*0.7,
                              // height: height*0.05,
                              // child: TextField(
                              // controller: myControllerTitle,
                              //
                              // decoration: InputDecoration(
                              // hintText: 'Title',
                              //
                              // hintStyle: GoogleFonts.barlow(
                              // textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                              // ),
                              // contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 7),
                              //
                              // focusedBorder: OutlineInputBorder(
                              // borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                              // ),
                              // enabledBorder: OutlineInputBorder(
                              // borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                              // ),
                              //
                              //
                              // ),
                              // ),
                              // ),
                              // ),



                              SizedBox(height: height*0.02),


                              Center(
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              SizedBox(
                              width: width*0.4,
                              height: height*0.05,
                              child: TextField(
                              controller: myControllerSubject,
                              decoration: InputDecoration(
                              hintText: 'Subject',
                              hintStyle: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 7),

                              focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                              ),


                              ),
                              ),
                              ),
                              SizedBox(width: 10,),
                              SizedBox(
                              height: height*0.05,

                              child: ElevatedButton(
                              onPressed: () async{
                              FileUploadInputElement uploadInput = FileUploadInputElement();

                              uploadInput.click();

                              uploadInput.onChange.listen((e) {
                              // read file content as dataURL
                              final files = uploadInput.files;
                              if (files?.length == 1) {
                              final file = files?[0];
                              final reader = new FileReader();

                              reader.onLoadEnd.listen((e) async {
                              print(e);
                              print('loaded: ${file?.name}');
                              print('type: ${reader.result.runtimeType}');
                              print('file size = ${file?.size}');
                              _handleResult(reader.result);
                              print("i reached here");

                              });
                              reader.readAsDataUrl(file!);
                              myControllerSubject.text = file.name;
                              }
                              });



                              },
                              child: Text('Browse'.tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                              ),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                              ),),
                              style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                              primary: Color(0xFFF5F0E5),
                              onPrimary: Color(0xFF183028),
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                              ),

                              ),
                              ),
                              ),
                              ],
                              ),
                              ),

                              SizedBox(height: height*0.02),
                                Center(
                                  child: TextField(
                                    controller: myControllerAuthor,


                                    decoration: InputDecoration(
                                      hintText: 'Author',

                                      hintStyle: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 7),

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                      ),


                                    ),
                                  ),
                                ),

                              // Center(
                              // child: SizedBox(
                              // width: width*0.3,
                              //
                              // height: height*0.05,
                              // child: TextField(
                              // controller: myControllerAuthor,
                              // decoration: InputDecoration(
                              // hintText: 'Author',
                              // hintStyle: GoogleFonts.barlow(
                              // textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                              // ),
                              // contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 7),
                              //
                              //
                              // focusedBorder: OutlineInputBorder(
                              // borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                              // ),
                              // enabledBorder: OutlineInputBorder(
                              // borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                              // ),
                              //
                              //
                              // ),
                              // ),
                              // ),
                              // ),

                              SizedBox(height: height*0.04),

                              Center(
                              child: SizedBox(
                              width: width*0.5,

                              child:ElevatedButton(
                              onPressed: () {
                                submitForm();
                                setState(() {
                                // futureSchedule = fetchSchedule();


                                });

                              },
                              child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 15),
                              child: Text('Upload Files'.tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                              ),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                              )),
                              ),
                              style: ElevatedButton.styleFrom(
                              primary: Color(0xFF215732),
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                              onPrimary: Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                              ),

                              ),
                              ),

                              ),
                              ),
                              SizedBox(height: height*0.02),


                              ],
                              ),
                              ),

                              ),
                              );
                            });
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
                    ))
            ],),

              FutureBuilder<List<MaterialsModel>>(

                future: futureMaterial,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),

                      shrinkWrap:true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(

                        child: Column(
                          children: [
                            InkWell(
                              hoverColor: Colors.transparent,
                              onLongPress: ()async {
                                ht.window.open(global.apiAddress + 'download/${snapshot.data![index].file_name}',"_self");

                                // final status = await Permission.storage.request();
                                //
                                // if (status.isGranted) {
                                //
                                //   // var dir = await getExternalStorageDirectory();
                                //   try{
                                //     final taskId = await FlutterDownloader.enqueue(
                                //       url: "https://192.168.156.1:7040/api/PIF/download/${snapshot.data![index].file_name}",
                                //       savedDir:  "/storage/emulated/0/Download",
                                //       fileName:"${snapshot.data![index].file_name}",
                                //       showNotification: true, // show download progress in status bar(forAndroid)
                                //       openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                                //     );
                                //     debugPrint(taskId);
                                //
                                //     //   FlutterDownloader.retry(taskId: taskId);
                                //   }
                                //   catch(e){
                                //     print(e);
                                //   }
                                //   // final id = await FlutterDownloader.enqueue(
                                //   //   url: "https://192.168.156.1:7040/api/PIF/download/${snapshot.data![index].file_name}",
                                //   //   savedDir: "/storage/emulated/0/Download",
                                //   //   showNotification: true,
                                //   //   openFileFromNotification: true,
                                //   //   fileName: DateTime.now().millisecond.toString().replaceAll(" ", ""),
                                //   //
                                //   // ).then((value) {
                                //   //   print("complated");
                                //   // });
                                // } else {
                                //   setState(() {
                                //     print("faild");
                                //   });
                                //   print('Permission Denied');
                                // }

                              },
                              child:
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/mobileImages/paper.png"),
                                      SizedBox(height: height* 0.008,),
                                      Text("${snapshot.data![index].title}",style: GoogleFonts.barlow(textStyle:  TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) )),),
                                      SizedBox(height: height* 0.005,),

                                      Text("${snapshot.data![index].author}",style: GoogleFonts.barlow(textStyle:  TextStyle(fontSize: 11,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF9C9FA1) )),),
                                      SizedBox(height: height* 0.005,),
                                      Text("${snapshot.data![index].time}",style: GoogleFonts.barlow(textStyle:  TextStyle(fontSize: 11,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF9C9FA1) )),),

                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.8/ 2.3
                    ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //
              //   children: [
              //     materialInfo,
              //     materialInfo,
              //     materialInfo,
              //
              //   ],
              // ),
              // SizedBox(height: height*0.02,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //
              //   children: [
              //     materialInfo,
              //     materialInfo,
              //     materialInfo,
              //
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}