import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/review_bloc.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/DataLayer/review.dart';
import 'package:restaurant_finder/UI/image_container.dart';

class ReviewContainer extends StatelessWidget {
  final Restaurant restaurant;

  const ReviewContainer({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ReviewBloc(restaurant);
    bloc.submitQuery(0);

    return Scaffold(
      body: StreamBuilder<List<Review>>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final results = snapshot.data;

          if (results == null || results.isEmpty) {
            return Center(child: Text('No Results'));
          }

          return ListView.separated(
            itemCount: results.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final review = results[index];
              return ListTile(
                leading: ImageContainer(
                    width: 50, height: 50, url: review.user.profileImage),
                title: Text(review.user.name),
                subtitle: Text(review.reviewText),
              );
            },
          );
        },
      ),
    );
  }
}
