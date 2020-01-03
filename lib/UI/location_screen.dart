import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_finder/BLoC/location/location.dart';
import 'package:restaurant_finder/DataLayer/location.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => LocationQueryBloc(),
        child: LocationWidget(isFullScreenDialog: isFullScreenDialog)
    );
  }
}

class LocationWidget extends StatefulWidget {
  final bool isFullScreenDialog;

  const LocationWidget({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  LocationWidgetState createState() => LocationWidgetState();
}

class LocationWidgetState extends State<LocationWidget> {
  LocationQueryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<LocationQueryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Where do you want to eat?')),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a location'),
                  onChanged: (query) {
                    _bloc.add(Query(query));
                  },
                )),
            Expanded(
              child: buildResults(),
            )
          ],
        ));
  }

  Widget buildResults() {
    return BlocBuilder<LocationQueryBloc, LocationQueryState>(
      builder: (BuildContext context, LocationQueryState state) {
        if (state is LocationQueryUninitialized) {
          return Center(child: Text('Enter a location'));
        }

        if (state is LocationQueryError) {
          return Center(
            child: Text('failed to fetch locations'),
          );
        }

        return _buildSearchResults((state as LocationQueryLoaded).locations);
      },
    );
  }

  Widget _buildSearchResults(List<Location> results) {
    // 2
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final location = results[index];
        return ListTile(
          title: Text(location.title),
          onTap: () {
            final locationBloc = BlocProvider.of<LocationBloc>(context);
            locationBloc.add(SelectLocation(location));

            if (widget.isFullScreenDialog) {
              Navigator.of(context).pop();
            }

            locationBloc.close();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}