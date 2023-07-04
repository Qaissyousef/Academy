import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../../models/PostModel.dart';
import 'package:http/http.dart' as http;
import 'package:pif_admin_dashboard/util/global.dart' as global;
import 'package:pif_admin_dashboard/Util/fieldValidator.dart' as validator;
import '../../models/ReplyModel.dart';
import 'package:date_time_format/date_time_format.dart';
import '../courseDetails/mobileForumComment.dart';



class mobileForum extends StatefulWidget {
    final String current_course_id;

  const mobileForum({Key? key,required this.current_course_id}) : super(key: key);


  @override
  State<mobileForum> createState() => _mobileForumState();
}

class _mobileForumState extends State<mobileForum> {
  late ScrollController _scrollController;

  Set<int> checked = {};
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

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

  Future<List<Post>> fetchPosts() async {
    final response =
    await http.get(Uri.parse(global.apiAddress + 'GetPosts/${widget.current_course_id}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Post>((json) => Post.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  late Future<List<Post>> futurePost;

  Future<void> deletePost({required int postId}) async {
    await http.post(Uri.parse('${global.apiAddress}deletePost/$postId'));
  }

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
    futurePost = fetchPosts();
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
      futurePost = fetchPosts();
    });
    return true;
  }




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


    final delete = Container(
      width: width*0.435,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFF999999),width: 0.4),

      ),
      child: ElevatedButton(
        onPressed: checked.isEmpty ? null : () async {
          // deleting selected posts
          for (int postId in checked) {
            await deletePost(postId: postId);
          }
          // resetting checked and fetching restting post page
          setState(() {
            checked = <int>{}; 
            futurePost = fetchPosts();
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
      )
    );

    
    postCard(Post p) {
      var commentControllers = TextEditingController();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: checked.contains(p.post_id),
          onChanged: (bool? select){
            if (select != null){
              setState(() {
                if (select){
                  checked.add(p.post_id);
                } else {
                  checked.remove(p.post_id);
                }
              });
            }
          },
        ),
        SizedBox(
            width: width*0.85,
            child: Card(
              child: Padding(
                padding:  EdgeInsets.only(bottom: 20.0,left: width*0.03,right: width*0.03,top: 5),
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
                              Container(
        
                                  child: Image.asset("images/u3.png")),
                              SizedBox(width: 10,),
                              Container(
        
                                child: Row(
                                  children: [
                                    Column(
        
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
        
                                        Text(p.name.tr(),style: GoogleFonts.barlow(
                                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                        ),),
                                        SizedBox(height: 1,),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 15.0),
        
                                          child: Text(p.post_time.tr(),style: GoogleFonts.barlow(
                                            textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                          ),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 50),
                        GestureDetector(
                          onTap: ()async {
                            await deletePost(postId: p.post_id);
                            setState(() {
                              futurePost = fetchPosts();
                            });
                          },
                            child: Image.asset("assets/images/bin.png",height: 18,))
        
                      ],
                    ),
                    Text(p.post_title.tr(),style: GoogleFonts.barlow(
                      textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                    ),),
                    Container(
                      child:  Text(p.post_description.tr(),style: GoogleFonts.barlow(
                        textStyle: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
                      ),),
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
                            child: GestureDetector(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("images/chat.svg",fit: BoxFit.scaleDown,),
                                      Text("${p.post_replies} replies".tr().toString(),strutStyle: StrutStyle(
                                          forceStrutHeight: true
                                      ),style: TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),
                            
                                    ],
                                  )
                              ),
                              onTap: () async {
                                commentCard(width, height, context:context, post:p, replies: getReplies(postId: p.post_id));
                              },
                            ),
        
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width*0.5,
                          height: 55,
            
                          // >> comment text field
                          child: TextFormField( 
                            maxLength: 50,
                            controller: commentControllers,
            
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
                            var comment = commentControllers.text;
                            if(validator.isValid("comment", comment, "empty") == ""){
                              postReply(userId: 1, postId: p.post_id, reply: comment);
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
      ],
    );}
    return Scaffold(
      body:  SizedBox(
        height: height,
        width: width,
        child: WebSmoothScroll(
          controller: _scrollController,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height*0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              width: width*0.7,
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
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
                                            children: [ GestureDetector(
                                                child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 14,),
                                                onTap: () {Navigator.pop(context);},
                                              ), Text("    Forum".tr(),style: GoogleFonts.barlow(
                                              textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                            ))],
                                          ),
                                        ),
                                        body: Padding(
                                          padding: const EdgeInsets.only(left: 16, right: 16, top: 15,bottom: 15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(width: 6,),
                                                  SizedBox(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Row(
                                                              children: [
                                                                Image.asset("assets/mobileImages/mobileuser.png"),
                                                                const SizedBox(width: 4,),
                                                                Text("User".tr(),style: GoogleFonts.barlow(
                                                                  textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                                                                ),),
                                                              ],
                                                            ),
                                                            const SizedBox(height:4,),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 40),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    border: Border.all(color: const Color(0xFFEEEEEE),width:1)
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text("Tag people".tr(),style: GoogleFonts.barlow(
                                                                        textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 12),
                                                                      ),),
                                                                      const Icon(Icons.expand_more,size: 13,)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              SizedBox(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(4),
                                                          border: Border.all(color: const Color(0xFF999999),width: 0.3)
                                                      ),
                                                      child: TextField( maxLength: 50,
                                                        controller: myController2,
                                                        decoration: InputDecoration(
                                                          contentPadding: const EdgeInsets.all(15),
                                                          hintText: "title".tr(),
                                                          hintStyle: const TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w400),
                                                          border: InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height:10),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(4),
                                                          border: Border.all(color: const Color(0xFF999999),width: 0.3)
                                                      ),
                                                      child: TextField( maxLength: 50,
                                                        maxLines: 6,
                                                        controller: myController1,
                                                        decoration: InputDecoration(
                                                          contentPadding: const EdgeInsets.all(15),
                                                          hintText: "Your post".tr(),
                                                          hintStyle: const TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w400),
                                                          border: InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      foregroundColor: Colors.black, 
                                                      backgroundColor: const Color(0xFFF5F0E5), elevation: 0.0,
                                                      shadowColor: Colors.transparent,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                                                      child: Text('Cancel'.tr().toString(),strutStyle: const StrutStyle(
                                                          forceStrutHeight: true
                                                        ),style: GoogleFonts.barlow(
                                                          textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async{
                                                      if(await submitForm()) {
                                                        Navigator.pop(context);
                                                        myController1.text = "";
                                                        myController2.text = "";
                                                      }
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      foregroundColor: const Color(0xFFFFFFFF), 
                                                      backgroundColor: const Color(0xFF215732), elevation: 0.0,
                                                      shadowColor: Colors.transparent,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 7),
                                                      child: Row(
                                                        children: [
                                                          Text('Post now    '.tr().toString(),strutStyle: const StrutStyle(
                                                              forceStrutHeight: true
                                                          ),style: GoogleFonts.barlow(
                                                            textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
                                                          ),),
                                                          SvgPicture.asset("assets/images/send.svg"),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                                        color: Color(0xFF215732)
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        filter,sort
                      ],),
                      SizedBox(height: height*0.02,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        num,

                          delete
                      ],),
                      SizedBox(height: height*0.02,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 4),
                        child: Text("Showing 6 of 6 results".tr(),style: GoogleFonts.barlow(
                          textStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                        ),),
                      ),
                      SizedBox(height: height*0.02,),




                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder <List<Post>>( future: fetchPosts(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData){
                              return Column(
                                children: [
                                  for(var post in snapshot.data ?? [])
                                    Column(
                                      children: [
                                        postCard(post),
                                        const SizedBox(height:8)
                                      ],
                                    )
                                ],
                              );
                            }
                            return Container();
                          }
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),),
    );
  }
}