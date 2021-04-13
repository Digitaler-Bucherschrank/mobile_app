import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'Schraenke.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<String>> search(String search) async {
    var schraenke = await schrankeFuture();
    print("schraenke in search: $schraenke");
    List<String> result = [];
    int i = 0;
    while (i < 112) {
      if (schraenke[i].title.contains(search)) {
        print("schraenke[i].title: ${schraenke[i].title}");
        result.add("Bücherschrank: ${schraenke[i].title}");
      }
      i++;
    }
    print("result: $result");
    result.add(await getBook(search));
    print("result: $result");
    if (result.length != 0) {
      return result;
    } else {
      return ["Nichts gefunden!"];
    }
  }

  Future getBook(String bookInfo) async {
    const _url =
        "https://test-3eea7-default-rtdb.europe-west1.firebasedatabase.app/getInfo.json";
    Map response = await http
        .post(_url,
            body: json.encode({
              'bookInfo': bookInfo,
            }))
        .then((response) {
      Map out = {};
      print(json.decode(response.body));
      out = json.decode(response.body);
      return out;
    });
    return response['name'];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<String>(
            onSearch: search,
            onItemFound: (String post, int index) {
              return ListTile(
                title: Text(post),
              );
            },
          ),
        ),
      ),
    );
  }
}
