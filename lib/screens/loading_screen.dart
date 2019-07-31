import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import "location_screen.dart";
import '../services/weather.dart' as weatherHelper;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async {
    weatherHelper.Weather weather = await weatherHelper.getWeather();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weather);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}
