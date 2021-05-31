import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:digitaler_buecherschrank/api/api_service.dart';
import '../../models/book.dart';
import 'modules/scanner_logic.dart';
import 'modules/getManuellyWidget.dart';
import 'modules/getFrotpageModules.dart';

enum WidgetMarker { isbn, manuelly }
WidgetMarker selectedWidgetMarker = WidgetMarker.isbn;

class _GetISBNScannWidget extends StatefulWidget {
  final String markersId;
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

  ApiService apiService = new ApiService();

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
            getScannerWidget(context, _book, txt, txt2, apiService),
            getBookinfo(context, txt, txt2),
            getBookcase(markersId),
            ElevatedButton(
              style: Theme.of(context).outlinedButtonTheme.style,
              onPressed: () async {
                print(_book);
                apiService.donateBook(_book, false, null).then((value) {
                  print("donateBook: $value");
                });
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
  }
}

class DonateWidget extends StatefulWidget {
  final String markersId;
  DonateWidget(this.markersId);
  @override
  _DonateWidgetState createState() => _DonateWidgetState(markersId);
}

class _DonateWidgetState extends State<DonateWidget> {
  String markersId;
  _DonateWidgetState(this.markersId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(S.of(context).label_donate_book),
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
  Color? _scannpageColor;
  Color? _manualpageColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.qr_code_scanner_sharp),
              color: _scannpageColor == null
                  ? Theme.of(context).primaryColorLight
                  : _scannpageColor,
              onPressed: () {
                print("isbn");
                print(selectedWidgetMarker);
                setState(() {
                  selectedWidgetMarker = WidgetMarker.isbn;
                  _manualpageColor = Theme.of(context).primaryColorDark;
                  _scannpageColor = Theme.of(context).primaryColorLight;
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
                  _scannpageColor = Theme.of(context).primaryColorDark;
                  _manualpageColor = Theme.of(context).primaryColorLight;
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
