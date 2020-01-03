import 'package:equatable/equatable.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RestaurantUninitialized extends RestaurantState {}

class RestaurantError extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  const RestaurantLoaded({this.restaurants});

  RestaurantLoaded copyWith({
    List<Restaurant> restaurants,
  }) {
    return RestaurantLoaded(
        restaurants: restaurants ?? this.restaurants);
  }

  @override
  // TODO: implement props
  List<Object> get props => [Restaurant];

  @override
  String toString() => 'RestaurantLoaded { restaurants: ${restaurants.length} }';
}