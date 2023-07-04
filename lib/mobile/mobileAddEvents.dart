import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:date_time_format/date_time_format.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;

class mobileAddEvents extends StatefulWidget {
  @override
  _mobileAddEventsState createState() => _mobileAddEventsState();
}
class _mobileAddEventsState extends State<mobileAddEvents>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  late ScrollController _scrollController;

  final myControllersdate = TextEditingController();
  final myControlleredate = TextEditingController();
  final myControllersdatea = TextEditingController();
  final myControlleredatea = TextEditingController();

  final myControllerstime = TextEditingController();
  final myControlleretime = TextEditingController();
  final myControllerstimea = TextEditingController();
  final myControlleretimea = TextEditingController();

  final myControllertitlea = TextEditingController();
  final myControllerdesa = TextEditingController();
  final myControlleracca = TextEditingController();
  final myControllertagsa = TextEditingController();
  final myControllercapa = TextEditingController();
  final myControllerloca = TextEditingController();
  final myControllerlinka = TextEditingController();

  final myControllertitle = TextEditingController();
  final myControllerdes = TextEditingController();
  final myControlleracc = TextEditingController();
  final myControllertags = TextEditingController();
  final myControllercap = TextEditingController();
  final myControllerloc = TextEditingController();
  final myControllerlink = TextEditingController();



  Future<http.Response> postMYEvent () async {

    final myController1 = TextEditingController();
    final myController2 = TextEditingController();
    final myController3 = TextEditingController();
    final myController4 = TextEditingController();

    Map data =
    {
      "user_id": 0,
      "attending": 0,
      "event_id": 0,
      "event_title": "string",
      "event_start_date": "string",
      "event_end_date": "string",
      "event_start_time": "string",
      "event_end_time": "string",
      "event_description": "string",
      "event_mention_account": "string",
      "event_tags": "string",
      "event_link": "string",
      "event_schedule_time": "string",
      "event_capacity": 0,
      "event_location": "string",
      "rsvp": 0
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddMyEvents'),

        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },

        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }


  Future<http.Response> postRequest (DateTime? picked) async {


    Map data = {
      "event_title": myControllertitle.text,
      "event_start_date": myControllersdate.text,
      "event_end_date":myControlleredate.text,
      "event_start_time": myControllerstime.text,
      "event_end_time": myControlleretime.text,
      "event_description": myControllerdes.text,
      "event_mention_account": myControlleracc.text,
      "event_tags": myControllertags.text,
      "event_link": myControllerlink.text,
      "event_capacity": myControllercap.text,
      "event_schedule_time": "testing",
      "rsvp": 0,
    "event_display" : picked.toString(),

    "event_location": myControllerloc.text,

    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddEvent'),

        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },

        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> postRequestArb (DateTime? picked) async {


    Map data = {

      "event_title": myControllertitlea.text,
      "event_start_date": myControllersdatea.text,
      "event_end_date":myControlleredatea.text,
      "event_start_time": myControllerstimea.text,
      "event_end_time": myControlleretimea.text,
      "event_description": myControllerdesa.text,
      "event_mention_account": myControlleracca.text,
      "event_tags": myControllertagsa.text,
      "event_link": myControllerlinka.text,
      "event_capacity": myControllercapa.text,
      "event_schedule_time": "testing",
      "event_location": myControllerloca.text,
      "rsvp": 0,
      "event_display" : picked.toString(),


    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(global.apiAddress + 'AddArabicEvent'),

        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },

        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }


  // used when user tries to submit the form
  // if all text fields are valid, do the post request
  // otherwise alert user of error
  bool submitFormWithDate(DateTime? picked) {
    String errorText = "";

    // Arabic fields validity check
    errorText += validator.isValid("Arabic title", myControllertitlea.text, "empty");
    errorText += validator.isValid("Arabic start time", myControllerstimea.text, "empty;time");
    errorText += validator.isValid("Arabic start date", myControllersdatea.text, "empty;date");
    errorText += validator.isValid("Arabic end time", myControlleretimea.text, "empty;time");
    errorText += validator.isValid("Arabic end date", myControlleredatea.text, "empty;date");
    errorText += validator.isValid("Arabic description", myControllerdesa.text, "empty");
    errorText += validator.isValid("Arabic mentions", myControlleracca.text, "empty");
    errorText += validator.isValid("Arabic Tags", myControllertagsa.text, "empty");
    errorText += validator.isValid("Arabic location", myControllerloca.text, "empty");
    errorText += validator.isValid("Arabic capacity", myControllercapa.text, "empty;number");
    errorText += validator.isValid("Arabic invitation link", myControllerlinka.text, "empty;link");

    // English fields validity check
    errorText += validator.isValid("English title", myControllertitle.text, "empty");
    errorText += validator.isValid("English start time", myControllerstime.text, "empty;time");
    errorText += validator.isValid("English start date", myControllersdate.text, "empty;date");
    errorText += validator.isValid("English end time", myControlleretime.text, "empty;time");
    errorText += validator.isValid("English end date", myControlleredate.text, "empty;date");
    errorText += validator.isValid("English description", myControllerdes.text, "empty");
    errorText += validator.isValid("English mentions", myControlleracc.text, "empty");
    errorText += validator.isValid("English Tags", myControllertags.text, "empty");
    errorText += validator.isValid("English location", myControllerloc.text, "empty");
    errorText += validator.isValid("English capacity", myControllercap.text, "empty;number");
    errorText += validator.isValid("English invitation link", myControllerlink.text, "empty;link");

    // date time start end validators
    // putting it in an if statement cuz if the user get notified that thier date/time can't be greater before
    // they even input the date, that would be wierd
    if (errorText == "") {
      if (!validator.isDateGreater(myControllersdate.text, myControlleredate.text)) errorText += "${validator.bullet} English start date can't be greater than end date\n";
      if (!validator.isDateGreater(myControllersdatea.text, myControlleredatea.text)) errorText += "${validator.bullet} Arabic start date can't be greater than end date\n";
      if (!validator.isTimeGreater(myControllerstime.text, myControlleretime.text)) errorText += "${validator.bullet} English start time can't be greater than end time\n";
      if (!validator.isTimeGreater(myControllerstimea.text, myControlleretimea.text)) errorText += "${validator.bullet} Arabic start time can't be greater than end time\n";
    }
    if (errorText != "") {
      validator.mobileAlertDialog(context, errorText.substring(0, errorText.length - 1));
      return false;
    }

    // posting stuff
    postRequest(picked);
    postRequestArb(picked);
    postMYEvent();
    return true;
  }

  bool submitForm() {
    return submitFormWithDate(DateTime.now());
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
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

    return Scaffold(
      drawer: SideNavBar(),
      appBar: AppBar(
          toolbarHeight: height*0.15,
          automaticallyImplyLeading: false,
          title: Column(

            children: [
              SizedBox(height: height*0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    child: Row(
                      children: [
                        GestureDetector( onTap: () {Navigator.of(context).pop();}, child: Icon(Icons.arrow_back_ios,size: 15) ),
                        Text("Add new event".tr(),style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 22),
                        ),),
                      ],
                    ),
                  ),
    Container(

                  ),
                  // SizedBox(width: width*0.55,),
                  Builder(
                    builder: (context) => IconButton(
                      icon: new Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // actions: <Widget>[
          //
          // ],
          flexibleSpace: Container(

            decoration: BoxDecoration(
                image: DecorationImage(
                  // image: AssetImage(context.locale == Locale("en") ? 'assets/images/bgsmall.png' : 'assets/images/topNavArabic.png'),
                  image: AssetImage('assets/mobileImages/navbg.png'),
                  fit: BoxFit.fill,

                )

            ),

          )
      ),
      body: WebSmoothScroll(
        controller: _scrollController,

        child: SingleChildScrollView(
          child: Container(
            height: 5000,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),

                      Text("Administration /Events /".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                      ),
                      SizedBox(height: 10,),
                      Text("Add new event".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 13,),
                Card(
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
                        height:1370,

                        margin: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: TabBarView(
                          controller: _nestedTabController,
                          children: <Widget>[
                            Container(
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height*0.02,),
                                  Text("العنوان",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),
                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControllertitlea,
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
                                  Text("تاريخ البدء",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControllersdatea,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(

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
                                                myControllersdatea.text = date!.format('M d Y').toString();
                                              });
                                            });
                                          },
                                          icon:                          SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),

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
                                  Text("تاريخ الانتهاء",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControlleredatea,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(

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
                                                myControlleredatea.text = date!.format('M d Y').toString();
                                              });
                                            });
                                          },
                                          icon:                          SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),

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

                                  Text("وقت البدء",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControllerstimea,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.access_time,size: 18,  color: Color(0xFF999999)),

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

                                  Text("وقت الانتهاء",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                    controller: myControlleretimea,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.access_time,size: 18,  color: Color(0xFF999999)),

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

                                  Text("الوصف",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),

                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.3,
                                    child: TextField(
                                      controller: myControllerdesa,
                                      maxLines: 20,
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
                                  Divider(thickness: 1,color: Color(0xFFEEEEEE),),
                                  SizedBox(height: height*0.02,),
                                  Text("اذكر الحسابات",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),

                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.1,
                                    child: TextField(
                                      controller: myControlleracca,
                                      maxLines: 12,
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
                                  Text("العلامات",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),

                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.1,
                                    child: TextField(
                                      controller: myControllertagsa,
                                      maxLines: 12,
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

                                  Text("الموقع",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),
                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControllerloca,
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

                                  Text("الاهلية",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),
                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControllercapa,
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

                                  Text("رابط الدعوة",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),
                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControllerlinka,
                                      decoration: InputDecoration(
                                        suffixIcon: ImageIcon(AssetImage("images/copy.png"),size: 18,  color: Color(0xFF999999)),
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

                                  Text("الحجز",style: GoogleFonts.barlow(
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
                                  SizedBox(height: height*0.05,),
                                  Divider(thickness: 1,color: Color(0xFFEEEEEE),),

                                  SizedBox(height: height*0.05,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      SizedBox(
                                        height: height*0.055,
                                        width: width*0.44,
                                        child: ElevatedButton(
                                          onPressed: () {

                                          },
                                          child: Text('Schedule for later'.tr().toString(),strutStyle: StrutStyle(
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
                                        height: height*0.055,
                                        width: width*0.44,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            submitForm();
                                          },
                                          child: Text('Add event now'.tr().toString(),strutStyle: StrutStyle(
                                              forceStrutHeight: true
                                          ),style: GoogleFonts.barlow(
                                            textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                          )),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF215732),
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
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
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height*0.02,),
                                  Text("Title",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),
                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                       controller: myControllertitle,
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
                                  Text("Start date",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControllersdate,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(

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
                                                myControllersdate.text = date!.format('M d Y').toString();
                                              });
                                            });
                                          },
                                          icon:                          SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),

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
                                  Text("End date",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControlleredate,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(

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
                                                myControlleredate.text = date!.format('M d Y').toString();
                                              });
                                            });
                                          },
                                          icon:                          SvgPicture.asset("images/calendar.svg",fit: BoxFit.scaleDown,),

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

                                  Text("Start time",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControllerstime,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.access_time,size: 18,  color: Color(0xFF999999)),

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

                                  Text("End time",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControlleretime,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.access_time,size: 18,  color: Color(0xFF999999)),

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

                                  Text("Description",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),

                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.3,
                                    child: TextField(
                                      controller: myControllerdes,
                                      maxLines: 20,
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
                                  Divider(thickness: 1,color: Color(0xFFEEEEEE),),
                                  SizedBox(height: height*0.02,),
                                  Text("Mention",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),

                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.1,
                                    child: TextField(
                                      controller: myControlleracc,
                                      maxLines: 12,
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
                                  Text("Tags",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),

                                  SizedBox(height: height*0.009,),

                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.1,
                                    child: TextField(
                                      controller: myControllertags,
                                      maxLines: 12,
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

                                  Text("Location",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),
                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
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
                                  SizedBox(height: height*0.02,),

                                  Text("Capacity",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),
                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControllercap,
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

                                  Text("Invitation link",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),
                                  SizedBox(height: height*0.009,),
                                  SizedBox(
                                    width: width*0.95,
                                    height: height*0.05,
                                    child: TextField(
                                      controller: myControllerlink,
                                      decoration: InputDecoration(
                                        suffixIcon: ImageIcon(AssetImage("images/copy.png"),size: 18,  color: Color(0xFF999999)),
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

                                  Text("RSVP",style: GoogleFonts.barlow(
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
                                  SizedBox(height: height*0.05,),
                                  Divider(thickness: 1,color: Color(0xFFEEEEEE),),

                                  SizedBox(height: height*0.05,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      SizedBox(
                                        height: height*0.055,
                                        width: width*0.44,
                                        child: ElevatedButton(
                                          onPressed: () {

                                          },
                                          child: Text('Schedule for later'.tr().toString(),strutStyle: StrutStyle(
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
                                        height: height*0.055,
                                        width: width*0.44,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            submitForm();

                                          },
                                          child: Text('Add event now'.tr().toString(),strutStyle: StrutStyle(
                                              forceStrutHeight: true
                                          ),style: GoogleFonts.barlow(
                                            textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                          )),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF215732),
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
