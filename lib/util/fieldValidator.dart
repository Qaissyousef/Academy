// ignore_for_file: depend_on_referenced_packages, library_names, file_names, non_constant_identifier_names
library pif_admin_dashboard.fieldValidator;

import 'package:string_validator/string_validator.dart' as sv;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';


// the bullet character
const String bullet = "\u2022";

// >> Date Validator >>====================================================================================================================================================================<<
// >> Used for Date Validation (isDateValid())
// Define a date format for the "Jan 01 2022" format
final dateFormat = DateFormat('MMM dd yyyy');

// extention function to do tryParse
extension DateFormatTryParse on DateFormat {
  DateTime? tryParse(String inputString, [bool utc = false]) {
    try {
      return parse(inputString, utc);
    } on FormatException {
      return null;
    }
  }
}

// validates that a date if it is in the correct format
bool isDateValid(String text) {
  if (dateFormat.tryParse(text) == null) return false;
  return true;
}

// checks if end occours after start
bool isDateGreater(String start, String end) {
  DateTime? s = dateFormat.tryParse(start);
  DateTime? e = dateFormat.tryParse(end);

  if (s == null || e == null) return false;
  if(e.isAtSameMomentAs(s))
    {
      return true;
    }
  return e.isAfter(s);
}

// >> Time Validator >>====================================================================================================================================================================<<
// converts string to time of day reliabely
List stringToTOD(final String text) {
  final hm = text.split(":");
  if (hm.length != 2) return [false, null];

  int? hour = int.tryParse(hm[0]);
  if (hour == null || hour < 0 || hour > 24) return [false, null];

  int? minute = int.tryParse(hm[1]);
  if (minute == null || minute < 0 || minute > 59) return [false, null];

  return [true, TimeOfDay(hour: hour, minute: minute)];
}

// used for validation
bool isTimeValid(final String text) {
  return stringToTOD(text)[0];
}

// checks if start is greater than end
bool isTimeGreater(final String start, final String end) {
  TimeOfDay? t_start = stringToTOD(start)[1];
  TimeOfDay? t_end = stringToTOD(end)[1];

  if (t_start == null || t_end == null) return false;

  if (t_start.hour > t_end.hour) {
    return false;
  } else if (t_start.hour == t_end.hour) {
    if (t_start.minute >= t_end.minute) return false;
  }

  return true;
}

// >> Validation Function >>===============================================================================================================================================================<<
// generic function used in validator functions
// returns true if the string is valid
// according to the given validators
//
// example syntax:
// note: only use lower case characters for the validators
// =======================================================
//    // checks if the controller text is email and only contains ascii (non-foreign) characters
//    isValid(myController1.text, "email;ascii");
//
//    // checks if the text only contains letters
//    isValid("7h1s t2xt c0nt6ins n4ms", "alpha")
// =======================================================
//
// null and correctness of validators string is checked by default
// empty: checks if string empty
// alpha: checks if string only contains alpha characters
// number: checks if string only contains numbers
// alphanum: checks if string only contains both numbers and letters
// date: checks if string is a valid date in this format: MMM dd yyyy
// time: checks if string is a valid time in this format: HH:mm (0~24 hours (no PM or AM))
// link: checks if string is a valid link
//
String isValid(final String fieldName, final String? text, final String validators) {
  final vList = validators.split(';');

  if (text != null) {
    for (var v in vList) {
      switch (v) {
        case "empty":
          if (text.isEmpty) return "$bullet $fieldName shouldn't be empty\n";
          break;
        case "alpha":
          if (!sv.isAlpha(text)) return "$bullet $fieldName field should only contain letters\n";
          break;
        case "number":
          if (!sv.isNumeric(text)) return "$bullet $fieldName field should only contain numbers\n";
          break;
        case "alphanum":
          if (!sv.isAlphanumeric(text)) return "$bullet $fieldName field should only contain numbers and letters\n";
          break;
        case "date":
          if (!isDateValid(text)) return "$bullet $fieldName field should be a valid date\n";
          break;
        case "time":
          if (!isTimeValid(text)) return "$bullet $fieldName field should be a valid time\n";
          break;
        case "link":
          if (!sv.isURL(text)) return "$bullet $fieldName field should be a valid link or url\n";
          break;
        case "email":
          if (!sv.isEmail(text)) return "$bullet $fieldName field should be a valid email\n";
          break;
        default:
          return "validator error";
      }
    }
  } else {
    return "String is null";
  }

  return "";
}

// >> Field Error Border Stile >>==========================================================================================================================================================<<
// individual styles, used for fields where replaceing the entire decorator is difficult
// like in date/time pickers
//
// in case you are dealing with that copy the following
// errorBorder: validator.errorBorder,
// focusedErrorBorder: validator.errorBorder,
//
const errorColor = Color(0xFFd90100);
const errorBorder = OutlineInputBorder(borderSide: BorderSide(color: errorColor, width: 1.5));

// style used for fields with validation
const fieldDecorator = InputDecoration(
  errorBorder: errorBorder,
  focusedErrorBorder: errorBorder,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
  ),
);

// >> Field Error Alert Dialog >>==========================================================================================================================================================<<
void alertDialog(BuildContext ctx, String errorText) => showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          // padding
          contentPadding: const EdgeInsets.all(13),
          shape: RoundedRectangleBorder(side: const BorderSide(color: errorColor), borderRadius: BorderRadius.circular(5.0)),
          // the singleChildScrollView is to avoid a wierd error with columns
          content: SingleChildScrollView(
            // outer row for the exit button to be on the top right
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // the left Icon, Error! string, and error message
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.cancel_outlined,
                      color: errorColor,
                      size: 40,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Error!",
                          style: GoogleFonts.barlow(
                            textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 18),
                          ),
                        ),
                        Text(
                          errorText,
                          style: GoogleFonts.barlow(
                            textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // exit icon
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 20,
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFF999999),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(true),
                ),
              ],
            ),
          ),
        );
      },
    );

void mobileAlertDialog(BuildContext ctx, String errorText) => showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          // padding
          contentPadding: const EdgeInsets.all(13),
          shape: RoundedRectangleBorder(side: const BorderSide(color: errorColor), borderRadius: BorderRadius.circular(5.0)),
          // the singleChildScrollView is to avoid a wierd error with columns
          content: SingleChildScrollView(
            // outer row for the exit button to be on the top right
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // the left Icon, Error! string, and error message
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.cancel_outlined,
                              color: errorColor,
                              size: 30,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Error!",
                              style: GoogleFonts.barlow(
                                textStyle: const TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          errorText,
                          style: GoogleFonts.barlow(
                            textStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
