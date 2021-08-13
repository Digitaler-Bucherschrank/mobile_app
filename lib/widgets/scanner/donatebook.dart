import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../models/book.dart';
import 'modules/getFrotpageModules.dart';
import 'modules/getManuallyWidget.dart';

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
    _book.bookData = new VolumeData();
    _book.location = markersId;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Container(
        child: Column(
          children: [
            getScannerWidget(context, _book, txt, txt2, apiService),
            getBookcase(markersId),
            ElevatedButton(
              style: Theme.of(context).outlinedButtonTheme.style,
              onPressed: () async {
                print(_book);
                Navigator.pop(context);
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

class DonateWidget extends StatefulWidget {
  final String markersId;

  DonateWidget(this.markersId);

  @override
  _DonateWidgetState createState() => _DonateWidgetState(markersId);
}

class _DonateWidgetState extends State<DonateWidget>
    with TickerProviderStateMixin {
  TabController? _tabController;
  String markersId;
  _DonateWidgetState(this.markersId);

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(S.of(context).label_donate_book),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.qr_code_scanner_sharp),
            ),
            Tab(
              icon: Icon(Icons.text_snippet),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: new Container(
          height: 600,
          child: TabBarView(
            controller: _tabController,
            children: [
              _GetISBNScannWidget(markersId),
              getManuallyWidget(context),
            ],
          ),
        ),
      ),
    );
  }
}
