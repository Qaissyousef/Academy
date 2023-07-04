import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/event_model.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pif_admin_dashboard/mobile/mobileAddEvents.dart';
import 'package:pif_admin_dashboard/mobile/mobileCurrentEvent.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';


class mobileEvents extends StatefulWidget {
  const mobileEvents({Key? key}) : super(key: key);

  @override
  State<mobileEvents> createState() => _mobileEventsState();
}

class _mobileEventsState extends State<mobileEvents> {
  Future<List<EventModel>> fetchEventsEng() async {
    final responseEng =
    await http.get(Uri.parse(global.apiAddress + 'GetAllEventsEng'));

    if (responseEng.statusCode == 200) {
      final parsedEng = json.decode(responseEng.body).cast<Map<String, dynamic>>();

      return parsedEng.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<EventModel>> filterEventPost(bool isAscending, bool isHighest,
      String category, String date, String location) async {
    List<EventModel> events = [];
    List<EventModel> results = [];
    final response =  await http.get(Uri.parse(global.apiAddress + 'GetAllEventsEng'));


    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        events.add(EventModel.fromMap(jsonDecode(response.body)[i]));
      }
      if (isHighest) {
        events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));
      } else {
        events.sort((a, b) => a.event_capacity.compareTo(b.event_capacity));
      }
      // if (category.compareTo("Date") == 0) {
      //   if (isAscending) {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(a.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(b.event_start_date)));
      //   } else {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(b.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(a.event_start_date)));
      //   }
      // } else {
      //   if (isHighest) {
      //     events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));
      //   } else {
      //     events.sort((a, b) => a.event_capacity.compareTo(b.event_capacity));
      //   }
      // }

      var now = new DateTime.now();
      var now_1w = now.subtract(const Duration(days: 7));
      var now_1m = now.subtract(const Duration(days: 30));

      if (date == "All") {
        for (int i = 0; i < events.length; i++) {
          if (events[i].event_location.compareTo(location) == 0 ||
              location == "All") {
            results.add(events[i]);
          }
        }
      } else if (date == "Latest") {
        events.sort((a, b) => b.event_start_date.compareTo(a.event_start_date));
        results = events.sublist(0, 10);
      } else if (date == "week") {
        for (int i = 0; i < events.length; i++) {
          var eventDate =
          DateFormat('d MMM y').parse(events[i].event_start_date);
          if (eventDate.isAfter(now_1w) &&
              (events[i].event_location.compareTo(location) == 0 ||
                  location == "All")) {
            results.add(events[i]);
          }
        }
      } else if (date == "month") {
        for (int i = 0; i < events.length; i++) {
          var eventDate =
          DateFormat('d MMM y').parse(events[i].event_start_date);
          if (eventDate.isAfter(now_1m) &&
              (events[i].event_location.compareTo(location) == 0 ||
                  location == "All")) {
            results.add(events[i]);
          }
        }
      }

      if (results.isEmpty) {
        hasData = false;
      } else {
        hasData = true;
      }

      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> fetchEventsArb() async {
    final responseArb =
    await http.get(Uri.parse(global.apiAddress + 'GetAllEventsArb'));

    if (responseArb.statusCode == 200) {
      final parsedArb = json.decode(responseArb.body).cast<Map<String, dynamic>>();

      return parsedArb.map<EventModel>((json) => EventModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<EventModel>> searchEventPost(String name) async {
    List<EventModel> events = [];
    List<EventModel> results = [];
    final response =  await http.get(Uri.parse(global.apiAddress + 'GetAllEventsEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        events.add(EventModel.fromMap(jsonDecode(response.body)[i]));
      }

      // if (category.compareTo("Date") == 0) {
      //   if (isAscending) {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(a.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(b.event_start_date)));
      //   } else {
      //     events.sort((a, b) => DateFormat('d MMM y')
      //         .parse(b.event_start_date)
      //         .compareTo(DateFormat('d MMM y').parse(a.event_start_date)));
      //   }
      // } else
      // {
      events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));

      if (isHighest) {
        events.sort((a, b) => b.event_capacity.compareTo(a.event_capacity));
      } else {
        events.sort((a, b) => a.event_capacity.compareTo(b.event_capacity));
      }
      // }

      if (name.isNotEmpty) {
        events.forEach((element) {
          if (element.event_title.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(events);
      }

      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }


  late Future<List<EventModel>> futureEventsEng;
  late Future<List<EventModel>> futureEventsArb;
  bool isAscending = false;
  bool isHighest = true;
  String category = "Date";
  String date = "All";
  String location = "All";
  TextEditingController _searchController = TextEditingController();
  bool hasData = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    // initialize scroll controllers
    futureEventsEng = fetchEventsEng();
    futureEventsArb = fetchEventsArb();
    _scrollController = ScrollController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                                    isHighest = true;
                                    category = "Capacity";
                                  });
                                  futureEventsEng = filterEventPost(
                                      isAscending,
                                      isHighest,
                                      category,
                                      date,
                                      location);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Highest to Lowest'.tr().toString(),strutStyle: StrutStyle(
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
                                  setState(() {
                                    isHighest = false;
                                    category = "Capacity";
                                  });
                                  futureEventsEng = filterEventPost(
                                      isAscending,
                                      isHighest,
                                      category,
                                      date,
                                      location);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text('Lowest to Highest'.tr().toString(),strutStyle: StrutStyle(
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
          onChanged: (value) {
            setState(() {
              futureEventsEng = searchEventPost(value);

            });
          },
          controller: _searchController,
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

    final num = Container(
      width: width*0.435,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xFF999999),width: 0.2),

      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("10".tr().toString(),strutStyle: StrutStyle(
                forceStrutHeight: true
            )),
            SizedBox(width: 162,),
            Icon(Icons.expand_more_rounded,size: 16,color: Color(0xFF999999),)
          ],
        ),
      ),

    );

    
      eventCard(EventModel e) {
        // intializing data
        List<String> items = ['Capacity', 'RSPV', 'Location', 'Date', 'Time'];
        List<String> eventData = [e.event_capacity.toString(), e.rsvp.toString(), e.event_location, 
        e.event_start_date, "${e.event_start_time} - ${e.event_end_time}"];

        // Card body
        return Card(
          color: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title row
                SizedBox(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.event_title.tr().toString(),
                          strutStyle: const StrutStyle( forceStrutHeight: true),
                          style:  GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                        ),
                        const Icon(Icons.more_vert_outlined,color: Color(0xFF999999),size: 20,)
                      ],
                    ),
                  ),


                // Event data rows
                Column(
                  children: <Widget>[
                    for(int i = 0;  i < items.length; i++)
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items[i].tr().toString(),
                                  strutStyle: const StrutStyle( forceStrutHeight: true),
                                  style:  GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                ),

                                Text(
                                  eventData[i],
                                  strutStyle: const StrutStyle(forceStrutHeight: true),
                                  style:  GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: Color(0xFF999999),
                          ),
                        ],
                      ),
                  ],
                ),

                // View More Button
                Center(
                  child: Container(
                    height: height*0.058,
                    width: 90,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.black,width: 0.5),

                    ),

                    child: InkWell(
                      hoverColor: Colors.transparent,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mobileCurrentEvents(eventID: e.event_id)),
                        ).then((value) {
                          setState(() {
                            futureEventsEng = fetchEventsEng();
                            futureEventsArb = fetchEventsArb();
                          });
                        });
                      },
                      child: Center(
                        child: Text(
                          "View More".tr(),
                          style: GoogleFonts.barlow(
                            textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }


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
                        InkWell(hoverColor:Colors.transparent, onTap: () {Navigator.of(context).pop();}, child: Icon(Icons.arrow_back_ios,size: 15) ),
                        Text("Events".tr(),style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 22),
                        ),),
                      ],
                    ),
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

      body:  Container(
        height: height,
        width: width,
        child: WebSmoothScroll(
          controller: _scrollController,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  SizedBox(height: height*0.02,),
                  Row(
                    children: [
                      SizedBox(height: height*0.05,),


                      Row(
                        children: [
                          Text("Administration /".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ),
                          Text("Events".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.05,),




                    ],
                  ),
                  SizedBox(height: height*0.03,),
                  Row(
                    children: [




                      SizedBox(
                        height: height*0.058,

                        width: width*0.88,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => mobileAddEvents()),
                            ).then((value) {
                              setState(() {
                                futureEventsArb = fetchEventsArb();
                                futureEventsEng = fetchEventsEng();
                              });
                            });
                          },
                          child: Text("Add new event".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style: GoogleFonts.barlow(
                            textStyle: TextStyle(color:Colors.white, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                          )),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF215732),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),

                              side: BorderSide(
                                  width: 0.4,
                                  color: Colors.black
                              )
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: height*0.02,),
                  search,
                  SizedBox(height: height*0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                    filter,sort
                  ],),
                  SizedBox(height: height*0.017),
                  FutureBuilder <List<EventModel>>(
                    future: context.locale == const Locale("en") ? futureEventsEng : futureEventsArb,
                    builder: (context, snapshot) {
                      if (snapshot.hasData){
                        return Column(
                          children: [
                            for(var event in snapshot.data ?? [])
                              eventCard(event)
                          ],
                        );
                      }
                      return Container();
                    }
                  ),
                  ],
                ),
              ),
            ),
          ),),
      );
    }
}
