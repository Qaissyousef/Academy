import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/PostModel.dart';
import '../models/ReplyModel.dart';


var replyCard = (double width, double height, {
  required String userName,
  String? postTitle, // if null don't show title
  required String postBody,
  required String postTime,
  int? replyCount // if null don't show comment count widget
}) => Padding(
  padding: const EdgeInsets.only(bottom: 12.0,left: 15,right: 15,top: 5),
  child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // heading row
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 10,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName.tr(),style: GoogleFonts.barlow(
                      textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                    ),
                    ),

                    const SizedBox(height: 1,),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text( postTime.tr(),style: GoogleFonts.barlow(
                        textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 14),
                      ),),
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),

        // Title and Body
        if(postTitle != null) Text(postTitle.tr(),style: GoogleFonts.barlow(
          textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 16),
        ),),
        Padding(
          padding: const EdgeInsets.only(right: 8.0,top: 10.0,bottom: 10),
          child: Text(postBody.tr(),style: GoogleFonts.barlow(
            textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,fontSize: 14),
          ),),
        ),

        // like and comments
        Padding(
          padding: const EdgeInsets.only(top: 10.0,bottom: 14.0),
          child: Row(
            children: [
              // heart icon
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFF4F6F4),
                    borderRadius: BorderRadius.all(Radius.circular(23))
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  child: Icon(Icons.favorite_border_rounded,color: Color(0xFF215732),size: 16),
                ),
              ),

              const SizedBox(width:6),

              // comment count
              // if reply count is null don't show this
              Container(
                child: replyCount == null ? null : Container(
                  decoration: const BoxDecoration(
                      color:  Color(0xFFF4F6F4),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/chat.svg",fit: BoxFit.scaleDown,),
                          Text("$replyCount replies".tr().toString(),
                            strutStyle: const StrutStyle( forceStrutHeight: true),
                            style: const TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        ),

        // Divider thingy
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Divider(
            height: 0,
            thickness: 2,
            color: Color(0xEEEEEEFF),
          ),
        ),
      ]
  ),
);


var commentDialog = (BuildContext context, Post post, Future<List<Reply>> replies) {
  showDialog(
      context: context,
      builder: (context){
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;

        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left:40, right:20),
              child: SizedBox(
                width: width*0.3,
                height: height*0.5,
                // the entire body of the thing
                child: Column(
                    children: [
                      // the exit button <x>
                      // wrapped in a row to push to the right
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {Navigator.pop(context);},
                            child: const Icon(Icons.close, size: 30,),
                          ),
                        ],
                      ),

                      // The post, comments, and scroll area
                      SizedBox(
                        height: height*0.45,
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Theme( // the theme is only for the scroll bar
                            data: Theme.of(context).copyWith(
                                scrollbarTheme: ScrollbarThemeData(
                                  // colors
                                  thumbColor: MaterialStateProperty.all(const Color(0xFFBD9B60)),
                                  trackBorderColor: MaterialStateProperty.all(const Color(0xFFF5F0E5)),
                                  trackColor: MaterialStateProperty.all(const Color(0xFFF5F0E5)),
                                  // sizes
                                  minThumbLength: 50,
                                  thickness: MaterialStateProperty.all(12),
                                  crossAxisMargin: -3,
                                  // staying visible
                                  thumbVisibility: MaterialStateProperty.all(true),
                                  trackVisibility: MaterialStateProperty.all(true),
                                )
                            ),
                            child: SingleChildScrollView( // the thing that actually scrolls
                                child: Column(
                                  children: [
                                    // original post
                                    replyCard(width, height, userName: post.name, postTitle: post.post_title, postBody: post.post_description, postTime: post.post_time, replyCount: post.post_replies),

                                    // replies
                                    FutureBuilder<List<Reply>>(
                                      future: replies,
                                      builder: ((context, snapshot) {
                                        if (snapshot.hasData){
                                          return Column(
                                            children: <Widget>[
                                              for(var reply in snapshot.data ?? <Reply>[])
                                                replyCard(width, height, userName: reply.name, postBody: reply.reply, postTime: reply.reply_time),
                                            ],
                                          );
                                        } return Container();
                                      }
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              ),
            )
          ],
        );
      }
  );
};