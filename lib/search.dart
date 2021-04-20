import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/book_case.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<String>> search(String search) async {
    var bookCases = await getBookCases();
    print("bookCases in search: $bookCases");
    List<String> result = [];
    int i = 0;
    while (i < 112) {
      if (bookCases[i].title.contains(search)) {
        print("bookCases[i].title: ${bookCases[i].title}");
        result.add("Bücherschrank: ${bookCases[i].title}");
      }
      i++;
    }
    //result.add(await getBook(search));
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
                onTap: () {
                  _gotoLocation(lat, long);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<void> _gotoLocation(double lat, double long) async {
  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(cameraUpdate.newCameraPosition(CameraPosition(
    target: LatLng(lat, long),
    zoom: 15,
  )));
}
