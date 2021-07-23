import 'package:favorite_restaurant_app/data/api/restaurant_api.dart';
import 'package:favorite_restaurant_app/data/models/restaurant_detail.dart';
import 'package:flutter/cupertino.dart';

enum DetailState { Loading, HasData, Error }

class RestaurantDetailProvider extends ChangeNotifier {
  final String id;
  final RestaurantService restService;

  RestaurantDetailProvider({required this.restService, required this.id}) {
    _fetchDetailRestaurant();
  }
  late DetailState _state;
  late RestaurantDetailResult _restaurantsDetailResult;
  String _message = '';

  String get message => _message;
  RestaurantDetailResult get result => _restaurantsDetailResult;
  DetailState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = DetailState.Loading;
      notifyListeners();
      final restaurant = await restService.restaurantDetail(id);

      _state = DetailState.HasData;
      notifyListeners();
      return _restaurantsDetailResult = restaurant;
    } catch (e) {
      _state = DetailState.Error;
      notifyListeners();
      return _message = 'Errror => $e';
    }
  }
}
