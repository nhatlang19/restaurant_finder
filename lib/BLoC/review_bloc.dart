import 'dart:async';

import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/BLoC/bloc.dart';
import 'package:restaurant_finder/DataLayer/review.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

class ReviewBloc implements Bloc {
  final Restaurant restaurant;
  final _client = ZomatoClient();
  final _controller = StreamController<List<Review>>();

  Stream<List<Review>> get stream => _controller.stream;
  ReviewBloc(this.restaurant);

  void submitQuery(int start) async {
    final results = await _client.fetchReviews(restaurant, start);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}