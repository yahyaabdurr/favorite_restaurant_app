import 'package:favorite_restaurant_app/provider/db_provider.dart';
import 'package:favorite_restaurant_app/widgets/card_favorite.dart';

import 'package:favorite_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({Key? key}) : super(key: key);
  static const String title = 'Favorite Restaurants';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.headline5),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DbProvider>(
      builder: (context, provider, _) {
        if (provider.restaurants.length > 0) {
          return ListView.builder(
            itemCount: provider.restaurants.length,
            itemBuilder: (context, index) {
              return FavoriteCard(
                restaurant: provider.restaurants[index],
              );
            },
          );
        } else {
          return Center(
            child: Text('Belum ada data'),
          );
        }
      },
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
