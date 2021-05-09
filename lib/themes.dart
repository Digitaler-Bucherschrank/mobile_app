import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: todo
// TODO: import better color schemes
ThemeData lightThemeData() {
  return ThemeData(
      primaryColor: Colors.blue,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.notoSansTextTheme(),
      accentColor: Colors.blue);
}

ThemeData darkThemeData() {
  return ThemeData(
      primaryColor: Colors.blue,
      textTheme: GoogleFonts.notoSansTextTheme(
          new TextTheme(button: TextStyle(color: Colors.black))),
      cardColor: Colors.black,
      brightness: Brightness.dark,
      shadowColor: Colors.transparent,
      accentColor: Colors.blue);
}
