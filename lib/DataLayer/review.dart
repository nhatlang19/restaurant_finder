import 'package:restaurant_finder/DataLayer/user.dart';

class Review {
  final String rating;
  final String reviewText;
  final String reviewTimeFriendly;
  final String likes;
  final String comments;
  final int timestamp;
  final User user;

  String get stars {
    final buffer = StringBuffer();
    for (int i = 0; i < double.parse(rating); i++) {
      buffer.write('★ ');
    }

    return buffer.toString();
  }

  Review.fromJson(Map json)
      : rating = json['rating'].toString(),
        reviewText = json['review_text'].toString(),
        reviewTimeFriendly = json['review_time_friendly'].toString(),
        likes = json['likes'].toString(),
        comments = json['comments_count'].toString(),
        timestamp = json['timestamp'],
        user = User.fromJson(json['user']);
}
