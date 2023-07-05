
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWidgets extends StatelessWidget {
  final double ratingRate;
  const RatingBarWidgets({super.key, required this.ratingRate});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: ratingRate,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 15,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
