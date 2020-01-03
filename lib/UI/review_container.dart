import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_finder/BLoC/review/review.dart';
import 'package:restaurant_finder/UI/image_container.dart';
import 'package:restaurant_finder/UI/review_item.dart';

class ReviewContainer extends StatefulWidget {
  const ReviewContainer({Key key}) : super(key: key);

  @override
  ReviewContainerState createState() => ReviewContainerState();
}

class ReviewContainerState extends State<ReviewContainer> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  ReviewBloc _bloc;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    _bloc = BlocProvider.of<ReviewBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is ReviewUninitialized) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is ReviewError) {
          return Center(
            child: Text('failed to fetch reviews'),
          );
        }

        if (state is ReviewLoaded) {
          if (state.reviews.isEmpty) {
            return Center(
              child: Text('no reviews'),
            );
          }
          return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                padding: const EdgeInsets.all(10.0),
                itemCount: state.hasReachedMax
                    ? state.reviews.length
                    : state.reviews.length + 1,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  if (index >= state.reviews.length) {
                    return BottomLoader();
                  }
                  final review = state.reviews[index];
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
              )
          );
        }
      },
    );
  }

  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.add(Fetch());
    }
  }

  Future<void> _onRefresh() async {
    _bloc.add(Refresh());
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
