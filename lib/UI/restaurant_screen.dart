import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_finder/BLoC/restaurant/restaurant.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/favorite_screen.dart';
import 'package:restaurant_finder/UI/restaurant_tile.dart';

class RestaurantScreen extends StatelessWidget {
  final Location location;

  const RestaurantScreen({Key key, @required this.location}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(location.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => FavoriteScreen())),
            )
          ],
        ),
        body: _buildSearch(context)
    );
  }

  Widget _buildSearch(BuildContext context) {
    return BlocProvider(
        create: (context) => RestaurantBloc(location),
        child: RestaurantWidget()
    );
  }
}

class RestaurantWidget extends StatefulWidget {
  @override
  RestaurantWidgetState createState() => RestaurantWidgetState();
}

class RestaurantWidgetState extends State<RestaurantWidget> {
  RestaurantBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<RestaurantBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What do you want to eat?'),
            onChanged: (query) => _bloc.add(Fetch(query)),
          ),
        ),
        Expanded(
          child: _buildStreamBuilder(),
        )
      ],
    );
  }


  Widget _buildStreamBuilder() {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (BuildContext context, RestaurantState state) {
        if (state is RestaurantUninitialized) {
          return Center(child: Text('Enter a restaurant name or cuisine type'));
        }

        if (state is RestaurantError) {
          return Center(
            child: Text('failed to fetch restaurants'),
          );
        }

        return _buildSearchResults((state as RestaurantLoaded).restaurants);
      },
    );
  }

  Widget _buildSearchResults(List<Restaurant> results) {
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final restaurant = results[index];
        return RestaurantTile(restaurant: restaurant);
      },
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}