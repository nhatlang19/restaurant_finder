import 'package:equatable/equatable.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ToggleRestaurant extends FavoriteEvent {
  final Restaurant restaurant;

  ToggleRestaurant(this.restaurant);
}
