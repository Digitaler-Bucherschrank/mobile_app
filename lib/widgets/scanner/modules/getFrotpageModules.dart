import 'dart:ui';

import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:flutter/material.dart';
import '../../../models/book.dart';
import 'scanner_logic.dart';

double cardBorderRadius = 20.0;

Widget getScannerWidget(
    BuildContext context,
    Book _book,
    TextEditingController txt,
    TextEditingController txt2,
    ApiService apiService) {
  TextEditingController scannerText = new TextEditingController();
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(cardBorderRadius),
    ),
    elevation: 5,
    child: Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 10)),
        Container(
          child: Text(
            S.of(context).label_scanner_enterISBN,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 300,
                  child: TextField(
                    controller: scannerText,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      labelText: "ISBN",
                      fillColor: Theme.of(context).backgroundColor,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.qr_code_scanner),
                        onPressed: () {
                          scanBarcodeNormal().then((value) {
                            if (_book.isbn != null) {
                              print('old value of isbn before update: ' +
                                  _book.isbn!);
                            }
                            if (value != "-1") {
                              _book.isbn = value;
                              scannerText.text = _book.isbn!;
                              print('updated isbn: ' + _book.isbn!);
                            }
                          });
                        },
                      ),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    onChanged: (String str) {
                      if (_book.isbn != null) {
                        print(
                            'old value of isbn before update: ' + _book.isbn!);
                      }
                      _book.isbn = str;
                      print('updated isbn: ' + _book.isbn!);
                      apiService.getBookData([_book]).then((value) {
                        print(value.toString());
                        txt.text = "${value[0].title}";
                        print(txt.text);
                        txt2.text = "${value[0].author}";
                        print(txt2.text);
                      });
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget getBookinfo(BuildContext context, TextEditingController txt,
    TextEditingController txt2) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(cardBorderRadius),
    ),
    elevation: 5,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              child: Text(S.of(context).label_scanner_bookinfo,
                  style: Theme.of(context).textTheme.headline6),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("${S.of(context).label_scanner_title}: ",
                    style: Theme.of(context).textTheme.bodyText1),
                Container(
                  child: TextField(
                    selectionHeightStyle: BoxHeightStyle.tight,
                    controller: txt,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                    ),
                  ),
                  width: 200,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              children: [
                Text("${S.of(context).label_scanner_autor}: ",
                    style: Theme.of(context).textTheme.bodyText1),
                Container(
                  child: TextField(
                    controller: txt2,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                    ),
                  ),
                  width: 200,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: 250,
              child: Text(S.of(context).label_scanner_notYourBook,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
          ],
        ),
      ],
    ),
  );
}

Widget getBookcase(String markersId) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(cardBorderRadius),
    ),
    elevation: 5,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              child: FutureBuilder(
                  future: getBookCases(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text(S.of(context).label_loading,
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      );
                    } else {
                      print("snapshot.data.length ${snapshot.data.length}");
                      print("markersId $markersId");
                      for (int i = 0; i < snapshot.data.length; i++) {
                        if (snapshot.data[i].iId.oid == markersId) {
                          print(
                              "snapshot.data[$i].iId.oid ${snapshot.data[i].iId.oid}");
                          return Column(
                            children: [
                              Text(
                                S.of(context).label_scanner_bookcase,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Container(
                                width: 300,
                                child: ListTile(
                                  leading: SizedBox(
                                    height: 50,
                                    child: Image.asset(
                                        "assets/icons/book_case.png"),
                                  ),
                                  title: Text(
                                    snapshot.data[i].title,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  subtitle: Text(
                                    "${snapshot.data[i].address}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.grey.shade600),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                            ],
                          );
                        }
                      }
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ],
    ),
  );
}

class GetFromWidget extends StatefulWidget {
  final String from;

  GetFromWidget(this.from);

  @override
  _GetFromWidgetState createState() => _GetFromWidgetState(from);
}

class _GetFromWidgetState extends State<GetFromWidget> {
  String? from;

  _GetFromWidgetState(this.from);

  int? selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                width: 300,
                child: Text(
                  S.of(context).label_scanner_fromWhere,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                width: 300,
                child: RadioListTile(
                  value: 1,
                  groupValue: selectedRadio,
                  title: Text(
                    S.of(context).label_scanner_fromInventory,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (dynamic val) {
                    setState(() {
                      selectedRadio = val;
                      from = "inventory";
                    });
                  },
                ),
              ),
              Container(
                width: 300,
                child: RadioListTile(
                  value: 2,
                  groupValue: selectedRadio,
                  title: Text(
                    S.of(context).label_scanner_newBook,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (dynamic val) {
                    setState(() {
                      selectedRadio = val;
                      from = "newBook";
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
