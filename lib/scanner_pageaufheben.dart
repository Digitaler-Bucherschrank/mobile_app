import 'scanner_logic.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScannerPageaufheben extends StatefulWidget {
  String markersId;
  ScannerPageaufheben(this.markersId);
  @override
  _ScannerPageState createState() => _ScannerPageState(markersId);
}

class _ScannerPageState extends State<ScannerPageaufheben> {
  String markersId;
  _ScannerPageState(this.markersId);
  int selectedRadio;
  int selectedSchrank;
  var txt = TextEditingController();
  var txt2 = TextEditingController();
  Map bookInfo = {
    'name': 'Titel',
    'author': 'Autor',
  };
  Map formular = {
    'a': 'aufheben',
    'isbn': 'leer',
    'schrank': 'leer',
  };
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val, String von) {
    setState(() {
      selectedRadio = val;
      formular.update('von', (v) {
        print('old value of von before update: ' + v);
        print('updated formular: ' + von);
        return von;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Buch ablegen"),
      ),
      body: SingleChildScrollView(
        child: new Container(
          child: Column(
            children: [
              Card(
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
                            onSubmitted: (String str) {
                              getInfo(formular['isbn']).then((value) {
                                setState(() {
                                  bookInfo['name'] = value['name'];
                                  print(bookInfo);
                                  txt.text = bookInfo['name'];
                                });
                              });
                              setState(() {
                                print('old value of isbn before update: ' +
                                    formular['isbn']);
                                formular['isbn'] = str;
                                print('updated formular: ' + formular['isbn']);
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.qr_code_scanner),
                          tooltip: "Scannen",
                          onPressed: () {
                            setState(
                              () {
                                scanBarcodeNormal().then((value) {
                                  print('old value of isbn before update: ' +
                                      formular['isbn']);
                                  formular['isbn'] = value;
                                  print(
                                      'updated formular: ' + formular['isbn']);
                                  getInfo(formular['isbn']).then((value) {
                                    setState(() {
                                      bookInfo['name'] = value['name'];
                                      print(bookInfo);
                                      txt.text = bookInfo['name'];
                                    });
                                  });
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
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
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [Schraenke(formular, markersId)],
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  setSchrank(markersId, formular);
                  print(formular);
                  postIsbnAndSchrank(
                    formular['isbn'],
                    formular['schrank'],
                  );
                },
                child: Text("Bestätigen"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
