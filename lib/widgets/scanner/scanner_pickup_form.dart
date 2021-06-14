import 'package:digitaler_buecherschrank/DetailPage.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'modules/getInventoryWidget.dart';

class ScannerPickupForm extends StatefulWidget {
  final String markersId;
  ScannerPickupForm(this.markersId);
  @override
  _ScannerPickupFormState createState() => _ScannerPickupFormState(markersId);
}

class _ScannerPickupFormState extends State<ScannerPickupForm> {
  String markersId;
  _ScannerPickupFormState(this.markersId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(S.of(context).label_show_books),
        ),
        body: SingleChildScrollView(
          child: InkWell(onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage(markersId)),
            );
            new Container(
              child: getBookCaseInventoryWidget(markersId),
            );
          }),
        ));
  }
}
