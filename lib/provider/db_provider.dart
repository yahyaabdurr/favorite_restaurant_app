import 'package:favorite_restaurant_app/data/models/restaurant_detail.dart';
import 'package:favorite_restaurant_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class DbProvider extends ChangeNotifier {
  List<RestaurantDetail> _restaurants = [];
  late DatabaseHelper _dbHelper;

  List<RestaurantDetail> get restaurants => _restaurants;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavorites();
  }

  void _getAllFavorites() async {
    _restaurants = await _dbHelper.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(RestaurantDetail restaurant) async {
    await _dbHelper.insertFavorite(restaurant);
    _getAllFavorites();
  }

  Future getFavoriteById(String id) async {
    final result = await _dbHelper.getFavoriteById(id);
    if (result != null) {
      return result;
    }

    return null;
  }

  void deleteFavorite(String id) async {
    await _dbHelper.deleteFavorite(id);
    _getAllFavorites();
  }
}
