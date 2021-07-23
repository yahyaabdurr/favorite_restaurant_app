import 'package:favorite_restaurant_app/common/navigation.dart';
import 'package:favorite_restaurant_app/common/style.dart';
import 'package:favorite_restaurant_app/provider/restaurants_provider.dart';
import 'package:favorite_restaurant_app/widgets/card_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchRestaurant extends StatefulWidget {
  static String routeName = '/search';
  @override
  _SearchRestaurantState createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigation.back();
                  },
                  icon: Icon(Icons.arrow_back)),
              Container(
                width: MediaQuery.of(context).size.width - 70,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Consumer<RestaurantsProvider>(
                  builder: (context, provider, _) {
                    return TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor, width: 2.0),
                        ),
                        labelText: 'Search restaurant',
                        focusColor: mainColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: mainColor),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: mainColor,
                        ),
                      ),
                      onChanged: (String query) {
                        provider.getRestaurant(query: query);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Consumer<RestaurantsProvider>(builder: (context, rest, _) {
            if (rest.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (rest.state == ResultState.HasData) {
              return Expanded(
                child: ListView.builder(
                    itemCount: rest.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = rest.result.restaurants[index];
                      return RestaurantCard(restaurant: restaurant);
                    }),
              );
            } else if (rest.state == ResultState.NoData) {
              return Center(
                child: Text(rest.message),
              );
            } else if (rest.state == ResultState.Error) {
              return Center(
                child: Text(rest.message),
              );
            } else {
              return Center(
                child: Text("Ada Masalah"),
              );
            }
          }),
        ]),
      ),
    );
  }
}
