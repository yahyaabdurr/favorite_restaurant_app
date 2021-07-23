import 'package:favorite_restaurant_app/common/style.dart';
import 'package:favorite_restaurant_app/data/api/restaurant_api.dart';
import 'package:favorite_restaurant_app/provider/db_provider.dart';
import 'package:favorite_restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:favorite_restaurant_app/provider/settings_provider.dart';
import 'package:favorite_restaurant_app/widgets/menu_card.dart';
import 'package:favorite_restaurant_app/widgets/ratings_stars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static String routeName = '/restaurant_detail';
  final String id;
  RestaurantDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) =>
            RestaurantDetailProvider(restService: RestaurantService(), id: id),
        child: Consumer<RestaurantDetailProvider>(builder: (context, rest, _) {
          if (rest.state == DetailState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (rest.state == DetailState.HasData) {
            var restaurant = rest.result.restaurant;

            String urlImage =
                "https://restaurant-api.dicoding.dev/images/medium/" +
                    restaurant.pictureId;
            String id = restaurant.id;
            return Consumer<DbProvider>(
              builder: (context, db, _) {
                return FutureBuilder(
                    future: db.getFavoriteById(id),
                    builder: (context, snapshot) {
                      var isFavorite = snapshot.data != null;
                      return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                SafeArea(
                                  child: Container(
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(urlImage),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                SafeArea(
                                  child: IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                                SafeArea(
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 280),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Provider.of<SettingsProvider>(
                                                  context,
                                                  listen: false)
                                              .isDarkTheme
                                          ? Colors.grey
                                          : Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          restaurant.name,
                                          style: myTextTheme.headline5,
                                        ),
                                        RatingStars(restaurant.rating),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              restaurant.city,
                                              style: contentStyle,
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(restaurant.description,
                                              style: myTextTheme.bodyText1),
                                        ),
                                        Text(
                                          "Foods",
                                          style: myTextTheme.headline5,
                                        ),
                                        Container(
                                          height: 190,
                                          child: Expanded(
                                            child: ListView(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              children: restaurant.menus!.foods!
                                                  .map((food) {
                                                return MenuCard(
                                                    urlImage, food.name);
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Drinks",
                                          style: myTextTheme.headline5,
                                        ),
                                        Container(
                                          height: 190,
                                          child: Expanded(
                                            child: ListView(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              children: restaurant
                                                  .menus!.drinks!
                                                  .map((drink) {
                                                return MenuCard(
                                                    urlImage, drink.name);
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Customers Review",
                                          style: myTextTheme.headline5,
                                        ),
                                        ListView(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          children: restaurant.customerReviews!
                                              .map((review) {
                                            return Container(
                                              margin: EdgeInsets.only(top: 10),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      Provider.of<SettingsProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .isDarkTheme
                                                          ? Colors.grey[600]
                                                          : Colors.white,
                                                  borderRadius: BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 3,
                                                        blurRadius: 15,
                                                        color: Colors.black12)
                                                  ]),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    size: 50,
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(review.name!,
                                                            style: myTextTheme
                                                                .bodyText1),
                                                        Text(
                                                          review.review!,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: contentStyle
                                                              .copyWith(
                                                                  fontSize: 14),
                                                        ),
                                                        Text(
                                                          review.date!,
                                                          style: contentStyle
                                                              .copyWith(
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SafeArea(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: 260,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              70),
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 4,
                                            offset:
                                                Offset(2, 4), // Shadow position
                                          ),
                                        ],
                                      ),
                                      child: isFavorite
                                          ? IconButton(
                                              onPressed: () {
                                                db.deleteFavorite(id);
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ))
                                          : IconButton(
                                              onPressed: () {
                                                db.addFavorite(restaurant);
                                              },
                                              icon: Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.red,
                                              ))),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
            );
          } else if (rest.state == DetailState.Error) {
            return Center(
              child: Text(rest.message),
            );
          } else {
            return Center(
              child: Text("Ada Masalah"),
            );
          }
        }),
      ),
    );
  }
}
