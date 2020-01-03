import 'package:equatable/equatable.dart';
import 'package:restaurant_finder/DataLayer/location.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LocationUninitialized extends LocationState {}

class LocationError extends LocationState {}

class LocationLoaded extends LocationState {
  final Location location;

  const LocationLoaded({this.location});

  LocationLoaded copyWith({
    Location location,
  }) {
    return LocationLoaded(
        location: location ?? this.location);
  }

  @override
  // TODO: implement props
  List<Object> get props => [location];

  @override
  String toString() => 'LocationLoaded { location: ${location.toString()} }';
}