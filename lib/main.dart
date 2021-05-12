import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/themes.dart';
import 'package:digitaler_buecherschrank/utils/location.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/widgets/search/search.dart';
import 'package:digitaler_buecherschrank/widgets/search/search_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'widgets/drawer.dart';
import 'widgets/gmap.dart';
import 'models/book_case.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadBookCases();
  await SharedPrefs().init();

  runApp(MyApp());

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
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      themeMode: ThemeMode.system,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: MyHomePage()
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

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
