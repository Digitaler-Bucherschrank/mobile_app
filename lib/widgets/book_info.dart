import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:flutter/material.dart';
import "./../DetailPage.dart";
// ignore: unused_import
import './../models/book.dart';
import 'package:digitaler_buecherschrank/api/api_service.dart';

// ignore: must_be_immutable
class BookInfo extends StatefulWidget {
  String markersId;
  BookInfo(this.markersId);
  @override
  _BookInfo createState() => _BookInfo(markersId);
}

class _BookInfo extends State<BookInfo> {
  String markersId;
  _BookInfo(this.markersId);

  @override
  Widget build(BuildContext context) {
    ApiService apiService = new ApiService();
    String bookCaseID = markersId;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).label_show_books),
      ),
      body: Container(
        child: FutureBuilder(
          future: apiService.getBookCaseInventory(bookCaseID),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text(S.of(context).label_loading,
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].title),
                    // subtitle: Text(snapshot.data[index].author),
                    leading: Image.network(snapshot.data[index].thumbnail),
                    trailing: Icon(Icons.arrow_forward_rounded),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    snapshot.data[index].title,
                                    snapshot.data[index].author,
                                    snapshot.data[index].thumbnail,
                                    snapshot.data[index].bookData,
                                  )));
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
