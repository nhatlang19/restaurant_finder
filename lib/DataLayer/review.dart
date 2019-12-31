import 'package:restaurant_finder/DataLayer/user.dart';

class Review {
  final String rating;
  final String reviewText;
  final User user;

  Review.fromJson(Map json)
      : rating = json['rating'].toString(),
        reviewText = json['review_text'].toString(),
        user = User.fromJson(json['user']);
}
