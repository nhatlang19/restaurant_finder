import 'package:bloc/bloc.dart';
import 'package:restaurant_finder/BLoC/location/query/location_query_event.dart';
import 'package:restaurant_finder/BLoC/location/query/location_query_state.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

import 'package:rxdart/rxdart.dart';

class LocationQueryBloc extends Bloc<LocationQueryEvent, LocationQueryState> {
  final _client = ZomatoClient();

  @override
  // TODO: implement initialState
  LocationQueryState get initialState => LocationQueryUninitialized();

  @override
  Stream<LocationQueryState> transformEvents(Stream<LocationQueryEvent> events, Stream<LocationQueryState> Function(LocationQueryEvent) next) {
    // TODO: implement transformEvents
    return super.transformEvents(events.debounceTime(
      Duration(milliseconds: 500),
    ), next);
  }

  @override
  Stream<LocationQueryState> mapEventToState(LocationQueryEvent event) async* {
    if (event is Query) {
      try {
        final locations = await _client.fetchLocations(event.query);
        yield LocationQueryLoaded(locations: locations, isLoaded: true);
      } catch (_) {
        yield LocationQueryError();
      }
    }
  }
}
