import 'package:flutter/material.dart';

const Color cWhite = Color(0xffffffff);
const Color cSnow = Color(0xffFAFAFA);
// const Color cUfoGreen = Color(0xff32D777);
// const Color cDeepCarminePink = Color(0xffFF2E2E);
const Color cBlack = Color(0xff000000);
const Color cCharleston = Color(0xff23262F);
// const Color cRedPigment = Color(0xffF31629);
// const Color cSlateGray = Color(0xff8d8d93);
const Color cSlateGray = Color(0xffd3d3d3);
const Color cBrightRed = Color(0xFFFC0939);
// const Color cLightGreen = Color(0xffFD930B);
/*/// New Blue color scheme
///
const Color cBlueDark = Color(0xFF0077b6);
const Color cLightBlue = Color(0xFF00b4d8);
const Color cLightSkyBlue = Color(0xFF90e0ef);
const Color cExtraLightBlue = Color(0xFFcaf0f8);*/

/// New Orange color scheme

const Color cDark = Color(0xFFff6700);
const Color cLightDark = Color(0xFFFD930B);
const Color cLight = Color(0xFFffb38a);
const Color cExtraLight = Color(0xffffe3d1);
const Color cExtraLight2 = Color(0xfffff9f5);
const Color cMaxExtraLight = Color(0xfffff9f2);

// /// New Orange color scheme
//
// const Color cOrangeDark = Color(0xFFff6700);
// const Color cLightDarkOrange = Color(0xFFff9248);
// const Color cLightOrange = Color(0xFFffb38a);
// const Color cExtraLightOrange = Color(0xFFffd7b5);



int getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }
  return int.parse(hexColor, radix: 16);
}


