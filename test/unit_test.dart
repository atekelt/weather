import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:weather/data/fetch_weather_and_date.dart';

class FetchWeather extends Mock implements FetchWeatherDataFromAPI {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //change to your longitude and latitude
  double lat = 8.9806;
  double long = 38.7578;
  var url =
      'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&units=metric&%20exclude=hourly,daily&appid=539033bedf5c563c554d7e3b5ebe9d6f';
  group('Unit test...', () {
    test('Api test', () async {
      var resposes = await http.get(url);
      expect(resposes.statusCode, 200);
    });
    test('Data class test...', () async {
      final weatherData = FetchWeatherDataFromAPI();
      var data = await weatherData
          .fetchWeatherOfDays(lat, long)
          .then((value) async => await value.fold((l) => l, (r) => r));
      //change to your city name
      expect(data.cityName, 'Addis Ababa');
    });
    test('Date test', () {
      expect(getDate(1), 'Thursday');
    });
  });
}
