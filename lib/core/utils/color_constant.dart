import 'package:flutter/material.dart';

extension ColorConstant on ColorScheme {
  static Color gray5001 = fromHex('#fff6f4');

  static Color greenanecbar = fromHex('#00B140');

  static Color whiteA7007e = fromHex('#7effffff');

  static Color blueGray30077 = fromHex('#77929db0');

  static Color blueA200 = fromHex('#3b82f6');

  static Color black9003f = fromHex('#3f000000');

  static Color whiteA70099 = fromHex('#99ffffff');

  static Color whiteA70097 = fromHex('#97ffffff');

  static Color whiteA700Ad = fromHex('#adffffff');

  static Color blue50Bc = fromHex('#bcd9e4ff');

  static Color blueGray900 = fromHex('#263238');

  static Color orangeA200 = fromHex('#ffae34');

  static Color blueGray100 = fromHex('#d9d9d9');

  static Color blueGray300 = fromHex('#929db0');

  static Color blue = fromHex('#0F31BA');

  static Color orangeA20001 = fromHex('#ffad34');

  static Color yellow40083 = fromHex('#83ffe355');

  static Color orangeA20087 = fromHex('#87ffae34');

  static Color tealA100 = fromHex('#bbffe2');

  static Color black9000c = fromHex('#0c000000');

  static Color blue50 = fromHex('#d7e3ff');

  static Color gray10002 = fromHex('#f2f4f8');

  static Color black90011 = fromHex('#11000000');
  static Color line = fromHex('#3D3F5A');

  static Color black90099 = fromHex('#99000000');

  static Color gray10001 = fromHex('#eff4ff');

  static Color blueGray100A5 = fromHex('#a5d9d9d9');

  static Color blue100 = fromHex('#c6d7ff');

  static Color black90019 = fromHex('#19000000');

  static Color blueGray40001 = fromHex('#888888');

  static Color whiteA700 = fromHex('#ffffff');

  static Color indigo600 = fromHex('#234fb3');

  static Color deepOrange50 = fromHex('#ffe7e6');

  static Color drakdeposit = fromHex('#292C3E');

  static Color blueGray50 = fromHex('#eff1f4');

  static Color blueGray10087 = fromHex('#87d4d0d0');

  static Color blueGray30099 = fromHex('#99929db0');

  static Color blueA100 = fromHex('#739eff');

  static Color red500 = fromHex('#fb3f25');

  static Color limitclr = fromHex('#F3F5F9');
  static Color limitclrdark = fromHex('#272949');

  static const Color grey = Color(0xff7C7C7C);
  static const Color buyerbtn = Color(0xfff8ab59);
  static const Color bgcolor = Colors.white;
  static const Color maingreen = Color(0xff275135);
  static const Color mainlistgrayclr = Color(0xffebebeb);
  static const Color listsellerclr = Colors.amber;
  static const Color listdivaderclr = Color(0xffdadada);
  static const Color mainwhite = Color(0xffffffff);
  static const Color darkColor = Color(0xff040517);
  static const Color listdarkColor = Color(0xff1A1B2C);
  static const Color orderexecute = Color(0xffFFFFFF);
  static const Color bottmbuy = Color(0xff1A1B2C);
  static const Color lightwhite = Color(0xffEFF4FF);
  static const Color progrey = Color(0xff929DB0);
  static const Color buygreen = Color(0xff0EDA84);
  static const Color plusiconbtn = Color(0xff474A61);
  static const Color plusiconlight = Color(0xffEFF1F4);
  static const Color twotextfieldclr = Color(0xffF6F6F6);
  static const Color twotextfielddark = Color(0xff040517);
  static const Color serchlst = Color(0xff1A1B2C);

  static const Color bluenfo = Color(0xff0F31BA);
  static const Color graynfo = Color(0xff9BA5B7);

  // chekbox btns theme
  static const Color chekbtn = Color(0xff626378);
  static const Color cheklightbtn = Color(0xffD9D9D9);

  // Watchlist fore open high low close colors.
  static const Color openclr = Color(0xff858D9B);
  static const Color openlightclr = Color(0xff565E6B);
  static const Color openvalueclr = Color(0xff636783);
  static const Color openvaluelightclr = Color(0xff000000);

  // Limit and complete not cliked btns
  static const Color copleteclr = Color(0xff275135);
  static const Color copleteclrlight = Color(0xffBBFFE2);
  static const Color copletetxt = Color(0xff27DA8F);
  static const Color tradesheet = Color(0xff424972);
  static const Color tradesheetlight = Color(0xffDCE7FF);
  static const Color searchmcxclr = Color(0xffD9E5FF);
  static const Color searchredclr = Color(0xffFFE8E7);
  static const Color newblueclor = Color(0xff0F31BA);
  static const Color scaffoldclr = Color(0xffF6F9FF);

  //  //#040517
  static Color greenA400 = fromHex('#0dd984');

  static Color black900 = fromHex('#000000');

  static Color blueA20002 = fromHex('#568aff');

  static Color blueA20001 = fromHex('#407bff');

  static Color deepOrange600 = fromHex('#ff3d22');

  static Color blue5001 = fromHex('#dce7ff');

  static Color deepOrange400 = fromHex('#ff6550');

  static Color gray700 = fromHex('#565d6b');

  static Color gray500 = fromHex('#9097a2');

  static Color blueGray400 = fromHex('#7d889c');

  static Color whiteA700A2 = fromHex('#a2ffffff');

  static Color gray900 = fromHex('#111111');

  static Color teal50 = fromHex('#daffef');

  static Color gray300 = fromHex('#e0e0e0');
  static Color lightunseletedtab = fromHex('#739EFF');

  static Color gray100 = fromHex('#f6f5f5');

  static Color tealA400 = fromHex('#27d98e');

  static Color indigo100 = fromHex('#b8c7e1');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
