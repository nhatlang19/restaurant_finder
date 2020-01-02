
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_finder/BLoC/review/review_bloc.dart';
import 'package:restaurant_finder/BLoC/review/review_event.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/detail_container.dart';
import 'package:restaurant_finder/UI/map_container.dart';
import 'package:restaurant_finder/UI/review_container.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(restaurant.name),
          bottom: TabBar(
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
                icon: Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            switch(choice.title) {
              case 'DETAIL': return DetailContainer(restaurant: restaurant);
              case 'MAP': return MapContainer(restaurant: restaurant);
              case 'REVIEWS': return BlocProvider(
                create: (context) => ReviewBloc(restaurant)..add(Fetch()),
                child: ReviewContainer()
              );
              default: return null;
            }
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;

  const Choice ({this.title, this.icon});
}

const List<Choice> choices = const <Choice> [
  const Choice(title: 'DETAIL', icon: Icons.details),
  const Choice(title: 'MAP', icon: Icons.map),
  const Choice(title: 'REVIEWS', icon: Icons.rate_review),
];