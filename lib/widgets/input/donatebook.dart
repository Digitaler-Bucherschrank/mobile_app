import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/widgets/input/modules/popUps.dart';
import 'package:flutter/material.dart';

import '../../models/book.dart';
import 'modules/getFrotpageModules.dart';
import 'modules/getManuallyWidget.dart';

enum WidgetMarker { isbn, manuelly }

WidgetMarker selectedWidgetMarker = WidgetMarker.isbn;

class _GetISBNScannWidget extends StatefulWidget {
  final String markersId;
  final double containerWidth;

  _GetISBNScannWidget(this.markersId, this.containerWidth);

  @override
  _GetISBNScannWidgetState createState() =>
      _GetISBNScannWidgetState(markersId, containerWidth);
}

class _GetISBNScannWidgetState extends State<_GetISBNScannWidget> {
  String markersId;
  double containerWidth;

  _GetISBNScannWidgetState(this.markersId, this.containerWidth);

  Book _book = new Book();

  ApiService apiService = new ApiService();
  String txt = "";
  String txt2 = "";

  @override
  void initState() {
    super.initState();
    _book.bookData = new VolumeData();
    _book.location = markersId;
    txt = "";
    txt2 = "";
  }

  void callback(String t1, String t2) {
    setState(() {
      txt = t1;
      txt2 = t2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ScannerWidget(txt, txt2, callback, _book, apiService, containerWidth),
          getBookinfo(txt, txt2, context, containerWidth),
          getBookcase(markersId, context, containerWidth),
          ElevatedButton(
            style: Theme.of(context).outlinedButtonTheme.style,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return DonatePopUp(
                    book: _book,
                    manual: false,
                  );
                },
              ).then((value) => Navigator.pop(context));
            },
            child: Text(S.of(context).label_scanner_confirm),
          ),
          Padding(padding: EdgeInsets.only(top: 50)),
        ],
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
    double containerWidth = MediaQuery.of(context).size.width * 0.8;
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
          height: MediaQuery.of(context).size.height * 0.8,
          child: TabBarView(
            controller: _tabController,
            children: [
              _GetISBNScannWidget(markersId, containerWidth),
              ManuallyWidget(containerWidth),
            ],
          ),
        ),
      ),
    );
  }
}
