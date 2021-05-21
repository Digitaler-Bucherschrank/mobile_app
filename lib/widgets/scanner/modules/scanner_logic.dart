import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import '../../../models/book_case.dart';

// Platform messages are asynchronous, so we initialize in an async method.
Future scanBarcodeNormal() async {
  String scanBarcode = "";
  String barcodeScanRes;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.BARCODE);
    print(barcodeScanRes);
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
  } catch (e) {
    barcodeScanRes = e.toString();
  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.

  scanBarcode = barcodeScanRes;

  return (scanBarcode);
}

Future getInfo(String? isbn) async {
  var _url = Uri.parse(
      "https://test-3eea7-default-rtdb.europe-west1.firebasedatabase.app/getInfo.json");
  Map response = await http
      .post(_url,
          body: json.encode({
            'isbn': isbn,
          }))
      .then((response) {
    Map? out = {};
    print(json.decode(response.body));
    out = json.decode(response.body);
    return out!;
  });

  print(response['name']);
  return response;
}

Future postIsbnAndSchrank(String? isbn, String? schrank) async {
  var _url = Uri.parse(
      "https://test-3eea7-default-rtdb.europe-west1.firebasedatabase.app/isbn.json");
  http
      .post(_url,
          body: json.encode({
            'isbn': isbn,
            'schrank': schrank,
          }))
      .then((response) {
    print(json.decode(response.body));
  });
}

setSchrank(String markersId, Map formular) {
  if (markersId != "") {
    formular.update('schrank', (v) {
      print('old value of schrank before update: ' + v);
      print('updated formular: ' + markersId);
      return markersId;
    });
  }
}

// ignore: must_be_immutable
class Schraenke extends StatefulWidget {
  String markersId;
  Schraenke(this.markersId);

  @override
  _SchraenkeState createState() => _SchraenkeState(markersId);
}

class _SchraenkeState extends State<Schraenke> {
  var result;
  int? selectedSchrank;
  String markersId;
  _SchraenkeState(this.markersId);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          leading: Image.asset("assets/icons/book_case.png"),
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
    );
  }
}
