import 'package:favorite_restaurant_app/data/api/restaurant_api.dart';
import 'package:favorite_restaurant_app/data/models/restaurant.dart';
import 'package:flutter/cupertino.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class RestaurantsProvider extends ChangeNotifier {
  final RestaurantService restService;

  RestaurantsProvider({required this.restService}) {
    getRestaurant();
  }

  late ResultState _state;
  late RestaurantsResult _restaurantsResult;
  String _message = '';

  String get message => _message;
  RestaurantsResult get result => _restaurantsResult;
  ResultState get state => _state;

  void getRestaurant({String query = ''}) {
    if (query.isEmpty) {
      _fetchAllRestaurant();
    } else {
      _fetchSearchRestaurant(query);
    }
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await restService.restaurantList();

      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Errror => $e';
    }
  }

  Future<dynamic> _fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await restService.restaurantSearch(query);

      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Data Tidak ditemukan';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Errror => $e';
    }
  }
}
