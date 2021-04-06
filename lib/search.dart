import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'Schraenke.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<String>> search(String search) async {
    String test = "test";
    await Future.delayed(Duration(seconds: 2));
    return List.generate(
      search.length,
      (int index) {
        if (search.length != test.length) {
          return "nein";
        } else if (search.contains(test)) {
          return "Title : $search $index";
        } else {
          return "Nichts gefunden!";
        }
      },
    );
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
