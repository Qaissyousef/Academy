import 'dart:convert';
import 'package:date_time_format/date_time_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;

import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/util/fieldValidator.dart' as validator;


import '../models/instructorModel.dart';
import '../models/schedule_model.dart';

class newschedule extends StatefulWidget {
  final String cid;

  const newschedule({Key? key,required this.cid}) : super(key: key);

  @override
  State<newschedule> createState() => _newscheduleState();
}

class _newscheduleState extends State<newschedule> {
  String? dropdownvalue = 'Admin';
  var val = "eee";


  final myControllerloc = TextEditingController();
  final myControllerduration = TextEditingController();
  final myControllersdate = TextEditingController();
  final myControllerstime = TextEditingController();
  Future<http.Response> postRequest () async {


    Map data =
    {
      "course_id": widget.cid,

      "duration": myControllerduration.text,
      "date": myControllersdate.text,
      "time": myControllerstime.text,
      "location": myControllerloc.text,
      "material": "string",
      "instructor": val
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddSchedule'),

        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },

        body: body
    );

    setState(() {
      futureSchedule = fetchSchedule();

    });

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  bool submitForm() {
    String errorText = "";

    errorText += validator.isValid("date", myControllersdate.text, "empty;date");
    errorText += validator.isValid("end time", myControllerduration.text, "empty;time");
    errorText += validator.isValid("start time", myControllerstime.text, "empty;time");
    errorText += validator.isValid("location", myControllerloc.text, "empty");

    if (errorText == "") {
      if (!validator.isDateGreater(myControllerstime.text, myControllerduration.text)) errorText += "${validator.bullet} start time can't be greater than end time\n";
    }

    if (errorText != "") {
      validator.alertDialog(context, errorText.substring(0, errorText.length - 1));
      return false;
    }

    return true;
  }

  Future<List<InstructorModel>> fetchInstructor() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllInstructor/1'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<InstructorModel>((json) => InstructorModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
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
    'Mohammad Abdulrahman',
    'Abdulrahman',
    'Mohammad Abdul',
    'Mohammad ',

  ];

  Future<List<ScheduleCourse>> fetchSchedule() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetSchedule/22'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<ScheduleCourse>((json) => ScheduleCourse.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  late Future<List<ScheduleCourse>> futureSchedule;


  Future<http.Response> deleteRequestSchedule (int uid) async {


    Map data = {
      "course_id": 0,
      "schedule_id": uid,
      "duration": "string",
      "date": "string",
      "time": "string",
      "location": "string",
      "material": "string",
      "instructor": "string"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'DeleteSch'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  late ScrollController _scrollController;
  @override
  void initState() {
    futurefetchInstructor = fetchInstructor();
    futureSchedule = fetchSchedule();

    _scrollController = ScrollController();

    super.initState();
  }

  bool rowVisible = false;

  @override
  Widget build(BuildContext context) {


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final role = Container(
      height: height*0.3,
      child: FutureBuilder<List<InstructorModel>>(

        future: futurefetchInstructor ,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap:true,
              itemCount: 1,
              itemBuilder: (_, index) => Container(

                  child: Column(
                    children :[
                      DropdownButtonFormField(
                        decoration :const InputDecoration.collapsed(hintText: ''),
                        style: GoogleFonts.barlow(
                          textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                        ),
// Initial Value
                        value: snapshot.data![index].name,

// Down Arrow Icon
                        icon:const Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),

// Array list of items
                        items: snapshot.data!.map((list) {
                          return DropdownMenuItem(
                            value:  list.name.toString(),
                            child: Text( list.name ,),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            val = newValue!;

                            print (val);

                          });
                        },
                      ),],
                  )
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );

    // var formate1 = "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}";
    var formate2 = "${_dateTime2.day}-${_dateTime2.month}-${_dateTime2.year}";
    var formate3 = "${_dateTime3.day}-${_dateTime3.month}-${_dateTime3.year}";
    var formate4 = "${_dateTime4.day}-${_dateTime4.month}-${_dateTime4.year}";



    return Card(
      child: Container(
        height: height*0.9,
        width: width*0.92,
        child: WebSmoothScroll(
          controller: _scrollController,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.03),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [



                      Container(
                        width: width*0.67,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: width*0.92,
                              height: height*0.07,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF5F0E5),

                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(9.0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(9.0),
                                    bottomLeft: Radius.circular(0)),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: width*0.0125,),
                                  Container(
                                    width: width*0.17,
                                    child: Text("Schedule".tr(),style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 18),
                                    ),),
                                  ),
                                  Container(
                                    width: width*0.15,

                                    child: Text("Time".tr(),style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 18),
                                    ),),
                                  ),
                                  Container(
                                    width: width*0.18,


                                    child: Text("Instructor".tr(),style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 18),
                                    ),),
                                  ),
                                  Container(

                                    width: width*0.13,
                                    child: Text("Attachments".tr(),style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 18),
                                    ),),
                                  ),





                                ],
                              ),
                            ),
                            SizedBox(height: height*0.002,),

                            FutureBuilder<List<ScheduleCourse>>(

                              future: futureSchedule ,
                              builder: (context, snapshots) {
                                if (snapshots.hasData) {
                                  return ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap:true,
                                    itemCount: snapshots.data!.length,

                                    itemBuilder: (_, index) => Container(

                                        child: Column(
                                          children :[

                                            Material(
                                              elevation: 1,
                                              child: Container(
                                                color: Colors.white,
                                                width: width*0.9,
                                                height: height*0.07,

                                                child: Row(
                                                  children: [
                                                    SizedBox(width: width*0.0125,),
                                                    Row(
                                                      children: [

                                                        Container(
                                                          width: width*0.17,

                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: width*0.12,

                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text( "${snapshots.data![index].date}".toString().tr(),style: GoogleFonts.barlow(
                                                                      textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                                    ),),
                                                                    GestureDetector(
                                                                        onTap: (){



                                                                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2001), lastDate: DateTime(2100),
                                                                            builder: (context, child){
                                                                              return Theme(
                                                                                data: ThemeData(
                                                                                  //Header background color
                                                                                  primaryColor: const Color(0xff007A33),
                                                                                  //Background color
                                                                                  scaffoldBackgroundColor: Colors.white,
                                                                                  //Divider color
                                                                                  dividerColor: Colors.grey,
                                                                                  //Non selected days of the month color
                                                                                  textTheme: const TextTheme(
                                                                                    bodyMedium:
                                                                                    TextStyle(color: Colors.black),
                                                                                  ),colorScheme: ColorScheme.fromSwatch().copyWith(
                                                                                  //Selected dates background color
                                                                                  primary: const Color(0xff215732),
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
                                                                              _dateTime2 = date!;
                                                                            });
                                                                          });
                                                                        },
                                                                        child: SvgPicture.asset("assets/images/calendar.svg",fit: BoxFit.scaleDown,)),

                                                                  ],
                                                                ),
                                                              ),


                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width: width*0.15,

                                                      child: Row(
                                                        children: [
                                                          Text("${snapshots.data![index].time}".tr(),style: GoogleFonts.barlow(
                                                            textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                          ),),
                                                          SizedBox(width: width*0.009,),

                                                          SvgPicture.asset("assets/images/pen.svg",fit: BoxFit.scaleDown,),


                                                        ],
                                                      ),
                                                    ),
                                                    Container(

                                                      width: width*0.133,
                                                      child: FutureBuilder<List<InstructorModel>>(

                                                        future: futurefetchInstructor ,
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasData) {
                                                            return ListView.builder(
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              shrinkWrap:true,
                                                              itemCount: 1,
                                                              itemBuilder: (_, index) => Container(

                                                                  child: Column(
                                                                    children :[
                                                                      DropdownButtonFormField(
                                                                        decoration :const InputDecoration.collapsed(hintText: ''),
                                                                        style: GoogleFonts.barlow(
                                                                          textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                                        ),
// Initial Value
                                                                        value: snapshots.data![index].instructor,

// Down Arrow Icon
                                                                        icon:const Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),

// Array list of items
                                                                        items: snapshot.data!.map((list) {
                                                                          return DropdownMenuItem(
                                                                            value:  list.name.toString(),
                                                                            child: Text( list.name ,),
                                                                          );
                                                                        }).toList(),
                                                                        onChanged: (String? newValue) {
                                                                          setState(() {
                                                                            val = newValue!;

                                                                            print (val);

                                                                          });
                                                                        },
                                                                      ),],
                                                                  )
                                                              ),
                                                            );
                                                          } else {
                                                            return const Center(child: CircularProgressIndicator());
                                                          }
                                                        },
                                                      ),

                                                    ),
                                                    SizedBox(width: width*0.045,),
                                                    Container(
                                                      width: width*0.13,


                                                      child: Row(
                                                        children: [
                                                          Text("doc1.pdf".tr(),style: GoogleFonts.barlow(
                                                            textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                          ),),
                                                          SizedBox(width: width*0.009,),

                                                          SvgPicture.asset("assets/images/red_bin.svg",color: const Color(0xFFF64747),fit: BoxFit.scaleDown,),
                                                          SizedBox(width: width*0.006,),
                                                          const Icon(Icons.add_circle_outline,size: 18,color: Color(0Xff222222),),


                                                        ],
                                                      ),
                                                    ),
                                                    PopupMenuButton(
                                                      onSelected: (result) {
                                                        // your logic
                                                        if (result == 0) {
                                                          print("delete");
                                                          deleteRequestSchedule(snapshots.data![index].schedule_id);
                                                        }

                                                      },
                                                      itemBuilder: (BuildContext bc) {
                                                        return const [
                                                          PopupMenuItem(
                                                            value: 0,
                                                            child: Text("Delete"),
                                                          ),
                                                        ];
                                                      },
                                                    )








                                                  ],
                                                ),
                                              ),
                                            ),






                                          ],
                                        )
                                    ),
                                  );
                                } else {
                                  return const Center(child: CircularProgressIndicator());
                                }
                              },
                            ),
                            // detailrow,
                            // detailrow1,
                            // detailrow2,



                          ],
                        ),
                      ),
                      SizedBox(height: height*0.04),

                      Row(
                        children: [


                          SizedBox(width: width*0.584,),


                          GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {

                                    Locale? lang = const Locale("en");
                                    return AlertDialog(
                                      shape: const RoundedRectangleBorder(
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
                                                  child: const Icon(Icons.close))),
                                          Center(child: Text("Add Schedule".tr(),style: GoogleFonts.barlow(
                                            textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 28),
                                          ),),),
                                        ],
                                      ),
                                      content: Padding(
                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),

                                        child: Form(
                                          child:

                                          Column(

                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                              Center(
                                                child: Text("Enter the details below to add scheulde".tr(),style: GoogleFonts.barlow(
                                                  textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                ),),
                                              ),
                                              SizedBox(height: height*0.07),
                                              Padding(
                                                padding:
                                                EdgeInsets.only( right:context.locale == const Locale("en") ?width*0.04: 0,left:  context.locale == const Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                                child: Text("date".tr(),style: GoogleFonts.barlow(
                                                  textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
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
                                                                primaryColor: const Color(0xff007A33),
                                                                //Background color
                                                                scaffoldBackgroundColor: Colors.white,
                                                                //Divider color
                                                                dividerColor: Colors.grey,
                                                                //Non selected days of the month color
                                                                textTheme: const TextTheme(
                                                                  bodyText2:
                                                                  TextStyle(color: Colors.black),
                                                                ),colorScheme: ColorScheme.fromSwatch().copyWith(
                                                                //Selected dates background color
                                                                primary: const Color(0xff215732),
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
                                                            myControllersdate.text = date.format('M d Y').toString();
                                                          });
                                                        });
                                                      },
                                                      icon:  SvgPicture.asset("assets/images/calendar.svg",fit: BoxFit.scaleDown,),

                                                    ),
                                                    focusedBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                    ),
                                                    enabledBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                    ),


                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: height*0.02),
                                              Padding(
                                                padding:

                                                EdgeInsets.only(right:context.locale == const Locale("en") ?width*0.04: 0,left:  context.locale == const Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                                child: Text("time".tr(),style: GoogleFonts.barlow(
                                                  textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
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
                                                        const Icon(Icons.access_time,size: 18,  color: Color(0xFF999999))),

                                                    focusedBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                    ),
                                                    enabledBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                    ),


                                                  ),
                                                ),
                                              ),

                                              SizedBox(height: height*0.02),
                                              Padding(
                                                padding:  EdgeInsets.only(right:context.locale == const Locale("en") ?width*0.04: 0,left:  context.locale == const Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                                child: Text("End Time".tr(),style: GoogleFonts.barlow(
                                                  textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
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
                                                        const Icon(Icons.access_time,size: 18,  color: Color(0xFF999999))),

                                                    focusedBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                    ),
                                                    enabledBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                    ),


                                                  ),
                                                ),
                                              ),

                                              SizedBox(height: height*0.02),
                                              Padding(
                                                padding:EdgeInsets.only(right:context.locale == const Locale("en") ?width*0.04: 0,left:  context.locale == const Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                                child: Text("location".tr(),style: GoogleFonts.barlow(
                                                  textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                ),),
                                              ),
                                              Center(
                                                child: SizedBox(
                                                  width: width*0.25,
                                                  height: height*0.05,
                                                  child: TextField(
                                                    controller: myControllerloc,
                                                    decoration: const InputDecoration(

                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
                                                      ),


                                                    ),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(height: height*0.02),

                                              Padding(
                                                padding: EdgeInsets.only(right:context.locale == const Locale("en") ?width*0.04: 0,left:  context.locale == const Locale("en") ?0: width*0.04 ,bottom: height*0.01),
                                                child: Text("Instructor".tr(),style: GoogleFonts.barlow(
                                                  textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                ),),
                                              ),
                                              Center(
                                                child: Container(
                                                    width: width*0.25,

                                                    height: height*0.05,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color(0xFFEEEEEE)),
                                                      borderRadius: BorderRadius.circular(4.5),
                                                    ),
                                                    child: Padding(
                                                      padding:  EdgeInsets.only(top: height*0.015,left: 8),
                                                      child: role,
                                                    )
                                                ),
                                              ),

                                              SizedBox(height: height*0.07),

                                              Center(
                                                child: SizedBox(
                                                  width: width*0.25,

                                                  child: Row(
                                                    mainAxisAlignment : MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {

                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          elevation: 0.0,
                                                          shadowColor: Colors.transparent,
                                                          primary: const Color(0xFFF5F0E5),
                                                          onPrimary: const Color(0xFF183028),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(7),
                                                          ),

                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 14,horizontal:50),
                                                          child: Text('Cancel'.tr().toString(),strutStyle: const StrutStyle(
                                                              forceStrutHeight: true
                                                          ),style: GoogleFonts.barlow(
                                                            textStyle: const TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                          ),),
                                                        ),
                                                      ),
                                                      SizedBox(width: width*0.014,),
                                                      ElevatedButton(
                                                        onPressed: submitForm,
                                                        style: ElevatedButton.styleFrom(
                                                          primary: const Color(0xFF215732),
                                                          elevation: 0.0,
                                                          shadowColor: Colors.transparent,
                                                          onPrimary: const Color(0xFFFFFFFF),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(7),
                                                          ),

                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 25),
                                                          child: Text('Confirm & add'.tr().toString(),strutStyle: const StrutStyle(
                                                              forceStrutHeight: true
                                                          ),style: GoogleFonts.barlow(
                                                            textStyle: const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                          )),
                                                        ),
                                                      ),

                                                    ],
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
                            child: Container(

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFF999999),width: 1)
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.15,vertical: 10.0),
                                    child:                                 Icon(Icons.add_circle_outline,size: 14,color: Color(0Xff999999),),

                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 1.15,vertical: 10.0),

                                    child:  Text("  Add new section  ".tr(),style: GoogleFonts.barlow(
                                      textStyle: const TextStyle(color: Color(0Xff999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                    ),),
                                  ),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),













                    ],
                  ),






                ],
              ),
            ),
          ),
        ),),
    );
  }
}



