import 'package:bloc/bloc.dart';
import 'package:restaurant_finder/BLoC/favorite/favorite.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  @override
  // TODO: implement initialState
  FavoriteState get initialState => FavoriteUninitialized();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    var currentState = state;
    if (event is ToggleRestaurant) {
      try {
        if (currentState is FavoriteUninitialized) {
          yield FavoriteLoaded(restaurants: [event.restaurant]);
        }

        if (currentState is FavoriteLoaded) {
          List<Restaurant> restaurants = currentState.restaurants;
          if (restaurants.contains(event.restaurant)) {
            restaurants.remove(event.restaurant);
          } else {
            restaurants.add(event.restaurant);
          }
          print(restaurants.length);
          yield FavoriteLoaded(restaurants: restaurants);
        }
      } catch (_) {
        yield FavoriteError();
      }
    }
  }
}