import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/review_bloc.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/DataLayer/review.dart';
import 'package:restaurant_finder/UI/image_container.dart';
import 'package:restaurant_finder/UI/review_item.dart';

class ReviewContainer extends StatefulWidget {
  final Restaurant restaurant;

  const ReviewContainer({Key key, this.restaurant}) : super(key: key);

  @override
  ReviewContainerState createState() => ReviewContainerState();
}

class ReviewContainerState extends State<ReviewContainer> {
  final _scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static const offsetVisibleThreshold = 10;

  ReviewBloc _bloc;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    _bloc = ReviewBloc(widget.restaurant);
    _bloc.submitQuery(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder<List<Review>>(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          final results = snapshot.data;

          if (results == null) {
            return Center(child: CircularProgressIndicator());
          }

          if (results.isEmpty) {
            return Center(child: Text('No Results'));
          }

          return RefreshIndicator(
              onRefresh: _bloc.refresh,
              child: ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                padding: const EdgeInsets.all(10.0),
                itemCount: results.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final review = results[index];
                  return ReviewItem(
                    thumbnail: ImageContainer(
                        width: 50,
                        height: 50,
                        shape: BoxShape.circle,
                        url: review.user.profileImage),
                    author: review.user.name,
                    reviewTimeFriendly: review.reviewTimeFriendly,
                    subtitle: review.reviewText,
                    stars: review.stars,
                    likes: review.likes,
                    comments: review.comments,
                  );
                },
              ));
        },
      ),
    );
  }

  void _onScroll() async {
    // if scroll to bottom of list, then load next page
//    print("_scrollController.offset:" + _scrollController.offset.toString());
//    print("offsetVisibleThreshold:" + offsetVisibleThreshold.toString());
//    print("_scrollController.position.maxScrollExtent:" + _scrollController.position.maxScrollExtent.toString());
    if (_scrollController.offset + offsetVisibleThreshold >=
        _scrollController.position.maxScrollExtent) {
      print('_bloc.loadMore');
      await _bloc.loadMore();
      await makeAnimation();
    }
  }

  Future<void> makeAnimation() async {
    final offsetFromBottom =
        _scrollController.position.maxScrollExtent - _scrollController.offset;
    if (offsetFromBottom < offsetVisibleThreshold) {
      await _scrollController.animateTo(
        _scrollController.offset - (offsetVisibleThreshold - offsetFromBottom),
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bloc.dispose();

    super.dispose();
  }
}
