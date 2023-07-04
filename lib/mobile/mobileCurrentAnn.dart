import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_admin_dashboard/mobile/sideBar.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;
import 'dart:convert';
import '../models/ann_model.dart';


class mobileCurrentAnn extends StatefulWidget {
  final int current_ann;

  const mobileCurrentAnn({Key? key,required this.current_ann}) : super(key: key);

  @override
  _mobileCurrentAnnState createState() => _mobileCurrentAnnState();
}
class _mobileCurrentAnnState extends State<mobileCurrentAnn>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  late ScrollController _scrollController;
  
  final myControllertitle_e = TextEditingController();
  final myControllerdes_e = TextEditingController();
  final myControllertitle_a = TextEditingController();
  final myControllerdes_a = TextEditingController();


  Future<List<Announcement>> fetchPostEng() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'SpecificAnnEng/${widget.current_ann}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Announcement>((json) => Announcement.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Announcement>> fetchPostArb() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'SpecificAnnArb/${widget.current_ann}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Announcement>((json) => Announcement.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<http.Response> updateRequestEng () async {
    Map data = {
      "ann_id": 0,
      "ann_title": myControllertitle_e.text,
      "ann_description": myControllerdes_e.text,
      "ann_creation_time": "2022-10-31T07:09:33.500Z",
      "ann_image": "C:imgUpload062d1ea5c16c4d99872829f06c441abd.jpeg"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'UpdateAnnEng/${widget.current_ann}'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }  
  Future<http.Response> updateRequestArb () async {
    Map data = {
      "ann_id": 0,
      "ann_title": myControllertitle_a.text,
      "ann_description": myControllerdes_a.text,
      "ann_creation_time": "2022-10-31T07:09:33.500Z",
      "ann_image": "C:imgUpload062d1ea5c16c4d99872829f06c441abd.jpeg"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'UpdateAnnArb/${widget.current_ann}'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }
  bool submitForm(){
    String errorText = "";

    errorText += validator.isValid("English description", myControllerdes_a.text, "empty");
    errorText += validator.isValid("Arabic description", myControllerdes_e.text, "empty");
    errorText += validator.isValid("English title", myControllertitle_a.text, "empty");
    errorText += validator.isValid("Arabic title", myControllertitle_e.text, "empty");

    if (errorText != "") {
      validator.alertDialog(context, errorText.substring(0, errorText.length - 1));
      return false;
    }

    updateRequestArb();
    updateRequestEng();
    return true;
  }


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _nestedTabController = new TabController(length: 2, vsync: this);

    fetchPostArb().then((value) {
      myControllertitle_a.text = value[0].ann_title;
      myControllerdes_a.text = value[0].ann_description;
    });
    fetchPostEng().then((value) {
      myControllertitle_e.text = value[0].ann_title;
      myControllerdes_e.text = value[0].ann_description;
    });

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
        toolbarHeight: height * 0.17,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Container(

                    child: GestureDetector( onTap: () {Navigator.of(context).pop();}, child: Icon(Icons.arrow_back_ios,size: 15) )),

                Builder(
                  builder: (context) => IconButton(
                    icon: new Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ],
            ),

            Text("New: Advanced Data Analytics Workshop".tr().toString(),
              style: GoogleFonts.barlow(textStyle:  TextStyle(fontFamily: 'Barlow',fontSize: 22,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFFBFCFC) ),
              ),
            ),
            Text("launching".tr().toString(),
              style: GoogleFonts.barlow(textStyle:  TextStyle(fontFamily: 'Barlow',fontSize: 22,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFFFBFCFC) ),
              ),
            ),
            SizedBox(height: height*0.02),
          ],
        ),
        flexibleSpace: Container(

          decoration: BoxDecoration(
              image: DecorationImage(
                // image: AssetImage(context.locale == Locale("en") ? 'assets/images/bgsmall.png' : 'assets/images/topNavArabic.png'),
                image: AssetImage('assets/mobileImages/coursebg.png'),
                fit: BoxFit.fill,

              )

          ),

        ),
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

                      Text("Administration /Announcement /".tr().toString(),strutStyle: StrutStyle(
                          forceStrutHeight: true
                      ),style:  GoogleFonts.barlow(textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                      ),
                      SizedBox(height: 10,),
                      Text("New: Advanced Data Analytics Workshop launching".tr().toString(),strutStyle: StrutStyle(
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
                        height:700,

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
                                      controller: myControllertitle_a,
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


                                  Text("الوصف",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),

                                  SizedBox(height: height*0.009,),

                                  Container(
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
                                          controller: myControllerdes_a,
                                          maxLines: 2,
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
                                          child: GestureDetector(
                                              onTap: () async{
                                                FileUploadInputElement uploadInput = FileUploadInputElement();
                                                uploadInput.accept = '.csv';
                                                uploadInput.click();

                                                uploadInput.onChange.listen((e) {
                                                  // read file content as dataURL
                                                  final files = uploadInput.files;
                                                  if (files?.length == 1) {
                                                    final file = files?[0];
                                                    final reader = new FileReader();

                                                    reader.onLoadEnd.listen((e) {
                                                      print(e);
                                                      print('loaded: ${file?.name}');
                                                      print('type: ${reader.result.runtimeType}');
                                                      print('file size = ${file?.size}');
                                                      // _handleResult(reader.result);
                                                    });
                                                    reader.readAsDataUrl(file!);
                                                  }
                                                });


                                              },
                                              child: SvgPicture.asset("images/attach.svg",color: Color(0xFF9C9FA1))),
                                          // child: Image.asset(context.locale == Locale("en") ?"images/attach.png": "images/arAttach.png",color: Color(0xFF9C9FA1),),
                                        )
                                      ],
                                    ),
                                  ),


                                  SizedBox(height: height*0.3,),
                                  Container(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: SizedBox(
                                        height: height*0.055,
                                        width: width*0.4,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            submitForm();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0.6),
                                            child: Text('Save changes'.tr().toString(),strutStyle: StrutStyle(
                                                forceStrutHeight: true
                                            ),style: GoogleFonts.barlow(
                                              textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                            )),
                                          ),

                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF215732),
                                            onPrimary: Color(0xFFFFFFFF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),

                                          ),
                                        ),
                                      ),
                                    ),
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
                                      controller: myControllertitle_e,
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


                                  Text("Description",style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                  ),),

                                  SizedBox(height: height*0.009,),

                                  Container(
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
                                          controller: myControllerdes_e,
                                          maxLines: 2,
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
                                          child: GestureDetector(
                                              onTap: () async{
                                                FileUploadInputElement uploadInput = FileUploadInputElement();
                                                uploadInput.accept = '.csv';
                                                uploadInput.click();

                                                uploadInput.onChange.listen((e) {
                                                  // read file content as dataURL
                                                  final files = uploadInput.files;
                                                  if (files?.length == 1) {
                                                    final file = files?[0];
                                                    final reader = new FileReader();

                                                    reader.onLoadEnd.listen((e) {
                                                      print(e);
                                                      print('loaded: ${file?.name}');
                                                      print('type: ${reader.result.runtimeType}');
                                                      print('file size = ${file?.size}');
                                                      // _handleResult(reader.result);
                                                    });
                                                    reader.readAsDataUrl(file!);
                                                  }
                                                });


                                              },
                                              child: SvgPicture.asset("images/attach.svg",color: Color(0xFF9C9FA1))),
                                          // child: Image.asset(context.locale == Locale("en") ?"images/attach.png": "images/arAttach.png",color: Color(0xFF9C9FA1),),
                                        )
                                      ],
                                    ),
                                  ),


                                  SizedBox(height: height*0.3,),
                                  Container(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: SizedBox(
                                        height: height*0.055,
                                        width: width*0.4,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            submitForm();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0.6),
                                            child: Text('Save changes'.tr().toString(),strutStyle: StrutStyle(
                                                forceStrutHeight: true
                                            ),style: GoogleFonts.barlow(
                                              textStyle: TextStyle( fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 16),
                                            )),
                                          ),

                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF215732),
                                            onPrimary: Color(0xFFFFFFFF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),

                                          ),
                                        ),
                                      ),
                                    ),
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
