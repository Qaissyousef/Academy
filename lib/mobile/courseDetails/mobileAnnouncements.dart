import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pif_admin_dashboard/mobile/mobileAddAnn.dart';
import 'package:pif_admin_dashboard/mobile/mobileCurrentAnn.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/ann_model.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;

class mobileAnnouncements extends StatefulWidget {
  const mobileAnnouncements({Key? key}) : super(key: key);

  @override
  State<mobileAnnouncements> createState() => _mobileAnnouncementsState();
}

class _mobileAnnouncementsState extends State<mobileAnnouncements> {
  Future<List<Announcement>> fetchPostEng() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllAnnEng'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Announcement>((json) => Announcement.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Announcement>> fetchPostArb() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllAnnArb'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Announcement>((json) => Announcement.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  late Future<List<Announcement>> futureAnnEng;
  late Future<List<Announcement>> futureAnnArb;
  Future<List<Announcement>> searchPostEng(String name) async {
    print("enter");
    List<Announcement> ann = [];
    List<Announcement> results = [];
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetAllAnnEng'));


    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        ann.add(Announcement.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        ann.sort((a, b) => DateTime.parse(a.ann_creation_time)
            .compareTo(DateTime.parse(b.ann_creation_time)));
      } else {
        ann.sort((a, b) => DateTime.parse(b.ann_creation_time)
            .compareTo(DateTime.parse(a.ann_creation_time)));
      }

      if (name.isNotEmpty) {
        ann.forEach((element) {
          if (element.ann_title.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(ann);
      }
      print(results.length);
      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }
  TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;
  DateTimeRange? picked = DateTimeRange(
      start: DateTime.now()
          .subtract(const Duration(days: 365 * 5)),
      end: DateTime.now()
          .add((const Duration(days: 365 * 5))));

  bool isAscending = false;
  DateTimeRange date =
  DateTimeRange(start: DateTime.now(), end: DateTime.now());
  bool hasData = true;

  @override
  void initState() {
    futureAnnArb = fetchPostArb();
    futureAnnEng = fetchPostEng();
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final num = SizedBox(
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("08".tr().toString(),strutStyle: StrutStyle(
                  forceStrutHeight: true
              )),
              SizedBox(width: 70,),
              Icon(Icons.expand_more_rounded,size: 16,color: Color(0xFF999999),)
            ],
          ),
          onPressed: (){
            print("You pressed Icon Elevated Button");
          },
          // icon: Icon(Icons.filter_list),
          //  //label text
          style: ElevatedButton.styleFrom(
              elevation: 0,
              side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
              primary: Colors.white ,//elevated btton background color
              onPrimary: Colors.black,
              minimumSize: Size(135,50)
          ),
        ));


    Future<List<Announcement>> filterPostEng(
        bool isAscending, DateTimeRange date) async {
      print("enter");
      List<Announcement> ann = [];
      List<Announcement> results = [];
      final response =
      await http.get(Uri.parse(global.apiAddress + 'GetAllAnnEng'));


      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        var list = json.decode(response.body);

        for (int i = 0; i < list.length; i++) {
          ann.add(Announcement.fromMap(jsonDecode(response.body)[i]));
        }

        if (isAscending) {
          ann.sort((a, b) => DateTime.parse(a.ann_creation_time)
              .compareTo(DateTime.parse(b.ann_creation_time)));
        } else {
          ann.sort((a, b) => DateTime.parse(b.ann_creation_time)
              .compareTo(DateTime.parse(a.ann_creation_time)));
        }

        var startDate = date.start;
        var endDate = date.end;

        for (int i = 0; i < ann.length; i++) {
          var eventStart = DateTime.parse(ann[i].ann_creation_time);
          print(startDate);
          print(endDate);
          print(eventStart);
          if (eventStart.isAfter(startDate) && eventStart.isBefore(endDate)) {
            print("true");
            results.add(ann[i]);
          }
        }
        print(results.length);

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
                                    isAscending = false;
                                    futureAnnEng = filterPostEng(
                                            isAscending,
                                            picked!);
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
                                  setState(() {
                                    isAscending = true;
                                    futureAnnEng =
                                        filterPostEng(
                                            isAscending,
                                            picked!);
                                  });

                                  Navigator.pop(context);
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
          onChanged: (value) {
            setState(() {
              futureAnnEng = searchPostEng(value);
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

    final filter = SizedBox(height: height*0.055,
        width: width*0.44,
        child : ElevatedButton.icon(
          onPressed: () async {
            picked = await showDateRangePicker(
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
                      bodyText2: TextStyle(color: Colors.black),
                    ),
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      //Selected dates background color
                      primary: Color(0xff007A33),
                      //Month title and week days color
                      onSurface: Colors.black,
                      //Header elements and selected dates text color
                      onPrimary: Colors.white,
                    ),
                  ),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 400.0,
                          maxHeight: height * 0.7,
                        ),
                        child: child,
                      )
                    ],
                  ),
                );
              },
            );
            setState(() {
              if (picked != null) {
                futureAnnEng = filterPostEng(isAscending, picked!);
              } else {
                futureAnnEng = filterPostEng(
                    isAscending,picked!);
              }
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

    annCard(Announcement a) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Color(0xffffffff),
      
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(

                    child: Text(a.ann_title.tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                    ),
                  ),

                  Container(
                      child: Icon(Icons.more_vert_outlined,color: Color(0xFF999999),size: 20,)
                  )
                ],
              ),
            ),

            // description
            Text(a.ann_description.tr().toString(),strutStyle: StrutStyle(
                forceStrutHeight: true
            ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
            ),

            SizedBox(height: height*0.01),
            // date
            const Divider(thickness: 0.2,
              color: Color(0xFF999999),
            ),
            SizedBox(
              height: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("Date".tr().toString(),strutStyle: StrutStyle(
                      forceStrutHeight: true
                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                  ),
                  Text(a.ann_creation_time.split("T")[0].tr().toString(),strutStyle: StrutStyle(
                      forceStrutHeight: true
                  ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                  )
                ],
              ),
            ),

            SizedBox(height: height*0.03),
                
            Center(
              child: InkWell(
                hoverColor: Colors.transparent,
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mobileCurrentAnn(current_ann: a.ann_id)),
                  ).then((value) {
                    setState(() {
                      futureAnnArb = fetchPostArb();
                      futureAnnEng = fetchPostEng();
                    });
                  });
                },
                child: Container(
                  height: height*0.058,

                  width: 100,
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.black,width: 0.5),

                  ),
                  child: Center(
                    child: Text("View More".tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                    ),),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );



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
                      children: [GestureDetector( onTap: () {Navigator.of(context).pop();}, child: Icon(Icons.arrow_back_ios,size: 15) ),
                        Container(

                          child: Text("Announcements".tr(),style: GoogleFonts.barlow(
                            textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 22),
                          ),),
                        ),],
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
                          Text("Announcements".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.05,),



                    ],
                  ),
                  SizedBox(height: height*0.02,),
                  SizedBox(
                    height: height*0.058,

                    width: width*0.92,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => mobileAddAnn()),
                          ).then((value) {
                            setState(() {
                              futureAnnArb = fetchPostArb();
                              futureAnnEng = fetchPostEng();
                            });
                          });
                        },
                        child: Text("Add new announcement".tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ), style: GoogleFonts.barlow(textStyle:  TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFFBFCFC) ),
                        ),),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF215732),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),

                            side: BorderSide(
                                width: 0.4,
                                color: Color(0xFF215732)
                            )
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height*0.02,),

                  search,
                  SizedBox(height: height*0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    filter,sort
                  ],),
                  SizedBox(height: height*0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      num,
                      Text("Showing 6 of 6 results".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                      ),),
                  ],),
                  SizedBox(height: height*0.02,),

                  FutureBuilder <List<Announcement>>(
                    future: context.locale == const Locale("en") ? futureAnnEng : futureAnnArb,
                    builder: (context, snapshot) {
                      if (snapshot.hasData){
                        return Column(
                          children: [
                            for(var ann in snapshot.data ?? [])
                              annCard(ann)
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
