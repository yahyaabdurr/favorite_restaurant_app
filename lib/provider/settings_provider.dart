import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:favorite_restaurant_app/common/style.dart';
import 'package:favorite_restaurant_app/utils/background_service.dart';
import 'package:favorite_restaurant_app/utils/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const NOTIFICATION = 'NOTIFICATION';
  static const DARK_THEME = 'DARK_THEME';
  bool _isScheduled = false;
  bool _isDarkTheme = false;

  bool get isScheduled => _isScheduled;
  bool get isDarkTheme => _isDarkTheme;
  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  SettingsProvider() {
    _getRestaurantNotification();
    _getDarkTheme();
  }

  void setRestaurantNotification(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(NOTIFICATION, value);
    _getRestaurantNotification();
  }

  void _getRestaurantNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isScheduled = prefs.getBool(NOTIFICATION) ?? false;
    notifyListeners();
    _scheduledRestaurants();
  }

  void _getDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool(DARK_THEME) ?? false;
    notifyListeners();
  }

  void setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(DARK_THEME, value);
    _getDarkTheme();
  }

  Future<bool> _scheduledRestaurants() async {
    if (_isScheduled) {
      print('scheduling restaurant active');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
