import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DetailPage.dart';

// ignore: must_be_immutable
class BookInfo extends StatefulWidget {
  String markersId;
  BookInfo(this.markersId);
  @override
  _BookInfo createState() => _BookInfo(markersId);
}

class _BookInfo extends State<BuchAnzeigen> {
  String markersId;
  _BuchAnzeigen(this.markersId);
  Future<List<Book>> _getBooks() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/bVulMGunCa?indent=2");

    var jsonData = json.decode(data.body);

    List<Book> books = [];

    for (var u in jsonData) {
      Book book = Book(u["index"], u["about"], u["name"], u["email"]);

      books.add(book);
    }

    print(books.length);

    return books;
  }

  Future postMarkersId(String markersId) async {
    const _url =
        "http://www.json-generator.com/api/json/get/bVulMGunCa?indent=2";
    http
        .post(_url,
            body: json.encode({
              'markersId': markersId,
            }))
        .then((response) {
      print(json.decode(response.body));
    });
  }

class BookInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("buchanzeigen"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getBooks(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                    //  leading: Image.network(-) ,
                    trailing: Icon(Icons.arrow_forward_rounded),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  snapshot.data[index].name,
                                  snapshot.data[index].email)));

                      //   child: ElevatedButton(
                      //   onPressed: () {
                      //   {
                      //   Navigator.pop(context);
                      //}
                      //  },
                      //   child: Text('Zurück'),
                      //),
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

class Book {
  final int index;
  final String about;
  final String name;
  final String email;

  Book(this.index, this.about, this.name, this.email);
}
