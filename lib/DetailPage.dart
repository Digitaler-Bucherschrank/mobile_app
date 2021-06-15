import 'package:flutter/material.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/api/api_service.dart';
// ignore: unused_import
import 'package:digitaler_buecherschrank/models/book.dart';
// ignore: unused_import
import 'package:digitaler_buecherschrank/widgets/scanner/scanner_pickup_form.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  String isbn;
  DetailPage(this.isbn);
  @override
  _DetailPage createState() => _DetailPage(isbn);
}

class _DetailPage extends State<DetailPage> {
  String markersId;
  _DetailPage(this.markersId);
  @override
  Widget build(BuildContext context) {
    ApiService apiService = new ApiService();
    return Container(
        height: 600,
        child: FutureBuilder(
            future: apiService.getBookCaseInventory(markersId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: ListTile(
                    title: Text(S.of(context).label_loading,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                );
              }
              return Scaffold(
                  appBar: AppBar(
                    title: Text("${snapshot.data.title}",
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            "${snapshot.data.image}",
                            height: 500,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${snapshot.data.author}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade600),
                                textAlign: TextAlign.center,
                                //  style: TextStyle(
                                //      fontSize: 17.0,
                                //  fontStyle: FontStyle.italic),
                              )),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${snapshot.data.bookData}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontStyle: FontStyle.italic),
                              )),
                        ],
                      ),
                    ),
                  ));
            }));
  }
}
