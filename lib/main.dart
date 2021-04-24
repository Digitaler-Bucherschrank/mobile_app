import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:digitaler_buecherschrank/gmap.dart';
import 'package:digitaler_buecherschrank/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:location/location.dart';

import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'models/book_case.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var location = new Location();

  location.onLocationChanged
      .listen((l) => {LocationProvider.updateLocation(l)});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: AnimatedSplashScreen.withScreenFunction(
        duration: 1500,
        splash: Image.asset('assets/icons/splash.png', scale: 0.5),
        screenFunction: () async {
          await loadBookCases();
          return MyHomePage();
        },
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.blue,
        centered: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _getLocationPermission();
    FlutterDisplayMode.setHighRefreshRate();
  }

  void _getLocationPermission() async {
    var location = new Location();
    try {
      // ignore: unused_local_variable
      var perm = location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GMap();

    /*FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset('assets/icons/icon.png'),
            ),
          );
        } else {
          return GMap();
        }
      },
    ); */
  }
}
