import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:task_manager/model/weather_model.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';

class WeatherServices {
  static const Base_url = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices(this.apiKey);

  Future<Weather> getweather(String Name) async {
    final response = await http
        .get(Uri.parse('$Base_url?q=$Name&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      String? city = placemarks[0].locality;
      return city ?? "";
    } else {
      return "";
    }
  }
}