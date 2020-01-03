import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_finder/BLoC/location/location.dart';
import 'package:restaurant_finder/UI/location_screen.dart';
import 'package:restaurant_finder/UI/restaurant_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (BuildContext context, LocationState state) {
        if (state is LocationUninitialized) {
          return LocationScreen();
        }

        return RestaurantScreen(location: (state as LocationLoaded).location);
      },
    );
  }
}
