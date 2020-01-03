import 'package:equatable/equatable.dart';

abstract class LocationQueryEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Query extends LocationQueryEvent {
  final String query;

  Query(this.query);

  @override
  // TODO: implement props
  List<Object> get props => [this.query];
}