import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "./../DetailPage.dart";

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

  Future<List<Book>> fetchBooks() async {
    Uri url =
        "http://www.json-generator.com/api/json/get/bVulMGunCa?indent=2" as Uri;
    var response = await http.get(url);
    List<Book> books = [];

    if (response.statusCode == 200) {
      var booksJson = json.decode(response.body);
      for (var bookJson in booksJson) {
        books.add(Book.fromJson(bookJson));
      }
    }
    return books;
  }

  Future postMarkersId(String markersId) async {
    Uri _url =
        "http://www.json-generator.com/api/json/get/bVulMGunCa?indent=2" as Uri;
    http
        .post(_url,
            body: json.encode({
              'markersId': markersId,
            }))
        .then((response) {
      print(json.decode(response.body));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Maybe even book name?
        title: Text("buchanzeigen"),
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchBooks(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].title),
                    //title: Text(_books[index].title),
                    subtitle: Text(snapshot.data[index].author),
                    //  leading: Image.network(-) ,
                    trailing: Icon(Icons.arrow_forward_rounded),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  snapshot.data[index].title,
                                  snapshot.data[index].email)));
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
