import 'package:digitaler_buecherschrank/scanner_logic.dart';
import 'package:flutter/material.dart';

class ScannerPageablegen extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPageablegen> {
  int selectedRadio;
  int selectedSchrank;
  var txt = TextEditingController();
  Map bookInfo = {
    'name': 'Titel',
  };

  Map formular = {
    'a': 'ablegen',
    'isbn': 'leer',
    'von': 'leer',
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
        title: new Text("Buch ablegen"),
      ),
      body: SingleChildScrollView(
        child: new Container(
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text('Barcode scannen oder ISBN eingeben!'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 200,
                            child: TextField(
                              onSubmitted: (String str) {
                                setState(() async {
                                  formular.update('isbn', (v) {
                                    print('old value of isbn before update: ' +
                                        v);
                                    return str;
                                  });
                                  bookInfo = await getInfo(formular['isbn']);
                                  txt.text = bookInfo['name'] as String;
                                });
                                print(bookInfo);
                                print('updated formular: ' + formular['isbn']);
                              },
                            ),
                          ),
                          Container(
                            child: Text('Buchinformationen:'),
                          ),
                          Container(
                            child: TextField(
                              controller: txt,
                              decoration: InputDecoration(
                                labelText: bookInfo['name'],
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
                      Column(children: [
                        IconButton(
                          icon: Icon(Icons.qr_code_scanner),
                          tooltip: "Scannen",
                          onPressed: () {
                            setState(() {
                              Future text = scanBarcodeNormal();
                              text.then((value) => formular.update('isbn', (v) {
                                    print('old value of isbn before update: ' +
                                        v);
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
                          Container(
                            width: 300,
                            child: RadioListTile(
                              value: 1,
                              groupValue: selectedRadio,
                              title: Text("Buch aus Inventar ablegen"),
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                setSelectedRadio(val, "inv");
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
                              onChanged: (val) {
                                setSelectedRadio(val, "neu");
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
                              postIsbn(formular['isbn']);
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
      ),
    );
  }
}
