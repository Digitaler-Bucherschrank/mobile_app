import 'dart:async';
import 'dart:convert';

import 'package:digitaler_buecherschrank/location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

List<BookCase> _bookcases = [];
bool finished = false;

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
  String? distance;

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
    distance = "-1000";
  }

  updateDistance() async {
    var currLocation = await LocationProvider.getLocation();

    double lng2db = double.parse(this.lon!);
    double lat2db = double.parse(this.lon!);
    var distanceBetweenPoints = SphericalUtil.computeDistanceBetween(
        LatLng(currLocation.latitude!, currLocation.longitude!),
        LatLng(lat2db, lng2db));
    this.distance = (distanceBetweenPoints / 1000).toStringAsFixed(2);
  }
}

Future<List<BookCase>> parseBookCaseJSON(String file) async {
  return jsonDecode(file)
      .cast<Map<String, dynamic>>()
      .map<BookCase>((Map<String, dynamic> json) {
    final tempMarker = BookCase.fromJson(json);
    return tempMarker;
  }).toList();
}

Future<bool> loadBookCases() async {
  if (_bookcases.length == 0) {
    var file = await rootBundle.loadString("assets/markers.json");

    _bookcases = await compute(parseBookCaseJSON, file);

    finished = true;
    return true;
  }
  print(_bookcases.length);
  return false;
}

Future<void> _waitUntilDone() async {
  final completer = Completer();
  if (!finished) {
    await Future.delayed(Duration(milliseconds: 500));
    return _waitUntilDone();
  } else {
    completer.complete();
  }
  return completer.future;
}

Future<List<BookCase>> getBookCases() async {
  await _waitUntilDone();

  return _bookcases;
}
