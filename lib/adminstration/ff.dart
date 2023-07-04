
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class testingaddcontroller extends StatefulWidget {
  const testingaddcontroller({Key? key}) : super(key: key);

  @override
  State<testingaddcontroller> createState() => _testingaddcontrollerState();
}

class _testingaddcontrollerState extends State<testingaddcontroller> {

  final _dateTime = DateTime.parse("2022-10-01 00:00:00.000");
  late ScrollController _scrollController;


  @override
  void initState() {

    _scrollController = ScrollController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
          child: Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF5F0E5),
                elevation: 0.0,
                shadowColor: Colors.transparent,
                onPrimary: const Color(0xFF183028),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                ),
              ),
              child: Text(
                  'Export list as spreadsheet'
                      .tr()
                      .toString(),
                  strutStyle: const StrutStyle(
                      forceStrutHeight: true),
                  style: GoogleFonts.barlow(
                    textStyle: const TextStyle(
                        color: Color(0xFF183028),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16),
                  )),
            ),
          )
        ),
        bottomNavigationBar: ElevatedButton(

          onPressed: () {
            // createExcel;

            print("clickks");
          },
          child: const Text('Looks like a RaisedButton'),
        )
    );

  }
//   Future<void> createExcel() async{
//     final Workbook workbook = new Workbook();
// //Accessing worksheet via index.
//     workbook.worksheets[0];
// // Save the document.
//     final List<int> bytes = workbook.saveAsStream();
//     String directory = (await getApplicationDocumentsDirectory()).path;
//     io.File('$directory/CreateExcel.xlsx').writeAsBytes(bytes);
// //Dispose the workbook.
//     workbook.dispose();
//   }

}
