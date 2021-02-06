import 'package:digitaler_buecherschrank/scanner.dart';
import 'package:flutter/material.dart';

class ScannerPageaufheben extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPageaufheben> {
  int selectedRadio;
  int selectedSchrank;
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

  setSelectedSchrank(int val, String schrank) {
    setState(() {
      selectedSchrank = val;
      formular.update('schrank', (v) {
        print('old value of schrank before update: ' + v);
        print('updated formular: ' + schrank);
        return schrank;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Buch aufheben"),
      ),
      body: new Container(
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  child: Text('Barcode scannen oder ISBN eingeben!'),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 200,
                          child: TextField(
                            onSubmitted: (String str) {
                              setState(() {
                                formular.update('isbn', (v) {
                                  print(
                                      'old value of isbn before update: ' + v);
                                  return str;
                                });
                              });
                              print('updated formular: ' + formular['isbn']);
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(children: [
                      IconButton(
                        icon: Icon(Icons.qr_code_scanner),
                        tooltip: "Scannen",
                        onPressed: () {
                          setState(() {
                            Future text = scanBarcodeNormal();
                            text.then((value) => formular.update('isbn', (v) {
                                  print(
                                      'old value of isbn before update: ' + v);
                                  print('updated formular: ' + value);
                                  return value;
                                }));
                          });
                        },
                      ),
                    ]),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 300,
                          child: RadioListTile(
                            value: 1,
                            groupValue: selectedSchrank,
                            title: Text("Test"),
                            subtitle: Text("Entfernung"),
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              setSelectedSchrank(val, "Test");
                            },
                          ),
                        ),
                        Container(
                          width: 300,
                          child: RadioListTile(
                            value: 2,
                            groupValue: selectedSchrank,
                            title: Text("Test2"),
                            subtitle: Text("Entfernung"),
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              setSelectedSchrank(val, "Test2");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        OutlineButton(
                          onPressed: () {
                            print(formular);
                          },
                          child: Text("Bestätigen"),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}