import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../color_constant.dart';

class AppStyle {
  //login_And_Signup_scrren_all_Text_style.

  static TextStyle lblAppbar = TextStyle(
      fontSize: Adaptive.sp(16),
      fontWeight: FontWeight.w500,
      color: Colors.white
      // fontStyle: FontStyle.normal,
      );

  static TextStyle lblloging = TextStyle(
      fontSize: Adaptive.sp(16),
      fontWeight: FontWeight.w500,
      color: Colors.black
      // fontStyle: FontStyle.normal,
      );

  static TextStyle lblenteryouremailandpass = TextStyle(
    fontSize: Adaptive.sp(16),
    color: ColorConstant.grey,
  );

  static TextStyle lblalltextfromfields = TextStyle(
    color: ColorConstant.grey,
    // fontWeight: FontWeight.w500,
    fontSize: Adaptive.sp(16),
  );
  static TextStyle lblalerttext = TextStyle(
    color: ColorConstant.grey,
    // fontWeight: FontWeight.w500,
    fontSize: Adaptive.sp(16),
  );
  static TextStyle lblaccontdetail = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: Adaptive.sp(16),
  );

  static TextStyle lblaccontsecond = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle lblhomebtns = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: Adaptive.sp(16),
      color: Colors.white);

  static TextStyle lblbuydetail = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: Adaptive.sp(16),
      color: Colors.white);

  static TextStyle wallatmoneylist =
      const TextStyle(fontSize: 14, color: Colors.white);

  static TextStyle lblforgotpassword = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static TextStyle lblforgclrdark = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle lblmystock = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: Adaptive.sp(16),
    color: ColorConstant.maingreen,
  );
  static TextStyle lblmystockspot = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13,
    // color: ColorConstant.maingreen,
  );

  static TextStyle lblviewbtnwithdraw = const TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: 14,
  );
  static TextStyle lblonbordingp =
      TextStyle(fontSize: Adaptive.sp(16), height: 1.4);

  static TextStyle aplayforloan = const TextStyle(
    fontSize: 13,
  );

  static TextStyle bankliststl = TextStyle(
    fontSize: Adaptive.sp(16),
  );

  static TextStyle mystoke = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static TextStyle mystokedetail = const TextStyle(
    fontSize: 13,
  );

  static TextStyle mystokeexpiry =
      const TextStyle(fontSize: 13, color: Colors.grey);

  static TextStyle mystokedetailblueclr = const TextStyle(
    fontSize: 13,
    color: Colors.blue,
  );

  static TextStyle lblonbordingh = const TextStyle(
    fontSize: 22,
  );

  static TextStyle lbltermncon = TextStyle(
    fontSize: 14,
    color: ColorConstant.maingreen,
    fontWeight: FontWeight.w500,
  );

  static TextStyle lblsellnbuy = const TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  static TextStyle lblonlinemandibig = const TextStyle(
    fontSize: 17,
    // color: Colors.green,
    fontWeight: FontWeight.w400,
  );

  static TextStyle lbldrawerbtn =
      TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500);

  static TextStyle lblontestimonalname = const TextStyle(
    fontSize: 13,
    // color: Colors.green,
    fontWeight: FontWeight.w500,
  );
  static TextStyle lblonlinemandibiglistdetail = const TextStyle(
    fontSize: 14,
    color: Color(0xff7c7c7c),
    fontWeight: FontWeight.w500,
  );

  static TextStyle lbldateandtime = const TextStyle(
    fontSize: 10,
    color: ColorConstant.grey,
    fontWeight: FontWeight.w500,
  );

  static TextStyle lbldateanddetail = const TextStyle(
    fontSize: 13,
    color: ColorConstant.grey,
    // fontWeight: FontWeight.w500,
  );

  static TextStyle lbltestimonial = const TextStyle(
      fontSize: 14,
      color: Color(0xff8d8d8d),
      height: 1.2,
      fontWeight: FontWeight.normal
      // fontWeight: FontWeight.w500,
      );

  static TextStyle lbleyepopup =
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w500);

  static TextStyle lbleyepopupsecond = const TextStyle(
    fontSize: 13,
  );

  static TextStyle lblsummary = TextStyle(
    fontSize: Adaptive.sp(16),
    color: ColorConstant.grey,
    // fontWeight: FontWeight.w500,
  );

  static ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith((states) => ColorConstant.maingreen),
      textStyle: WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.white))));
  static ButtonStyle loginButtonStyle = ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith((states) => ColorConstant.whiteA700),
      textStyle: WidgetStatePropertyAll(TextStyle(
          fontWeight: FontWeight.bold, color: ColorConstant.maingreen)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(
          color: ColorConstant.maingreen,
          width: 1.2,
        ),
      ),
    ),);

  static ButtonStyle disabledButtonStyle = ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith((states) => ColorConstant.grey),
      textStyle: WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.white))));

  static ButtonStyle buttonStyleOutline = ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith((states) => Colors.transparent),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: ColorConstant.maingreen))));
  static TextStyle lbldrawer = TextStyle(
    fontSize: Adaptive.sp(16),
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle lblmoneybtn = TextStyle(
      fontSize: Adaptive.sp(16),
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static TextStyle lblgraphtext = TextStyle(
      fontSize: Adaptive.sp(16),
      fontWeight: FontWeight.w500,
      color: Colors.blue);

  static TextStyle lblwarehousename = TextStyle(
      color: ColorConstant.listsellerclr,
      // fontWeight: FontWeight.w500,
      fontSize: Adaptive.sp(16));

  static TextStyle lblnote = TextStyle(color: Colors.white, fontSize: 13);

  static TextStyle lbldata = TextStyle(fontSize: 24, color: Colors.grey);

  static TextStyle chosephoto = TextStyle(
      color: Colors.black,
      fontSize: Adaptive.sp(16),
      fontWeight: FontWeight.w400);
}
