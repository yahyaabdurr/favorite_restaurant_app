import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:favorite_restaurant_app/common/navigation.dart';

import 'package:favorite_restaurant_app/data/api/restaurant_api.dart';
import 'package:favorite_restaurant_app/provider/db_provider.dart';
import 'package:favorite_restaurant_app/provider/restaurants_provider.dart';

import 'package:favorite_restaurant_app/provider/settings_provider.dart';
import 'package:favorite_restaurant_app/ui/home_page.dart';
import 'package:favorite_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:favorite_restaurant_app/ui/search_page.dart';
import 'package:favorite_restaurant_app/ui/splash_screen_page.dart';
import 'package:favorite_restaurant_app/utils/background_service.dart';
import 'package:favorite_restaurant_app/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                RestaurantsProvider(restService: RestaurantService())),
        ChangeNotifierProvider(
          create: (_) => DbProvider(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Restaurants App',
            theme:
                Provider.of<SettingsProvider>(context, listen: false).themeData,
            navigatorKey: navigatorKey,
            initialRoute: SplashScreenPage.routeName,
            routes: {
              SplashScreenPage.routeName: (context) => SplashScreenPage(),
              HomePage.routeName: (context) => HomePage(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                  id: ModalRoute.of(context)?.settings.arguments as String),
              SearchRestaurant.routeName: (context) => SearchRestaurant()
            },
          );
        },
      ),
    );
  }
}
