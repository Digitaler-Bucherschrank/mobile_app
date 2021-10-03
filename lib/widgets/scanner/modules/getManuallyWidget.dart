import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../models/book.dart';
import 'scanner_logic.dart';

Widget getManuallyWidget(BuildContext context, double containerWidth) {
  TextEditingController scannerText = new TextEditingController();
  ApiService apiService = new ApiService();
  ManualBookData _manualBook = new ManualBookData();
  Book _book = new Book();
  _book.bookData = new VolumeData();
  return Column(
    children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(S.of(context).label_scanner_manual_explanation,
                style: Theme.of(context).textTheme.headline6),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: containerWidth,
                  child: TextField(
                    controller: scannerText,
                    decoration: InputDecoration(
                      labelText: "ISBN",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      fillColor: Theme.of(context).backgroundColor,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.qr_code_scanner),
                        onPressed: () {
                          scanBarcodeNormal().then((val) {
                            _book.id = val;
                            print(_book.id);
                            scannerText.text = val;
                          });
                        },
                      ),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    onSubmitted: (val) {
                      _book.id = val;
                      print(_book.id);
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: containerWidth,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: S.of(context).label_scanner_title,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      fillColor: Theme.of(context).backgroundColor,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    onSubmitted: (val) {
                      _book.title = val;
                      print(_book.title);
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: containerWidth,
              child: TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).label_scanner_autor,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  fillColor: Theme.of(context).backgroundColor,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                onSubmitted: (val) {
                  _book.author = val;
                  print(_book.author);
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: containerWidth,
              child: TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).label_scanner_subtitle,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  fillColor: Theme.of(context).backgroundColor,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                onSubmitted: (val) {
                  _book.bookData!.titleLong = val;
                  print(_book.bookData!.titleLong);
                  _manualBook.description = val;
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: containerWidth,
              child: TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).label_scanner_publisher,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  fillColor: Theme.of(context).backgroundColor,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                onSubmitted: (val) {
                  _book.bookData!.publisher = val;
                  print(_book.bookData!.publisher);
                  _manualBook.publisher = val;
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            // TODO: Natives Datumspicker verwenden ==> dann richtigen ISO String mitschicken
            Container(
              width: containerWidth,
              child: TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).label_scanner_publishedDate,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  fillColor: Theme.of(context).backgroundColor,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                onSubmitted: (val) {
                  _book.bookData!.datePublished = new DateTime.now();
                  print(_book.bookData!.datePublished);
                  _manualBook.publishedDate = val;
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: containerWidth,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Language",
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  fillColor: Theme.of(context).backgroundColor,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                onSubmitted: (val) {
                  _book.bookData!.language = val;
                  print(_book.bookData!.datePublished);
                  _manualBook.language = val;
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
          ],
        ),
      ),
      ElevatedButton(
        style: Theme.of(context).outlinedButtonTheme.style,
        onPressed: () {
          print(_book);
          Navigator.pop(context);
          apiService.donateBook(_book, true, _manualBook).then((value) {
            print("donateBook: $value");
          });
        },
        child: Text(
          S.of(context).label_scanner_confirm,
        ),
      ),
    ],
  );
}
