import 'dart:convert';

import 'package:digitaler_buecherschrank/models/user.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SharedPrefs {
  static StreamingSharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await StreamingSharedPreferences.instance;
  }

  User get user => User.fromJson(json
      .decode(_sharedPrefs!.getString("user", defaultValue: "{}").getValue()));

  set user(User user) {
    _sharedPrefs!.setString("user", json.encode(user));
  }

  // Checks if clientID has been set already, if not then generate one
  String get clientId {
    var id = _sharedPrefs!.getString("clientId", defaultValue: "").getValue();
    print(id);

    if (id == "") {
      var rnd = Uuid().v4();
      _sharedPrefs!.setString("clientId", rnd);
      return rnd;
    } else {
      return id;
    }
  }

  bool get isLoggedIn =>
      _sharedPrefs!.getBool("loggedIn", defaultValue: false).getValue();

  set isLoggedIn(bool loggedIn) {
    _sharedPrefs!.setBool("loggedIn", loggedIn);
  }

  bool get finishedIntro =>
      _sharedPrefs!.getBool("finishedIntro", defaultValue: false).getValue();

  set finishedIntro(bool finishedIntro) {
    _sharedPrefs!.setBool("finishedIntro", finishedIntro);
  }

  bool get acceptedDataDeclaration => _sharedPrefs!
      .getBool("acceptedDataDeclaration", defaultValue: false)
      .getValue();

  set acceptedDataDeclaration(bool acceptedDataDeclaration) {
    _sharedPrefs!.setBool("acceptedDataDeclaration", acceptedDataDeclaration);
  }

  String get language =>
      _sharedPrefs!.getString("language", defaultValue: "de").getValue();

  set language(String language) {
    _sharedPrefs!.setString("language", language);
  }

  clearSettings() {
    //clears client related data
    _sharedPrefs?.remove("user");
    _sharedPrefs?.remove("loggedIn");
    _sharedPrefs?.remove("user");
    _sharedPrefs?.remove("client_id");
  }
}
