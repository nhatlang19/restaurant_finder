import 'package:equatable/equatable.dart';
import 'package:restaurant_finder/DataLayer/review.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ReviewUninitialized extends ReviewState {}

class ReviewError extends ReviewState{}

class ReviewLoaded extends ReviewState {
  final List<Review> reviews;
  final bool hasReachedMax;

  const ReviewLoaded({
    this.reviews,
    this.hasReachedMax,
  });

  ReviewLoaded copyWith({
    List<Review> reviews,
    bool hasReachedMax,
  }) {
    return ReviewLoaded(
      reviews: reviews ?? this.reviews,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [reviews, hasReachedMax];

  @override
  String toString() =>
      'ReviewLoaded { reviews: ${reviews.length}, hasReachedMax: $hasReachedMax }';
}