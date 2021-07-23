import 'package:favorite_restaurant_app/data/api/restaurant_api.dart';
import 'package:favorite_restaurant_app/data/models/restaurant_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'module_restaurant_service_tes.mocks.dart';

var response = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "w9pga3s2tubkfw1e867",
    "name": "Bring Your Phone Cafe",
    "description":
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    "city": "Surabaya",
    "address": "Jln. Belimbing Timur no 27",
    "pictureId": "03",
    "categories": [
      {"name": "Modern"},
      {"name": "Italia"}
    ],
    "menus": {
      "foods": [
        {"name": "Salad lengkeng"},
        {"name": "Sosis squash dan mint"},
        {"name": "Toastie salmon"},
        {"name": "Salad yuzu"},
        {"name": "Matzo farfel"},
        {"name": "Kari terong"},
        {"name": "roket penne"},
        {"name": "Napolitana"},
        {"name": "Daging Sapi"},
        {"name": "Bebek crepes"},
        {"name": "Sup Kohlrabi"},
        {"name": "Ikan teri dan roti"},
        {"name": "Tumis leek"}
      ],
      "drinks": [
        {"name": "Kopi espresso"},
        {"name": "Coklat panas"},
        {"name": "Jus jeruk"},
        {"name": "Jus apel"},
        {"name": "Minuman soda"},
        {"name": "Air"},
        {"name": "Es kopi"}
      ]
    },
    "rating": 4.2,
    "customerReviews": [
      {"name": "Widdy", "review": "Tidak ada duanya!", "date": "13 Juli 2019"},
      {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      },
      {
        "name": "Gilang",
        "review": "Saya sangat suka menu malamnya!",
        "date": "13 Juli 2019"
      },
      {"name": "Guset", "review": "Saya suka Saya suka", "date": "21 Juli 2021"}
    ]
  }
};

var badResponse = {"error": true, "message": "not found", "restaurant": null};

@GenerateMocks([http.Client])
void main() {
  var restaurantService = RestaurantService();
  group('fetch restaurant service', () {
    test('return an RestaurantResult if the http call completes successfully',
        () async {
      final client = new MockClient();

      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/detail/w9pga3s2tubkfw1e867')))
          .thenAnswer((_) async => http.Response(response.toString(), 200));

      expect(await restaurantService.restaurantDetail('w9pga3s2tubkfw1e867'),
          isA<RestaurantDetailResult>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/detail/w9pga3s2tubkfw1e86')))
          .thenAnswer((_) async => http.Response(badResponse.toString(), 404));

      expect(restaurantService.restaurantDetail('w9pga3s2tubkfw1e86'),
          throwsException);
    });
  });
}
