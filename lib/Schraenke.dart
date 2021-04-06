import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'dart:convert';
import 'dart:async';

List<SchrankListe> _schraenke;

Future getDistance(String lat2, String lng2) async {
  String out;
  LocationData _locationData;
  Location location = new Location();
  double lng2db = double.parse(lng2);
  double lat2db = double.parse(lat2);
  _locationData = await location.getLocation();
  print(_locationData);
  var distanceBetweenPoints = SphericalUtil.computeDistanceBetween(
      LatLng(_locationData.latitude, _locationData.longitude),
      LatLng(lat2db, lng2db));
  out = (distanceBetweenPoints / 1000).toStringAsFixed(2);
  print(out);
  return out;
}

class SchrankListe {
  String title;
  String address;
  String id;
  var lat;
  var lon;
  var entfernung;
  SchrankListe(
      this.title, this.address, this.lat, this.lon, this.id, this.entfernung);
}

Future<void> getSchraenke() async {
  _schraenke = [];
  var _data = jsonDecode(await rootBundle.loadString("assets/markers.json"));

  for (var i in _data) {
    SchrankListe sch = SchrankListe(
      i["title"],
      i["address"],
      i["lat"],
      i["lon"],
      i["_id"]["\$oid"],
      await getDistance(i["lat"], i["lon"]),
    );
    _schraenke.add(sch);
  }
  print(_schraenke.length);
}

Future<List<SchrankListe>> schrankeFuture() async {
  if (_schraenke != null) {
    print("schraenke1 $_schraenke");
    return _schraenke;
  } else {
    return getSchraenke().then((v) {
      print("${v as String}");
      print("schraenke2 $_schraenke");
      while (_schraenke == null) {}
      return _schraenke;
    });
  }
}
