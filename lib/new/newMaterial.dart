import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class newmaterial extends StatefulWidget {
  final String cid;

  const newmaterial({Key? key, required this.cid}) : super(key: key);

  @override
  State<newmaterial> createState() => _newmaterialState();
}

class _newmaterialState extends State<newmaterial> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final searchtab = Container(
      width: width * 0.4,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 18.0, right: 20.0, top: 5, bottom: 5),
        child: Row(
          children: [
            Image.asset("assets/images/search.png", color: Color(0xFFBD9B60)),
            SizedBox(
              width: width * 0.009,
            ),
            Text(
              "  Search".tr().toString(),
              style: GoogleFonts.barlow(
                textStyle: TextStyle(
                    color: Color(0xFFBD9B60),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: width * 0.01),
              ),
            ),
            SizedBox(
              width: width * 0.22,
            ),
            Image.asset("assets/images/mic.png", color: Color(0xFF999999)),
            SizedBox(
              width: width * 0.009,
            ),

            // SizedBox(width: width*0.06,),
            Image.asset(
              "assets/images/Separator.png",
              color: Color(0xFFEEEEEE),
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.021,
                ),
                Image.asset("assets/images/filter.png",
                    color: Color(0xFF215732)),
                Text(
                  "  Filter".tr(),
                  style: GoogleFonts.barlow(
                    textStyle: TextStyle(
                        color: Color(0xFF215732),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: width * 0.01),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    final sortbtn = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black, width: 0.4),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 12.5, bottom: 12.5, left: 17, right: 17),
        child: Row(
          children: [
            Image.asset("assets/images/sort.png", color: Color(0xFF222222)),
            Text(
              "  Sort".tr(),
              style: GoogleFonts.barlow(
                textStyle: TextStyle(
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: width * 0.01),
              ),
            ),
          ],
        ),
      ),
    );

    return Card(
      child: Container(
        height: height,
        width: width * 0.92,
        child: WebSmoothScroll(
          controller: _scrollController,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.004,
                          ),
                          searchtab,
                          SizedBox(
                            width: width * 0.24,
                          ),
                          sortbtn,
                        ],
                      ),
                      SizedBox(height: height * 0.035),
                      Container(
                        width: width * 0.92,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.92,
                              height: height * 0.07,
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
                                  SizedBox(
                                    width: width * 0.0125,
                                  ),
                                  Container(
                                    width: width * 0.17,
                                    child: Text(
                                      "Title".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFFBD9B60),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.15,
                                    child: Text(
                                      "Upload time".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFFBD9B60),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.18,
                                    child: Text(
                                      "Subject".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFFBD9B60),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.12,
                                    child: Text(
                                      "Author".tr(),
                                      style: GoogleFonts.barlow(
                                        textStyle: TextStyle(
                                            color: Color(0xFFBD9B60),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.002,
                            ),
                            SizedBox(
                              height: height * 0.002,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            SizedBox(height: height * 0.03),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.616,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Color(0xFF999999), width: 1)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3.15, vertical: 10.0),
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          size: 14,
                                          color: Color(0Xff999999),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1.15, vertical: 10.0),
                                        child: Text(
                                          "  Upload new file  ".tr(),
                                          style: GoogleFonts.barlow(
                                            textStyle: TextStyle(
                                                color: Color(0Xff222222),
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.62, top: height * 0.1),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 0.6),
                                  child: Text('Save changes'.tr().toString(),
                                      strutStyle:
                                          StrutStyle(forceStrutHeight: true)),
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
                      ),
                      SizedBox(height: height * 0.01),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.616,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
