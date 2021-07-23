import 'dart:async';
import 'dart:math';

import 'package:favorite_restaurant_app/common/navigation.dart';
import 'package:favorite_restaurant_app/common/style.dart';
import 'package:favorite_restaurant_app/ui/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  static const routeName = '/splash_page';

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  double _size = 100.0;
  Tween<double> _animationTween = Tween<double>(begin: 0, end: pi * 2);

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () {
      Navigation.intentWithoutData(HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: _animationTween,
              duration: Duration(seconds: 3),
              builder: (context, double value, child) {
                return Transform.rotate(
                  angle: value,
                  child: Container(
                    color: Colors.blue,
                    height: _size,
                    width: _size,
                    child: Image(image: AssetImage('assets/restaurant.jpg')),
                  ),
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Restaurants Dicoding',
              style: myTextTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
