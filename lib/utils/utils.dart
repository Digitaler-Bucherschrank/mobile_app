import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:path_provider/path_provider.dart';

/// Utilities for some use cases dart hasn't implemented yet
class Utilities{
  static bool containsIgnoreCase(String string1, String string2) {
    return string1.toLowerCase().contains(string2.toLowerCase());
  }

  static Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  static Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if(appDir.existsSync()){
      appDir.deleteSync(recursive: true);
    }
  }

  static Future<void> logoutUser(BuildContext? context) async {
    await _deleteAppDir();
    await _deleteCacheDir();
    SharedPrefs().clearSettings();

    if(context != null){
      Phoenix.rebirth(context);
    }
  }
}