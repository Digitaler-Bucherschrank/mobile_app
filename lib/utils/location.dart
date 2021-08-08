import 'dart:async';

import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationProvider {
  static var _streamProvider = BehaviorSubject<LocationData>();

  static updateLocation(LocationData l) {
    _streamProvider.add(l);
  }

  static Future<LocationData> getLocation() async {
    ValueStream<LocationData> _currentLocation = _streamProvider.stream;

    return _currentLocation.first;
  }
}
