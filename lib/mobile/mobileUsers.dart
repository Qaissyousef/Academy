import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pif_admin_dashboard/mobile/mobileUserAdd.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:pif_admin_dashboard/mobile/specificUser.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';

class mobileUsers extends StatefulWidget {
  const mobileUsers({Key? key}) : super(key: key);

  @override
  State<mobileUsers> createState() => _mobileUsersState();
}

class _mobileUsersState extends State<mobileUsers> {
  late ScrollController _scrollController;
  String user_status = "All";
  String user_role = "All";
  Future<List<User>> fetchPostEng(bool isAscending) async {
    List<User> users = [];
    final response = await http
        .get(Uri.parse(global.apiAddress + 'GetAllUsers'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        users.add(User.fromMap(jsonDecode(response.body)[i]));
      }
      if (isAscending) {
        users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      } else {
        users.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      }
      return users;
    } else {
      throw Exception('Failed to load album');
    }
  }
  late Future<List<User>> futurePostEng;
  Future<List<User>> filterPost(
      bool isAscending, String status, String role) async {
    List<User> users = [];
    List<User> results = [];
    final response = await http
        .get(Uri.parse(global.apiAddress + 'GetAllUsers'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        users.add(User.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      } else {
        users.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      }

      var now = DateTime.now();
      var now_1w = now.subtract(const Duration(days: 7));
      var now_1m = now.subtract(const Duration(days: 30));

      if (status.compareTo("All") == 0) {
        for (int i = 0; i < users.length; i++) {
          if (users[i].user_type.compareTo(role) == 0 ||
              role.compareTo("All") == 0) {
            print("Role all: " + role);
            print("User type all: " + users[i].user_type.tr().toString());
            results.add(users[i]);
          }
        }
      }
      else if(status.compareTo("Active") == 0)
      {
        for (int i = 0; i < users.length; i++) {
          if ((users[i].user_type.compareTo(role) == 0 &&
              users[i].user_status.compareTo("Active") == 0) || (role.compareTo("All") == 0 &&
              users[i].user_status.compareTo("Active") == 0)) {
            print("Role all: " + role);
            print("User type all: " + users[i].user_type.tr().toString());
            results.add(users[i]);
          }
        }

      }
      else if(status.compareTo("Deactivate")==0)
      {
        for (int i = 0; i < users.length; i++) {
          if ((users[i].user_type.compareTo(role) == 0 &&
              users[i].user_status.compareTo("Deactivate") == 0) || (role.compareTo("All") == 0 &&
              users[i].user_status.compareTo("Deactivate") == 0)) {
            print("Role all: " + role);
            print("User type all: " + users[i].user_type.tr().toString());
            results.add(users[i]);
          }
        }
      }

      // else {
      //   for (int i = 0; i < 10; i++) {
      //     print("Role ${status}: " + role);
      //     print("user ${users[i].user_status}: ".tr().toString() +
      //         users[i].user_type);
      //     if (users[i].user_status.toLowerCase().compareTo(status) == 0 &&
      //         (users[i].user_type.toLowerCase().compareTo(role) == 0 ||
      //             role.compareTo("All") == 0)) {
      //       results.add(users[i]);
      //     }
      //   }
      // }

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
  Future<List<User>> searchPost(String name) async {
    List<User> users = [];
    List<User> results = [];
    final response = await http
        .get(Uri.parse(global.apiAddress + 'GetAllUsers'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        users.add(User.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      } else {
        users.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      }

      if (name.isNotEmpty) {
        users.forEach((element) {
          if (element.name.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(users);
      }

      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }
  late List<User> userList = [];
  TextEditingController _searchController = TextEditingController();

  bool hasData = true;
  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();
    futurePostEng = fetchPostEng(isAscending);

    super.initState();
  }
  String dropdownvalue1 = 'Admin'.tr();
  String dropdownvalue = 'Admin'.tr();


  bool isAscending = true;
  // List of items in our dropdown menu
  var items = [

    'Admin'.tr(),
    'Participant'.tr(),
    'Instructor'.tr()

  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final role = Container(
      width: width*0.9,
      height: height*0.05,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: const InputDecoration.collapsed(hintText: ''),
          icon:const Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),

          iconSize: 4.0,

          // Initial Value
          value: dropdownvalue,
          // Down Arrow Icon

          // Array list of items
          items: [
            DropdownMenuItem( value: "Admin".tr(),
              child: Padding(
                padding:  const EdgeInsets.only(left: 8.0),
                child: Text( 'Instructor'.tr().toString(),    style: GoogleFonts.barlow(textStyle:  const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),),
              ),),

            DropdownMenuItem( value: "Instructor".tr(),
              child: Text('Admin'.tr().toString(),    style: GoogleFonts.barlow(textStyle:  const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),),),


            DropdownMenuItem( value: "Participants".tr(),
              child: Text('Participant'.tr().toString(),    style: GoogleFonts.barlow(textStyle:  const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),),),

          ],

          onChanged: (String? newValue) {
            setState(() {




            });
          },
        ),
      ),
    );

    final sort =
    SizedBox(
        height: height*0.055,
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
                              icon:  const Icon(Icons.arrow_back_ios_new,size: 18),
                              onPressed: () {  Navigator.of(context).pop(); },
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Text("Sort".tr(),style: GoogleFonts.barlow(
                                textStyle :const TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color: Color(0xff222222) ),)),

                              ],
                            ),
                            const SizedBox(width: 1,)

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
                                    isAscending = true;
                                  });
                                  futurePostEng =
                                      filterPost(isAscending,user_status,user_role);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('A -> Z'.tr().toString(),strutStyle: const StrutStyle(
                                        forceStrutHeight: true
                                    ),style: GoogleFonts.barlow(textStyle:const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),),
                                    const SizedBox(width: 5,),SvgPicture.asset('assets/images/tick.svg',), const SizedBox(width: 5),],),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    side: const BorderSide(
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

                              child: ElevatedButton(onPressed: () {
                                setState(() {
                                  isAscending = false;
                                });
                                futurePostEng =
                                    filterPost(isAscending,user_status,user_role);
                                Navigator.pop(context);
                              },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text('Z -> A'.tr().toString(),strutStyle: const StrutStyle(
                                        forceStrutHeight: true
                                    ),style: GoogleFonts.barlow(textStyle:const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),)],),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    side: const BorderSide(
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
          icon: const Icon(Icons.filter_list),  //icon data for elevated button
          label: Text("Sort".tr().toString(),strutStyle: const StrutStyle(
              forceStrutHeight: true
          )), //label text
          style: ElevatedButton.styleFrom(
              elevation: 0,
              side: const BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
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

            border: Border.all(color: const Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              futurePostEng = searchPost(value);

            });
          },
          controller: _searchController,
          decoration: InputDecoration(
            prefixIcon:  SvgPicture.asset("images/search.svg",fit: BoxFit.scaleDown,),
            border: InputBorder.none,

            hintText: 'Search'.tr().toString(),
            contentPadding: const EdgeInsets.only(top:10),
            hintStyle:  GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ) ),
            
            // enabledBorder: const OutlineInputBorder(
            //   // borderSide: const BorderSide(color: Color(0xFFEEEEEE),),
            // ),



          ),



        ),
      ),
    );

    final filter = SizedBox(height: height*0.055,
        width: width*0.47,
        child : ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                String? dropdownvalue = 'Admin';
                Locale? lang = const Locale("en");
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  scrollable: true,

                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.close))),
                      ],
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Form(
                      child: Row(
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account Type".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: const TextStyle(
                                        color: Color(0xFF222222),
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Container(
                                  width: width * 0.3,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(color: Color(0xFFEEEEEE)))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.012,
                                    ),
                                    child: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              user_role = "All";
                                              futurePostEng = filterPost(
                                                  isAscending, user_status, user_role);
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "All".tr(),
                                            style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(
                                                  color: Color(0xFF222222),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.04,
                                        ),
                                        user_role.compareTo("All") == 0
                                            ? SvgPicture.asset(
                                          "assets/images/sortyes.svg",
                                          fit: BoxFit.scaleDown,
                                        )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.012,
                                ),
                                Container(
                                  width: width * 0.3,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(color: Color(0xFFEEEEEE)))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.012,
                                    ),
                                    child: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              user_role = "Admin";
                                              futurePostEng = filterPost(
                                                  isAscending, user_status, user_role);
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Admin".tr(),
                                            style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(
                                                  color: Color(0xFF222222),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.04,
                                        ),
                                        user_role.compareTo("Admin") == 0
                                            ? SvgPicture.asset(
                                          "assets/images/sortyes.svg",
                                          fit: BoxFit.scaleDown,
                                        )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.012,
                                ),
                                Container(
                                  width: width * 0.3,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(color: Color(0xFFEEEEEE)))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.012,
                                    ),
                                    child: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              user_role = "Participants";
                                              futurePostEng = filterPost(
                                                  isAscending, user_status, user_role);
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Participants".tr(),
                                            style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(
                                                  color: Color(0xFF222222),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.04,
                                        ),
                                        user_role.compareTo("Participants") == 0
                                            ? SvgPicture.asset(
                                          "assets/images/sortyes.svg",
                                          fit: BoxFit.scaleDown,
                                        )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.012,
                                ),
                                Container(
                                  width: width * 0.3,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(color: Color(0xFFEEEEEE)))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.012,
                                    ),
                                    child: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              user_role = "Instructor";
                                              futurePostEng = filterPost(
                                                  isAscending, user_status, user_role);
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Instructor".tr(),
                                            style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(
                                                  color: Color(0xFF222222),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.04,
                                        ),
                                        user_role.compareTo("Instructor") == 0
                                            ? SvgPicture.asset(
                                          "assets/images/sortyes.svg",
                                          fit: BoxFit.scaleDown,
                                        )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.06,
                          ),
                          Container(

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status".tr(),
                                  style: GoogleFonts.barlow(
                                    textStyle: const TextStyle(
                                        color: Color(0xFF222222),
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Container(
                                  width: width * 0.3,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(color: Color(0xFFEEEEEE)))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.012,
                                    ),
                                    child: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              user_status = "All";
                                              futurePostEng = filterPost(
                                                  isAscending, user_status, user_role);
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "All".tr(),
                                            style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(
                                                  color: Color(0xFF222222),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.04,
                                        ),
                                        user_status.compareTo("All") == 0
                                            ? SvgPicture.asset(
                                          "assets/images/sortyes.svg",
                                          fit: BoxFit.scaleDown,
                                        )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.012,
                                ),
                                Container(
                                  width: width * 0.3,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(color: Color(0xFFEEEEEE)))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.012,
                                    ),
                                    child: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              user_status = "Active";
                                              futurePostEng = filterPost(
                                                  isAscending, user_status, user_role);
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Active".tr(),
                                            style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(
                                                  color: Color(0xFF222222),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.04,
                                        ),
                                        user_status.compareTo("Active") == 0
                                            ? SvgPicture.asset(
                                          "assets/images/sortyes.svg",
                                          fit: BoxFit.scaleDown,
                                        )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.012,
                                ),
                                Container(

                                  width: width * 0.3,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(color: Color(0xFFEEEEEE)))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.012,
                                    ),
                                    child: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              user_status = "Deactivate";
                                              futurePostEng = filterPost(
                                                  isAscending, user_status, user_role);
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Deactivated".tr(),
                                            style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(
                                                  color: Color(0xFF222222),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.04,
                                        ),
                                        user_status.compareTo("Deactivate") == 0
                                            ? SvgPicture.asset(
                                          "assets/images/sortyes.svg",
                                          fit: BoxFit.scaleDown,
                                        )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          icon: const ImageIcon(
            AssetImage("assets/mobileImages/funnel.png"),
            size: 24,
          ),  //icon data for elevated button
          label: Text("Filter".tr().toString(),strutStyle: const StrutStyle(
              forceStrutHeight: true
          )), //label text
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: const BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7), // <-- Radius
            ),
            primary: Colors.white ,//elevated btton background color
            onPrimary: Colors.black,


          ),
        )
    );

    final num = SizedBox(
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("10".tr().toString(),strutStyle: const StrutStyle(
                  forceStrutHeight: true
              )),
              const SizedBox(width: 60,),
              const Icon(Icons.expand_more_rounded,size: 16,color: Color(0xFF999999),)
            ],
          ),
          onPressed: (){
            print("You pressed Icon Elevated Button");
          },
          // icon: Icon(Icons.filter_list),
          //  //label text
          style: ElevatedButton.styleFrom(
              elevation: 0,
              side: const BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
              primary: Colors.white ,//elevated btton background color
              onPrimary: Colors.black,
              minimumSize: const Size(130,50)
          ),
        ));






    return Scaffold(
      drawer: const SideNavBar(),
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
                      children: [GestureDetector( onTap: () {Navigator.of(context).pop();}, child: const Icon(Icons.arrow_back_ios,size: 15) ),
                        Container(

                          child: Text("   Users".tr(),style: GoogleFonts.barlow(
                            textStyle: const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 22),
                          ),),
                        ),],
                    ),
                  ),

                  // SizedBox(width: width*0.55,),
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
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

            decoration: const BoxDecoration(
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
                      SizedBox(height: height*0.02,),

                      Row(
                        children: [
                          Text("Administration /".tr().toString(),strutStyle: const StrutStyle(
                              forceStrutHeight: true
                          ),style:  GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ),
                          Text("Users".tr().toString(),strutStyle: const StrutStyle(
                              forceStrutHeight: true
                          ),style:  GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.02,),



                    ],
                  ),

                  SizedBox(height: height*0.02,),
                  SizedBox(
                    height: height*0.055,
                    width: width*0.92,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Column(
                                    children: [
                                      const Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(Icons.close)),
                                      Center(child: Text("Add New User".tr(),style: GoogleFonts.barlow(
                                        textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 28),
                                      ),),),
                                    ],
                                  ),
                                  insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                                  content: Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: Form(
                                      child: Column(

                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Center(
                                            child: Text("Enter the details below to add a new user".tr(),style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                            ),),
                                          ),
                                          SizedBox(height: height*0.07),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: height*0.01),
                                            child: Text("Name".tr(),style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                            ),),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: width*0.9,
                                              height: height*0.05,
                                              child: const TextField(
                                                decoration: InputDecoration(
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
                                            padding: EdgeInsets.only(bottom: height*0.01),
                                            child: Text("Email".tr(),style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                            ),),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: width*0.9,
                                              height: height*0.05,
                                              child: const TextField(
                                                obscureText: true,
                                                decoration: InputDecoration(

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
                                            padding: EdgeInsets.only(bottom: height*0.01),
                                            child: Text("Account type".tr(),style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                            ),),
                                          ),
                                          Center(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color(0xFFEEEEEE)),
                                                  borderRadius: BorderRadius.circular(4.5),
                                                ),
                                              width: width*0.9,
                                              height: height*0.05,
                                              child: Padding(
                                                padding: EdgeInsets.only(top: height*0.01,
                                               ),
                                                  child:role
                                              )
                                            ),
                                          ),

                                          SizedBox(height: height*0.07),

                                          Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [
                                                SizedBox(
                                                  width: width*0.25,
                                                  height: height*0.055,
                                                  child: ElevatedButton(
                                                    onPressed: () {

                                                    },
                                                    child: Text('Cancel'.tr().toString(),strutStyle: const StrutStyle(
                                                        forceStrutHeight: true
                                                    )),
                                                    style: ElevatedButton.styleFrom(
                                                      primary: const Color(0xFFF5F0E5),
                                                      onPrimary: const Color(0xff183028),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),

                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: width*0.33,
                                                  height: height*0.055,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => const mobileUsersAdd()),
                                                      );
                                                    },
                                                    child: Text('Confirm & add'.tr().toString(),strutStyle: const StrutStyle(
                                                        forceStrutHeight: true
                                                    )),
                                                    style: ElevatedButton.styleFrom(
                                                        primary: const Color(0xFF215732),
                                                        onPrimary: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        side: const BorderSide(
                                                            width: 0.4,
                                                            color: Colors.black
                                                        )
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                        child: Text("Add new user".tr().toString(),strutStyle: const StrutStyle(
                            forceStrutHeight: true
                        ), style: GoogleFonts.barlow(textStyle:  const TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFFBFCFC) ),
                        ),),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF215732),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),

                            side: const BorderSide(
                                width: 0.4,
                                color: Colors.black
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.01,),

                  SizedBox(
                    height: height*0.055,
                    width: width*0.92,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        child: Text("Export list as spreadsheet".tr().toString(),strutStyle: const StrutStyle(
                            forceStrutHeight: true
                        ), style: GoogleFonts.barlow(textStyle:  const TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF183028) ),
                        ),),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                            shadowColor: Colors.transparent,
                            primary: const Color(0xFFF5F0E5),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),

                            side: const BorderSide(
                                width: 0.4,
                              color: Color(0xFFF5F0E5)

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

                  FutureBuilder<List<User>>(
                    future: futurePostEng,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (!hasData) {
                          return Center(
                            child: Padding(
                              padding:
                              const EdgeInsets
                                  .all(8.0),
                              child: Text(
                                "No Users".tr(),
                                style: GoogleFonts
                                    .barlow(
                                  textStyle: const TextStyle(
                                      color: Color(
                                          0xFF222222),
                                      fontWeight:
                                      FontWeight
                                          .w400,
                                      fontStyle:
                                      FontStyle
                                          .normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            physics:
                            const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot
                                .data!.length,
                            itemBuilder:
                                (_, index) =>
                                Container(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => webSpecificUser()),
                                          // );
                                        },
                                        hoverColor: Colors
                                            .transparent,
                                        child: Material(
                                          elevation: 1,
                                          color:
                                          Colors.white,
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const specificUser()),
                                              );
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
                                                          child: Row(
                                                            children: [
                                                              Image.asset("images/smallpfp.png"),
                                                              const SizedBox(width: 15,),
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text("${snapshot.data![index].name}".tr().toString(),strutStyle: const StrutStyle(
                                                                      forceStrutHeight: true
                                                                  ),style:  GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                                                                  ),
                                                                  Text("${snapshot.data![index].email}".tr().toString(),strutStyle: const StrutStyle(
                                                                      forceStrutHeight: true
                                                                  ),style:  GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow', fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999)  ),),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        const Icon(Icons.more_vert_outlined,size: 16,color: Color(0xFF999999),)
                                                      ],
                                                    ),


                                                    Container(
                                                      height: 35,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(

                                                            child: Text("Account Type ".tr().toString(),strutStyle: const StrutStyle(
                                                                forceStrutHeight: true
                                                            ),style:  GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                                            ),
                                                          ),
                                                          // Container(
                                                          //   width: width*0.3,
                                                          //   child: DropdownButtonFormField(
                                                          //     decoration :InputDecoration.collapsed(hintText: ''),
                                                          //     style: GoogleFonts.barlow(
                                                          //       textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                          //     ),
                                                          //     // Initial Value
                                                          //     value: snapshot
                                                          //         .data![index]
                                                          //         .user_type,
                                                          //
                                                          //     // Down Arrow Icon
                                                          //     icon:Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),
                                                          //
                                                          //     // Array list of items
                                                          //     items: items.map((String items) {
                                                          //       return DropdownMenuItem(
                                                          //         value: items,
                                                          //         child: Text(
                                                          //           items,
                                                          //           style: GoogleFonts.barlow(
                                                          //             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                                                          //           ),
                                                          //         ),
                                                          //       );
                                                          //     }).toList(),
                                                          //     // After selecting the desired option,it will
                                                          //     // change button value to selected value
                                                          //     onChanged: (String? newValue) {
                                                          //       setState(() {
                                                          //         dropdownvalue1 = newValue!;
                                                          //       });
                                                          //     },
                                                          //   ),
                                                          // )
                                                          Text(snapshot
                                                              .data![index]
                                                              .user_type,
                                                            style:  GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Colors.black ),),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(height: 0.001,thickness: 0.2,
                                                      color: Color(0xFF999999),
                                                    ),

                                                    Container(

                                                      height: 35,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                        children: [
                                                          Container(

                                                            child: Text("Status".tr().toString(),strutStyle: const StrutStyle(
                                                                forceStrutHeight: true
                                                            ),
                                                              style:  GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(18.0),
                                                              border: Border.all(
                                                                color: const Color(0xFF007A33),
                                                                width: 0.5,
                                                              ),
                                                            ),

                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                                              child: Text('${snapshot.data![index].user_status}'.tr(),style: GoogleFonts.barlow(
                                                                textStyle: const TextStyle(color: Color(0xFF007A33), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                              ),),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),



                                                  ],
                                                ),
                                              ),
                                            ),
                                          )


                                        ),
                                      ),
                                    ],
                                  ),

                                  // Column(
                                  //   children: [
                                  //     Text("${snapshot.data![index].name}"),
                                  //     Text("${snapshot.data![index].email}"),
                                  //     Text("${snapshot.data![index].user_type}"),
                                  //     Text("${snapshot.data![index].user_id}"),
                                  //
                                  //     Text("${snapshot.data![index].user_status}"),
                                  //
                                  //
                                  //
                                  //     DropdownButtonFormField(
                                  //       decoration :InputDecoration.collapsed(hintText: ''),
                                  //       style: GoogleFonts.barlow(
                                  //         textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                  //       ),
                                  //       // Initial Value
                                  //       value: snapshot.data![index].user_type,
                                  //
                                  //       // Down Arrow Icon
                                  //       icon:Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),
                                  //
                                  //       // Array list of items
                                  //       items: items.map((String items) {
                                  //         return DropdownMenuItem(
                                  //           value: items,
                                  //           child: Text(items,style: GoogleFonts.barlow(
                                  //             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  //           ),),
                                  //         );
                                  //       }).toList(),
                                  //       // After selecting the desired option,it will
                                  //       // change button value to selected value
                                  //       onChanged: (String? newValue) {
                                  //         setState(() {
                                  //           updateRole(newValue!,snapshot.data![index].user_id);
                                  //         });
                                  //       },
                                  //     ),
                                  //     PopupMenuButton(
                                  //       onSelected: (result) {
                                  //         // your logic
                                  //         if (result == 0) {
                                  //           print("delete");
                                  //           deleteRequest(snapshot.data![index].user_id);
                                  //         }
                                  //         else if (result == 1)
                                  //         {
                                  //           print("activate");
                                  //           updateRequest("active",snapshot.data![index].user_id);
                                  //         }
                                  //         else
                                  //         {
                                  //           print("deactivate");
                                  //           updateRequest("inactive",snapshot.data![index].user_id);
                                  //
                                  //         }
                                  //       },
                                  //       itemBuilder: (BuildContext bc) {
                                  //         return const [
                                  //           PopupMenuItem(
                                  //             child: Text("Delete"),
                                  //             value: 0,
                                  //           ),
                                  //           PopupMenuItem(
                                  //             child: Text("Activate"),
                                  //             value: 1,
                                  //           ),
                                  //           PopupMenuItem(
                                  //             child: Text("DeActivate"),
                                  //             value:2 ,
                                  //           )
                                  //         ];
                                  //       },
                                  //     )
                                  //
                                  //   ],
                                  // ),
                                ),
                          );
                        }
                      } else {
                        return Center(
                            child: Text(
                                "No Items Found",
                                style: GoogleFonts.barlow(
                                    textStyle: const TextStyle(
                                        color: Color(
                                            0xFF222222),
                                        fontWeight:
                                        FontWeight
                                            .w400,
                                        fontStyle:
                                        FontStyle
                                            .normal,
                                        fontSize:
                                        16))));
                      }
                    },
                  ),





                ],
              ),
            ),
          ),
        ),),
    );
  }
}
