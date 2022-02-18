import 'dart:ui';

import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:flutter/material.dart';
import 'scanner_logic.dart';

double cardBorderRadius = 20.0;

class ScannerWidget extends StatefulWidget {
  ScannerWidget(this.txt, this.txt2, this.callback, this._book, this.apiService,
      this.containerWidth);
  final String txt;
  final String txt2;
  final Function callback;
  final Book _book;
  final ApiService apiService;
  final double containerWidth;
  @override
  _ScannerWidgetState createState() =>
      _ScannerWidgetState(txt, txt2, _book, apiService, containerWidth);
}

class _ScannerWidgetState extends State<ScannerWidget> {
  _ScannerWidgetState(
      this.txt, this.txt2, this._book, this.apiService, this.containerWidth);
  Book _book;
  String txt;
  String txt2;
  ApiService apiService;
  double containerWidth;

  TextEditingController scannerText = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Padding(padding: EdgeInsets.only(top: 10)),
            ],
          ),
          Container(
            width: containerWidth,
            child: TextField(
              controller: scannerText,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                labelText: "ISBN",
                fillColor: Theme.of(context).backgroundColor,
                suffixIcon: IconButton(
                  icon: Icon(Icons.qr_code_scanner),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => getScannerScreen(
                                context, _book, scannerText))).then(
                      (value) {
                        apiService.getBookData([_book]).then((value) {
                          this.widget.callback(
                              "${value[0].title}", "${value[0].author}");

                          print("${value[0].title}");
                          print("${value[0].author}");
                        });
                        setState(
                          () {
                            scannerText.text = _book.isbn!;
                          },
                        );
                      },
                    );
                  },
                ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  borderSide: new BorderSide(),
                ),
              ),
              onSubmitted: (String str) {
                if (_book.isbn != null) {
                  print('old value of isbn before update: ' + _book.isbn!);
                }
                _book.isbn = str;
                print('updated isbn: ' + _book.isbn!);
                apiService.getBookData([_book]).then((value) {
                  print(value.toString());
                  txt = "${value[0].title}";
                  print(txt);
                  txt2 = "${value[0].author}";
                  print(txt2);
                });
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
        ],
      ),
    );
  }
}

Widget getBookinfo(
    String txt, String txt2, BuildContext context, double containerWidth) {
  double testFieldWidth = MediaQuery.of(context).size.width * 0.6;
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("${S.of(context).label_scanner_title}: ",
                        style: Theme.of(context).textTheme.bodyText1),
                    Padding(padding: EdgeInsets.only(top: 35)),
                    Text("${S.of(context).label_scanner_autor}: ",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        txt,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      width: testFieldWidth,
                    ),
                    Padding(padding: EdgeInsets.only(top: 35)),
                    Container(
                      child: Text(
                        txt2,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      width: testFieldWidth,
                    ),
                  ],
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: containerWidth,
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

Widget getBookcase(
    String markersId, BuildContext context, double containerWidth) {
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
                                width: containerWidth,
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
