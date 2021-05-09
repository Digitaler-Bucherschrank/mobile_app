import 'dart:convert';

import 'package:digitaler_buecherschrank/models/user.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SharedPrefs {
  static StreamingSharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await StreamingSharedPreferences.instance;
  }
  
  User get user => User.fromJson(json.decode(_sharedPrefs!.getString("user", defaultValue: "{}").toString()));

  set user(User user){
    _sharedPrefs!.setString("user", json.encode(user));
  }

  String get language => _sharedPrefs!.getString("language", defaultValue: "de").toString();

  set language(String language){
    _sharedPrefs!.setString("language", language);
  }
}