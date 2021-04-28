import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/utils/location.dart';
import 'package:digitaler_buecherschrank/search/search.dart';
import 'package:digitaler_buecherschrank/search/search_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'drawer.dart';
import 'gmap.dart';
import 'models/book_case.dart';


void main() {
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  var location = new Location();

  location.onLocationChanged.listen((l) => {
    LocationProvider.updateLocation(l)
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
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
        splashIconSize: 256,
        splash: Image.asset('assets/icons/splash.png'),
        screenFunction: () async{
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
      var perm = location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          GMap(),
          ChangeNotifierProvider(
            create: (_) => SearchModel(),
            child: const Search(),
          ),
        ],
      ),
    );
  }
}
