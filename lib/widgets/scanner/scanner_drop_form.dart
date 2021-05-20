import 'package:digitaler_buecherschrank/generated/l10n.dart';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Container(
        child: Column(
          children: [
            getScannerWidget(context, _book, txt, txt2),
            getBookinfo(context, txt, txt2),
            getBookcase(markersId),
            GetFromWidget(from),
            ElevatedButton(
              style: Theme.of(context).outlinedButtonTheme.style,
              onPressed: () {
                print(_book);
                //postBook(_book);
                postIsbnAndSchrank(
                  _book.id,
                  _book.location,
                );
              },
              child: Text(S.of(context).label_scanner_confirm),
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
          ],
        ),
      ),
    );
  }
}

Widget getCustomContainer(String markersId, BuildContext context) {
  print("inside getCustomContainer");
  switch (selectedWidgetMarker) {
    case WidgetMarker.manuelly:
      {
        print(WidgetMarker.manuelly);
        return getManuellyWidget(context);
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
        title: new Text(S.of(context).label_dropbook),
      ),
      body: SingleChildScrollView(
        child: new Container(child: ContentWidget(markersId)),
      ),
    );
  }
}

class ContentWidget extends StatefulWidget {
  final String markersId;
  ContentWidget(this.markersId);
  @override
  State<StatefulWidget> createState() => ContentWidgetState(markersId);
}

class ContentWidgetState extends State<ContentWidget> {
  String markersId;
  ContentWidgetState(this.markersId);
  Color _scannpageColor = Colors.black;
  Color? _manualpageColor;
  Color? _inventorypageColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.qr_code_scanner_sharp),
              color: _scannpageColor,
              onPressed: () {
                print("isbn");
                print(selectedWidgetMarker);
                setState(() {
                  selectedWidgetMarker = WidgetMarker.isbn;
                  _manualpageColor = Theme.of(context).accentColor;
                  _scannpageColor = Colors.black;
                  _inventorypageColor = Theme.of(context).accentColor;
                });
                print(selectedWidgetMarker);
              },
            ),
            IconButton(
              icon: Icon(Icons.text_snippet),
              color: _manualpageColor == null
                  ? Theme.of(context).accentColor
                  : _manualpageColor,
              onPressed: () {
                print("manuell");
                setState(() {
                  selectedWidgetMarker = WidgetMarker.manuelly;

                  _scannpageColor = Theme.of(context).accentColor;
                  _manualpageColor = Colors.black;
                  _inventorypageColor = Theme.of(context).accentColor;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.inventory),
              color: _inventorypageColor == null
                  ? Theme.of(context).accentColor
                  : _inventorypageColor,
              onPressed: () {
                print("Inventar");
                setState(() {
                  selectedWidgetMarker = WidgetMarker.iventory;
                  _inventorypageColor = Colors.black;
                  _scannpageColor = Theme.of(context).accentColor;
                  _manualpageColor = Theme.of(context).accentColor;
                });
              },
            ),
          ],
        ),
        Container(
          child: getCustomContainer(markersId, context),
        )
      ],
    );
  }
}
