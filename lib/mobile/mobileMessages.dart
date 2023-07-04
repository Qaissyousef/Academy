import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pif_admin_dashboard/mobile/mobileMessageInside.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class mobileMessage extends StatefulWidget {
  const mobileMessage({Key? key}) : super(key: key);

  @override
  State<mobileMessage> createState() => _mobileMessageState();
}

class _mobileMessageState extends State<mobileMessage> {
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

                                    //
                                    // isVisible = !isVisible;
                                    // isVisibleButton = !isVisibleButton;

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
    final messagebox = GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  mobileMessageInside()),
        );
      },
      child: Container(
        height: height*0.15,
        width: width*0.9,

        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Row(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: width*0.02,),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox( height: height*0.01,
                  ),
                  Image.asset("images/smallpfp.png",scale: 0.96,),
                ],
              ),
              SizedBox(width: width*0.03,),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(

                        child: Text("Saad Alkroud".tr(),style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                        ),),

                      ),

                      SizedBox(height: height*0.002,),

                    ],
                  ),



                  Container(

                    width: width*0.55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height*0.005,),

                            Text("This is a message title ".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                            SizedBox(height: height*0.005,),
                            Text("Lorem ipsum dolor sit amet".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),

                            Text("consectetur adipiscing...".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                          ],
                        ),


                      ],
                    ),
                  ),

                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("5:30 PM".tr(),style: GoogleFonts.barlow(
                    textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                  ),),
                  SizedBox(height: height*0.04,),

                  Container(
                    child:                                                 Padding(
                      padding:  EdgeInsets.only(left:8.0,right:8),
                      child: Image.asset("images/star.png",color:Color(0xFFBD9B60)),
                    ),

                  ),
                ],
              )



            ],
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
                  SizedBox(height: height*0.02,),
                  search,
                  SizedBox(height: height*0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    filter,sort
                  ],),
                  SizedBox(height: height*0.017),
                  Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Container(
                          width: width*0.96,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: width*0.96,
                                height: height*0.07,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F0E5),

                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(9.0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(9.0),
                                      bottomLeft: Radius.circular(0)),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: width*0.02,),
                                    Container(
                                      height: 20.0,
                                      width: 20.0,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(color: Colors.grey,width: 0.5),
                                      ),
                                      child: SizedBox(
                                        height: 24.0,
                                        width: 24.0,
                                        child: Checkbox(
                                          // checkColor: Colors.pink,
                                          // activeColor: Colors.yellow,
                                          side: BorderSide(
                                            color: Color(0xFFEEEEEE), //your desire colour here
                                            width: 1.5,
                                          ),
                                          value: false, onChanged:  (newValue) {
                                          setState(() {
                                            checkedValue = newValue;
                                          });
                                        },),
                                      ),
                                    ),
                                    Text("  Select all".tr(),style: GoogleFonts.barlow(
                                      textStyle: TextStyle(color: Color(0xFFBD9B60), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                    ),),
                                    SizedBox(width: width*0.07,),

                                    Image.asset("images/bin.png",color: Color(0xFFBD9B60),),
                                    SizedBox(width: width*0.1,),

                                    Image.asset("images/openMessages.png",color: Color(0xFFBD9B60)),



                                  ],
                                ),
                              ),
                              SizedBox(height: height*0.002,),
                              messagebox,
                              SizedBox(height: height*0.002,),
                              messagebox,

                              SizedBox(height: height*0.002,),
                              messagebox,

                              SizedBox(height: height*0.002,),
                              messagebox,
                              SizedBox(height: height*0.002,),


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
        ),),
    );
  }
}
