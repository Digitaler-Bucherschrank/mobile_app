import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'modules/getInventoryWidget.dart';

class ScannerDropForm extends StatefulWidget {
  final String markersId;
  ScannerDropForm(this.markersId);
  @override
  _ScannerDropFormState createState() => _ScannerDropFormState(markersId);
}

class _ScannerDropFormState extends State<ScannerDropForm> {
  String markersId;
  _ScannerDropFormState(this.markersId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(S.of(context).label_dropbook),
      ),
      body: SingleChildScrollView(
        child: new Container(child: getUserInventoryWidget()),
      ),
    );
  }
}
