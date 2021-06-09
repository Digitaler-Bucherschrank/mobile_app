import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:digitaler_buecherschrank/widgets/scanner/scanner_pickup_form.dart';

class DetailPage extends StatelessWidget {
  String markersId;
  DetailPage(this.markersId);
  @override
  // ignore: override_on_non_overriding_member
  _DetailPage createState() => _DetailPage(markersId);
}

class _DetailPage extends State<DetailPage> {
  String markersId;
  _DetailPage(this.markersId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  thumbnail,
                  height: 500,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      bookData,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.0, fontStyle: FontStyle.italic),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      author,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17.0, fontStyle: FontStyle.italic),
                    )),
              ],
            ),
          ),
        ));
  }
}
