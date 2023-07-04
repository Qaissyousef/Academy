import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/PostModel.dart';
import '../../models/ReplyModel.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


commentCard(double width, double height, {
  required BuildContext context, required Post post, required Future<List<Reply>> replies})  {
      var commentControllers = TextEditingController();
      showMaterialModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: SizedBox(
            height: 600,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon:  const Icon(Icons.arrow_back_ios_new,size: 18),
                        onPressed: () {  Navigator.of(context).pop(); },
                      ),
                      Text("Thread".tr()),
                    ],
                  ),
                  const Divider(color: Colors.grey,),

                  // the main post
                  Padding(
                    padding:  EdgeInsets.only(left:width*0.04,right:width*0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [                                    Padding(
                            padding: const EdgeInsets.only(right: 8.0,left:8),
                            child: Image.asset("images/u3.png"),
                          ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(post.name.tr(),style:
                                GoogleFonts.barlow(
                                  textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                ),
                                Text(post.post_time.tr(),style:
                                GoogleFonts.barlow(
                                  textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height:7),
                        Text(post.post_title.tr(),style:
                        GoogleFonts.barlow(
                          textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Colors.black ),),
                        ),const SizedBox(height:7),
                        Text(post.post_description.tr(),style:
                        GoogleFonts.barlow(
                          textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Colors.black ),),
                        ),
                        const SizedBox(height:9),

                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color:  Color(0xFFf4f7f5),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left:12,right:12,top:6,bottom:6),
                                child:  Icon(Icons.favorite_border_rounded,color: Color(0xFF215732),size: 20),
                              ),
                            ),
                            const SizedBox(width:6),

                            Container(
                              decoration: const BoxDecoration(
                                  color:  Color(0xFFf4f7f5),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(left:12,right:12,top:6,bottom:6),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/images/replies.svg',fit: BoxFit.scaleDown,),
                                      const SizedBox(width: 5,),
                                      Text("${post.post_replies} replies".tr(),
                                      style:GoogleFonts.barlow(textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF215732) ),),
                                      ),
                                    ],
                                  )
                              ),

                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey,),


                  // the comments
                  FutureBuilder<List<Reply>>(
                    future: replies,
                    builder: (((context, snapshot) {
                      return Column(
                        children: <Widget>[
                          for (Reply r in snapshot.data ?? [])
                          Padding(
                            padding:  EdgeInsets.only(left:width*0.04,right:width*0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [                                    Padding(
                                    padding: const EdgeInsets.only(right: 8.0,left:8),
                                    child: Image.asset("images/u3.png"),
                                  ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(r.name,style:
                                        GoogleFonts.barlow(
                                          textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                        ),
                                        Text(r.reply_time.tr(),style:
                                        GoogleFonts.barlow(
                                          textStyle: const TextStyle(fontFamily: 'Barlow',fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color:Color(0xFF999999) ),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),SizedBox(height:7),

                                Text(r.reply.tr(),style:
                                GoogleFonts.barlow(
                                  textStyle: TextStyle(fontFamily: 'Barlow',fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color:Colors.black ),),
                                ),
                                SizedBox(height:9),

                                Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color:  Color(0xFFf4f7f5),
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: const Padding(
                                        padding: const EdgeInsets.only(left:12,right:12,top:6,bottom:6),
                                        child:  Icon(Icons.favorite_border_rounded,color: Color(0xFF215732),size: 20),
                                      ),
                                    ),
                                    const SizedBox(width:6),
                                  ],
                                ),
                                const Divider(color: Colors.grey,),
                              ],
                            ),
                          ),
                        ],
                      );
                    })) 
                  ),
                  SizedBox(height:  context.locale == Locale("en") ? height*0.15:height*0.05 ,),
                ],
              ),
            ),
          ),
        ),
      );
    }