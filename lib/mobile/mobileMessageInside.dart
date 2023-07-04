import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class mobileMessageInside extends StatefulWidget {
  const mobileMessageInside({Key? key}) : super(key: key);

  @override
  State<mobileMessageInside> createState() => _mobileMessageInsideState();
}

class _mobileMessageInsideState extends State<mobileMessageInside> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }


  bool? checkedValue = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


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
                        Container(

                          child: Text("Messages".tr(),style: GoogleFonts.barlow(
                            textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 22),
                          ),),
                        ),
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
        width: width*0.96,
        child: WebSmoothScroll(
          controller: _scrollController,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.04,),
                  search,
                  SizedBox(height: height*0.04,),
                  Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(

                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("This is a message title ".tr(),style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                ),),
                              ),
                            ),
                            Image.asset("images/star.png",color:Color(0xFFBD9B60)),

                          ],
                        ),

                        Container(

                          height: height*0.11,
                          width: width*0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width*0.4,


                                child:  Padding(
                                  padding: const EdgeInsets.only(top:8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      SizedBox(width: width*0.02,),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: [
                                          SizedBox( height: height*0.01,
                                          ),
                                          Image.asset("images/smallpfp.png",scale: 0.96,),
                                        ],
                                      ),
                                      // SizedBox(width: width*0.03,),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: height*0.016,),
                                          Row(

                                            children: [
                                              Container(

                                                // width:width*0.52,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Saad Alkroud".tr(),style: GoogleFonts.barlow(
                                                      textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                                    ),),
                                                    Text("to me".tr(),style: GoogleFonts.barlow(
                                                      textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                    ),),
                                                  ],
                                                ),

                                              ),

                                              SizedBox(height: height*0.001,),

                                            ],
                                          ),


                                          // Container(
                                          //   width: width*0.4,
                                          //   child: Row(
                                          //     children: [
                                          //       Column(
                                          //         mainAxisAlignment: MainAxisAlignment.start,
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         children: [
                                          //           SizedBox(height: height*0.005,),
                                          //
                                          //           Text("to me".tr(),style: GoogleFonts.barlow(
                                          //             textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                          //           ),),
                                          //         ],
                                          //       ),
                                          //       SizedBox(width: width*0.38,),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),



                                    ],
                                  ),
                                ),
                              ),
                              Text("5:30 PM".tr(),style: GoogleFonts.barlow(
                                textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                              ),),
                            ],
                          ),
                        ),
                        Container(
                          width: width*0.99,
                          height: height*0.24,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 2),
                            child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. At purus imperdiet nec elementum, maecenas nam est. Blandit cras commodo sit tellus tempor. Gravida convallis dui ligula pretium neque, facilisi. Quisque enim, nisl facilisi ac mauris parturient. Ipsum massa duis lectus quis odio etiam a cursus. Diam feugiat curabitur sed fames quis vel.".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                          ) ,

                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 2),

                          child: SizedBox(
                            height: height*0.055,
                            width: width*0.9,
                            child: ElevatedButton(
                              onPressed: () {

                              },
                              child: Text("Reply".tr().toString(),strutStyle: StrutStyle(
                                  forceStrutHeight: true
                              ),style: GoogleFonts.barlow(
                                textStyle: TextStyle(color:Colors.white, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 20),
                              )),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFBD9B60),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                  side: BorderSide(
                                      width: 0.4,
                                      color: Color(0xFFBD9B60),
                                  )
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height*0.03,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 2),

                          child: SizedBox(
                            height: height*0.055,
                            width: width*0.9,
                            child: ElevatedButton(
                              onPressed: () {

                              },
                              child: Text("Mark as resolved".tr().toString(),strutStyle: StrutStyle(
                                  forceStrutHeight: true
                              ),style: GoogleFonts.barlow(
                                textStyle: TextStyle(color:Color(0xff183028), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 20),
                              )),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFD1CCBD),
                                  onPrimary: Color(0xff183028),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                  side: BorderSide(
                                      width: 0.4,
                                      color: Color(0xFFD1CCBD)
                                  )
                              ),
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
        ),),
    );
  }
}
