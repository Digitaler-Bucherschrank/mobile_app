import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

// Platform messages are asynchronous, so we initialize in an async method.
Future scanBarcodeNormal() async {
  String scanBarcode = "";
  String barcodeScanRes;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.BARCODE);
    print(barcodeScanRes);
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
  } catch (e) {
    barcodeScanRes = e;
  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.

  scanBarcode = barcodeScanRes;

  return (scanBarcode);
}

Future getInfo() async {
  const _url = "";
  return;
}

Future postIsbn(String isbn) async {
  const _url =
      "https://test-3eea7-default-rtdb.europe-west1.firebasedatabase.app/";
  var response = await http.post(_url,
      body: json.encode({
        'isbn': isbn,
      }));
  print(response);
  return;
}
