import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class newattendance extends StatefulWidget {
  const newattendance({Key? key}) : super(key: key);

  @override
  State<newattendance> createState() => _newattendanceState();
}

class _newattendanceState extends State<newattendance> {
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

    final collect = ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.open_in_new),
                              SizedBox(
                                width: 25,
                              ),
                              Icon(Icons.open_in_full_sharp),
                              SizedBox(
                                width: 25,
                              ),
                              Icon(Icons.close),
                            ],
                          )),
                    ),
                  ],
                ),
                content: Row(
                  children: [
                    Container(
                      width: 400,
                      color: Colors.blue,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container(
                            //   height: 20,
                            //   color: Colors.blue,
                            // ),
                            Text(
                              "17/05/2022 12:30GST",
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 24),
                              ),
                            ),
                            Image.asset("assets/images/qr.png"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Please register your attendance using this QR code",
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 24),
                              ),
                            ),
                            Container(
                              height: 60,
                              color: Colors.blue,
                            ),
                          ],
                        )),
                    Container(
                      width: 400,
                      color: Colors.blue,
                    ),
                  ],
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0.6),
        child: Text('  Collect attendance  '.tr().toString(),
            strutStyle: StrutStyle(forceStrutHeight: true),
            style: GoogleFonts.barlow(
              textStyle: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 16),
            )),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        primary: Color(0xFF215732),
        onPrimary: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
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
                          searchtab,
                          SizedBox(
                            width: width * 0.005,
                          ),
                          sortbtn,
                          SizedBox(
                            width: width * 0.122,
                          ),
                          collect
                        ],
                      ),
                      SizedBox(height: height * 0.03),
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
                                    width: width * 0.013,
                                  ),
                                  Container(
                                    width: width * 0.06,
                                    child: Text(
                                      "   Picture",
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
                                      "Name",
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
                                    width: width * 0.1,
                                    child: Text(
                                      "Date",
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
                                    width: width * 0.09,
                                    child: Text(
                                      "Account type",
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
                                      "Percentage",
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
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.1),
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
