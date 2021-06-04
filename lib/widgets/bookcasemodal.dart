import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:digitaler_buecherschrank/widgets/scanner/scanner_drop_form.dart';
import 'package:digitaler_buecherschrank/widgets/scanner/scanner_pickup_form.dart';
import 'package:flutter/material.dart';
import 'package:intl_utils/intl_utils.dart';

import 'book_info.dart';
import 'scanner/donatebook.dart';

class BookCaseModal extends StatelessWidget {
  final BookCase bookcase;
  BookCaseModal(this.bookcase);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            title: Text(
              '${bookcase.title}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
            subtitle: Text('${bookcase.address}'),
          ),
          ElevatedButton(
              child: Text(S.of(context).label_show_books),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ScannerPickupForm('${bookcase.iId!.oid}')),
                );
              }),
          ElevatedButton(
              child: Text(S.of(context).label_dropbook),
              onPressed: () {
                print('${bookcase.iId!.oid}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ScannerDropForm('${bookcase.iId!.oid}')),
                );
              }),
          ElevatedButton(
              child: Text(S.of(context).label_donate_book),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DonateWidget('${bookcase.iId!.oid}')),
                );
              }),
          ElevatedButton(
            child: Text(S.of(context).label_close_sheet),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}