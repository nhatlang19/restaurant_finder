import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'location.dart';
import 'restaurant.dart';
import 'review.dart';

class ZomatoClient {
  final _apiKey = DotEnv().env['ZAMATO_CLIENT_KEY'];

  final _host = 'developers.zomato.com';
  final _contextRoot = 'api/v2.1';

  Future<List<Location>> fetchLocations(String query) async {
    final results = await request(
        path: 'locations', parameters: {'query': query, 'count': '10'});

    final suggestions = results['location_suggestions'];
    return suggestions
        .map<Location>((json) => Location.fromJson(json))
        .toList(growable: false);
  }

  Future<List<Restaurant>> fetchRestaurants(
      Location location, String query) async {
    final results = await request(path: 'search', parameters: {
      'entity_id': location.id.toString(),
      'entity_type': location.type,
      'q': query,
      'count': '10'
    });

    final restaurants = results['restaurants']
        .map<Restaurant>((json) => Restaurant.fromJson(json['restaurant']))
        .toList(growable: false);

    return restaurants;
  }

  Future<List<Review>> fetchReviews(Restaurant restaurant, int start, int count) async {
    final results = await request(path: 'reviews', parameters: {
      'res_id': restaurant.id,
      'start': start.toString(),
      'count': count.toString(),
    });

    final reviews = results['user_reviews']
        .map<Review>((json) => Review.fromJson(json['review']))
        .toList(growable: false);

    return reviews;
  }

  Future<Map> request(
      {@required String path, Map<String, String> parameters}) async {
    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }

  Map<String, String> get _headers =>
      {'Accept': 'application/json', 'user-key': _apiKey};
}
