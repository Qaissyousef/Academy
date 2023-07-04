import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class newMobileForum extends StatefulWidget {
  const newMobileForum({Key? key}) : super(key: key);

  @override
  State<newMobileForum> createState() => _newMobileForumState();
}

class _newMobileForumState extends State<newMobileForum> {
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



    final num = SizedBox(
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("0".tr().toString(),strutStyle: StrutStyle(
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


    final delete = Container(
      width: width*0.435,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFF999999),width: 0.4),

      ),
      child: Center(
        child: Text("Delete selected",style: GoogleFonts.barlow(
          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
        ),),
      ),
    );
    final c1 = Container(
      width: width*0.88,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0,left: 15,right: 15,top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      width: width*0.08,
                      child: Image.asset("images/u3.png")),
                  SizedBox(width: 10,),
                  Container(
                    width: width*0.65,
                    child: Row(
                      children: [
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),

                            Text("Jahaan Ahmend",style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                            SizedBox(height: 1,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),

                              child: Text("13th May",style: GoogleFonts.barlow(
                                textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                              ),),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.asset("images/bin.png",height: 20,)

                ],
              ),
              Text("What are some great data analytic tools out there?",style: GoogleFonts.barlow(
                textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
              ),),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,top: 10.0,bottom: 10),
                child: Container(
                  child:  Text("I’ve been trying to find some good tools but can’t seem to find any. If anyone has any good resources, please drop them in this thread!",style: GoogleFonts.barlow(
                    textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                  ),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0,bottom: 18.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color:  Color(0xFFF4F6F4),

                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        child:  Icon(Icons.favorite_border_rounded,color: Color(0xFF215732),size: 16),
                      ),

                    ),
                    SizedBox(width:6),
                    Container(
                      decoration: BoxDecoration(
                          color:  Color(0xFFF4F6F4),

                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child: Row(
                            children: [
                              ImageIcon(
                                AssetImage("images/chat.png"),
                                color: Color(0xFF215732) ,
                                size: 16,
                              ),
                              Text("83 replies".tr().toString(),strutStyle: StrutStyle(
                                  forceStrutHeight: true
                              ),style: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),

                            ],
                          )
                      ),

                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width*0.65,
                    height: 33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xFFEEEEEE)),
                    ),
                    child:                         Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Type a comment".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                    ),
                  ),
                  SizedBox(width: 18.5,),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF5F0E5),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xFFEEEEEE)),
                    ),
                    child:                         Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13),
                      child: Text("Post".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),style: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF183028) ),),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

    return Scaffold(

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
                  SizedBox(height: height*0.02),
                  SizedBox(height: height*0.02,),

                  Row(
                    children: [




                      Center(
                        child: SizedBox(
                          height: height*0.055,
                          width: width*0.92,
                          child: ElevatedButton(
                            onPressed: () {showModalBottomSheet<void>(
                              isScrollControlled: true,

                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),

                                  ),
                                  child: Scaffold(
                                      appBar: AppBar(
                                        backgroundColor: Colors.white,
                                        elevation: 1,
                                        automaticallyImplyLeading: false,

                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [Icon(Icons.arrow_back_ios,color: Colors.black,size: 14,), Text("    Forum",style: GoogleFonts.barlow(
                                            textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                          ))],
                                        ),
                                      ),
                                      body: Container(
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.only(left: 30,right: 15.0,top: 15,bottom: 15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [

                                                  Container(
                                                    width: width*0.9,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(

                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            SizedBox(height: 10,),

                                                            Row(
                                                              children: [
                                                                Image.asset("assets/mobileImages/mobileuser.png"),
                                                                Text("  Jahaan Ahmend",style: GoogleFonts.barlow(
                                                                  textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                                                ),),
                                                              ],
                                                            ),
                                                            SizedBox(height:4,),
                                                            Padding(
                                                              padding: const EdgeInsets.only(bottom: 20.0,left: 40),

                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    border: Border.all(color: Color(0xFFEEEEEE),width:1)
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text("  Tag people",style: GoogleFonts.barlow(
                                                                        textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 12),
                                                                      ),),
                                                                      Icon(Icons.expand_more,size: 13,)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: width*0.9,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(4),
                                                                  border: Border.all(color: Color(0xFF999999),width: 0.3)
                                                              ),
                                                              // height: height*0.4,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: [
                                                                  TextField(
                                                                    maxLines: 6,
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,
                                                                      // suffixIcon: IconButton(
                                                                      //   iconSize: 12,
                                                                      //   onPressed: (){},
                                                                      //   icon: ImageIcon(
                                                                      //     AssetImage("images/attach.png"),color: Color(0xFF215732),
                                                                      //   ),
                                                                      // ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //   borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                      // ),
                                                                      // enabledBorder: OutlineInputBorder(
                                                                      //   borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
                                                                      // ),


                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Image.asset("images/attach.png",color: Color(0xFF9C9FA1),),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(height: 250,),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: width*0.44,
                                                                  height: height*0.065,
                                                                  child: ElevatedButton(
                                                                    onPressed: () {

                                                                    },
                                                                    child: Text('Cancel'.tr().toString(),strutStyle: StrutStyle(
                                                                        forceStrutHeight: true
                                                                    )),
                                                                    style: ElevatedButton.styleFrom(
                                                                      elevation: 0,
                                                                      shadowColor: Colors.transparent,
                                                                      primary: Color(0xFFF5F0E5),
                                                                      onPrimary: Color(0xff183028),
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(8),
                                                                      ),

                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: width*0.01,),
                                                                SizedBox(
                                                                  width: width*0.44,
                                                                  height: height*0.065,
                                                                  child: ElevatedButton(
                                                                    onPressed: () {

                                                                    },
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        Text('Post Now  '.tr().toString(),strutStyle: StrutStyle(
                                                                            forceStrutHeight: true
                                                                        )),
                                                                        SvgPicture.asset("images/send.svg"),

                                                                      ],
                                                                    ),
                                                                    style: ElevatedButton.styleFrom(
                                                                        elevation: 0,
                                                                        shadowColor: Colors.transparent,
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

                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),


                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                );
                              },
                            );},
                            child: Text('  Add new post  '.tr().toString(),strutStyle: StrutStyle(
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
                      ),

                    ],
                  ),
                  SizedBox(height: height*0.02),
                  search,
                  SizedBox(height: height*0.02,),

                  Row(children: [
                    filter,SizedBox(width: width*0.04,),sort
                  ],),
                  SizedBox(height: height*0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      num,
                      SizedBox(width: 110,),
                      delete
                    ],),
                  SizedBox(height: height*0.02,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("No posts yet".tr().toString(),strutStyle: StrutStyle(
                            forceStrutHeight: true
                        ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                        ),
                      ),
                    ],
                  )




                ],
              ),
            ),
          ),
        ),),
    );
  }
}

