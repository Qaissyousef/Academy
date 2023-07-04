import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class mobileUsersAdd extends StatefulWidget {
  const mobileUsersAdd({Key? key}) : super(key: key);

  @override
  State<mobileUsersAdd> createState() => _mobileUsersAddState();
}

class _mobileUsersAddState extends State<mobileUsersAdd> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final sort =
    SizedBox(
        height: height*0.055,
        width: width*0.44,
        child: ElevatedButton.icon(
          onPressed: (){
            print("You pressed Icon Elevated Button");
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
            prefixIcon: ImageIcon(AssetImage('assets/mobileImages/search.png'),color: Color(0xFFBD9B60),),
            border: InputBorder.none,

            hintText: 'Search'.tr().toString(),
            contentPadding: EdgeInsets.only(top:10),
            hintStyle:  GoogleFonts.barlow(textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ) ),
            suffixIcon: ImageIcon(AssetImage('assets/images/mic.png'),),
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
          onPressed: (){
            print("You pressed Icon Elevated Button");
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
    final addedPopup = SizedBox(height: height*0.055,
        width: width*0.44,
        child : ElevatedButton.icon(
          onPressed: (){
            print("You pressed Icon Elevated Button");
          },
          icon: ImageIcon(
            AssetImage("images/yes.png"),color:Color(0xFF215732),
            size: 26,
          ),  //icon data for elevated button
          label: Text("New user has been added".tr().toString(),strutStyle: StrutStyle(
              forceStrutHeight: true
          ),style: GoogleFonts.barlow(
            textStyle: TextStyle(color: Color(0xFF215732), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
          ),), //label text
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7), // <-- Radius
            ),
            primary: Color(0xfff1f4f2) ,//elevated btton background color
            onPrimary: Color(0xFF215732)


          ),
        )
    );


    final num = SizedBox(
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("10".tr().toString(),strutStyle: StrutStyle(
                  forceStrutHeight: true
              )),
              SizedBox(width: 60,),
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
              minimumSize: Size(130,50)
          ),
        ));



    final saad = Card(
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
              children: [
                Image.asset("images/smallpfp.png"),
                SizedBox(width: 15,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Saad Alkroud".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFBD9B60) ),),
                    ),
                    Text("saad@pif.gov.sa".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow', fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999)  ),),
                    ),
                  ],
                ),
                SizedBox(width: 250,),
                Icon(Icons.more_vert_outlined,size: 16,color: Color(0xFF999999),)
              ],
            ),


            Container(
              height: 35,
              child: Row(
                children: [
                  Container(
                    width: width*0.69,
                    child: Text("Account Type ".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("Admin ".tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF222222) ),),
                        ),
                        SizedBox(width: width*0.02,),
                        Icon(Icons.expand_more_rounded,size: 14,color: Color(0xFF222222),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 0.001,thickness: 0.2,
              color: Color(0xFF999999),
            ),

            Container(

              height: 35,
              child: Row(
                children: [
                  Container(
                    width: width*0.69,
                    child: Text("Status ".tr().toString(),strutStyle: StrutStyle(
                        forceStrutHeight: true
                    ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        color: Color(0xFF007A33),
                        width: 0.5,
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                      child: Text('Active',style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFF007A33), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                      ),),
                    ),
                  )
                ],
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
                children: [
                  Container(
                    width: width*0.85,
                    child: Text("Users",style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 22),
                    ),),
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
                      SizedBox(height: height*0.02,),

                      Row(
                        children: [
                          Text("Administration /".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                          ),
                          Text(" Announcements".tr().toString(),strutStyle: StrutStyle(
                              forceStrutHeight: true
                          ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),
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
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(Icons.close)),
                                      Center(child: Text("Add New User",style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 28),
                                      ),),),
                                    ],
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: Form(
                                      child: Column(

                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Center(
                                            child: Text("Enter the details below to add a new user",style: GoogleFonts.barlow(
                                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                            ),),
                                          ),
                                          SizedBox(height: height*0.07),
                                          Padding(
                                            padding: EdgeInsets.only(right: width*0.04,bottom: height*0.01),
                                            child: Text("Name",style: GoogleFonts.barlow(
                                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                            ),),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: width*0.9,
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
                                          ),
                                          SizedBox(height: height*0.02),
                                          Padding(
                                            padding: EdgeInsets.only(right: width*0.04,bottom: height*0.01),
                                            child: Text("Email",style: GoogleFonts.barlow(
                                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                            ),),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: width*0.9,
                                              height: height*0.05,
                                              child: TextField(
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
                                            padding: EdgeInsets.only(right: width*0.04,bottom: height*0.01),
                                            child: Text("Account type",style: GoogleFonts.barlow(
                                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                            ),),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: width*0.9,
                                              height: height*0.05,
                                              child: TextField(
                                                controller: TextEditingController(text: " Admin"),
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.all(3),
                                                  suffixIcon: IconButton(

                                                      onPressed: (){},
                                                      icon: Icon(Icons.expand_more_rounded,size: 14,color: Color(0Xff999999),)
                                                  ),
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

                                          SizedBox(height: height*0.07),

                                          Center(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: width*0.33,
                                                  height: height*0.055,
                                                  child: ElevatedButton(
                                                    onPressed: () {

                                                    },
                                                    child: Text('Cancel'.tr().toString(),strutStyle: StrutStyle(
                                                        forceStrutHeight: true
                                                    )),
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Color(0xFFF5F0E5),
                                                      onPrimary: Color(0xff183028),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: width*0.04,),
                                                SizedBox(
                                                  width: width*0.33,
                                                  height: height*0.055,
                                                  child: ElevatedButton(
                                                    onPressed: () {

                                                    },
                                                    child: Text('Confirm & add'.tr().toString(),strutStyle: StrutStyle(
                                                        forceStrutHeight: true
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
                                          ),
                                          SizedBox(height: height*0.02),


                                        ],
                                      ),
                                    ),
                                  ),

                                );
                              });
                        },
                        child: Text('  Add new user  '.tr().toString(),strutStyle: StrutStyle(
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
                        child: Text('  Export list as spreadsheet  '.tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ), style: GoogleFonts.barlow(textStyle:  TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF183028) ),
                        ),),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            primary: Color(0xFFF5F0E5),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),

                            side: BorderSide(
                                width: 0.4,
                                color: Color(0xFFF5F0E5)

                            )
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height*0.03,),

                  Center(child: addedPopup),
                  SizedBox(height: height*0.03,),


                  search,
                  SizedBox(height: height*0.02,),

                  Row(children: [
                    filter,SizedBox(width: width*0.04,),sort
                  ],),
                  SizedBox(height: height*0.02,),

                  saad,
                  SizedBox(width: width*0.015,),
                  saad,
                  SizedBox(width: width*0.015,),
                  saad,
                  SizedBox(width: width*0.015,),
                  saad




                ],
              ),
            ),
          ),
        ),),
    );
  }
}
