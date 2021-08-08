import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:flutter/material.dart';

import 'modules/getInventoryWidget.dart';

class ScannerDropForm extends StatefulWidget {
  final BookCase bookcase;

  ScannerDropForm(this.bookcase);

  @override
  _ScannerDropFormState createState() => _ScannerDropFormState(bookcase);
}

class _ScannerDropFormState extends State<ScannerDropForm> {
  BookCase bookcase;

  _ScannerDropFormState(this.bookcase);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(S.of(context).label_dropbook),
      ),
      body: SingleChildScrollView(
        child: new Container(
          child: FutureBuilder(
              future: getUserInventoryWidget(bookcase),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Text("");
                } else {
                  return snapshot.data;
                }
              }),
        ),
      ),
    );
  }
}
