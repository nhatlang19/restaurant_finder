import 'package:equatable/equatable.dart';
import 'package:restaurant_finder/DataLayer/location.dart';

abstract class LocationEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SelectLocation extends LocationEvent {
  final Location selectedLocation;

  SelectLocation(this.selectedLocation);

  @override
  // TODO: implement props
  List<Object> get props => [selectedLocation];
}