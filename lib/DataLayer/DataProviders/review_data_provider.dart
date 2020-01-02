import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/DataLayer/review.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

class ReviewDataProvider {
  final _client = ZomatoClient();

  Future<List<Review>> getReviews(Restaurant restaurant, int start, int count) async {
    List<Review> reviews = await _client.fetchReviews(restaurant, start, count);

    return reviews;
  }
}