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

Future postIsbn(String isbn) async {
  const _url =
      "https://test-3eea7-default-rtdb.europe-west1.firebasedatabase.app/isbn.json";
  http
      .post(_url,
          body: json.encode({
            'isbn': isbn,
          }))
      .then((response) {
    print(json.decode(response.body));
  });
}

class SchrankListe {
  String title;
  String address;
  String id;
  var lat;
  var lon;
  SchrankListe(this.title, this.address, this.lat, this.lon, this.id);
}

class Schraenke extends StatefulWidget {
  final formular;
  Schraenke(this.formular);
  @override
  _SchraenkeState createState() => _SchraenkeState(formular);
}

class _SchraenkeState extends State<Schraenke> {
  var result;
  Map formular;
  int selectedSchrank;
  _SchraenkeState(this.formular);

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
          } else {
            return Container(
              height: 400,
              width: 300,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                    value: index,
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
          }
        },
      ),
    );
  }
}
