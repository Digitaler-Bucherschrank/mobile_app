import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:flutter/material.dart';

import 'modules/getInventoryWidget.dart';

class ScannerPickupForm extends StatefulWidget {
  final BookCase bookcase;

  ScannerPickupForm(this.bookcase);

  @override
  _ScannerPickupFormState createState() => _ScannerPickupFormState(bookcase);
}

class _ScannerPickupFormState extends State<ScannerPickupForm> {
  BookCase bookcase;

  _ScannerPickupFormState(this.bookcase);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(S.of(context).label_show_books),
      ),
      body: SingleChildScrollView(
        child: new Container(
            child: getBookCaseInventoryWidget('${bookcase.iId!.oid}')),
      ),
    );
  }
}
