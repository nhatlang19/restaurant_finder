import 'package:bloc/bloc.dart';
import 'package:restaurant_finder/BLoC/location/location_event.dart';
import 'package:restaurant_finder/BLoC/location/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  @override
  // TODO: implement initialState
  LocationState get initialState => LocationUninitialized();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    var currentState = state;

    if (event is SelectLocation) {
      try {
        if (currentState is LocationUninitialized) {
          yield LocationLoaded(location: event.selectedLocation);
        }
      } catch (_) {
        yield LocationError();
      }
    }
  }
}
