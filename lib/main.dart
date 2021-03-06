import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_finder/BLoC/favorite/favorite.dart';
import 'package:restaurant_finder/BLoC/location/location.dart';
import 'package:restaurant_finder/BLoC/restaurant_finder_delegate.dart';
import 'package:restaurant_finder/UI/main_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await DotEnv().load('.env');
  BlocSupervisor.delegate = RestaurantFinderDelegate();
  runApp(RestaurantFinder());
}

class RestaurantFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationBloc>(
        create: (context) => LocationBloc(),
        child: BlocProvider<FavoriteBloc>(
            create: (context) => FavoriteBloc(),
            child: MaterialApp(
              title: 'Restaurant Finder',
              theme: ThemeData(
                primarySwatch: Colors.red,
              ),
              home: MainScreen(),
            )));
  }
}
