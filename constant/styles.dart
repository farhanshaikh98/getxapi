import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class CommonStyle {
  /*static const hintTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: CommonColor.hintTextColor,
  );

  static const toolbarTextStyle = TextStyle(
      color: CommonColor.primaryColor,
      fontWeight: FontWeight.w600,
      fontSize: 19);

  static const fontWeight400FontSize13 = TextStyle(
      color: CommonColor.textColorGrey,
      fontWeight: FontWeight.w400,
      fontSize: 12);

  static const fontWeight400FontSize10 = TextStyle(
      color: CommonColor.textColorGrey,
      fontWeight: FontWeight.w400,
      fontSize: 10);

  static const fw600FontSize14TextColorGrey = TextStyle(
      color: CommonColor.textColorGrey,
      fontWeight: FontWeight.w600,
      fontSize: 14);

  static const fw600FontSize10TextColorGrey = TextStyle(
      color: CommonColor.textColorGrey,
      fontWeight: FontWeight.w600,
      fontSize: 10);

  static const fw600FontSize10TextColorGreen = TextStyle(
      color: CommonColor.colorGreen, fontWeight: FontWeight.w600, fontSize: 10);

  static const fontWeight400FontSize12SecondaryColor = TextStyle(
      color: CommonColor.secondaryColor,
      fontWeight: FontWeight.w400,
      fontSize: 12);

  static const fontWeight600FontSize12 = TextStyle(
      color: CommonColor.textColorGrey,
      fontWeight: FontWeight.w600,
      fontSize: 12);

  static const titleTextStyle = TextStyle(
    color: CommonColor.textTitleColor,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const buttonTextStyle = TextStyle(
      color: CommonColor.colorWhite, fontWeight: FontWeight.w600, fontSize: 12);

  static const addToCarButtonTextStyle = TextStyle(
      color: CommonColor.colorWhite, fontWeight: FontWeight.w600, fontSize: 9);

  static const removeFromCarButtonTextStyle = TextStyle(
      color: CommonColor.primaryColor,
      fontWeight: FontWeight.w600,
      fontSize: 9);

  static const bookToCarButtonTextStyle = TextStyle(
      color: CommonColor.colorWhite, fontWeight: FontWeight.w500, fontSize: 10);

  static const viewFromCarButtonTextStyle = TextStyle(
      color: CommonColor.primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 10);*/


  static TextStyle font13SpWeight300color = GoogleFonts.sora(
      fontWeight: FontWeight.w300,
      fontSize: 13.sp,
      color: const Color(0xff7B7B7B));
  static TextStyle font16SpWeight500white = GoogleFonts.sora(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: const Color(0xffFFFFFF));
  static TextStyle font24SpWeight500 =
      GoogleFonts.sora(fontWeight: FontWeight.w500, fontSize: 24.sp);
  static TextStyle font20SpWeight600 = GoogleFonts.sora(
      fontWeight: FontWeight.w600,
      fontSize: 20.sp,
      color: const Color(0xffFFFFFF));
  static TextStyle font16SpWeight400 = GoogleFonts.sora(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  );
  static TextStyle font20SpAppColor = GoogleFonts.sora(
    color: const Color(0xff2A70FF),
    fontSize: 12.sp,
  );
  static TextStyle font16SpWeight700color = GoogleFonts.sora(
      fontWeight: FontWeight.w700,
      fontSize: 16.sp,
      color: const Color(0xff18193D));
  static TextStyle font16SpWeight500colorBlack = GoogleFonts.sora(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: const Color(0xff000000));
  static TextStyle font12SpWeight400color = GoogleFonts.sora(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: const Color(0xff18193D));
  static TextStyle font12SpWeight400 =
      GoogleFonts.sora(fontSize: 12.0.sp, fontWeight: FontWeight.w400);
  static TextStyle font12SpWeight400profileInfo = GoogleFonts.sora(
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xff828282));
  static TextStyle font12SpWeight300 =
      GoogleFonts.sora(fontSize: 12.0.sp, fontWeight: FontWeight.w300);
  static TextStyle font12SpWeight600 = GoogleFonts.sora(
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w600,
      color: const Color(0xffFFFFFF));
  static TextStyle font14SpWeight500 = GoogleFonts.sora(
    textStyle: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w500),
  );
  static TextStyle font14SpWeight700 = GoogleFonts.sora(
    textStyle: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w700),
  );
  static TextStyle font14SpWeight600black = GoogleFonts.sora(
    textStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xff000000)),
  );

  static BoxDecoration textFieldDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8.0.sp),
      border: Border.all(color: const Color(0xffBDD1DC), width: 1.w));

  static BoxDecoration profileBoxDeco = BoxDecoration(
      color: const Color(0xffFFFFFF),
      borderRadius: BorderRadius.circular(20.sp),
      boxShadow: const [
        BoxShadow(
          offset: Offset(0, 3),
          color: Color.fromRGBO(0, 0, 0, 0.1),
          spreadRadius: 3,
          blurRadius: 7,
        ),
      ]);
}
