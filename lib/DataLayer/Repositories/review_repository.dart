import 'package:restaurant_finder/DataLayer/DataProviders/review_data_provider.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/DataLayer/review.dart';

class ReviewRepository {
  final ReviewDataProvider reviewDataProvider;

  ReviewRepository(this.reviewDataProvider);

  Future<List<Review>> getReviews(Restaurant restaurant, int start, int count) async {
    return await reviewDataProvider.getReviews(restaurant, start, count);
  }
}