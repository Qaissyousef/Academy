import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:date_time_format/date_time_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as ht;

import 'package:http_parser/http_parser.dart';
import '../../models/instructorModel.dart';
import '../../models/schedule_model.dart';

import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;

class mobileSchedule extends StatefulWidget {
  final String current_course_id;

  const mobileSchedule({Key? key,required this.current_course_id}) : super(key: key);

  @override
  State<mobileSchedule> createState() => _mobileScheduleState();
}


// IMPORTANT NOTE: drop downs are absolutely refusing to work, i would love to fix em but no time
class _mobileScheduleState extends State<mobileSchedule> {
  String? dropdownvalue = 'Admin';


  final myControllerloc = TextEditingController();
  final myControllerduration = TextEditingController();
  final myControllersdate = TextEditingController();
  final myControllerstime = TextEditingController();
  final myControllerSubject = TextEditingController();
    bool submitForm() {
    String errorText = "";

    errorText += validator.isValid("date", myControllersdate.text, "empty");
    errorText += validator.isValid("end time", myControllerduration.text, "empty;time");
    errorText += validator.isValid("start time", myControllerstime.text, "empty;time");
    errorText += validator.isValid("location", myControllerloc.text, "empty");
    errorText += validator.isValid("subject", myControllerSubject.text, "empty");

    print(myControllerstime.text);
    print(myControllerduration.text);
    if (errorText == "") {
      if (!validator.isTimeGreater(myControllerstime.text, myControllerduration.text)) errorText += "${validator.bullet} start time can't be\n  greater than end time\n";
    }

    if (errorText != "") {
      validator.mobileAlertDialog(context, errorText.substring(0, errorText.length - 1));
      return false;
    }

    postRequest();
    Navigator.pop(context);
    return true;
  }



  Future<String> postRequest () async {

    var url = Uri.parse(global.apiAddress + "AddSchedule");
    var request = new http.MultipartRequest("POST", url);
    request.fields['course_id'] = widget.current_course_id.toString();
    request.fields['duration'] = myControllerduration.text;
    request.fields['date'] = myControllersdate.text;
    request.fields['time'] = myControllerstime.text;
    request.fields['location'] = myControllerloc.text;
    request.fields['instructor'] = dropdownvalue!;
    request.fields['subject'] = myControllerSubject.text;

    request.fields['subjectpath'] = 'wfe';


    request.files.add(await http.MultipartFile.fromBytes('fileModel', _selectedFile,

        contentType: new MediaType('application', 'octet-stream'),
        filename: 'hhh'));

    request.send().then((response) {
      print("i am hereee makerequest");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");

      setState(() {
        futureSchedule = fetchSchedule();


      });

    });
    return "finished";

    // Map data =
    // {
    //   "course_id": widget.current_course_id,
    //
    //   "duration": myControllerduration.text,
    //   "date": myControllersdate.text,
    //   "time": myControllerstime.text,
    //   "location": myControllerloc.text,
    //   "material": "string",
    //   "instructor": val
    // };
    //
    // //encode Map to JSON
    // var body = json.encode(data);
    // var response = await http.post(Uri.parse(global.apiAddress + 'AddSchedule'),
    //
    //     headers: {
    //       'Content-Type': 'application/json',
    //       "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    //       "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
    //       "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    //       "Access-Control-Allow-Methods": "POST, OPTIONS"
    //     },
    //
    //     body: body
    // );
    // print("${response.statusCode}");
    // print("${response.body}");


    // setState(() {
    //   futureSchedule = fetchSchedule();
    // });
    //
    // return response;
  }

  late Future<List<InstructorModel>> futurefetchInstructor;
  // DateTime _dateTime = DateTime.now();
  var _dateTime1 = DateTime.parse("2022-10-01 00:00:00.000");
  var _dateTime2 = DateTime.parse("2022-02-12 00:00:00.000");
  var _dateTime3 = DateTime.parse("2022-06-01 00:00:00.000");
  var _dateTime4 = DateTime.parse("2022-04-05 00:00:00.000");
  // String dropdownvalue = 'Mohammad Abdulrahman';

  // List of items in our dropdown menu
  var items = [
    'instructor 1',
    'instructor 2',
    'instructor 3',
  ];

  Future<List<ScheduleCourse>> fetchSchedule() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetSchedule/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<ScheduleCourse>((json) => ScheduleCourse.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  late List<int> _selectedFile;
  late Uint8List _bytesData;
  late Future<List<ScheduleCourse>> futureSchedule;
  void _handleResult(Object? result) {
    setState(()  {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;




    });


  }

  Future<http.Response> deleteRequestSchedule (int uid) async {


    Map data = {
      "course_id": 0,
      "schedule_id": uid,
      "duration": "string",
      "date": "string",
      "time": "string",
      "location": "string",
      "material": "string",
      "instructor": "string",

    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'DeleteSch'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    setState(() {
      futureSchedule = fetchSchedule();


    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }
  @override
  void initState() {
    // futurefetchInstructor = fetchInstructor();
    futureSchedule = fetchSchedule();



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final role = Container(
    //   height: height*0.3,
    //   child:DropdownButtonFormField(
    //     decoration :InputDecoration.collapsed(hintText: ''),
    //     style: GoogleFonts.barlow(
    //       textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
    //     ),
    //     // Initial Value
    //     value: "test",

    //     // Down Arrow Icon
    //     icon: const Icon(Icons.keyboard_arrow_down),

    //     // Array list of items
    //     items: ["this", "is", "a"].map((String item) {
    //       return DropdownMenuItem(
    //         value: item,
    //         child: Text(item),
    //       );
    //     }).toList(),
    //     // After selecting the desired option,it will
    //     // change button value to selected value
    //     onChanged: (String? newValue) {
    //       setState(() {
    //         dropdownvalue = newValue!;
    //       });
    //     },
    //   ),
    // );
      //    FutureBuilder<List<InstructorModel>>(
      //
      //           future: futurefetchInstructor ,
      //           builder: (context, snapshot) {
      //             if (snapshot.hasData) {
      //               return ListView.builder(
      //                 physics: NeverScrollableScrollPhysics(),
      //                 shrinkWrap:true,
      //                 itemCount: 1,
      //                 itemBuilder: (_, index) => Container(
      //
      //                     child: Column(
      //                       children :[
      //                         DropdownButtonFormField(
      //                           decoration :InputDecoration.collapsed(hintText: ''),
      //                           style: GoogleFonts.barlow(
      //                             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
      //                           ),
      // // Initial Value
      //                           value: snapshot.data![index].name,
      //
      // // Down Arrow Icon
      //                           icon:Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),
      //
      // // Array list of items
      //                           items: snapshot.data!.map((list) {
      //                             return DropdownMenuItem(
      //                               child: Text( list.name ,),
      //                               value:  list.name.toString(),
      //                             );
      //                           }).toList(),
      //                           onChanged: (String? newValue) {
      //                             setState(() {
      //                               val = newValue!;
      //
      //                               print (val);
      //
      //                             });
      //                           },
      //                         ),],
      //                     )
      //                 ),
      //               );
      //             } else {
      //               return Center(child: CircularProgressIndicator());
      //             }
      //           },
      //         ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(

                  child: Row(children: [
                    Text("Subject name ".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Colors.black ),),
                    ),
                    SizedBox(width: 10,),
                    ImageIcon(AssetImage("images/pencil.png"),color: Color(0xffBD9B60),),
                  ],),
                ),
                // SizedBox(width: 255,),


                ImageIcon(AssetImage("assets/mobileImages/forward.png"),color: Color(0xff999999),),

              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 25,
              color: Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(


                    child: Text("Schedule".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("16/05/2022".tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                        ),
                        SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),


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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(


                    child: Text("Instructor ".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),
                  // Container(
                  //   width: width*0.35,
                  //   child: DropdownButtonFormField(
                  //     decoration :InputDecoration.collapsed(hintText: ''),
                  //     style: GoogleFonts.barlow(
                  //       textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                  //     ),
                  //     // Initial Value
                  //     value: dropdownvalue,

                  //     // Down Arrow Icon
                  //     icon:Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),

                  //     // Array list of items
                  //     items: items.map((String item) {
                  //       return DropdownMenuItem(
                  //         value: item,
                  //         child: Text(item),
                  //       );
                  //     }).toList(),
                  //     // After selecting the desired option,it will
                  //     // change button value to selected value
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         dropdownvalue = newValue!;
                  //       });
                  //     },
                  //   ),
                  // )
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

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0,right: 25.0),
            child:  FutureBuilder<List<ScheduleCourse>>(

              future: futureSchedule ,
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap:true,
                    itemCount: snapshots.data!.length,

                    itemBuilder: (_, index) => Container(

                        child: Column(
                          children :[

                            InkWell(
                              onTap: (){
                                // Uri.parse(global.apiAddress + 'download')
                                // downloadmaterial(snapshots.data![index].file_name);
                                ht.window.open(global.apiAddress + 'download/${snapshots.data![index].subjectpath}',"_self");

                              },
                              child: Card(
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Container(

                                            child: Row(children: [
                                              Text("Subject name ".tr().toString(),strutStyle: StrutStyle(
                                                  forceStrutHeight: true
                                              ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Colors.black ),),
                                              ),
                                              SizedBox(width: 10,),
                                              ImageIcon(AssetImage("images/pencil.png"),color: Color(0xffBD9B60),),
                                            ],),
                                          ),
                                          // SizedBox(width: 255,),


                                          PopupMenuButton(
                                            onSelected: (result) {
                                              // your logic
                                              if (result == 0) {
                                                print("delete");
                                                setState(() {
                                                  futureSchedule = fetchSchedule();

                                                  deleteRequestSchedule(snapshots.data![index].schedule_id);

                                                  futureSchedule = fetchSchedule();


                                                });
                                              }

                                            },
                                            itemBuilder: (BuildContext bc) {
                                              return const [
                                                PopupMenuItem(
                                                  child: Text("Delete"),
                                                  value: 0,
                                                ),
                                              ];
                                            },
                                          )


                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: 25,
                                        color: Color(0xffffffff),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Container(


                                              child: Text("Schedule".tr().toString(),strutStyle: StrutStyle(
                                                  forceStrutHeight: true
                                              ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text("${snapshots.data![index].date}".tr().toString(),strutStyle: StrutStyle(
                                                      forceStrutHeight: true
                                                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                                                  ),
                                                  SvgPicture.asset("assets/images/calendar.svg",fit: BoxFit.scaleDown,),


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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Container(


                                              child: Text("Instructor ".tr().toString(),strutStyle: StrutStyle(
                                                  forceStrutHeight: true
                                              ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                              ),
                                            ),
                                            // Container(
                                            //   width: width*0.35,
                                            //   child: DropdownButtonFormField(
                                            //     decoration :InputDecoration.collapsed(hintText: ''),
                                            //     style: GoogleFonts.barlow(
                                            //       textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                            //     ),
                                            //     // Initial Value
                                            //     value: dropdownvalue,

                                            //     // Down Arrow Icon
                                            //     icon: const Icon(Icons.keyboard_arrow_down),

                                            //     // Array list of items
                                            //     items: items.map((String item) {
                                            //       return DropdownMenuItem(

                                            //         value: item,
                                            //         child: Text(item),
                                            //       );
                                            //     }).toList(),
                                            //     // After selecting the desired option,it will
                                            //     // change button value to selected value
                                            //     onChanged: (String? newValue) {
                                            //       setState(() {
                                            //         dropdownvalue = newValue!;
                                            //       });
                                            //     },
                                            //   ),
                                            // )
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

                                            Text("${snapshots.data![index].subject}".tr().toString(),strutStyle: StrutStyle(
                                                forceStrutHeight: true
                                            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Colors.black),),
                                            ),
                                            SizedBox(width: 12,),
                                            Image.asset("assets/images/bin.png",color: Color(0xffD80000),),
                                            SizedBox(width: 12,),
                                            Icon(Icons.add_circle_outline,size: 16,)
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height*0.02,),







                          ],
                        )
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0,right: 25.0),
            child: SizedBox(
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
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0))),

                              scrollable: true,
                              title: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                          onTap: (){
                                            //Navigator.pop(context);
                                          },
                                          child: Icon(Icons.close))),
                                  Center(child: Text("Add Schedule".tr(),style: GoogleFonts.barlow(
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
                                      child: Text("Enter the details below to add scheulde".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                      ),),
                                    ),
                                    SizedBox(height: height*0.07),
                                    Padding(
                                      padding:
                                      EdgeInsets.only( right:context.locale == Locale("en") ?width*0.04: 0,left:  context.locale == Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                      child: Text("date".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                      ),),
                                    ),
                                    Center(
                                      child: TextField(
                                        controller: myControllersdate,
                                        decoration: InputDecoration(
                                          prefixIcon: IconButton(

                                            onPressed: (){
                                              showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2001), lastDate: DateTime(2100),
                                                builder: (context, child){
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
                                                            maxWidth: 450.0,
                                                            maxHeight: height*0.7,
                                                          ),
                                                          child: child,
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ).then((date){
                                                setState((){
                                                  _dateTime1 = date!;
                                                  myControllersdate.text = date.format('M d').toString();
                                                });
                                              });
                                            },
                                            icon:  SvgPicture.asset("assets/images/calendar.svg",fit: BoxFit.scaleDown,),

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
                                    SizedBox(height: height*0.02),
                                    Padding(
                                      padding:

                                      EdgeInsets.only(right:context.locale == Locale("en") ?width*0.04: 0,left:  context.locale == Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                      child: Text("time".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                      ),),
                                    ),
                                    Center(
                                      child: TextField(
                                        controller: myControllerstime,
                                        decoration: InputDecoration(
                                          prefixIcon: IconButton(
                                              onPressed: ()
                                              async {
                                                TimeOfDay? pickedTime =  await showTimePicker(
                                                  initialTime: TimeOfDay.now(),
                                                  context: context,
                                                );

                                                if(pickedTime != null ){
                                                  print(pickedTime.format(context));   //output 10:51 PM
                                                  DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                  //converting to DateTime so that we can further format on different pattern.
                                                  print(parsedTime); //output 1970-01-01 22:53:00.000
                                                  String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                  print(formattedTime); //output 14:59:00
                                                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                  setState(() {
                                                    myControllerstime.text = formattedTime; //set the value of text field.
                                                  });
                                                }else{
                                                  print("Time is not selected");
                                                }
                                              },
                                              // {

                                              //   var selectedTime = showTimePicker(
                                              //   initialTime: TimeOfDay.now(),
                                              //   context: context,
                                              //   builder: (context, child) {
                                              //     return Theme(
                                              //       data: ThemeData(
                                              //         //Header background color
                                              //         primaryColor: Color(0xff007A33),
                                              //         //Background color
                                              //         scaffoldBackgroundColor: Colors.white,
                                              //         //Divider color
                                              //         dividerColor: Colors.grey,
                                              //         //Non selected days of the month color
                                              //         textTheme: TextTheme(
                                              //           bodyText2:
                                              //           TextStyle(color: Colors.black),
                                              //         ),colorScheme: ColorScheme.fromSwatch().copyWith(
                                              //         //Selected dates background color
                                              //         primary: Color(0xff215732),
                                              //         //Month title and week days color
                                              //         onSurface: Colors.black,
                                              //         //Header elements and selected dates text color
                                              //         //onPrimary: Colors.white,
                                              //       ),),
                                              //       child: Column(
                                              //         children: [
                                              //           ConstrainedBox(
                                              //             constraints: BoxConstraints(
                                              //
                                              //             ),
                                              //             child: child,
                                              //           )
                                              //         ],
                                              //       ),
                                              //     );
                                              //
                                              //   },
                                              // );
                                              // myControllerstime.text = selectedTime.toString();
                                              // },
                                              icon:
                                              Icon(Icons.access_time,size: 18,  color: Color(0xFF999999))),

                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                          ),


                                        ),
                                      ),
                                    ),

                                    SizedBox(height: height*0.02),
                                    Padding(
                                      padding:  EdgeInsets.only(right:context.locale == Locale("en") ?width*0.04: 0,left:  context.locale == Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                      child: Text("End Time".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                      ),),
                                    ),
                                    Center(
                                      child: TextField(
                                        controller: myControllerduration,

                                        decoration: InputDecoration(
                                          prefixIcon: IconButton(
                                              onPressed: ()
                                              async {
                                                TimeOfDay? pickedTime =  await showTimePicker(
                                                  initialTime: TimeOfDay.now(),
                                                  context: context,
                                                );

                                                if(pickedTime != null ){
                                                  print(pickedTime.format(context));   //output 10:51 PM
                                                  DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                  //converting to DateTime so that we can further format on different pattern.
                                                  print(parsedTime); //output 1970-01-01 22:53:00.000
                                                  String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                  print(formattedTime); //output 14:59:00
                                                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                  setState(() {
                                                    myControllerduration.text = formattedTime; //set the value of text field.
                                                  });
                                                }else{
                                                  print("Time is not selected");
                                                }
                                              },
                                              // {

                                              //   var selectedTime = showTimePicker(
                                              //   initialTime: TimeOfDay.now(),
                                              //   context: context,
                                              //   builder: (context, child) {
                                              //     return Theme(
                                              //       data: ThemeData(
                                              //         //Header background color
                                              //         primaryColor: Color(0xff007A33),
                                              //         //Background color
                                              //         scaffoldBackgroundColor: Colors.white,
                                              //         //Divider color
                                              //         dividerColor: Colors.grey,
                                              //         //Non selected days of the month color
                                              //         textTheme: TextTheme(
                                              //           bodyText2:
                                              //           TextStyle(color: Colors.black),
                                              //         ),colorScheme: ColorScheme.fromSwatch().copyWith(
                                              //         //Selected dates background color
                                              //         primary: Color(0xff215732),
                                              //         //Month title and week days color
                                              //         onSurface: Colors.black,
                                              //         //Header elements and selected dates text color
                                              //         //onPrimary: Colors.white,
                                              //       ),),
                                              //       child: Column(
                                              //         children: [
                                              //           ConstrainedBox(
                                              //             constraints: BoxConstraints(
                                              //
                                              //             ),
                                              //             child: child,
                                              //           )
                                              //         ],
                                              //       ),
                                              //     );
                                              //
                                              //   },
                                              // );
                                              // myControllerstime.text = selectedTime.toString();
                                              // },
                                              icon:
                                              Icon(Icons.access_time,size: 18,  color: Color(0xFF999999))),

                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                          ),


                                        ),
                                      ),
                                    ),

                                    SizedBox(height: height*0.02),
                                    Padding(
                                      padding:EdgeInsets.only(right:context.locale == Locale("en") ?width*0.04: 0,left:  context.locale == Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                      child: Text("location".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                      ),),
                                    ),
                                    Center(
                                      child: TextField(
                                        controller: myControllerloc,
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

                                    SizedBox(height: height*0.02),

                                    Padding(
                                      padding: EdgeInsets.only(right:context.locale == Locale("en") ?width*0.04: 0,left:  context.locale == Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                      child: Text("Instructor".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                      ),),
                                    ),
                                    Center(
                                      child: Container(
                                          width: width*0.8,
                                          height: height*0.05,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xFFEEEEEE)),
                                            borderRadius: BorderRadius.circular(4.5),
                                          ),
                                          child: Padding(
                                            padding:  EdgeInsets.only(top: height*0.015,left: 8),
                                            child: Container(), // used to be role
                                          )
                                      ),
                                    ),

                                    SizedBox(height: height*0.02),


                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: width*0.33,
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

                                    SizedBox(height: height*0.07),

                                    Center(
                                      child:  ElevatedButton(
                                        onPressed: () {

                                          setState(() {
                                            submitForm();
                                          });
                                          //Navigator.pop(context);

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 40),
                                          child: Text('Confirm & add'.tr().toString(),strutStyle: StrutStyle(
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
                )),
          )
        ],
      ),
    );
  }
}
