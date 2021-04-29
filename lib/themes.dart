import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: import better color schemes
ThemeData lightThemeData(BuildContext context){
  return ThemeData(
  primaryColor: Colors.blue,
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.notoSansTextTheme(
    Theme.of(context).textTheme,
  ),
  accentColor: Colors.blue);
}


ThemeData darkThemeData(BuildContext context){
  return ThemeData(
      primaryColor: Colors.blue,
      textTheme: GoogleFonts.notoSansTextTheme(
        new TextTheme(button: TextStyle(color: Colors.black54))
      ),
      cardColor: Colors.black54,
      brightness: Brightness.dark,
      accentColor: Colors.blue);
}