import 'package:equatable/equatable.dart';
import 'package:restaurant_finder/DataLayer/location.dart';

abstract class LocationQueryState extends Equatable {
  const LocationQueryState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LocationQueryUninitialized extends LocationQueryState {}

class LocationQueryError extends LocationQueryState {}

class LocationQueryLoaded extends LocationQueryState {
  final List<Location> locations;
  final bool isLoaded;

  const LocationQueryLoaded({this.locations, this.isLoaded});

  LocationQueryLoaded copyWith({
    List<Location> locations,
    bool isLoaded,
  }) {
    return LocationQueryLoaded(
        locations: locations ?? this.locations,
        isLoaded: isLoaded ?? this.isLoaded);
  }

  @override
  // TODO: implement props
  List<Object> get props => [locations];

  @override
  String toString() => 'LocationQueryLoaded { locations: ${locations.length} }';
}
