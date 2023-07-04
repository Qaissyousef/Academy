import 'dart:convert';

import 'package:date_time_format/date_time_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:http/http.dart' as http;

import '../models/PostModel.dart';
import '../models/ReplyModel.dart';
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;
import '../courseDetails/materialsCommentPopup.dart';


class materials extends StatefulWidget {
  final String current_course_id;
  final int Function() onNext;

  const materials({Key? key,required this.current_course_id,  required this.onNext}) : super(key: key);

  @override
  State<materials> createState() => _materialsState();
}

class _materialsState extends State<materials> {
  Future<http.Response> deleteRequestPost (int uid) async {


    Map data = {
      "user_id": 0,
      "post_id": uid,
      "post_title": "string",
      "post_description": "string",
      "post_replies": 0,
      "course_id": 0,
      "post_time": "2022-11-08T02:52:04.084Z"
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'DeletePost'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  bool? CheckBoxValue = false;
  bool buttonActive = false;
  bool? CheckBoxValue2 = false;
  bool? CheckBoxValue3 = false;

  late ScrollController _scrollController;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final _dateTime = DateTime.parse("2022-10-01 00:00:00.000");
  Future<List<Post>> searchMaterials(String name) async {
    List<Post> courses = [];
    List<Post> results = [];
    final response = await http.get(Uri.parse(global.apiAddress + 'GetPosts/${widget.current_course_id}'));


    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);

      for (int i = 0; i < list.length; i++) {
        courses.add(Post.fromMap(jsonDecode(response.body)[i]));
      }

      if (name.isNotEmpty) {
        courses.forEach((element) {
          if (element.post_title.toLowerCase().contains(name.toLowerCase())) {
            results.add(element);
          }
        });
        if (results.isEmpty) {
          hasData = false;
        } else {
          hasData = true;
        }
      } else {
        results.addAll(courses);
        hasData = true;
      }
      return results;
    } else {
      throw Exception('Failed to load album');
    }
  }
  bool hasData = true;
  bool isAscending = true;
  Future<http.Response> postRequest () async {


    Map data = {
      "course_id": widget.current_course_id,
      "user_id":1,
      "post_description":myController1.text,
      "post_title":myController2.text,
      "post_replies":0,


    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(global.apiAddress + 'AddPost'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  // Future<List<Post>> fetchPosts() async {
  //   final response =
  //   await http.get(Uri.parse(global.apiAddress + 'GetPosts/${widget.current_course_id}'));
  //
  //   if (response.statusCode == 200) {
  //     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
  //
  //     return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future<List<Post>> fetchPosts(bool isAscending) async {
    List<Post> events = [];
    final response =  await http.get(Uri.parse(global.apiAddress + 'GetPosts/${widget.current_course_id}'));


    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        events.add(Post.fromMap(jsonDecode(response.body)[i]));
      }

      if (isAscending) {
        events.sort((a, b) => DateFormat('yMd')
            .parse(a.post_time)
            .compareTo(DateFormat('yMd').parse(b.post_time)));
      } else {
        events.sort((a, b) => DateFormat('yMd')
            .parse(b.post_time)
            .compareTo(DateFormat('yMd').parse(a.post_time)));
      }

      var now = new DateTime.now();
      var now_1w = now.subtract(const Duration(days: 7));
      var now_1m = now.subtract(const Duration(days: 30));


      // if (events.isEmpty) {
      //   hasData = false;
      // } else {
      //   hasData = true;
      // }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Post>> futurePost;

  Future<void> deletePost({required int postId}) async {
    await http.post(Uri.parse('${global.apiAddress}deletePost/$postId'));
  }
  Set<int> checked = {};

  Future<List<Reply>> getReplies({required int postId}) async {
    final response =
    await http.get(Uri.parse('${global.apiAddress}GetReplies/$postId'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Reply>((json) => Reply.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  void postReply({required int userId, required int postId, required String reply}) async {
    var requestBody = json.encode({
      "user_id": userId,
      "post_id": postId,
      "reply_id": 0,
      "reply": reply,
      "reply_time": DateTime.now().format()
    });

    await http.post(Uri.parse('${global.apiAddress}AddReply'),
      headers:  {"Content-Type": "application/json"},
      body: requestBody,
    );

    setState(() {
      futurePost = fetchPosts(isAscending);
    });
  }


  Future<bool> submitForm() async {
    String errorText = "";

    // Arabic fields validity check
    errorText += validator.isValid("post", myController1.text, "empty");

    // English fields validity check
    errorText += validator.isValid("title ", myController2.text, "empty");

    if (errorText != "") {
      validator.alertDialog(context, errorText.substring(0, errorText.length - 1));
      return false;
    }

    // posting stuff
    await postRequest();

    // updating
    setState(() {
      futurePost = fetchPosts(isAscending);
    });
    return true;
  }

  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {

    futurePost = fetchPosts(isAscending);

    super.initState();
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final searchtab =    Container(
      width: width*0.4,
      height: height*0.048,

      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(4)

      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            futurePost = searchMaterials(value);
          });
        },
        controller: _searchController,

        decoration: InputDecoration(
          prefixIcon:  SvgPicture.asset("images/search.svg",fit: BoxFit.scaleDown,),
          border: InputBorder.none,

          hintText: 'Search'.tr().toString(),
          contentPadding: EdgeInsets.only(top:7),
          hintStyle:  GoogleFonts.barlow(textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Color(0xFF999999) ) ),

          // enabledBorder: const OutlineInputBorder(
          //   // borderSide: const BorderSide(color: Color(0xFFEEEEEE),),
          // ),



        ),



      ),
    );


    final sortbtn = Container(
      height: height * 0.047,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black, width: 0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17),
        child: InkWell(
          hoverColor: Colors.transparent,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  String? dropdownvalue = 'Admin';
                  Locale? lang = const Locale("en");
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    scrollable: true,
                    title: Column(
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
                    content: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Form(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date".tr(),
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
                                width: width * 0.1,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Color(0xFFEEEEEE)))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: height * 0.012,
                                  ),
                                  child: Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isAscending = false;
                                          });
                                          futurePost = fetchPosts(isAscending);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Newest to Oldest".tr(),
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
                                        width: width * 0.02,
                                      ),
                                      !isAscending
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

                              // SizedBox(height: ),

                              Container(
                                width: width * 0.1,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Color(0xFFEEEEEE)))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: height * 0.012,
                                  ),
                                  child: Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isAscending = true;

                                          });
                                          futurePost = fetchPosts(isAscending);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Oldest to Newest".tr(),
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
                                        width: width * 0.02,
                                      ),
                                      isAscending
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
                      ),
                    ),
                  );
                });
          },
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/images/sort.svg",
                fit: BoxFit.scaleDown,
              ),
              Text(
                "  Sort".tr(),
                style: GoogleFonts.barlow(
                  textStyle: TextStyle(
                      color: const Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: width * 0.01),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final delete = SizedBox(
      width: width*0.1,
      height: height*0.047,

      child: ElevatedButton(

        onPressed: checked.isEmpty ? null : () async {
          // deleting selected posts
          for (int postId in checked) {
            await deletePost(postId: postId);
          }
          // resetting checked and fetching restting post page
          setState(() {
            checked = <int>{};
            futurePost = fetchPosts(isAscending);
          });
        },
        child: Text("Delete selected".tr().toString(),strutStyle: StrutStyle(
            forceStrutHeight: true
        ), style: GoogleFonts.barlow(
          textStyle: TextStyle( fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
        )),
        style:  ElevatedButton.styleFrom(
            onSurface: Colors.grey,
            primary: Color(0xFF215732),
            onPrimary: checked.isEmpty ? Color(0xFF999999): Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // maximumSize: Size(width*0.07,height*0.1),
            side: BorderSide(
                color: Colors.transparent
            )
        ),
      ),
    );
    final delewte = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFF999999),width: 0.4),

      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.5,bottom: 12.5,left: 10,right: 10),
        child: Row(
          children: [
            Text("Delete selected".tr(),style: GoogleFonts.barlow(
              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: width*0.01),
            ),),

          ],
        ),
      ),
    );

    final add =

    Container(
      height: height*0.047,

      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  scrollable: true,
                  title: Column(
                    children: [

                      Row(
                        children: [

                          Container(
                            width: width*0.23,
                            child: Row(

                              children: [
                                Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [


                                    Text("preeti".tr(),style: GoogleFonts.barlow(
                                      textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 19),
                                    ),),


                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 300,),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: (() {
                                Navigator.pop(context);
                              }),
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                  content: Row(
                    children: [
                      SizedBox(width: 20,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: width*0.45,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(4),
                            //     border: Border.all(color: Color(0xFF999999),width: 0.3)
                            // ),
                            // height: height*0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: width*0.45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Color(0xFF999999),width: 0.3)
                                  ),
                                  child: TextField( maxLength: 50,
                                    controller: myController2,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(15),
                                      hintText: "title".tr(),
                                      hintStyle: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w400),
                                      border: InputBorder.none,



                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),

                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Color(0xFF999999),width: 0.3)
                                  ),
                                  child: TextField( maxLength: 50,
                                    controller: myController1,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(15),
                                      hintText: "Your post...".tr(),
                                      hintStyle: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w400),
                                      border: InputBorder.none,



                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: GestureDetector(
                                //       onTap: () async{
                                //         FileUploadInputElement uploadInput = FileUploadInputElement();
                                //         uploadInput.accept = '.csv';
                                //         uploadInput.click();
                                //
                                //         uploadInput.onChange.listen((e) {
                                //           // read file content as dataURL
                                //           final files = uploadInput.files;
                                //           if (files?.length == 1) {
                                //             final file = files?[0];
                                //             final reader = new FileReader();
                                //
                                //             reader.onLoadEnd.listen((e) {
                                //               print(e);
                                //               print('loaded: ${file?.name}');
                                //               print('type: ${reader.result.runtimeType}');
                                //               print('file size = ${file?.size}');
                                //               // _handleResult(reader.result);
                                //             });
                                //             reader.readAsDataUrl(file!);
                                //           }
                                //         });
                                //
                                //
                                //       },
                                //       child: SvgPicture.asset("assets/images/attach.svg",color: Color(0xFF9C9FA1))),
                                //
                                //   // child: Image.asset(context.locale == Locale("en") ?"assets/images/attach.png": "assets/images/arAttach.png",color: Color(0xFF9C9FA1),),
                                // )
                              ],
                            ),
                          ),
                          SizedBox(height: 100,),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 23),
                                  child: Text('Cancel'.tr().toString(),strutStyle: StrutStyle(
                                      forceStrutHeight: true
                                  ),style: GoogleFonts.barlow(
                                    textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                  ),),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  shadowColor: Colors.transparent,
                                  primary: Color(0xFFF5F0E5),
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                ),
                              ),
                              SizedBox(width: width*0.01,),
                              ElevatedButton(
                                onPressed: () async{
                                  if(await submitForm()) {
                                    Navigator.pop(context);
                                    myController1.text = "";
                                    myController2.text = "";
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
                                  child: Row(
                                    children: [
                                      Text('Post now    '.tr().toString(),strutStyle: StrutStyle(
                                          forceStrutHeight: true
                                      ),style: GoogleFonts.barlow(
                                        textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                      ),),
                                      SvgPicture.asset("assets/images/send.svg"),


                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  shadowColor: Colors.transparent,
                                  primary: Color(0xFF215732),
                                  onPrimary: Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 39,),

                        ],
                      ),
                      SizedBox(width: 20,),

                    ],
                  ),

                );
              });
        },
        child: Text('  Add new post  '.tr().toString(),strutStyle: StrutStyle(
            forceStrutHeight: true
        ), style: GoogleFonts.barlow(
          textStyle: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
        )),
        style:  ElevatedButton.styleFrom(
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
    );

    final num = SizedBox(
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("08       ".tr().toString(),strutStyle: StrutStyle(
                  forceStrutHeight: true
              )),
              SizedBox(width: 25,),
              Icon(Icons.expand_more_rounded,size: 18,color: Color(0xFF999999),)
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
                borderRadius: BorderRadius.circular(8), // <-- Radius
              ),
              primary: Colors.white ,//elevated btton background color
              onPrimary: Colors.black,
              minimumSize: Size(120,50)
          ),
        ));
    void _onCategorySelected(bool selected, category_id) {
      if (selected == true) {
        setState(() {
          // _selecteCategorys.add(category_id);
        });
      } else {
        setState(() {
          // _selecteCategorys.remove(category_id);
        });
      }
    }

    final c1 = Container(
      width: width*0.32,
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
                    width: width*0.05,
                    child:  Image.asset("assets/images/f1.png",scale: 3,),),
                  Container(
                    width: width*0.21,
                    child: Row(
                      children: [
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Jahaan Ahmend".tr(),style: GoogleFonts.barlow(
                              textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                            ),),
                            SizedBox(height: 1,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),

                              child: Text("13th May".tr(),style: GoogleFonts.barlow(
                                textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                              ),),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.asset("assets/images/bin.png",height: 18,)

                ],
              ),
              Text("What are some great data analytic tools out there?".tr(),style: GoogleFonts.barlow(
                textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
              ),),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,top: 10.0,bottom: 10),
                child: Container(
                  child:  Text("I’ve been trying to find some good tools but can’t seem to find any. If anyone has any good resources, please drop them in this thread!".tr(),style: GoogleFonts.barlow(
                    textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                  ),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0,bottom: 14.0),
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
                              SvgPicture.asset("assets/images/chat.svg",fit: BoxFit.scaleDown,),


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
                    width: width*0.25,
                    height: 40,
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
                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
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
    return  Card(
      child: Container(
        height: height,
        width: width*0.92,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          searchtab,

                          delete,



                          sortbtn,




                          add,
                        ],
                      ),




                      SizedBox(height: height*0.03),

                      Container(
                        width: width*0.92,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            FutureBuilder<List<Post>>(

                              future: futurePost,
                              builder: (context, snapshot) {
                                if (snapshot.hasData){
                                  List<TextEditingController> commentControllers = [];
                                  for (int i = 0; i < snapshot.data!.length; i++) {
                                    commentControllers.add(TextEditingController());
                                  }

                                  return GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 2/ 1
                                      ),
                                      physics: NeverScrollableScrollPhysics(),

                                      shrinkWrap:true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (_, index) =>
                                          CheckboxListTile(
                                            value: checked.contains(snapshot.data![index].post_id),
                                            onChanged: (bool? select){
                                              if (select != null){
                                                setState(() {
                                                  // if the user selects, add the post to the check set
                                                  // if unselects, remove it
                                                  // using a set for easier iteration, and enabling of delete button
                                                  if (select){
                                                    checked.add(snapshot.data![index].post_id);
                                                  } else {
                                                    checked.remove(snapshot.data![index].post_id);
                                                  }
                                                });
                                              }
                                            },
                                            title: Container(
                                              width: width*0.32,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Card(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 20.0,left: 15,right: 15,top: 10),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: width*0.21,
                                                              child: Row(
                                                                children: [
                                                                  Column(

                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Text("${snapshot.data![index].name}".tr(),style: GoogleFonts.barlow(
                                                                        textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                                                      ),),
                                                                      SizedBox(height: 1,),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(bottom: 15.0),

                                                                        child: Text( "${snapshot.data![index].post_time}".tr(),style: GoogleFonts.barlow(
                                                                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                                                        ),),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // SizedBox(width: 30,),
                                                            // GestureDetector(
                                                            //     onTap: ()async {
                                                            //       await deletePost(postId: snapshot.data![index].post_id);
                                                            //       setState(() {
                                                            //         futurePost = fetchPosts(isAscending);
                                                            //       });
                                                            //     },
                                                            //     child: Image.asset("assets/images/bin.png",height: 18,))

                                                          ],
                                                        ),
                                                        Text("${snapshot.data![index].post_title}".tr(),style: GoogleFonts.barlow(
                                                          textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                                        ),),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 8.0,top: 10.0,bottom: 10),
                                                          child: Container(
                                                            child:  Text("${snapshot.data![index].post_description}".tr(),style: GoogleFonts.barlow(
                                                              textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                                                            ),),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10.0,bottom: 14.0),
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
                                                              GestureDetector(
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                      color:  Color(0xFFF4F6F4),

                                                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                                                  ),
                                                                  child: Padding(
                                                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                                      child: Row(
                                                                        children: [
                                                                          SvgPicture.asset("assets/images/chat.svg",fit: BoxFit.scaleDown,),

                                                                          Text("${snapshot.data![index].post_replies} replies".tr().toString(),strutStyle: StrutStyle(
                                                                              forceStrutHeight: true
                                                                          ),style: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),

                                                                        ],
                                                                      )
                                                                  ),

                                                                ),
                                                                onTap: () {
                                                                  commentDialog(context, snapshot.data![index], getReplies(postId: snapshot.data![index].post_id));
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width*0.23,
                                                              height: 55,

                                                              // >> comment text field
                                                              child: TextFormField(
                                                                maxLength: 50,
                                                                controller: commentControllers[index],

                                                                // style stuff
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                                                                  ),
                                                                  contentPadding: const EdgeInsets.all(8.0),
                                                                  labelText: "Type a comment",
                                                                  labelStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),
                                                                ),
                                                              ),
                                                            ),

                                                            const SizedBox(width: 18.5,),

                                                            ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: const Color(0xffF5F0E5),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                ),
                                                                elevation: 0,
                                                                side: const BorderSide(color: Color(0xFFEEEEEE)),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                                child: Text("Post".tr().toString(),strutStyle: const StrutStyle(
                                                                    forceStrutHeight: true
                                                                ),style: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF183028) ),),
                                                              ),
                                                              onPressed: () {
                                                                var comment = commentControllers[index].text;
                                                                if(validator.isValid("comment", comment, "empty") == ""){
                                                                  postReply(userId: 1, postId: snapshot.data![index].post_id, reply: comment);
                                                                } else {
                                                                  validator.alertDialog(context, "comment can't be empty");
                                                                }
                                                              },
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          )


                                  );
                                } else {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No Forum".tr(),
                                        style: GoogleFonts.barlow(
                                          textStyle: const TextStyle(
                                              color: Color(0xFF222222),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),




                          ],
                        ),
                      ),
                      SizedBox(height: height*0.01),

                      // Row(
                      //   children: [
                      //
                      //     num,
                      //     SizedBox(width: width*0.007,),
                      //     Text("Showing 6 of 6 results".tr(),style: GoogleFonts.barlow(
                      //       textStyle: TextStyle(color: Color(0Xff999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                      //     ),),
                      //   ],
                      // ),


                      SizedBox(height: height*0.02,),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width*0.187),
                            child:  ElevatedButton(
                              onPressed: () {
                                widget.onNext();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 0.6),
                                child: Text('Next'.tr().toString(),strutStyle: StrutStyle(
                                    forceStrutHeight: true
                                ),style: GoogleFonts.barlow(
                                  textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                ),),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                                primary: Color(0xFF215732),
                                onPrimary: Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),

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
          ),
        ),),
    );
  }
}
