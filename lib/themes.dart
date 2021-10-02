import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: import better color schemes
// Basically all of our themes with some tweaks so the UI is more consistent (rounded corners)
ThemeData lightThemeData() {
  return FlexColorScheme.light(
          colors: FlexSchemeColor.from(
              primary: Color(0xFF423C3A), secondary: Color(0xFF1890C9)),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          appBarStyle: FlexAppBarStyle.primary)
      .toTheme
      .copyWith(
          bottomSheetTheme: new BottomSheetThemeData(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          )),
          cardTheme: CardTheme(
            margin: EdgeInsets.all(4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          textTheme: GoogleFonts.notoSansTextTheme());
  /*return ThemeData(
      colorScheme: new ColorScheme.light(
          primary: Color(0xFF1890C9), secondary: Color(0xFF423C3A)),
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      bottomSheetTheme: new BottomSheetThemeData(
          backgroundColor: Colors.black,
          modalBackgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          )),
      textTheme: GoogleFonts.notoSansTextTheme(),
      accentColor: Colors.blue);*/
}

ThemeData darkThemeData() {
  return FlexColorScheme.dark(
          colors: FlexSchemeColor.from(
                  primary: Color(0xFF423C3A), secondary: Color(0xFF1890C9))
              .toDark(),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          appBarStyle: FlexAppBarStyle.primary)
      .toTheme
      .copyWith(
        bottomSheetTheme: new BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
        ),
        cardTheme: CardTheme(
          margin: EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        inputDecorationTheme: ThemeData.dark().inputDecorationTheme,
        textTheme: GoogleFonts.notoSansTextTheme(
          new TextTheme(
            button: TextStyle(color: Colors.black),
          ),
        ),
      );
}
