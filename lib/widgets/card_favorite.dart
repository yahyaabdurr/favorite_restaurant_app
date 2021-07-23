import 'package:favorite_restaurant_app/common/navigation.dart';
import 'package:favorite_restaurant_app/common/style.dart';

import 'package:favorite_restaurant_app/data/models/restaurant_detail.dart';
import 'package:favorite_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:favorite_restaurant_app/widgets/ratings_stars.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final RestaurantDetail restaurant;

  const FavoriteCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    String baseUrlImage = "https://restaurant-api.dicoding.dev/images/medium/";
    return GestureDetector(
        onTap: () => Navigation.intentWithData(
            RestaurantDetailPage.routeName, restaurant.id),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 120,
                    height: 118,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                                baseUrlImage + restaurant.pictureId),
                            fit: BoxFit.cover)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(restaurant.name, style: titleStyle),
                        Row(children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            restaurant.city,
                            style: contentStyle,
                          )
                        ]),
                        RatingStars(restaurant.rating)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
