import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:digitaler_buecherschrank/widgets/scanner/scanner_drop_form.dart';
import 'package:digitaler_buecherschrank/widgets/scanner/scanner_pickup_form.dart';
import 'package:flutter/material.dart';

import 'book_info.dart';

class BookCaseModal extends StatelessWidget {
  final BookCase bookcase;
  BookCaseModal(this.bookcase);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Text('${bookcase.title}'),
            ),
            ListTile(
              title: Text('${bookcase.address}'),
            ),
            ElevatedButton(
                child: const Text("Siehe Bücher"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookInfo()),
                  );
                }),
            ElevatedButton(
              child: const Text('Close BottomSheet'),
              onPressed: () => Navigator.pop(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                    child: Text(S.of(context).label_dropbook),
                    onPressed: () {
                      print('${bookcase.iId!.oid}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScannerDropForm(
                                '${bookcase.iId!.oid}')),
                      );
                    }),
                ElevatedButton(
                    child: Text(S.of(context).label_borrowbook),
                    onPressed: () {
                      print('${bookcase.iId!.oid}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ScannerPickupForm(
                                      '${bookcase.iId!.oid}')));
                    }),
              ],
            ),
          ],
        ),
      );
  }
}
