import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:restaurant_finder/BLoC/review/review.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

import 'package:rxdart/rxdart.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final Restaurant restaurant;
  final _client = ZomatoClient();
  static int offset = 0;
  static int limit = 10;

  ReviewBloc(this.restaurant);

  @override
  ReviewState get initialState => ReviewUninitialized();

  @override
  Stream<ReviewState> transformEvents(Stream<ReviewEvent> events, Stream<ReviewState> Function(ReviewEvent) next) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<ReviewState> mapEventToState(ReviewEvent event) async* {
    final currentState = state;
    if (event is Refresh) {
      final reviews = await _client.fetchReviews(restaurant, offset, limit);
      yield ReviewLoaded(reviews: reviews, hasReachedMax: false);
    }

    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ReviewUninitialized) {
          final reviews = await _client.fetchReviews(restaurant, offset, limit);
          yield ReviewLoaded(reviews: reviews, hasReachedMax: false);
        }

        if (currentState is ReviewLoaded) {
          final reviews = await _client.fetchReviews(
              restaurant, currentState.reviews.length, limit);
          yield reviews.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ReviewLoaded(
                  reviews: currentState.reviews + reviews,
                  hasReachedMax: false);
        }
      } catch (_) {
        yield ReviewError();
      }
    }
  }

  bool _hasReachedMax(ReviewState state) =>
      state is ReviewLoaded && state.hasReachedMax;

}
