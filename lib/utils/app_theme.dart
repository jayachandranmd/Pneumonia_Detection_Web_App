import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color maintheme = Color(0xFF17C5CC);
  static const Color background = Color(0XFFF4FDFE);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0XFF848789);
  static const Color white = Color(0xFFFFFFFF);
  static const Color violet = Color(0xFF3C3056);
  static const Color lightgrey = Color(0XFFC4C4C4);
  static const Color textboxgrey = Color(0XFFEBEBEB);
  static const String fontName = 'hebrew';
}

const TextStyle appBarheader = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppTheme.white);

const TextStyle appBarmenu = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppTheme.white);

const TextStyle header1 = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 50,
    fontWeight: FontWeight.w700,
    color: AppTheme.black);

const TextStyle body1 = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppTheme.grey,
    height: 2);

const TextStyle header2 = TextStyle(
  fontFamily: AppTheme.fontName,
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: AppTheme.black,
);

const TextStyle header3 = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 39,
    fontWeight: FontWeight.w700,
    color: AppTheme.black);

const TextStyle body2 = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppTheme.black,
    height: 2);

const TextStyle browse = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppTheme.white,
    height: 2);

const TextStyle header4 = TextStyle(
  fontFamily: AppTheme.fontName,
  fontSize: 24,
  fontWeight: FontWeight.w700,
  color: AppTheme.black,
);

const TextStyle location = TextStyle(
  fontFamily: AppTheme.fontName,
  fontSize: 13,
  fontWeight: FontWeight.w700,
  color: AppTheme.white,
);

const TextStyle cardHeader = TextStyle(
  fontFamily: AppTheme.fontName,
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: AppTheme.black,
);

const TextStyle cardButton = TextStyle(
  fontFamily: AppTheme.fontName,
  fontSize: 13,
  fontWeight: FontWeight.w700,
  color: AppTheme.white,
);

const TextStyle header5 = TextStyle(
  fontFamily: AppTheme.fontName,
  fontSize: 24,
  fontWeight: FontWeight.w400,
  color: AppTheme.black,
);

const TextStyle starText = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppTheme.lightgrey,
    height: 2);
