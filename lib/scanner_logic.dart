import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

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
    barcodeScanRes = e;
  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.

  scanBarcode = barcodeScanRes;

  return (scanBarcode);
}

Future getInfo(String isbn) async {
  const _url =
      "https://test-3eea7-default-rtdb.europe-west1.firebasedatabase.app/getInfo.json";
  Map response = await http
      .post(_url,
          body: json.encode({
            'isbn': isbn,
          }))
      .then((response) {
    Map out = {};
    print(json.decode(response.body));
    out = json.decode(response.body);
    return out;
  });

  print(response['name']);
  return response;
}

Future postIsbnAndSchrank(String isbn, String schrank) async {
  const _url =
      "https://test-3eea7-default-rtdb.europe-west1.firebasedatabase.app/isbn.json";
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

class SchrankListe {
  String title;
  String address;
  String id;
  var lat;
  var lon;
  SchrankListe(this.title, this.address, this.lat, this.lon, this.id);
}

// ignore: must_be_immutable
class Schraenke extends StatefulWidget {
  final formular;
  String markersId;
  Schraenke(this.formular, this.markersId);

  @override
  _SchraenkeState createState() => _SchraenkeState(formular, markersId);
}

class _SchraenkeState extends State<Schraenke> {
  var result;
  Map formular;
  int selectedSchrank;
  String markersId;
  _SchraenkeState(this.formular, this.markersId);

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

  Future<List<SchrankListe>> getSchranke() async {
    var data = jsonDecode(
        await DefaultAssetBundle.of(context).loadString("assets/markers.json"));
    List<SchrankListe> schraenke = [];
    for (var i in data) {
      SchrankListe sch = SchrankListe(
        i["title"],
        i["address"],
        i["lat"],
        i["lon"],
        i["_id"]["\$oid"],
      );
      schraenke.add(sch);
    }
    print(schraenke.length);

    return schraenke;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getSchranke(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else if (markersId == "") {
              return Container(
                height: 400,
                width: 300,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                      value: 0,
                      groupValue: selectedSchrank,
                      title: Text(snapshot.data[index].title),
                      subtitle: Container(
                        child: Text("${snapshot.data[index].address}"),
                      ),
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        setSelectedSchrank(val, snapshot.data[index].id);
                      },
                    );
                  },
                ),
              );
            } else {
              for (int i = 0; i < snapshot.data.length; i++) {
                if (snapshot.data[i].id == markersId) {
                  return Container(
                    height: 100,
                    width: 300,
                    child: Card(
                      child: ListTile(
                        title: Text(snapshot.data[i].title),
                        subtitle: Container(
                          child: Text("${snapshot.data[i].address}"),
                        ),
                      ),
                    ),
                  );
                }
              }
            }
            return Container(child: Text(""));
          }),
    );
  }
}
