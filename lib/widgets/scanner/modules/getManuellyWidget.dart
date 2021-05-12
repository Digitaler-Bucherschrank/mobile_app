import 'package:flutter/material.dart';
import '../../../models/book.dart';
import 'scanner_logic.dart';

Widget getManuellyWidget() {
  TextEditingController scannerText = new TextEditingController();
  Book _book = new Book();
  _book.bookData = new BookData();
  _book.bookData!.volumeInfo = new VolumeInfo();
  return Container(
    width: 300,
    child: Column(
      children: [
        Card(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: scannerText,
                  decoration: InputDecoration(labelText: "ISBN"),
                  onSubmitted: (val) {
                    _book.id = val;
                    print(_book.id);
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.qr_code_scanner),
                tooltip: "Scannen",
                onPressed: () {
                  scanBarcodeNormal().then((val) {
                    _book.id = val;
                    print(_book.id);
                    scannerText.text = val;
                  });
                },
              ),
            ],
          ),
        ),
        Card(
          child: TextField(
            decoration: InputDecoration(labelText: "Autor"),
            onSubmitted: (val) {
              _book.author = val;
              print(_book.author);
            },
          ),
        ),
        Card(
          child: TextField(
            decoration: InputDecoration(labelText: "Titel"),
            onSubmitted: (val) {
              _book.title = val;
              print(_book.title);
            },
          ),
        ),
        Card(
          child: TextField(
            decoration: InputDecoration(labelText: "Untertitel"),
            onSubmitted: (val) {
              _book.bookData!.volumeInfo!.subtitle = val;
              print(_book.bookData!.volumeInfo!.subtitle);
            },
          ),
        ),
        Card(
          child: TextField(
            decoration: InputDecoration(labelText: "Verlag"),
            onSubmitted: (val) {
              _book.bookData!.volumeInfo!.publisher = val;
              print(_book.bookData!.volumeInfo!.publisher);
            },
          ),
        ),
        Card(
          child: TextField(
            decoration: InputDecoration(labelText: "Erscheinungsdatum"),
            onSubmitted: (val) {
              _book.bookData!.volumeInfo!.publishedDate = val;
              print(_book.bookData!.volumeInfo!.publishedDate);
            },
          ),
        ),
      ],
    ),
  );
}
