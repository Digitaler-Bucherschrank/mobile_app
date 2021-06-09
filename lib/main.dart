import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digitaler_buecherschrank/api/authentication_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/themes.dart';
import 'package:digitaler_buecherschrank/utils/location.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/utils/utils.dart';
import 'package:digitaler_buecherschrank/widgets/inventory.dart';
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
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'api/api_service.dart';
import 'models/book_case.dart';
import 'widgets/gmap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadBookCases();
  await SharedPrefs().init();
  AuthenticationService();

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
      resizeToAvoidBottomInset: true,
      body: SlidingUpPanel(
        renderPanelSheet: false,
        padding: EdgeInsets.only(top: 30),
        backdropEnabled: true,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 6,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GMap(),
            ChangeNotifierProvider(
              create: (_) => SearchModel(),
              child: const Search(),
            ),
          ],
        ),
        panel: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 12),
                      Container(
                        height: 5,
                        width: 30,
                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(S.current.title, style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  )
              ),
            ),
            Expanded(
              flex: 20,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: new ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                  ),
                  child: Container(
                    color: Theme.of(context).cardColor.withOpacity(0.8),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: constraints.maxWidth * 0.04,
                              right: constraints.maxWidth * 0.04),
                          child: Column(mainAxisSize: MainAxisSize.min,children: [
                            SizedBox(height: constraints.maxHeight * 0.05),
                            Row(children: [
                              Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
                                    child: FractionallySizedBox(
                                        alignment: Alignment.center,
                                        widthFactor: 0.6,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text: S.current.label_welcome_user(SharedPrefs().user.username!),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .copyWith(
                                                    fontWeight:
                                                    FontWeight.w300))),
                                        )),
                                  ), fit: FlexFit.loose,)
                            ]),
                            SizedBox(height: constraints.maxHeight * 0.03),
                            // TODO: Ripple Effect for buttons
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InventoryList()));
                                },
                                leading: Icon(Icons.inventory_2),
                                title: Text(S.current.label_inventory),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.settings),
                                title: Text(S.current.label_settings),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.help),
                                title: Text(S.current.label_help),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.logout),
                                onTap: () {
                                  Utilities.logoutUser(null);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                },
                                title: Text(S.current.label_logout),
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
