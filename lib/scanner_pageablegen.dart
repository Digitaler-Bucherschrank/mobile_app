import 'package:digitaler_buecherschrank/scanner.dart';
import 'package:flutter/material.dart';

class ScannerPageablegen extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPageablegen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Buch ablegen"),
      ),
      body: new Container(
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  child: Text('Barcode scannen oder ISBN eingeben!'),
                ),
                Scanner("ablegen"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
