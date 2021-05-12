import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:flutter/material.dart';
import 'scanner_logic.dart';
import '../../../models/book.dart';

Widget getScannerWidget(Book _book, Map bookInfo, TextEditingController txt,
    TextEditingController txt2) {
  TextEditingController scannerText = new TextEditingController();
  return Card(
    child: Column(
      children: [
        Container(
          child: Text('Barcode scannen oder ISBN eingeben!'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 100,
              child: TextField(
                controller: scannerText,
                onSubmitted: (String str) {
                  getInfo(_book.id).then((value) {
                    bookInfo['name'] = value['name'];
                    print(bookInfo);
                    txt.text = bookInfo['name'];
                  });

                  if (_book.id != null) {
                    print('old value of isbn before update: ' + _book.id!);
                  }
                  _book.id = str;
                  print('updated isbn: ' + _book.id!);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.qr_code_scanner),
              tooltip: "Scannen",
              onPressed: () {
                scanBarcodeNormal().then((value) {
                  if (_book.id != null) {
                    print('old value of isbn before update: ' + _book.id!);
                  }
                  _book.id = value;
                  scannerText.text = _book.id!;
                  print('updated isbn: ' + _book.id!);
                  getInfo(_book.id).then((value) {
                    bookInfo['name'] = value['name'];
                    print(bookInfo);
                    txt.text = bookInfo['name'];
                  });
                });
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget getBookinfo(TextEditingController txt, TextEditingController txt2) {
  return Card(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              child: Text('Buchinformationen:'),
            ),
            Container(
              child: TextField(
                controller: txt,
                decoration: InputDecoration(
                  labelText: "Titel",
                ),
              ),
              width: 200,
            ),
            Container(
              child: TextField(
                controller: txt2,
                decoration: InputDecoration(
                  labelText: "Autor",
                ),
              ),
              width: 200,
            ),
            Container(
              width: 200,
              child: Text(
                  'Nicht Ihr Buch? Barcode erneut scannen bzw. ISBN eingeben.'),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget getBookcase(String markersId) {
  return Card(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              child: FutureBuilder(
                  future: getBookCases(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading..."),
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
                              Text("Bücherschrank"),
                              Container(
                                height: 100,
                                width: 300,
                                child: ListTile(
                                  leading:
                                      Image.asset("assets/icons/book_case.png"),
                                  title: Text(snapshot.data[i].title),
                                  subtitle: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                            "Entfernung: ${snapshot.data[i].distance}km"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }
                    }
                    return Container(child: Text(""));
                  }),
            )
          ],
        ),
      ],
    ),
  );
}

class GetFromWidget extends StatefulWidget {
  String? from;
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text("Von wo soll das Buch hinzugefügt werden?"),
              Container(
                width: 300,
                child: RadioListTile(
                  value: 1,
                  groupValue: selectedRadio,
                  title: Text("Buch aus Inventar ablegen"),
                  activeColor: Colors.blue,
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
                  title: Text("Neues Buch ablegen"),
                  activeColor: Colors.blue,
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
