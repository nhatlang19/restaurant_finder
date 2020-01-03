import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Fetch extends ReviewEvent {}
class Refresh extends ReviewEvent {}
