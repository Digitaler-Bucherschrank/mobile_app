import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';

import 'package:flutter/material.dart';

Widget getScannerScreen(
    BuildContext context, Book _book, TextEditingController scannerText) {
  return Scaffold(
    appBar: AppBar(title: Text('Barcode Scanner')),
    body: BarcodeCamera(
      types: const [BarcodeType.ean8, BarcodeType.ean13, BarcodeType.code128],
      resolution: Resolution.hd720,
      framerate: Framerate.fps30,
      mode: DetectionMode.pauseVideo,
      onScan: (code) {
        if (_book.isbn != null) {
          print('old value of isbn before update: ' + _book.isbn!);
        }
        _book.isbn = code.value;
        print('updated isbn: ' + _book.isbn!);
        Navigator.pop(context);
      },
    ),
  );
}
