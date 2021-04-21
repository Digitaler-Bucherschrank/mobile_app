import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

List<BookCase>? _bookcases;
List? _data;

Future getDistance(String lat2, String lng2) async {
  String out;
  LocationData _locationData;
  Location location = new Location();
  double lng2db = double.parse(lng2);
  double lat2db = double.parse(lat2);
  _locationData = await location.getLocation();
  print(_locationData);
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
  var entfernung;

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
    this.entfernung,
  );
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
    entfernung = -1000;
  }
}

Future<void> parseJSON() async {
  _data = jsonDecode(await rootBundle.loadString("assets/markers.json"));
}

Future<List?> jsonFuture() async {
  if (_data != null) {
    return _data;
  } else {
    return parseJSON().then((v) {
      print("${v as String}");
      while (_data == null) {}
      return _data;
    });
  }
}

Future<String?> loadBookCases() async {
  _bookcases = [];
  if (_data == null) {
    await parseJSON();
  }

  for (final i in _data!) {
    var tempMarker = BookCase.fromJson(i);
    tempMarker.entfernung = await getDistance(tempMarker.lat!, tempMarker.lon!);
    _bookcases!.add(tempMarker);
  }
  print(_bookcases!.length);
}

 Future<List<BookCase>?> getBookCases() async {
  if (_bookcases!.length != 0) {
    print("schraenke1 $_bookcases");
    return _bookcases;
  } else {
    return loadBookCases().then((v) {

      print("${v as String}");
      print("schraenke2 $_bookcases");
      while (_bookcases!.length == 0) {}
      return _bookcases;
    });
  }
}
