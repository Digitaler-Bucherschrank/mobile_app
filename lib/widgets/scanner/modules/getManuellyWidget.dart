import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../models/book.dart';
import 'scanner_logic.dart';
import 'package:digitaler_buecherschrank/api/api_service.dart';

Widget getManuellyWidget(BuildContext context) {
  TextEditingController scannerText = new TextEditingController();
  ApiService apiService = new ApiService();
  Book _book = new Book();
  _book.bookData = new BookData();
  _book.bookData!.volumeInfo = new VolumeInfo();
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
                  width: 300,
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
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).label_scanner_title,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: 300,
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
              width: 300,
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
                  _book.bookData!.volumeInfo!.subtitle = val;
                  print(_book.bookData!.volumeInfo!.subtitle);
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: 300,
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
                  _book.bookData!.volumeInfo!.publisher = val;
                  print(_book.bookData!.volumeInfo!.publisher);
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: 300,
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
                  _book.bookData!.volumeInfo!.publishedDate = val;
                  print(_book.bookData!.volumeInfo!.publishedDate);
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
          apiService.donateBook(_book, false, null).then((value) {
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
