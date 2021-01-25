import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Scanner extends StatefulWidget {
  final String a;
  Scanner(this.a);
  @override
  _StateScanner createState() => _StateScanner(a);
}

class _StateScanner extends State<Scanner> {
  String a;
  _StateScanner(this.a);

  String _scanBarcode = "";

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
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
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    print(a + _scanBarcode);
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 200,
              child: TextField(
                onSubmitted: (String str) {
                  setState(() {
                    _scanBarcode = str;
                  });
                  print(a + _scanBarcode);
                },
              ),
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: Icon(Icons.qr_code_scanner),
              tooltip: "Scannen",
              onPressed: scanBarcodeNormal,
            )
          ],
        ),
      ],
    );
  }
}
