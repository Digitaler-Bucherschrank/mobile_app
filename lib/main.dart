import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digitaler_buecherschrank/api/authentication_service.dart';
// ignore: unused_import
import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/themes.dart';
import 'package:digitaler_buecherschrank/utils/location.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
// ignore: unused_import
import 'package:digitaler_buecherschrank/widgets/login.dart';
import 'package:digitaler_buecherschrank/widgets/search/search.dart';
import 'package:digitaler_buecherschrank/widgets/search/search_model.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

// ignore: unused_import
import 'config.dart';
import 'api/api_service.dart';
import 'models/book_case.dart';
import 'widgets/gmap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadBookCases();
  await SharedPrefs().init();
  //AuthenticationService();

  runApp(MyApp());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var location = new Location();

  location.onLocationChanged
      .listen((l) => {LocationProvider.updateLocation(l)});
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    var isLoggedIn = SharedPrefs().isLoggedIn;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(),
      navigatorKey: globalKey,
      darkTheme: darkThemeData(),
      themeMode: ThemeMode.system,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: isLoggedIn ? MyHomePage() : LoginScreen(),
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
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
    FlutterDisplayMode.setHighRefreshRate();

    // Show the user a dialog if offline and warning about limited functionality
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(S.current.error_connectivity_title),
              content: Text(S.current.error_connectivity_desc),
              actions: [
                TextButton(
                  child: Text(S.current.dialog_ok_button),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _getLocationPermission() async {
    var location = new Location();
    try {
      // ignore: unused_local_variable
      var perm = location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }

    // Be sure to cancel subscription after you are done
    @override
    dispose() {
      super.dispose();

      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ExpandableBottomSheet(
            background: GMap(),
            persistentContentHeight: 0,
            persistentHeader: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 6,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    )),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 12),
                    Container(
                      height: 5,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Color(200),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          S.current.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 16)
                  ],
                )),
            expandableContent: Container(
              height: 500,
              color: Colors.green,
              child: Center(
                child: Text('Content'),
              ),
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => SearchModel(),
            child: const Search(),
          ),
        ],
      ),
    );
  }
}
