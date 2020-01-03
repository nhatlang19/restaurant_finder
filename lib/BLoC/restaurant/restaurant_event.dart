import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Fetch extends RestaurantEvent{
  final String query;

  Fetch(this.query);

  @override
  // TODO: implement props
  List<Object> get props => [this.query];
}