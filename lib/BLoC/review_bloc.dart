import 'dart:async';

import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/BLoC/bloc.dart';
import 'package:restaurant_finder/DataLayer/review.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

class ReviewBloc implements Bloc {
  final Restaurant restaurant;
  final _client = ZomatoClient();
  final _controller = StreamController<List<Review>>();

  int page = 0;

  Stream<List<Review>> get stream => _controller.stream;
  ReviewBloc(this.restaurant);

  List<Review> reviews = List<Review>();

  void submitQuery(int start) async {
    final results = await _client.fetchReviews(restaurant, start);
    if (start == 0) {
      reviews = results;
    } else {
      print('length' + reviews.length.toString());
      reviews = new List.from(reviews)..addAll(results);
    }

    _controller.sink.add(reviews);
  }

  void loadMore() {
    print("page:" + page.toString());
    submitQuery(++page);
  }

  void loadFirstPage() {
    page = 0;
    submitQuery(page);
  }

  Future<void> refresh() async {
    print('Refresh');
    loadFirstPage();
  }

  @override
  void dispose() {
    _controller.close();
  }
}
