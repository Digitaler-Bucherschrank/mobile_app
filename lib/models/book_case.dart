import 'dart:async';
import 'dart:convert';

import 'package:digitaler_buecherschrank/location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

List<BookCase> _bookcases = [];
List _data = [];
bool finished = false;

Future<String> getDistance(String lat2, String lng2) async {
  String out;
  LocationData _locationData;
  Location location = new Location();
  double lng2db = double.parse(lng2);
  double lat2db = double.parse(lat2);
  _locationData = await LocationProvider.getLocation();
  var distanceBetweenPoints = SphericalUtil.computeDistanceBetween(
      LatLng(_locationData.latitude!, _locationData.longitude!),
      LatLng(lat2db, lng2db));
  out = (distanceBetweenPoints / 1000).toStringAsFixed(2);
  print(out);
  return out;
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json[r"$oid"];
  }
}

class BookCase {
  Id? iId;
  String? address;
  String? bcz;
  String? comment;
  String? contact;
  String? deactivated;
  String? deactreason;
  String? digital;
  String? entrytype;
  String? homepage;
  String? icontype;
  String? lat;
  String? lon;
  String? open;
  String? title;
  String? type;
  int? distance;

  BookCase(
      this.iId,
      this.address,
      this.bcz,
      this.comment,
      this.contact,
      this.deactivated,
      this.deactreason,
      this.digital,
      this.entrytype,
      this.homepage,
      this.icontype,
      this.lat,
      this.lon,
      this.open,
      this.title,
      this.type,
      this.distance);

  BookCase.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    address = json['address'];
    bcz = json['bcz'];
    comment = json['comment'];
    contact = json['contact'];
    deactivated = json['deactivated'];
    deactreason = json['deactreason'];
    digital = json['digital'];
    entrytype = json['entrytype'];
    homepage = json['homepage'];
    icontype = json['icontype'];
    lat = json['lat'];
    lon = json['lon'];
    open = json['open'];
    title = json['title'];
    type = json['type'];
    distance = -1000;
  }
}

List<BookCase> parseBookCaseJSON(String file) {
  BookCase tempMarker;
  return jsonDecode(file)
      .cast<Map<String, dynamic>>()
      .map<BookCase>((Map<String, dynamic> json) {
    tempMarker = BookCase.fromJson(json);
    return tempMarker;
  }).toList();
}

Future<bool> loadBookCases() async {
  if (_bookcases.length == 0) {
    var file = await rootBundle.loadString("assets/markers.json");

    _bookcases = await compute(parseBookCaseJSON, file);

    finished = true;
  }
  print(_bookcases.length);

  return true;
}

Future<void> _waitUntilDone() async {
  final completer = Completer();
  if (!finished) {
    await Future.delayed(Duration(seconds: 2));
    return _waitUntilDone();
  } else {
    completer.complete();
  }
  return completer.future;
}

Future<List<BookCase>> getBookCases() async {
  await _waitUntilDone();

  return _bookcases;
  /* if (_bookcases.length != 0) {
    print("schraenke1 $_bookcases");
    return _bookcases;
  } else {
    var books = await loadBookCases().then((v) {
      print("schraenke2 $_bookcases");
      return _bookcases;
    }, onError: (e) {
      print("$e");
    });
    return books;
  } */
}
