import 'dart:io';

import 'package:favorite_restaurant_app/provider/settings_provider.dart';
import 'package:favorite_restaurant_app/widgets/custom_dialog.dart';
import 'package:favorite_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const String settingsTitle = 'Settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SettingsPage.settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(SettingsPage.settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, provider, _) {
      return ListView(
        children: [
          Material(
            child: ListTile(
              title: Text('Dark Theme'),
              subtitle: Text('Enable Dark Theme'),
              trailing: Switch.adaptive(
                value: provider.isDarkTheme,
                onChanged: (value) async {
                  if (Platform.isIOS) {
                    customDialog(context);
                  } else {
                    provider.setDarkTheme(value);
                  }
                },
              ),
            ),
          ),
          Material(
            child: ListTile(
              title: Text('Restaurant Notification'),
              subtitle: Text('Enable Notification'),
              trailing: Switch.adaptive(
                value: provider.isScheduled,
                onChanged: (value) async {
                  if (Platform.isIOS) {
                    customDialog(context);
                  } else {
                    provider.setRestaurantNotification(value);
                  }
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
