import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SharedPrefs {
  static StreamingSharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await StreamingSharedPreferences.instance;
  }
}