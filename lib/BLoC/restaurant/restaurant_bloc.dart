import 'package:bloc/bloc.dart';
import 'package:restaurant_finder/BLoC/restaurant/restaurant.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

import 'package:rxdart/rxdart.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final Location location;
  final _client = ZomatoClient();

  RestaurantBloc(this.location);

  @override
  // TODO: implement initialState
  RestaurantState get initialState => RestaurantUninitialized();

  @override
  Stream<RestaurantState> transformEvents(Stream<RestaurantEvent> events, Stream<RestaurantState> Function(RestaurantEvent) next) {
    return super.transformEvents(events.debounceTime(
      Duration(milliseconds: 500),
    ), next);
  }

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is Fetch) {
      try {
        final restaurants = await _client.fetchRestaurants(location, event.query);
        yield RestaurantLoaded(restaurants: restaurants);
      } catch (_) {
        yield RestaurantError();
      }
    }
  }
}