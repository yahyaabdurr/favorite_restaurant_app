import 'package:favorite_restaurant_app/provider/restaurants_provider.dart';
import 'package:favorite_restaurant_app/ui/search_page.dart';
import 'package:favorite_restaurant_app/widgets/card_restaurant.dart';
import 'package:favorite_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatelessWidget {
  Widget _buildList() {
    return Consumer<RestaurantsProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: provider.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = provider.result.restaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
          );
        } else if (provider.state == ResultState.NoData) {
          return Center(child: Text(provider.message));
        } else {
          return Center(child: Text(provider.message));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants App'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, SearchRestaurant.routeName);
              })
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
