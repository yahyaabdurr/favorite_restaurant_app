import 'dart:convert';
import 'package:favorite_restaurant_app/data/models/restaurant.dart';
import 'package:favorite_restaurant_app/data/models/restaurant_detail.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantsResult> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<RestaurantDetailResult> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + 'detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<RestaurantsResult> restaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + 'search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }
}
