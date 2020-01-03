import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_finder/BLoC/favorite/favorite.dart';
import 'package:restaurant_finder/UI/restaurant_tile.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState> (
        builder: (BuildContext context, FavoriteState state) {
          if (state is FavoriteUninitialized) {
            return Center(child: Text('No Favorites'));
          }

          if (state is FavoriteError) {
            return Center(
              child: Text('failed to fetch favorites'),
            );
          }

          var favorites = (state as FavoriteLoaded).restaurants;
          return ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final restaurant = favorites[index];
              return RestaurantTile(restaurant: restaurant);
            },
          );
        },
      )
    );
  }
}
