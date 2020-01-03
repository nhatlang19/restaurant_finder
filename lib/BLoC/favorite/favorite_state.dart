import 'package:equatable/equatable.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FavoriteUninitialized extends FavoriteState {}

class FavoriteError extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Restaurant> restaurants;

  const FavoriteLoaded({this.restaurants});

  FavoriteLoaded copyWith({
    List<Restaurant> restaurants,
  }) {
    return FavoriteLoaded(
        restaurants: restaurants ?? this.restaurants);
  }

  @override
  // TODO: implement props
  List<Object> get props => [Restaurant];

  @override
  String toString() => 'FavoriteLoaded { restaurants: ${restaurants.length} }';
}