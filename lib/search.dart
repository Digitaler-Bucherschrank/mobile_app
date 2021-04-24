import 'dart:async';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/book_case.dart';

String selectedTerm = "";
FloatingSearchBarController? controller;

Completer<GoogleMapController> _controller = new Completer();

Future<void> gotoLocation(double lat, double long) async {
  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    target: LatLng(lat, long),
    zoom: 15,
  )));
}

Future<List<Map>> search(String? search) async {
  var bookCases = await getBookCases();
  print(search);
  print("bookCases in search: $bookCases");
  List<Map> result = [];
  int i = 0;
  while (i < bookCases.length) {
    if (bookCases[i].title!.contains(search!)) {
      print("bookCases[i].title: ${bookCases[i].title}");
      result.add({
        "title": bookCases[i].title!,
        "lat": bookCases[i].lat!,
        "lon": bookCases[i].lon!
      });
    }
    i++;
  }
  //result.add(await getBook(search));
  print("result: $result");
  if (result.length != 0) {
    return result;
  } else {
    return [
      {"title": "Nichts gefunden!"}
    ];
  }
}
