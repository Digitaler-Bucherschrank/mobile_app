import 'package:flutter/material.dart';

import '../../models/book.dart';
import 'modules/scanner_logic.dart';
import 'modules/getManuellyWidget.dart';
import 'modules/getInventoryWidget.dart';
import 'modules/getFrotpageModules.dart';

enum WidgetMarker { isbn, manuelly, iventory }
WidgetMarker selectedWidgetMarker = WidgetMarker.isbn;
String from = "";

// ignore: must_be_immutable
class _GetISBNScannWidget extends StatefulWidget {
  String markersId;
  _GetISBNScannWidget(this.markersId);
  @override
  _GetISBNScannWidgetState createState() => _GetISBNScannWidgetState(markersId);
}

class _GetISBNScannWidgetState extends State<_GetISBNScannWidget> {
  String markersId;
  _GetISBNScannWidgetState(this.markersId);

  TextEditingController txt = TextEditingController();
  TextEditingController txt2 = TextEditingController();

  Book _book = new Book();
  @override
  void initState() {
    super.initState();
    _book.bookData = new BookData();
    _book.bookData!.volumeInfo = new VolumeInfo();
    _book.location = markersId;
  }

  Map bookInfo = {
    'name': 'Titel',
    'author': 'Autor',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Container(
        child: Column(
          children: [
            getScannerWidget(_book, bookInfo, txt, txt2),
            getBookinfo(txt, txt2),
            getBookcase(markersId),
            GetFromWidget(from),
            OutlinedButton(
              onPressed: () {
                print(_book);
                //postBook(_book);
                postIsbnAndSchrank(
                  _book.id,
                  _book.location,
                );
              },
              child: Text("Bestätigen"),
            )
          ],
        ),
      ),
    );
  }
}

Widget getCustomContainer(String markersId) {
  print("inside getCustomContainer");
  switch (selectedWidgetMarker) {
    case WidgetMarker.manuelly:
      {
        print(WidgetMarker.manuelly);
        return getManuellyWidget();
      }
    case WidgetMarker.isbn:
      {
        print(WidgetMarker.isbn);
        return _GetISBNScannWidget(markersId);
      }
    case WidgetMarker.iventory:
      {
        print(WidgetMarker.iventory);
        return getInventoryWidget();
      }
  }
}

// ignore: must_be_immutable
class ScannerDropForm extends StatefulWidget {
  String markersId;
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
        title: new Text("Buch ablegen"),
      ),
      body: SingleChildScrollView(
        child: new Container(child: ContentWidget(markersId)),
      ),
    );
  }
}

// ignore: must_be_immutable
class ContentWidget extends StatefulWidget {
  String markersId;
  ContentWidget(this.markersId);
  @override
  State<StatefulWidget> createState() => ContentWidgetState(markersId);
}

class ContentWidgetState extends State<ContentWidget> {
  String markersId;
  ContentWidgetState(this.markersId);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: () {
                print("isbn");
                print(selectedWidgetMarker);
                setState(() {
                  selectedWidgetMarker = WidgetMarker.isbn;
                });
                print(selectedWidgetMarker);
              },
              child: Text(
                "Normal Scann",
                style: TextStyle(color: Colors.black12),
              ),
            ),
            TextButton(
              onPressed: () {
                print("manuell");
                setState(() {
                  selectedWidgetMarker = WidgetMarker.manuelly;
                });
              },
              child: Text(
                "manuelle Eingabe",
                style: TextStyle(color: Colors.black12),
              ),
            ),
            TextButton(
              onPressed: () {
                print("Inventar");
                setState(() {
                  selectedWidgetMarker = WidgetMarker.iventory;
                });
              },
              child: Text(
                "Inventar Auswahl",
                style: TextStyle(color: Colors.black12),
              ),
            ),
          ],
        ),
        Container(
          child: getCustomContainer(markersId),
        )
      ],
    );
  }
}
