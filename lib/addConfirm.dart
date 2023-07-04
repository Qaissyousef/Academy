// import 'package:cross_scroll/cross_scroll.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pif_admin_dashboard/addConfirm.dart';
// import 'package:pif_admin_dashboard/pfpimg.dart';
// import 'package:web_smooth_scroll/web_smooth_scroll.dart';
// import 'package:pif_admin_dashboard/main.dart';
// import 'package:pif_admin_dashboard/responsiveness/adminResponsive.dart';
// import 'package:pif_admin_dashboard/responsiveness/admissionResponsive.dart';
// import 'package:pif_admin_dashboard/responsiveness/announcementResponsive.dart';
// import 'package:pif_admin_dashboard/responsiveness/coursesResponsive.dart';
// import 'package:pif_admin_dashboard/responsiveness/eventsResponsive.dart';
// import 'package:pif_admin_dashboard/responsiveness/helpResponsive.dart';
// import 'package:pif_admin_dashboard/responsiveness/homeResponsive.dart';
// import 'package:pif_admin_dashboard/responsiveness/messageResponsive.dart';
// import 'package:pif_admin_dashboard/responsiveness/settingsResponsive.dart';
//
// import '../responsiveness/usersResponive.dart';
//
// class confirmusers extends StatefulWidget {
//   const confirmusers({Key? key}) : super(key: key);
//
//   @override
//   State<confirmusers> createState() => _confirmusersState();
// }
//
// class _confirmusersState extends State<confirmusers> {
//   String dropdownvalue1 = 'Instructor'.tr();
//
//   // List of items in our dropdown menu
//   var items = [
//     'Instructor'.tr(),
//     'Admin'.tr(),
//     'Participant'.tr(),
//   ];
//
//   var _dateTime = DateTime.parse("2022-10-01 00:00:00.000");
//
//   void onSelect(item) {
//     switch (item) {
//       case 'Home':
//         print('Home clicked');
//         break;
//       case 'Profile':
//         print('Profile clicked');
//         break;
//       case 'Setting':
//         print('Setting clicked');
//         break;
//     }
//   }
//
//   late ScrollController _scrollController;
//
//   @override
//   void initState() {
//     // initialize scroll controllers
//     _scrollController = ScrollController();
//
//     super.initState();
//   }
//
//   bool? checkedValue = true;
//
//   final num = SizedBox(
//       child: ElevatedButton(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("08       ".tr().toString(),
//             strutStyle: StrutStyle(forceStrutHeight: true)),
//         SizedBox(
//           width: 25,
//         ),
//         Icon(
//           Icons.expand_more_rounded,
//           size: 18,
//           color: Color(0xFF999999),
//         )
//       ],
//     ),
//     onPressed: () {
//       print("You pressed Icon Elevated Button");
//     },
//     // icon: Icon(Icons.filter_list),
//     //  //label text
//     style: ElevatedButton.styleFrom(
//         elevation: 0,
//         side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8), // <-- Radius
//         ),
//         primary: Colors.white, //elevated btton background color
//         onPrimary: Colors.black,
//         minimumSize: Size(120, 50)),
//   ));
//   final GlobalKey _menuKey = GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     final button = PopupMenuButton(
//         icon: Icon(Icons.more_vert_rounded, size: 18, color: Color(0xFF999999)),
//         key: _menuKey,
//         itemBuilder: (_) => const <PopupMenuItem<String>>[
//               PopupMenuItem<String>(child: Text('Edit'), value: 'Edit'),
//               PopupMenuItem<String>(child: Text('Report'), value: 'Report'),
//               PopupMenuItem<String>(
//                   child: Text(
//                     'Delete',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                   value: 'Report'),
//             ],
//         onSelected: (_) {});
//
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     String? dropdownvalue = 'Admin';
//     final eventCard = InkWell(
//       hoverColor: Colors.transparent,
//       child: Material(
//         color: Color(0xFFffffff),
//         elevation: 1,
//         borderRadius: BorderRadius.circular(10),
//         child: Container(
//           width: 0,
//           height: 0,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(150),
//           ),
//           child: Container(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   height: height * 0.13,
//                   width: width * 0.04,
//                   child: Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Jun ".tr().toString(),
//                           strutStyle: StrutStyle(forceStrutHeight: true),
//                           style: GoogleFonts.barlow(
//                             textStyle: TextStyle(
//                                 fontFamily: 'Barlow',
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 fontStyle: FontStyle.normal,
//                                 color: Color(0xFF999999)),
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           "16".tr().toString(),
//                           strutStyle: StrutStyle(forceStrutHeight: true),
//                           style: GoogleFonts.barlow(
//                             textStyle: TextStyle(
//                                 fontFamily: 'Barlow',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600,
//                                 fontStyle: FontStyle.normal,
//                                 color: Color(0xFFBD9B60)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFF9F2E7),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: height * 0.007,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: Text(
//                                 "5:30 PM - 6:30 PM".tr().toString(),
//                                 strutStyle: StrutStyle(forceStrutHeight: true),
//                                 style: GoogleFonts.barlow(
//                                   textStyle: TextStyle(
//                                       fontFamily: 'Barlow',
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                       fontStyle: FontStyle.normal,
//                                       color: Color(0xFF999999)),
//                                 ),
//                               ),
//                             ),
//
//                             SizedBox(
//                               height: height * 0.01,
//                             ),
//
//                             Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: Text(
//                                 "Meet & Greet".tr().toString(),
//                                 strutStyle: StrutStyle(forceStrutHeight: true),
//                                 style: GoogleFonts.barlow(
//                                   textStyle: TextStyle(
//                                       fontFamily: 'Barlow',
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                       fontStyle: FontStyle.normal,
//                                       color: Color(0xFF222222)),
//                                 ),
//                               ),
//                             ),
//                             // SizedBox(height: 5),
//                             SizedBox(
//                               height: height * 0.007,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//     final addedPopup = SizedBox(
//         height: height * 0.055,
//         width: width * 0.15,
//         child: ElevatedButton.icon(
//           onPressed: () {
//             print("You pressed Icon Elevated Button");
//           },
//           icon: ImageIcon(
//             AssetImage("assets/images/approve.png"),
//             color: Color(0xFF215732),
//           ), //icon data for elevated button
//           label: Text(
//             "New user has been added".tr().toString(),
//             strutStyle: StrutStyle(forceStrutHeight: true),
//             style: GoogleFonts.barlow(
//               textStyle: TextStyle(
//                   color: Color(0xFF215732),
//                   fontWeight: FontWeight.w500,
//                   fontStyle: FontStyle.normal,
//                   fontSize: 14),
//             ),
//           ), //label text
//           style: ElevatedButton.styleFrom(
//               elevation: 0,
//               side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(7), // <-- Radius
//               ),
//               primary: Color(0xfff1f4f2), //elevated btton background color
//               onPrimary: Color(0xFF215732)),
//         ));
//     final role = Container(
//       height: height * 0.3,
//       child: DropdownButtonHideUnderline(
//         child: DropdownButtonFormField(
//           decoration: InputDecoration.collapsed(hintText: ''),
//           icon: Icon(
//             Icons.expand_more_rounded,
//             size: 18,
//             color: Color(0Xff999999),
//           ),
//
//           iconSize: 4.0,
//
//           // Initial Value
//           value: dropdownvalue,
//           // Down Arrow Icon
//
//           // Array list of items
//           items: [
//             DropdownMenuItem(
//               value: "Admin",
//               child: Text(
//                 '   Admin'.tr().toString(),
//                 style: GoogleFonts.barlow(
//                   textStyle: TextStyle(
//                       fontFamily: 'Barlow',
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       fontStyle: FontStyle.normal,
//                       color: Color(0xFF222222)),
//                 ),
//               ),
//             ),
//             DropdownMenuItem(
//               value: "Instructor",
//               child: Text(
//                 '   Instructor'.tr().toString(),
//                 style: GoogleFonts.barlow(
//                   textStyle: TextStyle(
//                       fontFamily: 'Barlow',
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       fontStyle: FontStyle.normal,
//                       color: Color(0xFF222222)),
//                 ),
//               ),
//             ),
//             DropdownMenuItem(
//               value: "Participants",
//               child: Text(
//                 '   Participants'.tr().toString(),
//                 style: GoogleFonts.barlow(
//                   textStyle: TextStyle(
//                       fontFamily: 'Barlow',
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       fontStyle: FontStyle.normal,
//                       color: Color(0xFF222222)),
//                 ),
//               ),
//             ),
//           ],
//
//           onChanged: (String? newValue) {
//             setState(() {});
//           },
//         ),
//       ),
//     );
//     final searchtab = Container(
//       width: width * 0.4,
//       height: height * 0.048,
//       decoration: BoxDecoration(
//           border: Border.all(color: Color(0xFFEEEEEE)),
//           borderRadius: BorderRadius.circular(4)),
//       child: Padding(
//         padding:
//             const EdgeInsets.only(left: 18.0, right: 20.0, top: 5, bottom: 5),
//         child: Row(
//           children: [
//             SvgPicture.asset(
//               "assets/images/search.svg",
//               fit: BoxFit.scaleDown,
//             ),
//             SizedBox(
//               width: width * 0.009,
//             ),
//             Text(
//               "  Search".tr(),
//               style: GoogleFonts.barlow(
//                 textStyle: TextStyle(
//                     color: Color(0xFFBD9B60),
//                     fontWeight: FontWeight.w400,
//                     fontStyle: FontStyle.normal,
//                     fontSize: width * 0.01),
//               ),
//             ),
//             SizedBox(
//               width: width * 0.22,
//             ),
//             SvgPicture.asset(
//               "assets/images/mic.svg",
//               fit: BoxFit.scaleDown,
//             ),
//             SizedBox(
//               width: width * 0.009,
//             ),
//             SvgPicture.asset(
//               "assets/images/Separator.svg",
//               fit: BoxFit.scaleDown,
//             ),
//             InkWell(
//               hoverColor: Colors.transparent,
//               onTap: () async {
//                 DateTimeRange? picked = await showDateRangePicker(
//                     context: context,
//                     firstDate: DateTime(DateTime.now().year - 5),
//                     lastDate: DateTime(DateTime.now().year + 5),
//                     builder: (context, child) {
//                       return Theme(
//                         data: ThemeData(
//                           //Header background color
//                           primaryColor: Color(0xff007A33),
//                           //Background color
//                           scaffoldBackgroundColor: Colors.white,
//                           //Divider color
//                           dividerColor: Colors.grey,
//                           //Non selected days of the month color
//                           textTheme: TextTheme(
//                             bodyText2: TextStyle(color: Colors.black),
//                           ),
//                           colorScheme: ColorScheme.fromSwatch().copyWith(
//                             //Selected dates background color
//                             primary: Color(0xff215732),
//                             //Month title and week days color
//                             onSurface: Colors.black,
//                             //Header elements and selected dates text color
//                             //onPrimary: Colors.white,
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             ConstrainedBox(
//                               constraints: BoxConstraints(
//                                 maxWidth: 400.0,
//                                 maxHeight: height * 0.7,
//                               ),
//                               child: child,
//                             )
//                           ],
//                         ),
//                       );
//                     });
//                 print(picked);
//               },
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: width * 0.021,
//                   ),
//                   SvgPicture.asset(
//                     "assets/images/filter.svg",
//                     fit: BoxFit.scaleDown,
//                   ),
//                   Text(
//                     "  Filter".tr(),
//                     style: GoogleFonts.barlow(
//                       textStyle: TextStyle(
//                           color: Color(0xFF215732),
//                           fontWeight: FontWeight.w400,
//                           fontStyle: FontStyle.normal,
//                           fontSize: width * 0.01),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//
//     final sortbtn = Container(
//       height: height * 0.047,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(color: Colors.black, width: 0.4),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 17, right: 17),
//         child: GestureDetector(
//           onTap: () {
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   Locale? lang = Locale("en");
//                   return AlertDialog(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0))),
//                     scrollable: true,
//                     title: Column(
//                       children: [
//                         Align(
//                             alignment: Alignment.topRight,
//                             child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Icon(Icons.close))),
//                       ],
//                     ),
//                     content: Padding(
//                       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                       child: Form(
//                         child: Row(
//                           children: [
//                             Container(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Date".tr(),
//                                     style: GoogleFonts.barlow(
//                                       textStyle: TextStyle(
//                                           color: Color(0xFF222222),
//                                           fontWeight: FontWeight.w500,
//                                           fontStyle: FontStyle.normal,
//                                           fontSize: 16),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: height * 0.01,
//                                   ),
//
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Newest to Oldest".tr(),
//                                         style: GoogleFonts.barlow(
//                                           textStyle: TextStyle(
//                                               color: Color(0xFF222222),
//                                               fontWeight: FontWeight.w400,
//                                               fontStyle: FontStyle.normal,
//                                               fontSize: 16),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: width * 0.04,
//                                       ),
//                                       SvgPicture.asset(
//                                         "assets/images/sortyes.svg",
//                                         fit: BoxFit.scaleDown,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: height * 0.012,
//                                   ),
//
//                                   // SizedBox(height: ),
//
//                                   Container(
//                                     width: width * 0.1,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             top: BorderSide(
//                                                 color: Color(0xFFEEEEEE)))),
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                         top: height * 0.012,
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             "Oldest to Newest".tr(),
//                                             style: GoogleFonts.barlow(
//                                               textStyle: TextStyle(
//                                                   color: Color(0xFF222222),
//                                                   fontWeight: FontWeight.w400,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: width * 0.06,
//                             ),
//                             Container(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Attendance".tr(),
//                                     style: GoogleFonts.barlow(
//                                       textStyle: TextStyle(
//                                           color: Color(0xFF222222),
//                                           fontWeight: FontWeight.w500,
//                                           fontStyle: FontStyle.normal,
//                                           fontSize: 16),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: height * 0.02,
//                                   ),
//
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Lowest to Highest".tr(),
//                                         style: GoogleFonts.barlow(
//                                           textStyle: TextStyle(
//                                               color: Color(0xFF222222),
//                                               fontWeight: FontWeight.w400,
//                                               fontStyle: FontStyle.normal,
//                                               fontSize: 16),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: width * 0.04,
//                                       ),
//                                       SvgPicture.asset(
//                                         "assets/images/sortyes.svg",
//                                         fit: BoxFit.scaleDown,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: height * 0.012,
//                                   ),
//
//                                   // SizedBox(height: ),
//
//                                   Container(
//                                     width: width * 0.1,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             top: BorderSide(
//                                                 color: Color(0xFFEEEEEE)))),
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                         top: height * 0.012,
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             "Highest to Lowest".tr(),
//                                             style: GoogleFonts.barlow(
//                                               textStyle: TextStyle(
//                                                   color: Color(0xFF222222),
//                                                   fontWeight: FontWeight.w400,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 });
//           },
//           child: Row(
//             children: [
//               SvgPicture.asset(
//                 "assets/images/sort.svg",
//                 fit: BoxFit.scaleDown,
//               ),
//               Text(
//                 "  Sort".tr(),
//                 style: GoogleFonts.barlow(
//                   textStyle: TextStyle(
//                       color: Color(0xFF222222),
//                       fontWeight: FontWeight.w400,
//                       fontStyle: FontStyle.normal,
//                       fontSize: width * 0.01),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//     return Scaffold(
//       body: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: height,
//               width: width * 0.003,
//               color: Color(0xFFBD9B60),
//               // child: Text("we"),
//             ),
//             Drawer(
//               width: width * 0.2,
//               child: Container(
//                 color: Color(0xFF183028),
//                 child: ListView(
//                   children: <Widget>[
//                     SizedBox(
//                       child: Align(
//                         alignment: Alignment.bottomLeft,
//                         child: DrawerHeader(
//                           padding: EdgeInsets.all(0.0),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: width * 0.008,
//                               ),
//                               Image.asset(
//                                 "assets/images/pifLogo.png",
//                                 fit: BoxFit.contain,
//                                 width: width * 0.06,
//                                 //86
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       leading: ImageIcon(
//                         AssetImage("assets/images/home.png"),
//                         color: Color(0xFFBD9B60),
//                       ),
//                       minLeadingWidth: width * 0.02,
//                       title: Text(
//                         "Home".tr(),
//                         style: GoogleFonts.barlow(
//                           textStyle: TextStyle(
//                               color: Color(0xFFBD9B60),
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               fontSize: 18),
//                         ),
//                       ),
//                       onTap: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => HomeResponsive(uid: null,)),
//                         )
//                       },
//                     ),
//                     ListTile(
//                       leading: Padding(
//                         padding: const EdgeInsets.only(right: 2.0, left: 2),
//                         child: SvgPicture.asset("assets/images/courses.svg",
//                             color: Color(0xFFBD9B60)),
//                       ),
//                       minLeadingWidth: width * 0.02,
//                       title: Text(
//                         "Courses".tr(),
//                         style: GoogleFonts.barlow(
//                           textStyle: TextStyle(
//                               color: Color(0xFFBD9B60),
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               fontSize: 18),
//                         ),
//                       ),
//                       onTap: () => {
//                         Navigator.push(
//                             context,
//                             PageRouteBuilder(
//                               pageBuilder: (context, animation1, animation2) =>
//                                   courseResponsive(),
//                               transitionDuration: Duration(seconds: 0),
//                             ))
//                       },
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           right: context.locale == Locale("en")
//                               ? width * 0.01
//                               : 0.0,
//                           left: context.locale == Locale("en")
//                               ? 0.0
//                               : width * 0.01),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Color(0xFFBD9B60),
//                           //
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(
//                                 context.locale == Locale("en") ? 0 : 40.0),
//                             bottomLeft: Radius.circular(
//                                 context.locale == Locale("en") ? 0 : 40.0),
//                             topRight: Radius.circular(
//                                 context.locale == Locale("en") ? 40 : 0.0),
//                             bottomRight: Radius.circular(
//                                 context.locale == Locale("en") ? 40 : 0.0),
//                           ),
//                         ),
//                         child: ListTile(
//                           leading: ImageIcon(
//                             AssetImage("assets/images/admin.png"),
//                             color: Colors.white,
//                           ),
//                           minLeadingWidth: width * 0.02,
//                           title: Text(
//                             "Administration".tr(),
//                             style: GoogleFonts.barlow(
//                               textStyle: TextStyle(
//                                   color: Color(0xFFFFFFFF),
//                                   fontWeight: FontWeight.w400,
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: 18),
//                             ),
//                           ),
//                           onTap: () => {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => adminResponsive()),
//                             )
//                           },
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       title: Padding(
//                         padding: EdgeInsets.only(
//                             right: context.locale == Locale("en")
//                                 ? 0
//                                 : width * 0.028,
//                             left: context.locale == Locale("en")
//                                 ? width * 0.028
//                                 : 0),
//
//                         // padding:  EdgeInsets.only(left: ),
//                         child: Text(
//                           "Events".tr(),
//                           style: GoogleFonts.barlow(
//                             textStyle: TextStyle(
//                                 color: Color(0xFFBD9B60),
//                                 fontWeight: FontWeight.w400,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 18),
//                           ),
//                         ),
//                       ),
//                       onTap: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => eventResponsive()),
//                         )
//                       },
//                     ),
//                     ListTile(
//                       title: Padding(
//                         padding: EdgeInsets.only(
//                             right: context.locale == Locale("en")
//                                 ? 0
//                                 : width * 0.028,
//                             left: context.locale == Locale("en")
//                                 ? width * 0.028
//                                 : 0),
//                         child: Text(
//                           "Announcements".tr(),
//                           style: GoogleFonts.barlow(
//                             textStyle: TextStyle(
//                                 color: Color(0xFFBD9B60),
//                                 fontWeight: FontWeight.w400,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 18),
//                           ),
//                         ),
//                       ),
//                       onTap: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => announcementResponsive()),
//                         )
//                       },
//                     ),
//                     Padding(
//                       // padding:  EdgeInsets.only(right: width*0.01,left: ),
//                       padding: EdgeInsets.only(
//                           right: context.locale == Locale("en")
//                               ? width * 0.01
//                               : width * 0.025,
//                           left: context.locale == Locale("en")
//                               ? width * 0.025
//                               : width * 0.01),
//
//                       child: Row(
//                         children: [
//                           Container(
//                             height: height * 0.06,
//                             width: 5,
//                             color: Color(0xFFBD9B60),
//                             // child: Text("we"),
//                           ),
//                           Expanded(
//                             child: Container(
//                               height: height * 0.06,
//                               decoration: BoxDecoration(
//                                 color: Color.fromRGBO(189, 155, 96, 0.2),
//                                 //
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(
//                                       context.locale == Locale("en")
//                                           ? 0
//                                           : 40.0),
//                                   bottomLeft: Radius.circular(
//                                       context.locale == Locale("en")
//                                           ? 0
//                                           : 40.0),
//                                   topRight: Radius.circular(
//                                       context.locale == Locale("en")
//                                           ? 40
//                                           : 0.0),
//                                   bottomRight: Radius.circular(
//                                       context.locale == Locale("en")
//                                           ? 40
//                                           : 0.0),
//                                 ),
//                               ),
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: ListTile(
//                                   title: Text(
//                                     "Users".tr(),
//                                     style: GoogleFonts.barlow(
//                                       textStyle: TextStyle(
//                                           color: Color(0xFFFFFFFF),
//                                           fontWeight: FontWeight.w400,
//                                           fontStyle: FontStyle.normal,
//                                           fontSize: 18),
//                                     ),
//                                   ),
//                                   onTap: () => {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               userResponsive()),
//                                     )
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     ListTile(
//                       leading: Padding(
//                         padding: EdgeInsets.only(left: width * 0.0028),
//                         child: SvgPicture.asset("assets/images/admission.svg",
//                             color: Color(0xFFBD9B60)),
//                       ),
//                       minLeadingWidth: width * 0.02,
//                       title: Text(
//                         "Admission".tr(),
//                         style: GoogleFonts.barlow(
//                           textStyle: TextStyle(
//                               color: Color(0xFFBD9B60),
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               fontSize: 18),
//                         ),
//                       ),
//                       onTap: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => admissionResponsive()),
//                         )
//                       },
//                     ),
//                     ListTile(
//                       leading: Padding(
//                         padding: const EdgeInsets.only(right: 2.0, left: 2),
//                         child: SvgPicture.asset("assets/images/settings.svg",
//                             color: Color(0xFFBD9B60)),
//                       ),
//                       minLeadingWidth: width * 0.02,
//                       title: Text(
//                         "Settings".tr(),
//                         style: GoogleFonts.barlow(
//                           textStyle: TextStyle(
//                               color: Color(0xFFBD9B60),
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               fontSize: 18),
//                         ),
//                       ),
//                       onTap: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => settingResponsive()),
//                         )
//                       },
//                     ),
//                     ListTile(
//                       leading: SvgPicture.asset("assets/images/Headphone.svg",
//                           color: Color(0xFFBD9B60)),
//                       minLeadingWidth: width * 0.02,
//                       title: Text(
//                         "Help".tr(),
//                         style: GoogleFonts.barlow(
//                           textStyle: TextStyle(
//                               color: Color(0xFFBD9B60),
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               fontSize: 18),
//                         ),
//                       ),
//                       onTap: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => helpResponsive()),
//                         )
//                       },
//                     ),
//                     SizedBox(
//                       height: height * 0.004,
//                     ),
//                     Divider(
//                       color: Color(0xffFFFFFF),
//                       thickness: 0.2,
//                       indent: 12,
//                       endIndent: 12,
//                     ),
//                     SizedBox(
//                       height: height * 0.008,
//                     ),
//                     ListTile(
//                       leading: SvgPicture.asset("assets/images/message.svg"),
//                       minLeadingWidth: 1,
//                       title: Padding(
//                         padding: EdgeInsets.only(
//                             left: width * 0.003, right: width * 0.003),
//                         child: Text(
//                           "Messages".tr(),
//                           style: GoogleFonts.barlow(
//                             textStyle: TextStyle(
//                                 color: Color(0xFFBD9B60),
//                                 fontWeight: FontWeight.w400,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 18),
//                           ),
//                         ),
//                       ),
//                       onTap: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => MessageResponsive()),
//                         )
//                       },
//                     ),
//                     SizedBox(
//                       height: height * 0.008,
//                     ),
//                     Divider(
//                       color: Color(0xffFFFFFF),
//                       thickness: 0.2,
//                       indent: 12,
//                       endIndent: 12,
//                     ),
//                     ListTile(
//                       leading: ImageIcon(
//                         AssetImage("assets/images/logout.png"),
//                         color: Color(0xFFBD9B60),
//                       ),
//                       minLeadingWidth: width * 0.02,
//                       title: Text(
//                         "Logout".tr(),
//                         style: GoogleFonts.barlow(
//                           textStyle: TextStyle(
//                               color: Color(0xFFBD9B60),
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               fontSize: 18),
//                         ),
//                       ),
//                       onTap: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => MyApp()),
//                         )
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 child: WebSmoothScroll(
//                   controller: _scrollController,
//                   child: SingleChildScrollView(
//                       child: Padding(
//                     padding: EdgeInsets.only(
//                         left: width * 0.03,
//                         top: 20.0,
//                         bottom: 20.0,
//                         right: width * 0.03),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         Container(
//                           height: height * 0.06,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             // crossAxisAlignment: CrossAxisAlignment.end,
//
//                             children: [
//                               Container(
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       "Administration /".tr(),
//                                       style: GoogleFonts.barlow(
//                                         textStyle: TextStyle(
//                                             color: Color(0xFF999999),
//                                             fontWeight: FontWeight.w500,
//                                             fontStyle: FontStyle.normal,
//                                             fontSize: 16),
//                                       ),
//                                     ),
//                                     Text(
//                                       "Users".tr(),
//                                       style: GoogleFonts.barlow(
//                                         textStyle: TextStyle(
//                                             color: Color(0xFF215732),
//                                             fontWeight: FontWeight.w500,
//                                             fontStyle: FontStyle.normal,
//                                             fontSize: 16),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     InkWell(
//                                         hoverColor: Colors.transparent,
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     MessageResponsive()),
//                                           );
//                                         },
//                                         child: SvgPicture.asset(
//                                             "assets/images/message.svg")),
//                                     SizedBox(
//                                       width: width * 0.0152,
//                                     ),
//                                     InkWell(
//                                         hoverColor: Colors.transparent,
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     settingResponsive()),
//                                           );
//                                         },
//                                         child: pfpImage ??
//                                             (isSwitched
//                                                 ? Image.asset(
//                                                     "assets/images/noFace.png",
//                                                     width: width * 0.0277,
//                                                     height: height * 0.344,
//                                                   )
//                                                 : Image.asset(
//                                                     "assets/images/noFace.png",
//                                                     width: width * 0.0277,
//                                                     height: height * 0.344,
//                                                   )))
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: height * 0.13,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 child: Row(
//                                   children: [
//                                     GestureDetector(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Icon(
//                                           Icons.arrow_back_ios,
//                                           size: 17,
//                                           color: Colors.black,
//                                         )),
//                                     SizedBox(
//                                       width: width * 0.002,
//                                     ),
//                                     Text(
//                                       "Users".tr(),
//                                       style: GoogleFonts.barlow(
//                                         textStyle: TextStyle(
//                                             color: Color(0xFF222222),
//                                             fontWeight: FontWeight.w500,
//                                             fontStyle: FontStyle.normal,
//                                             fontSize: 28),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       height: 43,
//                                       child: ElevatedButton(
//                                         onPressed: () {},
//                                         child: Text(
//                                             'Export list as spreadsheet'
//                                                 .tr()
//                                                 .toString(),
//                                             strutStyle: StrutStyle(
//                                                 forceStrutHeight: true),
//                                             style: GoogleFonts.barlow(
//                                               textStyle: TextStyle(
//                                                   color: Color(0xFF183028),
//                                                   fontWeight: FontWeight.w400,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 16),
//                                             )),
//                                         style: ElevatedButton.styleFrom(
//                                           primary: Color(0xFFF5F0E5),
//                                           elevation: 0.0,
//                                           shadowColor: Colors.transparent,
//                                           onPrimary: Color(0xFF183028),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: width * 0.01,
//                                     ),
//                                     Container(
//                                       height: 43,
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 Locale? lang = Locale("en");
//                                                 return AlertDialog(
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   12.0))),
//                                                   scrollable: true,
//                                                   title: Column(
//                                                     children: [
//                                                       Align(
//                                                           alignment: Alignment
//                                                               .topRight,
//                                                           child:
//                                                               GestureDetector(
//                                                                   onTap: () {
//                                                                     Navigator.pop(
//                                                                         context);
//                                                                   },
//                                                                   child: Icon(Icons
//                                                                       .close))),
//                                                       Center(
//                                                         child: Text(
//                                                           "Add New User".tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 28),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   content: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 8.0,
//                                                             right: 8.0),
//                                                     child: Form(
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: <Widget>[
//                                                           Center(
//                                                             child: Text(
//                                                               "Enter the details below to add a new user"
//                                                                   .tr(),
//                                                               style: GoogleFonts
//                                                                   .barlow(
//                                                                 textStyle: TextStyle(
//                                                                     color: Color(
//                                                                         0xFF999999),
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     fontStyle:
//                                                                         FontStyle
//                                                                             .normal,
//                                                                     fontSize:
//                                                                         14),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                               height: height *
//                                                                   0.07),
//                                                           Padding(
//                                                             padding: EdgeInsets.only(
//                                                                 right: context
//                                                                             .locale ==
//                                                                         Locale(
//                                                                             "en")
//                                                                     ? width *
//                                                                         0.04
//                                                                     : 0,
//                                                                 left: context
//                                                                             .locale ==
//                                                                         Locale(
//                                                                             "en")
//                                                                     ? 0
//                                                                     : width *
//                                                                         0.04,
//                                                                 bottom: height *
//                                                                     0.01),
//                                                             child: Text(
//                                                               "Name".tr(),
//                                                               style: GoogleFonts
//                                                                   .barlow(
//                                                                 textStyle: TextStyle(
//                                                                     color: Color(
//                                                                         0xFF999999),
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     fontStyle:
//                                                                         FontStyle
//                                                                             .normal,
//                                                                     fontSize:
//                                                                         14),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Center(
//                                                             child: SizedBox(
//                                                               width:
//                                                                   width * 0.25,
//                                                               height:
//                                                                   height * 0.05,
//                                                               child: TextField(
//                                                                 decoration:
//                                                                     InputDecoration(
//                                                                   focusedBorder:
//                                                                       OutlineInputBorder(
//                                                                     borderSide: BorderSide(
//                                                                         color: Color(
//                                                                             0xFFEEEEEE),
//                                                                         width:
//                                                                             0.0),
//                                                                   ),
//                                                                   enabledBorder:
//                                                                       OutlineInputBorder(
//                                                                     borderSide: BorderSide(
//                                                                         color: Color(
//                                                                             0xFFEEEEEE),
//                                                                         width:
//                                                                             0.0),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                               height: height *
//                                                                   0.02),
//                                                           Padding(
//                                                             padding: EdgeInsets.only(
//                                                                 right: context
//                                                                             .locale ==
//                                                                         Locale(
//                                                                             "en")
//                                                                     ? width *
//                                                                         0.04
//                                                                     : 0,
//                                                                 left: context
//                                                                             .locale ==
//                                                                         Locale(
//                                                                             "en")
//                                                                     ? 0
//                                                                     : width *
//                                                                         0.04,
//                                                                 bottom: height *
//                                                                     0.01),
//                                                             child: Text(
//                                                               "Email".tr(),
//                                                               style: GoogleFonts
//                                                                   .barlow(
//                                                                 textStyle: TextStyle(
//                                                                     color: Color(
//                                                                         0xFF999999),
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     fontStyle:
//                                                                         FontStyle
//                                                                             .normal,
//                                                                     fontSize:
//                                                                         14),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Center(
//                                                             child: SizedBox(
//                                                               width:
//                                                                   width * 0.25,
//                                                               height:
//                                                                   height * 0.05,
//                                                               child: TextField(
//                                                                 obscureText:
//                                                                     true,
//                                                                 decoration:
//                                                                     InputDecoration(
//                                                                   focusedBorder:
//                                                                       OutlineInputBorder(
//                                                                     borderSide: BorderSide(
//                                                                         color: Color(
//                                                                             0xFFEEEEEE),
//                                                                         width:
//                                                                             0.0),
//                                                                   ),
//                                                                   enabledBorder:
//                                                                       OutlineInputBorder(
//                                                                     borderSide: BorderSide(
//                                                                         color: Color(
//                                                                             0xFFEEEEEE),
//                                                                         width:
//                                                                             0.0),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                               height: height *
//                                                                   0.02),
//                                                           Padding(
//                                                             padding: EdgeInsets.only(
//                                                                 right: context
//                                                                             .locale ==
//                                                                         Locale(
//                                                                             "en")
//                                                                     ? width *
//                                                                         0.04
//                                                                     : 0,
//                                                                 left: context
//                                                                             .locale ==
//                                                                         Locale(
//                                                                             "en")
//                                                                     ? 0
//                                                                     : width *
//                                                                         0.04,
//                                                                 bottom: height *
//                                                                     0.01),
//                                                             child: Text(
//                                                               "Account type"
//                                                                   .tr(),
//                                                               style: GoogleFonts
//                                                                   .barlow(
//                                                                 textStyle: TextStyle(
//                                                                     color: Color(
//                                                                         0xFF999999),
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     fontStyle:
//                                                                         FontStyle
//                                                                             .normal,
//                                                                     fontSize:
//                                                                         14),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Center(
//                                                             child: Container(
//                                                                 width: width *
//                                                                     0.25,
//                                                                 height: height *
//                                                                     0.05,
//                                                                 decoration:
//                                                                     BoxDecoration(
//                                                                   border: Border.all(
//                                                                       color: Color(
//                                                                           0xFFEEEEEE)),
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               4.5),
//                                                                 ),
//                                                                 child: Padding(
//                                                                   padding: EdgeInsets.only(
//                                                                       top: height *
//                                                                           0.015),
//                                                                   child: role,
//                                                                 )),
//                                                           ),
//                                                           SizedBox(
//                                                               height: height *
//                                                                   0.07),
//                                                           Center(
//                                                             child: SizedBox(
//                                                               width:
//                                                                   width * 0.25,
//                                                               child: Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .center,
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .center,
//                                                                 children: [
//                                                                   ElevatedButton(
//                                                                     onPressed:
//                                                                         () {},
//                                                                     child:
//                                                                         Padding(
//                                                                       padding: const EdgeInsets
//                                                                               .symmetric(
//                                                                           vertical:
//                                                                               14,
//                                                                           horizontal:
//                                                                               50),
//                                                                       child:
//                                                                           Text(
//                                                                         'Cancel'
//                                                                             .tr()
//                                                                             .toString(),
//                                                                         strutStyle:
//                                                                             StrutStyle(forceStrutHeight: true),
//                                                                         style: GoogleFonts
//                                                                             .barlow(
//                                                                           textStyle: TextStyle(
//                                                                               color: Color(0xFF183028),
//                                                                               fontWeight: FontWeight.w400,
//                                                                               fontStyle: FontStyle.normal,
//                                                                               fontSize: 16),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     style: ElevatedButton
//                                                                         .styleFrom(
//                                                                       elevation:
//                                                                           0.0,
//                                                                       shadowColor:
//                                                                           Colors
//                                                                               .transparent,
//                                                                       primary:
//                                                                           Color(
//                                                                               0xFFF5F0E5),
//                                                                       onPrimary:
//                                                                           Color(
//                                                                               0xFF183028),
//                                                                       shape:
//                                                                           RoundedRectangleBorder(
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(7),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   SizedBox(
//                                                                     width: width *
//                                                                         0.014,
//                                                                   ),
//                                                                   ElevatedButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator
//                                                                           .push(
//                                                                         context,
//                                                                         MaterialPageRoute(
//                                                                             builder: (context) =>
//                                                                                 confirmusers()),
//                                                                       );
//                                                                     },
//                                                                     child:
//                                                                         Padding(
//                                                                       padding: const EdgeInsets
//                                                                               .symmetric(
//                                                                           vertical:
//                                                                               14,
//                                                                           horizontal:
//                                                                               25),
//                                                                       child: Text(
//                                                                           'Confirm & add'
//                                                                               .tr()
//                                                                               .toString(),
//                                                                           strutStyle: StrutStyle(
//                                                                               forceStrutHeight:
//                                                                                   true),
//                                                                           style:
//                                                                               GoogleFonts.barlow(
//                                                                             textStyle: TextStyle(
//                                                                                 color: Color(0xFFFFFFFF),
//                                                                                 fontWeight: FontWeight.w400,
//                                                                                 fontStyle: FontStyle.normal,
//                                                                                 fontSize: 16),
//                                                                           )),
//                                                                     ),
//                                                                     style: ElevatedButton
//                                                                         .styleFrom(
//                                                                       primary:
//                                                                           Color(
//                                                                               0xFF215732),
//                                                                       elevation:
//                                                                           0.0,
//                                                                       shadowColor:
//                                                                           Colors
//                                                                               .transparent,
//                                                                       onPrimary:
//                                                                           Color(
//                                                                               0xFFFFFFFF),
//                                                                       shape:
//                                                                           RoundedRectangleBorder(
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(7),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                               height: height *
//                                                                   0.02),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 );
//                                               });
//                                         },
//                                         child: Text(
//                                             'Add new user'.tr().toString(),
//                                             strutStyle: StrutStyle(
//                                                 forceStrutHeight: true),
//                                             style: GoogleFonts.barlow(
//                                               textStyle: TextStyle(
//                                                   color: Color(0xFFFFFFFF),
//                                                   fontWeight: FontWeight.w500,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 16),
//                                             )),
//                                         style: ElevatedButton.styleFrom(
//                                             primary: Color(0xFF215732),
//                                             onPrimary: Colors.white,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                             side: BorderSide(
//                                               width: 0.4,
//                                             )),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         eventCard,
//                         SizedBox(height: height * 0.02),
//                         Container(
//                           height: height * 0.9,
//                           child: WebSmoothScroll(
//                             controller: _scrollController,
//                             child: SingleChildScrollView(
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 40.0, right: 40.0, top: 18.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           searchtab,
//                                           SizedBox(
//                                             width: width * 0.005,
//                                           ),
//                                           sortbtn
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: height * 0.035,
//                                       ),
//                                       Center(child: addedPopup),
//                                       SizedBox(
//                                         height: height * 0.035,
//                                       ),
//                                       Card(
//                                           child: WebSmoothScroll(
//                                         controller: _scrollController,
//                                         child: SingleChildScrollView(
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Container(
//                                                 width: width * 0.7,
//                                                 height: height * 0.07,
//                                                 decoration: BoxDecoration(
//                                                   color: Color(0xFFF5F0E5),
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                           topRight: Radius
//                                                               .circular(9.0),
//                                                           bottomRight:
//                                                               Radius.circular(
//                                                                   0),
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   9.0),
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                                   0)),
//                                                 ),
//                                                 child: Row(
//                                                   children: [
//                                                     SizedBox(
//                                                       width: width * 0.01,
//                                                     ),
//                                                     Text(
//                                                       "Picture".tr(),
//                                                       style: GoogleFonts.barlow(
//                                                         textStyle: TextStyle(
//                                                             color: Color(
//                                                                 0xFFBD9B60),
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             fontStyle: FontStyle
//                                                                 .normal,
//                                                             fontSize: 18),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: width * 0.023,
//                                                     ),
//                                                     Container(
//                                                       width: width * 0.135,
//                                                       child: Text(
//                                                         "Name".tr(),
//                                                         style:
//                                                             GoogleFonts.barlow(
//                                                           textStyle: TextStyle(
//                                                               color: Color(
//                                                                   0xFFBD9B60),
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               fontStyle:
//                                                                   FontStyle
//                                                                       .normal,
//                                                               fontSize: 18),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       width: context.locale ==
//                                                               Locale("en")
//                                                           ? width * 0.158
//                                                           : width * 0.19,
//                                                       child: Text(
//                                                         "Email".tr(),
//                                                         style:
//                                                             GoogleFonts.barlow(
//                                                           textStyle: TextStyle(
//                                                               color: Color(
//                                                                   0xFFBD9B60),
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               fontStyle:
//                                                                   FontStyle
//                                                                       .normal,
//                                                               fontSize: 18),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       width: context.locale ==
//                                                               Locale("en")
//                                                           ? width * 0.069
//                                                           : width * 0.063,
//                                                       child: Text(
//                                                         "Account type".tr(),
//                                                         style:
//                                                             GoogleFonts.barlow(
//                                                           textStyle: TextStyle(
//                                                               color: Color(
//                                                                   0xFFBD9B60),
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               fontStyle:
//                                                                   FontStyle
//                                                                       .normal,
//                                                               fontSize: 18),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: context.locale ==
//                                                               Locale("en")
//                                                           ? width * 0.07
//                                                           : width * 0.045,
//                                                     ),
//                                                     Text(
//                                                       "Status".tr(),
//                                                       style: GoogleFonts.barlow(
//                                                         textStyle: TextStyle(
//                                                             color: Color(
//                                                                 0xFFBD9B60),
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             fontStyle: FontStyle
//                                                                 .normal,
//                                                             fontSize: 18),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: width * 0.08,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Material(
//                                                 elevation: 1,
//                                                 color: Colors.white,
//                                                 child: Container(
//                                                   width: width * 0.725,
//                                                   height: height * 0.07,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius
//                                                         .only(
//                                                             topRight: Radius
//                                                                 .circular(9.0),
//                                                             bottomRight:
//                                                                 Radius.circular(
//                                                                     0),
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                     9.0),
//                                                             bottomLeft:
//                                                                 Radius.circular(
//                                                                     0)),
//                                                   ),
//                                                   child: Row(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: width * 0.01,
//                                                       ),
//                                                       Image.asset(
//                                                           "assets/images/smallpfp.png"),
//                                                       SizedBox(
//                                                         width: width * 0.035,
//                                                       ),
//                                                       Container(
//                                                         width: width * 0.135,
//                                                         child: Text(
//                                                           "Saad Alkroud".tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.158
//                                                             : width * 0.19,
//                                                         child: Text(
//                                                           "saad@pif.gov.sa",
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.065
//                                                             : width * 0.063,
//                                                         child: Container(
//                                                           child:
//                                                               DropdownButtonFormField(
//                                                             decoration:
//                                                                 InputDecoration
//                                                                     .collapsed(
//                                                                         hintText:
//                                                                             ''),
//                                                             style: GoogleFonts
//                                                                 .barlow(
//                                                               textStyle: TextStyle(
//                                                                   color: Color(
//                                                                       0xFF222222),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   fontStyle:
//                                                                       FontStyle
//                                                                           .normal,
//                                                                   fontSize: 16),
//                                                             ),
//                                                             // Initial Value
//                                                             value:
//                                                                 dropdownvalue1,
//
//                                                             // Down Arrow Icon
//                                                             icon: Icon(
//                                                               Icons
//                                                                   .expand_more_rounded,
//                                                               size: 18,
//                                                               color: Color(
//                                                                   0Xff999999),
//                                                             ),
//
//                                                             // Array list of items
//                                                             items: items.map(
//                                                                 (String items) {
//                                                               return DropdownMenuItem(
//                                                                 value: items,
//                                                                 child: Text(
//                                                                   items,
//                                                                   style:
//                                                                       GoogleFonts
//                                                                           .barlow(
//                                                                     textStyle: TextStyle(
//                                                                         color: Color(
//                                                                             0xFF222222),
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w400,
//                                                                         fontStyle:
//                                                                             FontStyle
//                                                                                 .normal,
//                                                                         fontSize:
//                                                                             14),
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             }).toList(),
//                                                             // After selecting the desired option,it will
//                                                             // change button value to selected value
//                                                             onChanged: (String?
//                                                                 newValue) {
//                                                               setState(() {
//                                                                 dropdownvalue1 =
//                                                                     newValue!;
//                                                               });
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.07
//                                                             : width * 0.045,
//                                                       ),
//                                                       ElevatedButton(
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                           primary: Colors.white,
//                                                           shape:
//                                                               RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         18.0),
//                                                             side: BorderSide(
//                                                               color: Color(
//                                                                   0xFF007A33),
//                                                               width: 0.5,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         child: Text(
//                                                           'Active'.tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF007A33),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                         onPressed: () {},
//                                                       ),
//                                                       SizedBox(
//                                                           width: width * 0.094),
//                                                       GestureDetector(
//                                                           onTap: () {
//                                                             // This is a hack because _PopupMenuButtonState is private.
//                                                             dynamic state =
//                                                                 _menuKey
//                                                                     .currentState;
//                                                             state
//                                                                 .showButtonMenu();
//                                                           },
//                                                           child: button)
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Material(
//                                                 elevation: 1,
//                                                 color: Colors.white,
//                                                 child: Container(
//                                                   width: width * 0.725,
//                                                   height: height * 0.07,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius
//                                                         .only(
//                                                             topRight: Radius
//                                                                 .circular(9.0),
//                                                             bottomRight:
//                                                                 Radius.circular(
//                                                                     0),
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                     9.0),
//                                                             bottomLeft:
//                                                                 Radius.circular(
//                                                                     0)),
//                                                   ),
//                                                   child: Row(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: width * 0.01,
//                                                       ),
//                                                       Image.asset(
//                                                           "assets/images/smallpfp.png"),
//                                                       SizedBox(
//                                                         width: width * 0.035,
//                                                       ),
//                                                       Container(
//                                                         width: width * 0.135,
//                                                         child: Text(
//                                                           "Mohammad Al...".tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.158
//                                                             : width * 0.19,
//                                                         child: Text(
//                                                           "alsugairmohd@gmail.com",
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.065
//                                                             : width * 0.063,
//                                                         child: Container(
//                                                           child:
//                                                               DropdownButtonFormField(
//                                                             decoration:
//                                                                 InputDecoration
//                                                                     .collapsed(
//                                                                         hintText:
//                                                                             ''),
//                                                             style: GoogleFonts
//                                                                 .barlow(
//                                                               textStyle: TextStyle(
//                                                                   color: Color(
//                                                                       0xFF222222),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   fontStyle:
//                                                                       FontStyle
//                                                                           .normal,
//                                                                   fontSize: 16),
//                                                             ),
//                                                             // Initial Value
//                                                             value:
//                                                                 dropdownvalue1,
//
//                                                             // Down Arrow Icon
//                                                             icon: Icon(
//                                                               Icons
//                                                                   .expand_more_rounded,
//                                                               size: 18,
//                                                               color: Color(
//                                                                   0Xff999999),
//                                                             ),
//
//                                                             // Array list of items
//                                                             items: items.map(
//                                                                 (String items) {
//                                                               return DropdownMenuItem(
//                                                                 value: items,
//                                                                 child: Text(
//                                                                   items,
//                                                                   style:
//                                                                       GoogleFonts
//                                                                           .barlow(
//                                                                     textStyle: TextStyle(
//                                                                         color: Color(
//                                                                             0xFF222222),
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w400,
//                                                                         fontStyle:
//                                                                             FontStyle
//                                                                                 .normal,
//                                                                         fontSize:
//                                                                             14),
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             }).toList(),
//                                                             // After selecting the desired option,it will
//                                                             // change button value to selected value
//                                                             onChanged: (String?
//                                                                 newValue) {
//                                                               setState(() {
//                                                                 dropdownvalue1 =
//                                                                     newValue!;
//                                                               });
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.07
//                                                             : width * 0.045,
//                                                       ),
//                                                       ElevatedButton(
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                           primary: Colors.white,
//                                                           shape:
//                                                               RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         18.0),
//                                                             side: BorderSide(
//                                                               color: Color(
//                                                                   0xFF007A33),
//                                                               width: 0.5,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         child: Text(
//                                                           'Active'.tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF007A33),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                         onPressed: () {},
//                                                       ),
//                                                       SizedBox(
//                                                           width: width * 0.1),
//                                                       Icon(
//                                                           Icons
//                                                               .more_vert_rounded,
//                                                           size: 18,
//                                                           color:
//                                                               Color(0xFF999999))
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Material(
//                                                 elevation: 1,
//                                                 color: Colors.white,
//                                                 child: Container(
//                                                   width: width * 0.725,
//                                                   height: height * 0.07,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius
//                                                         .only(
//                                                             topRight: Radius
//                                                                 .circular(9.0),
//                                                             bottomRight:
//                                                                 Radius.circular(
//                                                                     0),
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                     9.0),
//                                                             bottomLeft:
//                                                                 Radius.circular(
//                                                                     0)),
//                                                   ),
//                                                   child: Row(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: width * 0.01,
//                                                       ),
//                                                       Image.asset(
//                                                           "assets/images/smallpfp1.png"),
//                                                       SizedBox(
//                                                         width: width * 0.035,
//                                                       ),
//                                                       Container(
//                                                         width: width * 0.135,
//                                                         child: Text(
//                                                           "Fatemah Khalid".tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.158
//                                                             : width * 0.19,
//                                                         child: Text(
//                                                           "fatemahk@pif.gov.sa",
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.065
//                                                             : width * 0.063,
//                                                         child: Container(
//                                                           child:
//                                                               DropdownButtonFormField(
//                                                             decoration:
//                                                                 InputDecoration
//                                                                     .collapsed(
//                                                                         hintText:
//                                                                             ''),
//                                                             style: GoogleFonts
//                                                                 .barlow(
//                                                               textStyle: TextStyle(
//                                                                   color: Color(
//                                                                       0xFF222222),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   fontStyle:
//                                                                       FontStyle
//                                                                           .normal,
//                                                                   fontSize: 16),
//                                                             ),
//                                                             // Initial Value
//                                                             value:
//                                                                 dropdownvalue1,
//
//                                                             // Down Arrow Icon
//                                                             icon: Icon(
//                                                               Icons
//                                                                   .expand_more_rounded,
//                                                               size: 18,
//                                                               color: Color(
//                                                                   0Xff999999),
//                                                             ),
//
//                                                             // Array list of items
//                                                             items: items.map(
//                                                                 (String items) {
//                                                               return DropdownMenuItem(
//                                                                 value: items,
//                                                                 child: Text(
//                                                                   items,
//                                                                   style:
//                                                                       GoogleFonts
//                                                                           .barlow(
//                                                                     textStyle: TextStyle(
//                                                                         color: Color(
//                                                                             0xFF222222),
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w400,
//                                                                         fontStyle:
//                                                                             FontStyle
//                                                                                 .normal,
//                                                                         fontSize:
//                                                                             14),
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             }).toList(),
//                                                             // After selecting the desired option,it will
//                                                             // change button value to selected value
//                                                             onChanged: (String?
//                                                                 newValue) {
//                                                               setState(() {
//                                                                 dropdownvalue1 =
//                                                                     newValue!;
//                                                               });
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.07
//                                                             : width * 0.045,
//                                                       ),
//                                                       ElevatedButton(
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                           primary: Colors.white,
//                                                           shape:
//                                                               RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         18.0),
//                                                             side: BorderSide(
//                                                               color: Color(
//                                                                   0xFF007A33),
//                                                               width: 0.5,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         child: Text(
//                                                           'Active'.tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF007A33),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                         onPressed: () {},
//                                                       ),
//                                                       SizedBox(
//                                                           width: width * 0.1),
//                                                       Icon(
//                                                           Icons
//                                                               .more_vert_rounded,
//                                                           size: 18,
//                                                           color:
//                                                               Color(0xFF999999))
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Material(
//                                                 elevation: 1,
//                                                 color: Colors.white,
//                                                 child: Container(
//                                                   width: width * 0.725,
//                                                   height: height * 0.07,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius
//                                                         .only(
//                                                             topRight: Radius
//                                                                 .circular(9.0),
//                                                             bottomRight:
//                                                                 Radius.circular(
//                                                                     0),
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                     9.0),
//                                                             bottomLeft:
//                                                                 Radius.circular(
//                                                                     0)),
//                                                   ),
//                                                   child: Row(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: width * 0.01,
//                                                       ),
//                                                       Image.asset(
//                                                           "assets/images/smallpfp2.png"),
//                                                       SizedBox(
//                                                         width: width * 0.035,
//                                                       ),
//                                                       Container(
//                                                         width: width * 0.135,
//                                                         child: Text(
//                                                           "Ayesha Mohammad"
//                                                               .tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.158
//                                                             : width * 0.19,
//                                                         child: Text(
//                                                           "ayesha@pif.gov.sa",
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.065
//                                                             : width * 0.063,
//                                                         child: Container(
//                                                           child:
//                                                               DropdownButtonFormField(
//                                                             decoration:
//                                                                 InputDecoration
//                                                                     .collapsed(
//                                                                         hintText:
//                                                                             ''),
//                                                             style: GoogleFonts
//                                                                 .barlow(
//                                                               textStyle: TextStyle(
//                                                                   color: Color(
//                                                                       0xFF222222),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   fontStyle:
//                                                                       FontStyle
//                                                                           .normal,
//                                                                   fontSize: 16),
//                                                             ),
//                                                             // Initial Value
//                                                             value:
//                                                                 dropdownvalue1,
//
//                                                             // Down Arrow Icon
//                                                             icon: Icon(
//                                                               Icons
//                                                                   .expand_more_rounded,
//                                                               size: 18,
//                                                               color: Color(
//                                                                   0Xff999999),
//                                                             ),
//
//                                                             // Array list of items
//                                                             items: items.map(
//                                                                 (String items) {
//                                                               return DropdownMenuItem(
//                                                                 value: items,
//                                                                 child: Text(
//                                                                   items,
//                                                                   style:
//                                                                       GoogleFonts
//                                                                           .barlow(
//                                                                     textStyle: TextStyle(
//                                                                         color: Color(
//                                                                             0xFF222222),
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w400,
//                                                                         fontStyle:
//                                                                             FontStyle
//                                                                                 .normal,
//                                                                         fontSize:
//                                                                             14),
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             }).toList(),
//                                                             // After selecting the desired option,it will
//                                                             // change button value to selected value
//                                                             onChanged: (String?
//                                                                 newValue) {
//                                                               setState(() {
//                                                                 dropdownvalue1 =
//                                                                     newValue!;
//                                                               });
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.07
//                                                             : width * 0.045,
//                                                       ),
//                                                       ElevatedButton(
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                           primary: Colors.white,
//                                                           shape:
//                                                               RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         18.0),
//                                                             side: BorderSide(
//                                                               color: Color(
//                                                                   0xFF007A33),
//                                                               width: 0.5,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         child: Text(
//                                                           'Active'.tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF007A33),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                         onPressed: () {},
//                                                       ),
//                                                       SizedBox(
//                                                           width: width * 0.1),
//                                                       Icon(
//                                                           Icons
//                                                               .more_vert_rounded,
//                                                           size: 18,
//                                                           color:
//                                                               Color(0xFF999999))
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Material(
//                                                 elevation: 1,
//                                                 color: Colors.white,
//                                                 child: Container(
//                                                   width: width * 0.725,
//                                                   height: height * 0.07,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius
//                                                         .only(
//                                                             topRight: Radius
//                                                                 .circular(9.0),
//                                                             bottomRight:
//                                                                 Radius.circular(
//                                                                     0),
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                     9.0),
//                                                             bottomLeft:
//                                                                 Radius.circular(
//                                                                     0)),
//                                                   ),
//                                                   child: Row(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: width * 0.01,
//                                                       ),
//                                                       Image.asset(
//                                                           "assets/images/smallpfp.png"),
//                                                       SizedBox(
//                                                         width: width * 0.035,
//                                                       ),
//                                                       Container(
//                                                         width: width * 0.135,
//                                                         child: Text(
//                                                           "Mohammad Al...".tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.158
//                                                             : width * 0.19,
//                                                         child: Text(
//                                                           "alsugairmohd@gmail.com",
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.065
//                                                             : width * 0.063,
//                                                         child: Container(
//                                                           child:
//                                                               DropdownButtonFormField(
//                                                             decoration:
//                                                                 InputDecoration
//                                                                     .collapsed(
//                                                                         hintText:
//                                                                             ''),
//                                                             style: GoogleFonts
//                                                                 .barlow(
//                                                               textStyle: TextStyle(
//                                                                   color: Color(
//                                                                       0xFF222222),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   fontStyle:
//                                                                       FontStyle
//                                                                           .normal,
//                                                                   fontSize: 16),
//                                                             ),
//                                                             // Initial Value
//                                                             value:
//                                                                 dropdownvalue1,
//
//                                                             // Down Arrow Icon
//                                                             icon: Icon(
//                                                               Icons
//                                                                   .expand_more_rounded,
//                                                               size: 18,
//                                                               color: Color(
//                                                                   0Xff999999),
//                                                             ),
//
//                                                             // Array list of items
//                                                             items: items.map(
//                                                                 (String items) {
//                                                               return DropdownMenuItem(
//                                                                 value: items,
//                                                                 child: Text(
//                                                                   items,
//                                                                   style:
//                                                                       GoogleFonts
//                                                                           .barlow(
//                                                                     textStyle: TextStyle(
//                                                                         color: Color(
//                                                                             0xFF222222),
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w400,
//                                                                         fontStyle:
//                                                                             FontStyle
//                                                                                 .normal,
//                                                                         fontSize:
//                                                                             14),
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             }).toList(),
//                                                             // After selecting the desired option,it will
//                                                             // change button value to selected value
//                                                             onChanged: (String?
//                                                                 newValue) {
//                                                               setState(() {
//                                                                 dropdownvalue1 =
//                                                                     newValue!;
//                                                               });
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.07
//                                                             : width * 0.045,
//                                                       ),
//                                                       ElevatedButton(
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                           primary: Colors.white,
//                                                           shape:
//                                                               RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         18.0),
//                                                             side: BorderSide(
//                                                               color: Color(
//                                                                   0xFF007A33),
//                                                               width: 0.5,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         child: Text(
//                                                           'Active'.tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF007A33),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                         onPressed: () {},
//                                                       ),
//                                                       SizedBox(
//                                                           width: width * 0.1),
//                                                       Icon(
//                                                           Icons
//                                                               .more_vert_rounded,
//                                                           size: 18,
//                                                           color:
//                                                               Color(0xFF999999))
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Material(
//                                                 elevation: 1,
//                                                 color: Colors.white,
//                                                 child: Container(
//                                                   width: width * 0.725,
//                                                   height: height * 0.07,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius
//                                                         .only(
//                                                             topRight: Radius
//                                                                 .circular(9.0),
//                                                             bottomRight:
//                                                                 Radius.circular(
//                                                                     0),
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                     9.0),
//                                                             bottomLeft:
//                                                                 Radius.circular(
//                                                                     0)),
//                                                   ),
//                                                   child: Row(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: width * 0.01,
//                                                       ),
//                                                       Image.asset(
//                                                           "assets/images/smallpfp.png"),
//                                                       SizedBox(
//                                                         width: width * 0.035,
//                                                       ),
//                                                       Container(
//                                                         width: width * 0.135,
//                                                         child: Text(
//                                                           "Mohammad Abdulrahman"
//                                                               .tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.158
//                                                             : width * 0.19,
//                                                         child: Text(
//                                                           "alsugairmohd@gmail.com",
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF222222),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.065
//                                                             : width * 0.063,
//                                                         child: Container(
//                                                           child:
//                                                               DropdownButtonFormField(
//                                                             decoration:
//                                                                 InputDecoration
//                                                                     .collapsed(
//                                                                         hintText:
//                                                                             ''),
//                                                             style: GoogleFonts
//                                                                 .barlow(
//                                                               textStyle: TextStyle(
//                                                                   color: Color(
//                                                                       0xFF222222),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   fontStyle:
//                                                                       FontStyle
//                                                                           .normal,
//                                                                   fontSize: 16),
//                                                             ),
//                                                             // Initial Value
//                                                             value:
//                                                                 dropdownvalue1,
//
//                                                             // Down Arrow Icon
//                                                             icon: Icon(
//                                                               Icons
//                                                                   .expand_more_rounded,
//                                                               size: 18,
//                                                               color: Color(
//                                                                   0Xff999999),
//                                                             ),
//
//                                                             // Array list of items
//                                                             items: items.map(
//                                                                 (String items) {
//                                                               return DropdownMenuItem(
//                                                                 value: items,
//                                                                 child: Text(
//                                                                   items,
//                                                                   style:
//                                                                       GoogleFonts
//                                                                           .barlow(
//                                                                     textStyle: TextStyle(
//                                                                         color: Color(
//                                                                             0xFF222222),
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w400,
//                                                                         fontStyle:
//                                                                             FontStyle
//                                                                                 .normal,
//                                                                         fontSize:
//                                                                             14),
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             }).toList(),
//                                                             // After selecting the desired option,it will
//                                                             // change button value to selected value
//                                                             onChanged: (String?
//                                                                 newValue) {
//                                                               setState(() {
//                                                                 dropdownvalue1 =
//                                                                     newValue!;
//                                                               });
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: context.locale ==
//                                                                 Locale("en")
//                                                             ? width * 0.07
//                                                             : width * 0.045,
//                                                       ),
//                                                       ElevatedButton(
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                           primary: Colors.white,
//                                                           shape:
//                                                               RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         15.0),
//                                                             side: BorderSide(
//                                                               color: Color(
//                                                                   0xFF007A33),
//                                                               width: 0.5,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         child: Text(
//                                                           'Active'.tr(),
//                                                           style: GoogleFonts
//                                                               .barlow(
//                                                             textStyle: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF007A33),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontSize: 14),
//                                                           ),
//                                                         ),
//                                                         onPressed: () {},
//                                                       ),
//                                                       SizedBox(
//                                                           width: width * 0.1),
//                                                       Icon(
//                                                           Icons
//                                                               .more_vert_rounded,
//                                                           size: 18,
//                                                           color:
//                                                               Color(0xFF999999))
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )),
//                                       SizedBox(height: height * 0.2),
//                                       Row(
//                                         children: [
//                                           num,
//                                           SizedBox(
//                                             width: width * 0.007,
//                                           ),
//                                           Text(
//                                             "Showing 6 of 6 results".tr(),
//                                             style: GoogleFonts.barlow(
//                                               textStyle: TextStyle(
//                                                   color: Color(0Xff999999),
//                                                   fontWeight: FontWeight.w500,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: height * 0.03),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         eventCard,
//                       ],
//                     ),
//                   )),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// //
// //
// // class confirmusers extends StatefulWidget {
// //   const confirmusers({Key? key}) : super(key: key);
// //
// //   @override
// //   State<confirmusers> createState() => _confirmusersState();
// // }
// //
// // class _confirmusersState extends State<confirmusers> {
// //
// //   late ScrollController _scrollController;
// //
// //   @override
// //   void initState() {
// //     // initialize scroll controllers
// //     _scrollController = ScrollController();
// //
// //     super.initState();
// //   }
// //   bool? checkedValue = true;
// //   final num = SizedBox(
// //       child: ElevatedButton(
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text("08       ".tr().toString(),strutStyle: StrutStyle(
// //                 forceStrutHeight: true
// //             )),
// //             SizedBox(width: 25,),
// //             Icon(Icons.expand_more_rounded,size: 18,color: Color(0xFF999999),)
// //           ],
// //         ),
// //         onPressed: (){
// //           print("You pressed Icon Elevated Button");
// //         },
// //         // icon: Icon(Icons.filter_list),
// //         //  //label text
// //         style: ElevatedButton.styleFrom(
// //             elevation: 0,
// //             side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(8), // <-- Radius
// //             ),
// //             primary: Colors.white ,//elevated btton background color
// //             onPrimary: Colors.black,
// //             minimumSize: Size(120,50)
// //         ),
// //       ));
// //   @override
// //   Widget build(BuildContext context) {
// //     double height = MediaQuery.of(context).size.height;
// //     double width = MediaQuery.of(context).size.width;
// //     final addedPopup = SizedBox(height: height*0.055,
// //         width: width*0.15,
// //         child : ElevatedButton.icon(
// //           onPressed: (){
// //             print("You pressed Icon Elevated Button");
// //           },
// //           icon: ImageIcon(
// //             AssetImage("assets/images/approve.png"),color:Color(0xFF215732),
// //           ),  //icon data for elevated button
// //           label: Text("New user has been added".tr().toString(),strutStyle: StrutStyle(
// //               forceStrutHeight: true
// //           ),style: GoogleFonts.barlow(
// //             textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
// //           ),), //label text
// //           style: ElevatedButton.styleFrom(
// //               elevation: 0,
// //               side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(7), // <-- Radius
// //               ),
// //               primary: Color(0xfff1f4f2) ,//elevated btton background color
// //               onPrimary: Color(0xFF215732)
// //
// //
// //           ),
// //         )
// //     );
// //     final searchtab =    Container(
// //       width: width*0.4,
// //       decoration: BoxDecoration(
// //           border: Border.all(color: Color(0xFFEEEEEE)),
// //           borderRadius: BorderRadius.circular(4)
// //
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.only(left: 18.0,right: 20.0,top: 5,bottom: 5),
// //         child: Row(
// //           children: [
// //             Image.asset("assets/images/search.png",color: Color(0xFFBD9B60)),
// //             SizedBox(width: width*0.009,),
// //             Text("  Search",style: GoogleFonts.barlow(
// //               textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
// //             ),),
// //             SizedBox(width: width*0.22,),
// //             Image.asset("assets/images/mic.png",color: Color(0xFF999999)),
// //             SizedBox(width: width*0.009,),
// //
// //             // SizedBox(width: width*0.06,),
// //             Image.asset("assets/images/Separator.png",color: Color(0xFFEEEEEE),),
// //             Row(
// //               children: [
// //                 SizedBox(width: width*0.021,),
// //
// //                 Image.asset("assets/images/filter.png",color: Color(0xFF215732)),
// //                 Text("  Filter",style: GoogleFonts.barlow(
// //                   textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
// //                 ),),
// //               ],
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //     final sortbtn = Container(
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(4),
// //         border: Border.all(color: Colors.black,width: 0.4),
// //
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.only(top: 12.5,bottom: 12.5,left: 17,right: 17),
// //         child: Row(
// //           children: [
// //             Image.asset("assets/images/sort.png",color:Color(0xFF222222)),
// //             Text("  Sort",style: GoogleFonts.barlow(
// //               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
// //             ),),
// //
// //           ],
// //         ),
// //       ),
// //     );
// //
// //     return Scaffold(
// //       body: Container(
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Container(
// //               height: height,
// //               width: width*0.003,
// //               color: Color(0xFFBD9B60),
// //               // child: Text("we"),
// //             ),
// //             Drawer(
// //               width: width*0.2,
// //
// //               child: Container(
// //                 color: Color(0xFF183028),
// //                 child: ListView(
// //
// //                   children: <Widget>[
// //                     SizedBox(
// //                       child: Align(
// //                         alignment: Alignment.bottomLeft,
// //                         child: DrawerHeader(
// //                           padding: EdgeInsets.all(0.0),
// //                           child: Row(
// //                             children: [
// //                               SizedBox(width: width*0.008,),
// //                               Image.asset("assets/images/pifLogo.png",fit: BoxFit.contain,
// //                                 width: 86,),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //
// //                     ListTile(
// //                       leading: ImageIcon(AssetImage("assets/images/home.png"),color: Color(0xFFBD9B60),),
// //                       minLeadingWidth : width*0.02,
// //
// //                       title: Text("Home",style: GoogleFonts.barlow(
// //                         textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
// //                       ),),
// //                       onTap: () => {},
// //                     ),
// //
// //                     ListTile(
// //                       leading: ImageIcon(AssetImage("assets/images/courses.png"),color: Color(0xFFBD9B60),),
// //                       minLeadingWidth : width*0.02,
// //
// //
// //                       title:Text("Courses",style: GoogleFonts.barlow(
// //                         textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
// //                       ),),
// //
// //                       onTap: () => {
// //                         // Navigator.push(
// //                         //   context,
// //                         //   MaterialPageRoute(builder: (context) => coursesPage()),
// //                         // )
// //                       },
// //                     ),
// //                     Padding(
// //                       padding:  EdgeInsets.only(right: width*0.01),
// //                       child: Container(
// //
// //                         decoration: BoxDecoration(
// //
// //                           color: Color(0xFFBD9B60),
// //                           //
// //                           borderRadius: BorderRadius.only(
// //                             topRight: Radius.circular(40.0),
// //                             bottomRight: Radius.circular(40.0),
// //                           ),
// //                         ),
// //                         child: ListTile(
// //                           leading: ImageIcon(AssetImage("assets/images/admin.png"),color: Colors.white,),
// //                           minLeadingWidth : width*0.02,
// //
// //                           title: Text("Administration",style: GoogleFonts.barlow(
// //                             textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
// //                           ),),
// //                           onTap: () => {},
// //                         ),
// //                       ),
// //                     ),
// //
// //                     ListTile(
// //                       title: Padding(
// //                         padding:  EdgeInsets.only(left: width*0.028),
// //                         child: Text("Events",style: GoogleFonts.barlow(
// //                           textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
// //                         ),),
// //                       ),
// //                       onTap: () => {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => announcements()),
// //                         )
// //
// //                       },
// //                     ),
// //                     ListTile(
// //                       title: Padding(
// //                         padding:  EdgeInsets.only(left: width*0.028),
// //                         child: Text("Announcements",style: GoogleFonts.barlow(
// //                           textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
// //                         ),),
// //                       ),
// //                       onTap: () => {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => announcements()),
// //                         )
// //
// //                       },
// //                     ),
// //
// //                     Padding(
// //                       padding:  EdgeInsets.only(right: width*0.01,left: width*0.025),
// //
// //                       child: Row(
// //                         children: [
// //                           Container(
// //                             height: height*0.06,
// //                             width: 5,
// //                             color: Color(0xFFBD9B60),
// //                             // child: Text("we"),
// //                           ),
// //                           Expanded(
// //                             child: Container(
// //                               decoration: BoxDecoration(
// //
// //                                 color:  Color.fromRGBO(189, 155, 96, 0.2),
// //                                 //
// //                                 borderRadius: BorderRadius.only(
// //                                   topRight: Radius.circular(40.0),
// //                                   bottomRight: Radius.circular(40.0),
// //                                 ),
// //                               ),
// //                               child: ListTile(
// //                                 title: Text("Users",style: GoogleFonts.barlow(
// //                                   textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
// //                                 ),),
// //                                 onTap: () => {
// //                                   Navigator.push(
// //                                     context,
// //                                     MaterialPageRoute(builder: (context) => confirmusers()),
// //                                   )
// //
// //                                 },
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //
// //                     ListTile(
// //                       leading: ImageIcon(AssetImage("assets/images/settings.png"),color: Color(0xFFBD9B60),),
// //                       minLeadingWidth : width*0.02,
// //
// //                       title: Text("Settings",style: GoogleFonts.barlow(
// //                         textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
// //                       ),),
// //
// //                       onTap: () => {Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => settings()),
// //                       )},
// //                     ),
// //
// //
// //                     ListTile(
// //                       leading: ImageIcon(AssetImage("assets/images/communication.png"),color: Color(0xFFBD9B60),),
// //                       minLeadingWidth : width*0.02,
// //
// //
// //                       title: Text("Help",style: GoogleFonts.barlow(
// //                         textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
// //                       ),),
// //
// //                       onTap: () => {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => helpResponsive()),
// //                         )
// //                       },
// //                     ),
// //                     SizedBox(height: height*0.004,),
// //                     Divider(color: Color(0xffFFFFFF), thickness: 0.2,indent: 12,
// //                       endIndent: 12,),
// //                     SizedBox(height: height*0.008,),
// //
// //
// //                     ListTile(
// //                       leading: Image.asset("assets/images/message.png"),
// //                       minLeadingWidth : 1,
// //
// //                       title:Text("Messages",style: GoogleFonts.barlow(
// //                         textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
// //                       ),),
// //
// //                       onTap: () => {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => messages()),
// //                         )
// //                       },
// //                     ),
// //
// //
// //                     SizedBox(height: height*0.008,),
// //                     Divider(color: Color(0xffFFFFFF), thickness: 0.2,indent: 12,
// //                       endIndent: 12,),
// //                     ListTile(
// //                       leading: ImageIcon(AssetImage("assets/images/logout.png"),color: Color(0xFFBD9B60),),
// //                       minLeadingWidth : width*0.02,
// //
// //                       title: Text("Logout",style: GoogleFonts.barlow(
// //                         textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 18),
// //                       ),),
// //                       onTap: () => {Navigator.of(context).pop()},
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //
// //             ),
// //
// //             Container(
// //               height: height,
// //               width: width*0.77,
// //               child: Padding(
// //                 padding:  EdgeInsets.only(left: width*0.025,bottom:height*0.02),
// //                 child: WebSmoothScroll(
// //                   controller: _scrollController,
// //
// //                   child: SingleChildScrollView(
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.start,
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         SizedBox(height: height*0.02,),
// //                         Container(
// //                           height: height*0.08,
// //
// //                           child: Row(
// //                             children: [
// //                               Text("Administration /",style: GoogleFonts.barlow(
// //                                 textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
// //                               ),),Text("Users",style: GoogleFonts.barlow(
// //                                 textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize:16),
// //                               ),),
// //                               SizedBox(width: width*0.5685,),
// //                               Image.asset("assets/images/message.png"),
// //                               SizedBox(width: width*0.02,),
// //                               Image.asset("assets/images/profileIcon.png")
// //
// //
// //                             ],
// //                           ),
// //
// //                         ),
// //                         SizedBox(height: 10,),
// //                         Row(
// //                           children: [
// //                             Icon(Icons.arrow_back_ios,size: 12,),
// //                             SizedBox(width: width*0.002,),
// //
// //                             Text("Users",style: GoogleFonts.barlow(
// //                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 28),
// //                             ),),
// //                             SizedBox(width: width*0.45,),
// //
// //                             ElevatedButton(
// //
// //                               onPressed: () {
// //
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(builder: (context) => addEvent()),
// //                                 );
// //                               },
// //                               child: Text('Export list as spreadsheet'.tr().toString(),strutStyle: StrutStyle(
// //                                   forceStrutHeight: true
// //                               ),
// //                                   style: GoogleFonts.barlow(
// //                                     textStyle: TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
// //                                   )
// //                               ),
// //                               style: ElevatedButton.styleFrom(
// //                                 primary: Color(0xFFF5F0E5),
// //                                 elevation: 0.0,
// //                                 shadowColor: Colors.transparent,
// //                                 onPrimary: Color(0xFF183028),
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(8),
// //                                 ),
// //                                 minimumSize: Size(width*0.1,height*0.07),
// //
// //                               ),
// //                             ),
// //                             SizedBox(width: width*0.01,),
// //                             ElevatedButton(
// //                               onPressed: () {
// //                                 showDialog(
// //                                     context: context,
// //                                     builder: (BuildContext context) {
// //                                       return AlertDialog(
// //                                         shape: RoundedRectangleBorder(
// //                                             borderRadius: BorderRadius.all(Radius.circular(12.0))),
// //                                         scrollable: true,
// //                                         title: Column(
// //                                           children: [
// //                                             Align(
// //                                                 alignment: Alignment.topRight,
// //                                                 child: Icon(Icons.close)),
// //                                             Center(child: Text("Add New User",style: GoogleFonts.barlow(
// //                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 28),
// //                                             ),),),
// //                                           ],
// //                                         ),
// //                                         content: Padding(
// //                                           padding: const EdgeInsets.only(left: 8.0,right: 8.0),
// //                                           child: Form(
// //                                             child: Column(
// //
// //                                               mainAxisAlignment: MainAxisAlignment.start,
// //                                               crossAxisAlignment: CrossAxisAlignment.start,
// //                                               children: <Widget>[
// //
// //                                                 Center(
// //                                                   child: Text("Enter the details below to add a new user",style: GoogleFonts.barlow(
// //                                                     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                   ),),
// //                                                 ),
// //                                                 SizedBox(height: height*0.07),
// //                                                 Padding(
// //                                                   padding: EdgeInsets.only(right: width*0.04,bottom: height*0.01),
// //                                                   child: Text("Name",style: GoogleFonts.barlow(
// //                                                     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                   ),),
// //                                                 ),
// //                                                 Center(
// //                                                   child: SizedBox(
// //                                                     width: width*0.25,
// //                                                     height: height*0.05,
// //                                                     child: TextField(
// //                                                       decoration: InputDecoration(
// //                                                         focusedBorder: OutlineInputBorder(
// //                                                           borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
// //                                                         ),
// //                                                         enabledBorder: OutlineInputBorder(
// //                                                           borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
// //                                                         ),
// //
// //
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                                 SizedBox(height: height*0.02),
// //                                                 Padding(
// //                                                   padding: EdgeInsets.only(right: width*0.04,bottom: height*0.01),
// //                                                   child: Text("Email",style: GoogleFonts.barlow(
// //                                                     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                   ),),
// //                                                 ),
// //                                                 Center(
// //                                                   child: SizedBox(
// //                                                     width: width*0.25,
// //                                                     height: height*0.05,
// //                                                     child: TextField(
// //                                                       obscureText: true,
// //                                                       decoration: InputDecoration(
// //
// //                                                         focusedBorder: OutlineInputBorder(
// //                                                           borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
// //                                                         ),
// //                                                         enabledBorder: OutlineInputBorder(
// //                                                           borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
// //                                                         ),
// //
// //
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //
// //                                                 SizedBox(height: height*0.02),
// //                                                 Padding(
// //                                                   padding: EdgeInsets.only(right: width*0.04,bottom: height*0.01),
// //                                                   child: Text("Account type",style: GoogleFonts.barlow(
// //                                                     textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                   ),),
// //                                                 ),
// //                                                 Center(
// //                                                   child: SizedBox(
// //                                                     width: width*0.25,
// //                                                     height: height*0.05,
// //                                                     child: TextField(
// //                                                       controller: TextEditingController(text: "Admin"),
// //                                                       decoration: InputDecoration(
// //                                                         contentPadding: EdgeInsets.all(10.0),
// //                                                         suffixIcon: IconButton(
// //
// //                                                             onPressed: (){},
// //                                                             icon: Icon(Icons.expand_more_rounded,size: 14,color: Color(0Xff999999),)
// //                                                         ),
// //                                                         focusedBorder: OutlineInputBorder(
// //                                                           borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
// //                                                         ),
// //                                                         enabledBorder: OutlineInputBorder(
// //                                                           borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.0),
// //                                                         ),
// //
// //
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //
// //                                                 SizedBox(height: height*0.07),
// //
// //                                                 Center(
// //                                                   child: SizedBox(
// //                                                     width: width*0.25,
// //
// //                                                     child: Row(
// //                                                       mainAxisAlignment : MainAxisAlignment.center,
// //                                                       crossAxisAlignment: CrossAxisAlignment.center,
// //                                                       children: [
// //                                                         ElevatedButton(
// //                                                           onPressed: () {
// //
// //                                                           },
// //                                                           child: Padding(
// //                                                             padding: const EdgeInsets.symmetric(vertical: 14,horizontal:50),
// //                                                             child: Text('Cancel'.tr().toString(),strutStyle: StrutStyle(
// //                                                                 forceStrutHeight: true
// //                                                             ),style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF183028), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
// //                                                             ),),
// //                                                           ),
// //                                                           style: ElevatedButton.styleFrom(
// //                                                             elevation: 0.0,
// //                                                             shadowColor: Colors.transparent,
// //                                                             primary: Color(0xFFF5F0E5),
// //                                                             onPrimary: Color(0xFF183028),
// //                                                             shape: RoundedRectangleBorder(
// //                                                               borderRadius: BorderRadius.circular(7),
// //                                                             ),
// //
// //                                                           ),
// //                                                         ),
// //                                                         SizedBox(width: width*0.014,),
// //                                                         ElevatedButton(
// //                                                           onPressed: () {
// //
// //                                                           },
// //                                                           child: Padding(
// //                                                             padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 25),
// //                                                             child: Text('Confirm & add'.tr().toString(),strutStyle: StrutStyle(
// //                                                                 forceStrutHeight: true
// //                                                             ),style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
// //                                                             )),
// //                                                           ),
// //                                                           style: ElevatedButton.styleFrom(
// //                                                             primary: Color(0xFF215732),
// //                                                             elevation: 0.0,
// //                                                             shadowColor: Colors.transparent,
// //                                                             onPrimary: Color(0xFFFFFFFF),
// //                                                             shape: RoundedRectangleBorder(
// //                                                               borderRadius: BorderRadius.circular(7),
// //                                                             ),
// //
// //                                                           ),
// //                                                         ),
// //
// //                                                       ],
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                                 SizedBox(height: height*0.02),
// //
// //
// //                                               ],
// //                                             ),
// //                                           ),
// //                                         ),
// //
// //                                       );
// //                                     });
// //                               },
// //                               child: Text('Add new user'.tr().toString(),strutStyle: StrutStyle(
// //                                   forceStrutHeight: true
// //                               ), style: GoogleFonts.barlow(
// //                                 textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
// //                               )),
// //                               style:  ElevatedButton.styleFrom(
// //                                   primary: Color(0xFF215732),
// //                                   onPrimary: Colors.white,
// //                                   shape: RoundedRectangleBorder(
// //                                     borderRadius: BorderRadius.circular(8),
// //                                   ),
// //                                   minimumSize: Size(width*0.09,height*0.07),
// //                                   side: BorderSide(
// //                                       width: 0.4,
// //                                       color: Colors.black
// //                                   )
// //                               ),
// //                             ),
// //
// //
// //
// //                           ],
// //                         ),
// //                         SizedBox(height: height*0.02),
// //                         Container(
// //                           height: height*0.9,
// //                           child: WebSmoothScroll(
// //                             controller: _scrollController,
// //
// //                             child: SingleChildScrollView(
// //                               child: Card(
// //                                 child: Padding(
// //                                   padding: const EdgeInsets.only(left: 40.0,right:40.0,top:18.0),
// //                                   child: Column(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                     children: [
// //                                       Row(
// //                                         children: [
// //                                           searchtab,
// //                                           SizedBox(width: width*0.23,),
// //                                           sortbtn
// //                                         ],
// //                                       ),
// //                                       SizedBox(height: height*0.035,),
// //                                       Center(child: addedPopup),
// //                                       SizedBox(height: height*0.035,),
// //
// //                                       Card(
// //                                           child: WebSmoothScroll(
// //                                             controller: _scrollController,
// //
// //                                             child: SingleChildScrollView(
// //                                               child: Column(
// //                                                 mainAxisAlignment: MainAxisAlignment.start,
// //                                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                                 children: [
// //
// //                                                   Container(
// //                                                     width: width*0.7,
// //                                                     height: height*0.07,
// //                                                     decoration: BoxDecoration(
// //                                                       color: Color(0xFFF5F0E5),
// //
// //                                                       borderRadius: BorderRadius.only(
// //                                                           topRight: Radius.circular(9.0),
// //                                                           bottomRight: Radius.circular(0),
// //                                                           topLeft: Radius.circular(9.0),
// //                                                           bottomLeft: Radius.circular(0)),
// //                                                     ),
// //                                                     child: Row(
// //                                                       children: [
// //                                                         SizedBox(width: width*0.01,),
// //
// //                                                         Text("Picture",style: GoogleFonts.barlow(
// //                                                           textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 18),
// //                                                         ),),
// //                                                         SizedBox(width: width*0.023,),
// //                                                         Text("Name",style: GoogleFonts.barlow(
// //                                                           textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 18),
// //                                                         ),),
// //                                                         SizedBox(width: width*0.105,),
// //
// //                                                         Text("Email",style: GoogleFonts.barlow(
// //                                                           textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 18),
// //                                                         ),),
// //                                                         SizedBox(width: width*0.13,),
// //                                                         Text("Account type",style: GoogleFonts.barlow(
// //                                                           textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 18),
// //                                                         ),),
// //                                                         SizedBox(width: width*0.06,),
// //                                                         Text("Status",style: GoogleFonts.barlow(
// //                                                           textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 18),
// //                                                         ),),
// //
// //                                                         SizedBox(width: width*0.08,),
// //
// //
// //                                                       ],
// //                                                     ),
// //                                                   ),
// //
// //
// //
// //
// //                                                   Material(
// //                                                     elevation: 1,
// //                                                     color: Colors.white,
// //
// //                                                     child: Container(
// //                                                       width: width*0.725,
// //                                                       height: height*0.07,
// //                                                       decoration: BoxDecoration(
// //
// //
// //                                                         borderRadius: BorderRadius.only(
// //                                                             topRight: Radius.circular(9.0),
// //                                                             bottomRight: Radius.circular(0),
// //                                                             topLeft: Radius.circular(9.0),
// //                                                             bottomLeft: Radius.circular(0)),
// //                                                       ),
// //                                                       child: Row(
// //                                                         children: [
// //                                                           SizedBox(width: width*0.01,),
// //
// //
// //
// //                                                           Image.asset("assets/images/smallpfp.png"),
// //                                                           SizedBox(width: width*0.035,),
// //
// //                                                           Container(
// //                                                             width: width*0.135,
// //                                                             child: Text("Saad Alkroud",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //
// //                                                           Container(
// //
// //                                                             width: width*0.158,
// //                                                             child:  Text("saad@pif.gov.sa",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //                                                           Container(
// //                                                             width: width*0.128,
// //
// //
// //                                                             child: Padding(
// //                                                               padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
// //                                                               child: Row(
// //                                                                 children: [
// //                                                                   Text("Admin ",style: GoogleFonts.barlow(
// //                                                                     textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
// //                                                                   ),),
// //                                                                   Icon( Icons.keyboard_arrow_down_rounded,size: 14,)
// //
// //                                                                 ],
// //                                                               ),
// //                                                             ),
// //                                                           ),
// //                                                           ElevatedButton(
// //                                                             style: ElevatedButton.styleFrom(
// //                                                               primary: Colors.white,
// //
// //                                                               shape:
// //                                                               RoundedRectangleBorder(
// //                                                                 borderRadius: BorderRadius.circular(18.0),
// //                                                                 side: BorderSide(
// //                                                                   color: Color(0xFF007A33),
// //                                                                   width: 0.5,
// //                                                                 ),
// //
// //                                                               ),
// //
// //                                                             ),
// //                                                             child: Text('Active',style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF007A33), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                             onPressed: () {},
// //                                                           ),
// //                                                           SizedBox(width:width*0.1),
// //
// //                                                           GestureDetector(
// //                                                               onTap: (){
// //
// //
// //                                                               },
// //                                                               child: Icon( Icons.more_vert_rounded,size: 18,color: Color(0xFF999999)))
// //
// //                                                         ],
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //
// //                                                   Material(
// //                                                     elevation: 1,
// //                                                     color: Colors.white,
// //
// //                                                     child: Container(
// //                                                       width: width*0.725,
// //                                                       height: height*0.07,
// //                                                       decoration: BoxDecoration(
// //
// //
// //                                                         borderRadius: BorderRadius.only(
// //                                                             topRight: Radius.circular(9.0),
// //                                                             bottomRight: Radius.circular(0),
// //                                                             topLeft: Radius.circular(9.0),
// //                                                             bottomLeft: Radius.circular(0)),
// //                                                       ),
// //                                                       child: Row(
// //                                                         children: [
// //                                                           SizedBox(width: width*0.01,),
// //
// //
// //                                                           Image.asset("assets/images/smallpfp.png"),
// //                                                           SizedBox(width: width*0.035,),
// //
// //
// //                                                           Container(
// //                                                             width: width*0.135,
// //
// //                                                             child: Text("Mohammad Al...",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //
// //                                                           Container(
// //                                                             width: width*0.158,
// //
// //                                                             child:  Text("alsugairmohd@gmail.com",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //                                                           Container(
// //                                                             width: width*0.128,
// //
// //
// //                                                             child: Padding(
// //                                                               padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
// //                                                               child: Row(
// //                                                                 children: [
// //                                                                   Text("Admin",style: GoogleFonts.barlow(
// //                                                                     textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
// //                                                                   ),),
// //                                                                   Icon( Icons.keyboard_arrow_down_rounded,size: 14,)
// //
// //                                                                 ],
// //                                                               ),
// //                                                             ),
// //                                                           ),
// //                                                           ElevatedButton(
// //                                                             style: ElevatedButton.styleFrom(
// //                                                               primary: Colors.white,
// //
// //                                                               shape:
// //                                                               RoundedRectangleBorder(
// //                                                                 borderRadius: BorderRadius.circular(18.0),
// //                                                                 side: BorderSide(
// //                                                                   color: Color(0xFF007A33),
// //                                                                   width: 0.5,
// //                                                                 ),
// //
// //                                                               ),
// //
// //                                                             ),
// //                                                             child: Text('Active',style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF007A33), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
// //
// //                                                             ),),
// //                                                             onPressed: () {},
// //                                                           ),
// //                                                           SizedBox(width:width*0.1),
// //                                                           Icon( Icons.more_vert_rounded,size: 18,color: Color(0xFF999999))
// //
// //                                                         ],
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //
// //
// //                                                   Material(
// //                                                     elevation: 1,
// //                                                     color: Colors.white,
// //
// //                                                     child: Container(
// //                                                       width: width*0.725,
// //                                                       height: height*0.07,
// //                                                       decoration: BoxDecoration(
// //
// //
// //                                                         borderRadius: BorderRadius.only(
// //                                                             topRight: Radius.circular(9.0),
// //                                                             bottomRight: Radius.circular(0),
// //                                                             topLeft: Radius.circular(9.0),
// //                                                             bottomLeft: Radius.circular(0)),
// //                                                       ),
// //                                                       child: Row(
// //                                                         children: [
// //                                                           SizedBox(width: width*0.01,),
// //
// //
// //                                                           Image.asset("assets/images/smallpfp1.png"),
// //                                                           SizedBox(width: width*0.035,),
// //
// //
// //                                                           Container(
// //                                                             width: width*0.135,
// //
// //                                                             child: Text("Fatemah Khalid",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //
// //                                                           Container(
// //                                                             width: width*0.158,
// //
// //                                                             child:  Text("fatemahk@pif.gov.sa",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //                                                           Container(
// //                                                             width: width*0.128,
// //
// //
// //                                                             child: Padding(
// //                                                               padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
// //                                                               child: Row(
// //                                                                 children: [
// //                                                                   Text("Student ",style: GoogleFonts.barlow(
// //                                                                     textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
// //                                                                   ),),
// //                                                                   Icon( Icons.keyboard_arrow_down_rounded,size: 14,)
// //
// //                                                                 ],
// //                                                               ),
// //                                                             ),
// //                                                           ),
// //                                                           ElevatedButton(
// //                                                             style: ElevatedButton.styleFrom(
// //                                                               primary: Colors.white,
// //
// //                                                               shape:
// //                                                               RoundedRectangleBorder(
// //                                                                 borderRadius: BorderRadius.circular(18.0),
// //                                                                 side: BorderSide(
// //                                                                   color: Color(0xFF007A33),
// //                                                                   width: 0.5,
// //                                                                 ),
// //
// //                                                               ),
// //
// //                                                             ),
// //                                                             child: Text('Active',style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF007A33), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                             onPressed: () {},
// //                                                           ),
// //                                                           SizedBox(width:width*0.1),
// //                                                           Icon( Icons.more_vert_rounded,size: 18,color: Color(0xFF999999))
// //
// //                                                         ],
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //
// //                                                   Material(
// //                                                     elevation: 1,
// //                                                     color: Colors.white,
// //
// //                                                     child: Container(
// //                                                       width: width*0.725,
// //                                                       height: height*0.07,
// //                                                       decoration: BoxDecoration(
// //
// //
// //                                                         borderRadius: BorderRadius.only(
// //                                                             topRight: Radius.circular(9.0),
// //                                                             bottomRight: Radius.circular(0),
// //                                                             topLeft: Radius.circular(9.0),
// //                                                             bottomLeft: Radius.circular(0)),
// //                                                       ),
// //                                                       child: Row(
// //                                                         children: [
// //                                                           SizedBox(width: width*0.01,),
// //
// //
// //                                                           Image.asset("assets/images/smallpfp2.png"),
// //                                                           SizedBox(width: width*0.035,),
// //
// //
// //
// //                                                           Container(
// //                                                             width: width*0.135,
// //
// //                                                             child: Text("Ayesha Mohammad",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //
// //
// //                                                           Container(
// //                                                             width: width*0.158,
// //
// //                                                             child:  Text("ayesha@pif.gov.sa",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //                                                           Container(
// //                                                             width: width*0.128,
// //
// //
// //                                                             child: Padding(
// //                                                               padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
// //                                                               child: Row(
// //                                                                 children: [
// //                                                                   Text("Instructor ",style: GoogleFonts.barlow(
// //                                                                     textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
// //                                                                   ),),
// //                                                                   Icon( Icons.keyboard_arrow_down_rounded,size: 14,)
// //
// //                                                                 ],
// //                                                               ),
// //                                                             ),
// //                                                           ),
// //                                                           ElevatedButton(
// //                                                             style: ElevatedButton.styleFrom(
// //                                                               primary: Colors.white,
// //
// //                                                               shape:
// //                                                               RoundedRectangleBorder(
// //                                                                 borderRadius: BorderRadius.circular(18.0),
// //                                                                 side: BorderSide(
// //                                                                   color: Color(0xFF007A33),
// //                                                                   width: 0.5,
// //                                                                 ),
// //
// //                                                               ),
// //
// //                                                             ),
// //                                                             child: Text('Active',style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF007A33), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                             onPressed: () {},
// //                                                           ),
// //                                                           SizedBox(width:width*0.1),
// //                                                           Icon( Icons.more_vert_rounded,size: 18,color: Color(0xFF999999))
// //
// //                                                         ],
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //
// //                                                   Material(
// //                                                     elevation: 1,
// //                                                     color: Colors.white,
// //
// //                                                     child: Container(
// //                                                       width: width*0.725,
// //                                                       height: height*0.07,
// //                                                       decoration: BoxDecoration(
// //
// //
// //                                                         borderRadius: BorderRadius.only(
// //                                                             topRight: Radius.circular(9.0),
// //                                                             bottomRight: Radius.circular(0),
// //                                                             topLeft: Radius.circular(9.0),
// //                                                             bottomLeft: Radius.circular(0)),
// //                                                       ),
// //                                                       child: Row(
// //                                                         children: [
// //                                                           SizedBox(width: width*0.01,),
// //
// //
// //                                                           Image.asset("assets/images/smallpfp.png"),
// //                                                           SizedBox(width: width*0.035,),
// //
// //
// //                                                           Container(
// //                                                             width: width*0.135,
// //
// //                                                             child: Text("Mohammad Al...",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //
// //                                                           Container(
// //                                                             width: width*0.158,
// //
// //                                                             child:  Text("alsugairmohd@gmail.com",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //                                                           Container(
// //                                                             width: width*0.128,
// //
// //
// //                                                             child: Padding(
// //                                                               padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
// //                                                               child: Row(
// //                                                                 children: [
// //                                                                   Text("Student ",style: GoogleFonts.barlow(
// //                                                                     textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
// //                                                                   ),),
// //                                                                   Icon( Icons.keyboard_arrow_down_rounded,size: 14,)
// //
// //                                                                 ],
// //                                                               ),
// //                                                             ),
// //                                                           ),
// //                                                           ElevatedButton(
// //                                                             style: ElevatedButton.styleFrom(
// //                                                               primary: Colors.white,
// //
// //                                                               shape:
// //                                                               RoundedRectangleBorder(
// //                                                                 borderRadius: BorderRadius.circular(18.0),
// //                                                                 side: BorderSide(
// //                                                                   color: Color(0xFF007A33),
// //                                                                   width: 0.5,
// //                                                                 ),
// //
// //                                                               ),
// //
// //                                                             ),
// //                                                             child: Text('Active',style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF007A33), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                             onPressed: () {},
// //                                                           ),
// //                                                           SizedBox(width:width*0.1),
// //                                                           Icon( Icons.more_vert_rounded,size: 18,color: Color(0xFF999999))
// //
// //                                                         ],
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //
// //
// //
// //                                                   Material(
// //                                                     elevation: 1,
// //                                                     color: Colors.white,
// //                                                     child: Container(
// //                                                       width: width*0.725,
// //                                                       height: height*0.07,
// //                                                       decoration: BoxDecoration(
// //
// //
// //                                                         borderRadius: BorderRadius.only(
// //                                                             topRight: Radius.circular(9.0),
// //                                                             bottomRight: Radius.circular(0),
// //                                                             topLeft: Radius.circular(9.0),
// //                                                             bottomLeft: Radius.circular(0)),
// //                                                       ),
// //                                                       child: Row(
// //                                                         children: [
// //                                                           SizedBox(width: width*0.01,),
// //
// //
// //                                                           Image.asset("assets/images/smallpfp.png"),
// //                                                           SizedBox(width: width*0.035,),
// //
// //                                                           Container(
// //                                                             width: width*0.135,
// //
// //                                                             child: Text("Mohammad Abdulrahman",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //
// //                                                           Container(
// //                                                             width: width*0.158,
// //
// //                                                             child:  Text("alsugairmohd@gmail.com",style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                           ),
// //
// //                                                           Container(
// //                                                             width: width*0.128,
// //
// //
// //                                                             child: Padding(
// //                                                               padding: const EdgeInsets.only(top: 9.0,bottom: 9.0),
// //                                                               child: Row(
// //                                                                 children: [
// //                                                                   Text("Instructor ",style: GoogleFonts.barlow(
// //                                                                     textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
// //                                                                   ),),
// //                                                                   Icon( Icons.keyboard_arrow_down_rounded,size: 14,)
// //
// //                                                                 ],
// //                                                               ),
// //                                                             ),
// //                                                           ),
// //                                                           ElevatedButton(
// //                                                             style: ElevatedButton.styleFrom(
// //                                                               primary: Colors.white,
// //
// //                                                               shape:
// //                                                               RoundedRectangleBorder(
// //                                                                 borderRadius: BorderRadius.circular(15.0),
// //                                                                 side: BorderSide(
// //                                                                   color: Color(0xFF007A33),
// //                                                                   width: 0.5,
// //                                                                 ),
// //
// //                                                               ),
// //
// //                                                             ),
// //                                                             child: Text('Active',style: GoogleFonts.barlow(
// //                                                               textStyle: TextStyle(color: Color(0xFF007A33), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
// //                                                             ),),
// //                                                             onPressed: () {},
// //
// //                                                           ),
// //                                                           SizedBox(width:width*0.1),
// //                                                           Icon( Icons.more_vert_rounded,size: 18,color: Color(0xFF999999))
// //
// //                                                         ],
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //
// //
// //
// //
// //                                                 ],
// //
// //                                               ),
// //                                             ),
// //                                           )
// //                                       ),
// //                                       SizedBox(height: height*0.2),
// //
// //                                       Row(
// //                                         children: [
// //
// //
// //
// //                                           num,
// //                                           SizedBox(width: width*0.007,),
// //                                           Text("Showing 6 of 6 results",style: GoogleFonts.barlow(
// //                                             textStyle: TextStyle(color: Color(0Xff999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
// //                                           ),),
// //                                         ],
// //                                       ),
// //                                       SizedBox(height: height*0.03),
// //
// //                                     ],
// //                                   ),
// //
// //                                 ),
// //
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //
// //
// //
// //
// //
// //
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),)
// //
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
