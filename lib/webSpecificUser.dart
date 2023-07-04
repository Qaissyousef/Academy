import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:pif_admin_dashboard/main.dart';
import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/announcementResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/eventsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
import 'package:pif_admin_dashboard/responsiveness/usersResponive.dart';


class webSpecificUser extends StatefulWidget {
  const webSpecificUser({Key? key}) : super(key: key);

  @override
  State<webSpecificUser> createState() => _webSpecificUserState();
}

class _webSpecificUserState extends State<webSpecificUser> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    super.initState();
  }
  String dropdownvalue1 = 'Instructor'.tr();

  // List of items in our dropdown menu
  var items = [
    'Instructor'.tr(),
    'Admin'.tr(),
    'Participant'.tr(),

  ];
  String dropdownvalue2 = 'Active'.tr();

  // List of items in our dropdown menu
  var items2 = [
    'Active'.tr(),
    'InActive'.tr(),


  ];

  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isSwitched = true;
    final activestatus =  DropdownButtonFormField(
      decoration :InputDecoration.collapsed(hintText: ''),
      style: GoogleFonts.barlow(
        textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
      ),
      // Initial Value
      value: dropdownvalue2,

      // Down Arrow Icon
      icon:Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),

      // Array list of items
      items: items2.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items,style: GoogleFonts.barlow(
            textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
          ),),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue1 = newValue!;
        });
      },
    );
    final courseOne = Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {

        },
        child: Container(
          width: width*0.35,
          height: 111,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(150),


          ),

          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(


              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 14),

                      Padding(
                        padding: const EdgeInsets.only(top: 19.0),
                        child: Image.asset('mobileImages/course1.png',height: 80,width: 80,),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,left: 12.0,right: 12.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text("Introduction to Data Analytics ".tr().toString(),strutStyle: StrutStyle(
                                forceStrutHeight: true
                            ),style:
                            GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.002),
                            Row(
                              children: [
                                Text("Instructor: ".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:
                                GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                ),Text("Mohammad Alsugair".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                                ),
                              ],
                            ),
                            // Text("Instructor: ",style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                            SizedBox(height: height*0.01),
                            Row(
                              children: [
                                Text("1 of 2 workshops done".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:
                                GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                ),
                                SizedBox(width: width*0.17),

                                // SizedBox(width: width*0.16),
                                Text("   52%".tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style:
                                GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              height: 5,
                              width: width*0.27,
                              child:
                              LinearProgressIndicator(
                                backgroundColor: Color(0xFFD9D9D9),
                                color: Color(0xFFBD9B60),
                                minHeight: 5,
                                value: 0.6,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 65,),


                      ],
                    ),
                  ),

                ],
              ),

            ),
          ),
        ),
      ),
    );
    void toggleSwitch(bool value) {

      if(isSwitched == true)
      {
        setState(() {
          isSwitched = true;
        });
        print('Switch Button is ON');
        // img = 'assets/assets/images/femaleuser.png';

      }
      else
      {
        setState(() {
          isSwitched = false;
        });
        print('Switch Button is OFF');
        // img = 'assets/assets/images/pfp.png';
      }
    }
    final button = PopupMenuButton(
        icon: Icon( Icons.more_vert_rounded,size: 18,color: Color(0xFF999999)),
        key: _menuKey,
        itemBuilder: (_) => const<PopupMenuItem<String>>[
          PopupMenuItem<String>(
              child: Text('Edit'), value: 'Edit'),
          PopupMenuItem<String>(
              child: Text('Report'), value: 'Report'),
          PopupMenuItem<String>(
              child: Text('Delete',style: TextStyle(color: Colors.red) ,), value: 'Report'),
        ],
        onSelected: (_) {});
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width*0.003,
            color: Color(0xFFBD9B60),
            // child: Text("we"),
          ),
          Drawer(
            width: width*0.2,

            child: Container(
              color: Color(0xFF183028),
              child: ListView(

                children: <Widget>[
                  SizedBox(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: DrawerHeader(
                        padding: EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            SizedBox(width: width*0.008,),
                            Image.asset("assets/images/pifLogo.png",fit: BoxFit.contain,
                              width: width*0.06,
                              //86
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ListTile(
                    leading: ImageIcon(AssetImage("assets/images/home.png"),color: Color(0xFFBD9B60),),
                    minLeadingWidth : width*0.02,

                    title: Text("Home".tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                    ),),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeResponsive()),
                      )
                    },
                  ),

                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(right:2.0,left: 2),
                      child: SvgPicture.asset("assets/images/courses.svg",color: Color(0xFFBD9B60)),
                    ),
                    minLeadingWidth : width*0.02,


                    title:Text("Courses".tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                    ),),

                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => courseResponsive()),
                      )
                    },
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: context.locale == Locale("en") ? width*0.01: 0.0,left: context.locale == Locale("en") ?  0.0:width*0.01  ),

                    child: Container(

                      decoration: BoxDecoration(

                        color: Color(0xFFBD9B60),
                        //
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(context.locale == Locale("en") ? 0: 40.0 ),
                          bottomLeft: Radius.circular(context.locale == Locale("en") ? 0: 40.0 ),
                          topRight: Radius.circular(context.locale == Locale("en") ? 40: 0.0 ),
                          bottomRight: Radius.circular(context.locale == Locale("en") ? 40: 0.0),
                        ),
                      ),
                      child: ListTile(
                        leading: ImageIcon(AssetImage("assets/images/admin.png"),color: Colors.white,),
                        minLeadingWidth : width*0.02,

                        title: Text("Administration".tr(),style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                        ),),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => adminResponsive()),
                          )
                        },
                      ),
                    ),
                  ),

                  ListTile(
                    title: Padding(
                      padding:  EdgeInsets.only(right: context.locale == Locale("en") ? 0: width*0.028,left: context.locale == Locale("en") ?  width*0.028:0  ),

                      // padding:  EdgeInsets.only(left: ),
                      child: Text("Events".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                      ),),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => eventResponsive()),
                      )

                    },
                  ),
                  ListTile(
                    title: Padding(
                      padding:  EdgeInsets.only(right: context.locale == Locale("en") ? 0: width*0.028,left: context.locale == Locale("en") ?  width*0.028:0  ),

                      child: Text("Announcements".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                      ),),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => announcementResponsive()),
                      )

                    },
                  ),
                  Padding(
                    // padding:  EdgeInsets.only(right: width*0.01,left: ),
                    padding:  EdgeInsets.only(right: context.locale == Locale("en") ? width*0.01:width*0.025,left: context.locale == Locale("en") ?  width*0.025:width*0.01  ),

                    child: Row(
                      children: [
                        Container(
                          height: height*0.06,
                          width: 5,
                          color: Color(0xFFBD9B60),
                          // child: Text("we"),
                        ),
                        Expanded(
                          child: Container(
                            height: height*0.06,

                            decoration: BoxDecoration(

                              color:  Color.fromRGBO(189, 155, 96, 0.2),
                              //
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(context.locale == Locale("en") ? 0: 40.0 ),
                                bottomLeft: Radius.circular(context.locale == Locale("en") ? 0: 40.0 ),
                                topRight: Radius.circular(context.locale == Locale("en") ? 40: 0.0 ),
                                bottomRight: Radius.circular(context.locale == Locale("en") ? 40: 0.0),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,

                              child: ListTile(
                                title: Text("Users".tr(),style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                                ),),
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => userResponsive()),
                                  )

                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  ListTile(
                    leading: Padding(
                      padding:  EdgeInsets.only(left: width*0.0028),

                      child: SvgPicture.asset("assets/images/admission.svg",color: Color(0xFFBD9B60)),
                    ),
                    minLeadingWidth : width*0.02,

                    title: Text("Admission".tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                    ),),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => admissionResponsive()),
                      )

                    },
                  ),


                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 2.0,left: 2),
                      child: SvgPicture.asset("assets/images/settings.svg",color: Color(0xFFBD9B60)),
                    ),
                    minLeadingWidth : width*0.02,

                    title: Text("Settings".tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                    ),),

                    onTap: () => {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => settingResponsive()),
                    )},
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/images/Headphone.svg",color: Color(0xFFBD9B60)),
                    minLeadingWidth : width*0.02,


                    title: Text("Help".tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                    ),),

                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => helpResponsive()),
                      )
                    },
                  ),
                  SizedBox(height: height*0.004,),
                  Divider(color: Color(0xffFFFFFF), thickness: 0.2,indent: 12,
                    endIndent: 12,),
                  SizedBox(height: height*0.008,),


                  ListTile(
                    leading:  SvgPicture.asset("assets/images/message.svg"),
                    minLeadingWidth : 1,

                    title:Padding(
                      padding:  EdgeInsets.only(left: width*0.003,right: width*0.003),
                      child: Text("Messages".tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                      ),),
                    ),

                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MessageResponsive()),
                      )
                    },
                  ),


                  SizedBox(height: height*0.008,),
                  Divider(color: Color(0xffFFFFFF), thickness: 0.2,indent: 12,
                    endIndent: 12,),
                  ListTile(
                    leading: ImageIcon(AssetImage("assets/images/logout.png"),color: Color(0xFFBD9B60),),
                    minLeadingWidth : width*0.02,

                    title: Text("Logout".tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
                    ),),
                    onTap: () => { Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    )},
                  ),
                ],
              ),
            ),

          ),


          Expanded(

            child: Container(

              child: WebSmoothScroll(

                controller: _scrollController,
                child: SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.only(left: width*0.03,top: 20.0,bottom: 20.0,right: width*0.03),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.02,),
                          Container(
                            height: height*0.06,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,

                              children: [

                                InkWell(
                                    hoverColor: Colors.transparent,
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MessageResponsive()),
                                      );
                                    },
                                    child: SvgPicture.asset("assets/images/message.svg")),
                                SizedBox(width: width*0.0152,),
                                InkWell(
                                    hoverColor: Colors.transparent,
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => settingResponsive()),
                                      );
                                    },child: Image.asset("assets/images/pfpIcons.png",scale:4.5,))



                              ],
                            ),

                          ),

                          Container(
                            height: height*0.13,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [GestureDetector(
                                        onTap: (){Navigator.pop(context);},
                                        child: Icon(Icons.arrow_back_ios,size: 17,color: Colors.black,)),
                                      SizedBox(width: width*0.002,),

                                      Text("Users".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 28),
                                      ),),],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Text("User ID: PIFAC123K56".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                      ),),
                                      GestureDetector(
                                          onTap: (){
                                            // This is a hack because _PopupMenuButtonState is private.
                                            dynamic state = _menuKey.currentState;
                                            state.showButtonMenu();
                                          },
                                          child: button )
                                    ],
                                  ),

                                )



                              ],
                            ),

                          ),

                          SizedBox(height: height*0.02),
                          Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width*0.733,
                                    height: height*0.345,
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        image: ExactAssetImage("assets/images/settingsBanner.png"),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    child:Column(
                                      children: [
                                        SizedBox(height: height*0.03,),
                                        Image.asset("assets/images/pfpIcons.png",width: width*0.1,height: height*0.2,),
                                        SizedBox(height: height*0.03,),

                                        Text("Mohammad Alsugair".tr(),style: GoogleFonts.barlow(
                                          textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 20),
                                        ),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: height*0.01,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 5.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width*0.34,
                                          child: Text("Account Type".tr(),style: GoogleFonts.barlow(
                                            textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                          ),),
                                        ),
                                        SizedBox(width: width*0.015),

                                        SizedBox(
                                          width: width*0.34,
                                          child: Text("Email".tr(),style: GoogleFonts.barlow(
                                            textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                          ),),
                                        ),],
                                    ),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0,right:20.0),
                                    child: Row(children: [
                                      SizedBox(
                                        width: width*0.34,
                                        height: height*0.05,
                                        child: Container(

                                              width: width*0.25,

                                              height: height*0.05,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Color(0xFFEEEEEE)),
                                                borderRadius: BorderRadius.circular(4.5),
                                              ),
                                              child: Padding(
                                                padding:  EdgeInsets.only(top: height*0.015,left: 5,right: 5),
                                                child: DropdownButtonFormField(
                                                  decoration :InputDecoration.collapsed(hintText: ''),
                                                  style: GoogleFonts.barlow(
                                                    textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                  ),
                                                  // Initial Value
                                                  value: dropdownvalue1,

                                                  // Down Arrow Icon
                                                  icon:Icon(Icons.expand_more_rounded,size: 18,color: Color(0Xff999999),),

                                                  // Array list of items
                                                  items: items.map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items,style: GoogleFonts.barlow(
                                                        textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                      ),),
                                                    );
                                                  }).toList(),
                                                  // After selecting the desired option,it will
                                                  // change button value to selected value
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      dropdownvalue1 = newValue!;
                                                    });
                                                  },
                                                ),
                                              )

                                        ),
                                      ),
                                      SizedBox(width: width*0.015),

                                      SizedBox(
                                        width: width*0.34,
                                        height: height*0.05,
                                        child: TextField(
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
                                    ],),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 5.0),

                                    child: Row(
                                      children: [Text("Account Status".tr(),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize:14),
                                      ),),
                                      ],
                                    ),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0,right:20.0,bottom: 20),
                                    child: Row(children: [
                                      SizedBox(
                                        width: width*0.34,
                                        height: height*0.05,
                                        child: Container(

                                            width: width*0.25,

                                            height: height*0.05,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Color(0xFFEEEEEE)),
                                              borderRadius: BorderRadius.circular(4.5),
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.only(top: height*0.015,left: 5,right: 5),
                                              child: activestatus
                                            )

                                        ),
                                      ),
                                      SizedBox(width: width*0.015),

                                    ],),
                                  ),




                                ],
                              )
                          ),
                          SizedBox(height: height*0.02),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("Courses".tr().toString(),strutStyle: StrutStyle(
forceStrutHeight: true
),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
),
SizedBox(height: height*0.02,),

Card(
child: Padding(
padding: const EdgeInsets.all(10.0),
child: Column(
children: [
Row(
children: [
courseOne,
SizedBox(width: width*0.01,),
courseOne
],
),
SizedBox(height: width*0.01,),

Row(
children: [
courseOne,
SizedBox(width: width*0.01,),
courseOne
],
),
],
),
),
),
SizedBox(height: height*0.02,),

],
),


                        ],
                      ),
                    )
                ),
              ),
            ),),


        ],
      ),
    );
  }
}

