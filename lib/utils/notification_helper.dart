import 'dart:convert';
import 'dart:math';

import 'package:favorite_restaurant_app/common/navigation.dart';
import 'package:favorite_restaurant_app/data/models/restaurant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static int _restaurantIndex = 2;
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantsResult restaurants) async {
    var _channelId = '1';
    var _channelName = 'chanel_01';
    var _channelDescription = "restaurant channel";

    var androidPlatformChannelSpesifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpesifics = IOSNotificationDetails();
    var platformChannelSpesifics = NotificationDetails(
        android: androidPlatformChannelSpesifics,
        iOS: iOSPlatformChannelSpesifics);
    final _random = new Random();
    _restaurantIndex = _random.nextInt(restaurants.restaurants.length);
    var resturantName = restaurants.restaurants[_restaurantIndex].name;
    var restaurantId = restaurants.restaurants[_restaurantIndex].id;
    var titleNotification = "<b>$resturantName</b>";

    var payload = {"restaurantId": restaurantId};
    await flutterLocalNotificationsPlugin.show(0, titleNotification,
        'The best restaurant for you!', platformChannelSpesifics,
        payload: json.encode(payload));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = json.decode(payload);
      Navigation.intentWithData(route, data['restaurantId']);
    });
  }
}
