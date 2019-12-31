import 'package:flutter/cupertino.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';

class MapContainer extends StatelessWidget {
  final Restaurant restaurant;
  final double zoom;

  const MapContainer({Key key, this.restaurant, this.zoom = 14}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container();
  }

}