import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String author;
  final String reviewTimeFriendly;
  final Widget thumbnail;
  final String stars;
  final String likes;
  final String comments;

  ReviewItem(
      {Key key,
      this.title,
      this.subtitle,
      this.author,
      this.reviewTimeFriendly,
      this.thumbnail,
      this.stars,
      this.likes,
      this.comments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                    title: title,
                    subtitle: subtitle,
                    author: author,
                    reviewTimeFriendly: reviewTimeFriendly,
                    stars: this.stars,
                    likes: this.likes,
                    comments: this.comments),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription(
      {Key key,
      this.title,
      this.subtitle,
      this.author,
      this.reviewTimeFriendly,
      this.stars,
      this.likes,
      this.comments})
      : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String reviewTimeFriendly;
  final String stars;
  final String likes;
  final String comments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$author',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$stars- $reviewTimeFriendly',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$likes Likes, $comments Comments',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
