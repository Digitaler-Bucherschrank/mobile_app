import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: import better color schemes
ThemeData lightThemeData(){
  return ThemeData(
  colorScheme:new ColorScheme.light(
      primary: Color(0xFF1890C9),
      secondary:  Color(0xFF423C3A)
  ),
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  bottomSheetTheme: new BottomSheetThemeData(backgroundColor: Colors.black, modalBackgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  ),)),
  textTheme: GoogleFonts.notoSansTextTheme(),
  accentColor: Colors.blue);
}


ThemeData darkThemeData(){
  return FlexColorScheme.dark(
    colors: FlexSchemeColor.from(primary: Color(0xFF423C3A), secondary: Color(0xFF1890C9)).toDark(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    surfaceStyle: FlexSurface.strong,
  ).toTheme.copyWith(bottomSheetTheme: new BottomSheetThemeData( shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  ),)),
  textTheme: GoogleFonts.notoSansTextTheme(
      new TextTheme(button: TextStyle(color: Colors.black))
  ));
  return ThemeData(
      colorScheme: new ColorScheme.dark(
        primary: Color(0xFF1890C9),
        secondary: Color(0xFF423C3A),
      ),
      textTheme: GoogleFonts.notoSansTextTheme(
        new TextTheme(button: TextStyle(color: Colors.black))
      ),
      bottomSheetTheme: new BottomSheetThemeData( shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),)),
      brightness: Brightness.dark,

      shadowColor: Colors.transparent);
}