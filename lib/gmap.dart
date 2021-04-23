import 'dart:async';

import 'package:digitaler_buecherschrank/drawer.dart';
import 'package:digitaler_buecherschrank/location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:location/location.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'search.dart';
import 'models/book_case.dart';
import 'book_info.dart';
import 'scanner/scanner_drop_form.dart';
import 'scanner/scanner_pickup_form.dart';

class GMap extends StatefulWidget {
  GMap({Key? key}) : super(key: key);
  @override
  _GMapState createState() => _GMapState();
}

class Places {
  Id iId;
  String address;
  String bcz;
  String comment;
  String contact;
  String deactivated;
  String deactreason;
  String digital;
  String entrytype;
  String homepage;
  String icontype;
  String lat;
  String lon;
  String open;
  String title;
  String type;

  Places(
      {this.iId,
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
      this.type});

  Places.fromJson(Map<String, dynamic> json) {
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
  }
}

class Id {
  String oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json[r"$oid"];
  }
}

class _GMapState extends State<GMap> with AutomaticKeepAliveClientMixin<GMap> {
  @override
  bool get wantKeepAlive => true;
//doesnt restart map

  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = new Completer();

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    var schraenke = await getBookCases();
    print("blabla${schraenke.length}");
    for (int i = 0; i < schraenke.length; i++) {
      var tempMarker = schraenke[i];
      _markers.add(Marker(
          markerId: MarkerId('${tempMarker.iId!.oid}'),
          position: LatLng(
            double.parse('${tempMarker.lat}'),
            double.parse(
              '${tempMarker.lon}',
            ),
          ),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 5), 'assets/icons/book.png'),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return Container(
                    color: Color(0xff757575),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ListTile(
                            title: Text('${tempMarker.title}'),
                          ),
                          ListTile(
                            title: Text('${tempMarker.address}'),
                          ),
                          ElevatedButton(
                              child: const Text("Siehe Bücher"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BookInfo('${tempMarker.iId.oid}')),
                                );
                              }),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ElevatedButton(
                                  child: Text(S.of(context).label_dropbook),
                                  onPressed: () {
                                    print('${tempMarker.iId!.oid}');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScannerDropForm(
                                              '${tempMarker.iId!.oid}')),
                                    );
                                  }),
                              ElevatedButton(
                                  child: Text(S.of(context).label_borrowbook),
                                  onPressed: () {
                                    print('${tempMarker.iId!.oid}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScannerPickupForm(
                                                    '${tempMarker.iId!.oid}')));
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }));
    }

    setState(() => null);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(50.1109, 8.6821),
              zoom: 12,
            ),
            markers: Set<Marker>.of(_markers),
          ),
          buildFloatingSearchBar()
        ],
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData userLocation = await LocationProvider.getLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(userLocation.latitude!, userLocation.longitude!),
        zoom: 17.0,
      ),
    ));
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 400),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      automaticallyImplyDrawerHamburger: true,
      width: isPortrait ? 600 : 500,

      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // TODO: Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: _currentLocation,
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
