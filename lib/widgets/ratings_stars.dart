import 'package:flutter/material.dart';
import 'package:favorite_restaurant_app/common/style.dart';

class RatingStars extends StatelessWidget {
  final double rate;

  RatingStars(this.rate);
  @override
  Widget build(BuildContext context) {
    int totalStars = rate.round();
    return Row(
        children: List<Widget>.generate(
                5,
                (index) => Icon(
                    (index <= totalStars)
                        ? Icons.star
                        : Icons.star_border_outlined,
                    size: 16,
                    color: Color(0xfff39c12))) +
            [
              SizedBox(
                width: 5,
              ),
              Text(
                rate.toString(),
                style: myTextTheme.bodyText2,
              )
            ]);
  }
}
