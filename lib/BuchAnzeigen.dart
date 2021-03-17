import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuchAnzeigen extends StatefulWidget {
  BuchAnzeigen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BuchAnzeigen createState() => new _BuchAnzeigen();
}

class _BuchAnzeigen extends State<BuchAnzeigen> {
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
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));

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

class DetailPage extends StatelessWidget {
  final Book book;

  DetailPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(book.name),
    ));
  }
}

class Book {
  final int index;
  final String about;
  final String name;
  final String email;

  Book(this.index, this.about, this.name, this.email);
}
