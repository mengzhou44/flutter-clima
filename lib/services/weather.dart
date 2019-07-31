import 'package:http/http.dart' as http;
import 'location.dart';
import 'dart:convert';

const apiKey = '556afec6e2a4eaaf7b5ed036d3935c0a';

class Weather {
  String city;
  int condition;
  double temperature;
}

Future<Location> getLocation() async {
  Location location = Location();
  await location.getCurrentLocation();

  return location;
}

Future<Weather> getCityWeather(city) async {
  String url =
      'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

  return await getWeatherByUrl(url);
}

Future<Weather> getWeather() async {
  Location location = await getLocation();

  var latitude = location.latitude;
  var longitude = location.longitude;

  String url =
      'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

  return await getWeatherByUrl(url);
}

Future<Weather> getWeatherByUrl(url) async {
  try {
    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);

      Weather weather = Weather();
      weather.city = json['name'];
      weather.condition = json['weather'][0]['id'];
      weather.temperature = json['main']['temp'];

      return weather;
    } else {
      print(res.statusCode);
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

String getWeatherIcon(int condition) {
  if (condition < 300) {
    return '🌩';
  } else if (condition < 400) {
    return '🌧';
  } else if (condition < 600) {
    return '☔️';
  } else if (condition < 700) {
    return '☃️';
  } else if (condition < 800) {
    return '🌫';
  } else if (condition == 800) {
    return '☀️';
  } else if (condition <= 804) {
    return '☁️';
  } else {
    return '🤷‍';
  }
}

String getMessage(double temp) {
  if (temp > 25) {
    return 'It\'s 🍦 time';
  } else if (temp > 20) {
    return 'Time for shorts and 👕';
  } else if (temp < 10) {
    return 'You\'ll need 🧣 and 🧤';
  } else {
    return 'Bring a 🧥 just in case';
  }
}
