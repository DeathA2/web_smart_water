import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig{
  // static Color primaryColor = const Color(0xff3459e6);
  static Color primaryColor = const Color(0xff2C3E50);
  static Color hoverTextColor = const Color(0xff4a80ff);
  static Color secondColor = const Color(0xffD0A554);
  static Color backgroundColor =Colors.white;
  static Color background2 =  Color(0xfff5f5f5);
  static Color hoverColor =  const Color(0xfff2f7f7);
  static Color successColor = Color(0xFFaaf683);
  static Color errorColor = Color(0xFFee6055);
  static Color warningColor = Color(0xFFffd97d);
  static Color greenColor = Colors.green;
  static Color redColor = Colors.red;
  static Color textColor = Colors.black;
  static Color whiteColor = Colors.white;
  static Color whiteTextColor = Colors.white.withOpacity(0.8);
  static Color greyColor = Colors.grey;
  static Color blackColor = Colors.black;
  static Color buttonPrimary = Colors.blueAccent;
  static Color fillInput = const Color.fromRGBO(255, 255, 255, 0.6);
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(vertical: 4,horizontal: 10);

  static double get headerSize => 20;
  static double get borderRadius => 10;

  static double get defaultSize => 14;
  static double get labelSize => 14;
  static double get smallSize => 14;

  static double get titleSize => 18;

  static String fontFamily = 'Roboto';
  static double defaultHorPadding = 10;
  static double defaultPadding = 20;
  static double defaultVerPadding = 20;
  static double lineHigh = 1.5;
  static TextStyle defaultStyle = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: ThemeConfig.defaultSize,
          color: ThemeConfig.textColor,
          height: 1.5
      )
  );
  static TextStyle titleStyle = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: ThemeConfig.titleSize,
          color: ThemeConfig.textColor,
          height: 1.5
      )
  );

  static TextStyle headerStyle = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: ThemeConfig.headerSize,
          color: ThemeConfig.textColor,
          height: 1.5
      )
  );

  static TextStyle smallStyle = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: ThemeConfig.smallSize,
          color: ThemeConfig.textColor,
          height: 1.5
      )
  );

  static TextStyle labelStyle = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: ThemeConfig.labelSize,
          color: ThemeConfig.textColor,
          height: 1.5
      )
  );
}