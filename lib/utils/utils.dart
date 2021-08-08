import 'dart:convert';

import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restart_app/restart_app.dart';

/// Utilities for some use cases dart hasn't implemented yet
class Utilities {
  static List<Book> parseBooks(data) {
    var parsed = jsonDecode(data)
        .cast<Map<String, dynamic>>()
        .map<Book>((Map<String, dynamic> json) {
      final tempMarker = Book.fromJson(json);
      return tempMarker;
    }).toList();

    return parsed;
  }

  static Map<String, List<Book>> parseInventory(data) {
    var parsedData = jsonDecode(data);

    var parsedDonatedInv = parsedData["donated"]
        .cast<Map<String, dynamic>>()
        .map<Book>((Map<String, dynamic> json) {
      final tempMarker = Book.fromJson(json);
      return tempMarker;
    }).toList();

    var parsedBorrowedInv = parsedData["borrowed"]
        .cast<Map<String, dynamic>>()
        .map<Book>((Map<String, dynamic> json) {
      final tempMarker = Book.fromJson(json);
      return tempMarker;
    }).toList();

    return {"donated": parsedDonatedInv, "borrowed": parsedBorrowedInv};
  }

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

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  static Future<void> logoutUser(BuildContext? context) async {
    await _deleteAppDir();
    await _deleteCacheDir();
    SharedPrefs().clearSettings();

    if (context != null) {
      Restart.restartApp();
    }
  }
}
