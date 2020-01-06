import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';

class MapContainer extends StatefulWidget {
  final Restaurant restaurant;

  const MapContainer({Key key, this.restaurant}) : super(key: key);

  @override
  MapContainerState createState() => MapContainerState();
}

class MapContainerState extends State<MapContainer> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(double.parse(widget.restaurant.lat), double.parse(widget.restaurant.long)),
      zoom: 14.4746,
    );

    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}