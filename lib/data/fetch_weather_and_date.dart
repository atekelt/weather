import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/model/weather.dart';
import 'package:weather/data/networking.dart';

class FetchWeatherDataFromAPI {
  Future<Either<Exception, dynamic>> fetchWeatherOfDays(
      double lat, double log) async {
    var url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$log&units=metric&%20exclude=hourly,daily&appid=539033bedf5c563c554d7e3b5ebe9d6f';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData.fold(
      (erros) => left(erros),
      (resonse) {
        String cityName =
            resonse["timezone"].toString().split('/')[1].replaceAll('_', ' ');
        return right(
          Weather(
            cityName: cityName,
            temperatureCelsius: resonse['current']['temp'].toDouble(),
            icon: resonse['current']['weather'][0]['icon'],
            mainWeather: resonse['current']['weather'][0]['main'],
            day2: resonse['daily'][0]['temp']['day'].toDouble(),
            day2icon: resonse['daily'][0]['weather'][0]['icon'],
            main2Weather: resonse['daily'][0]['weather'][0]['description'],
            day3: resonse['daily'][1]['temp']['day'].toDouble(),
            day3icon: resonse['daily'][1]['weather'][0]['icon'],
            main3Weather: resonse['daily'][1]['weather'][0]['description'],
            day4: resonse['daily'][2]['temp']['day'].toDouble(),
            day4icon: resonse['daily'][2]['weather'][0]['icon'],
            main4Weather: resonse['daily'][2]['weather'][0]['description'],
            day5: resonse['daily'][3]['temp']['day'].toDouble(),
            day5icon: resonse['daily'][3]['weather'][0]['icon'],
            main5Weather: resonse['daily'][3]['weather'][0]['description'],
            day6: resonse['daily'][4]['temp']['day'].toDouble(),
            day6icon: resonse['daily'][4]['weather'][0]['icon'],
            main6Weather: resonse['daily'][4]['weather'][0]['description'],
            day7: resonse['daily'][5]['temp']['day'].toDouble(),
            day7icon: resonse['daily'][5]['weather'][0]['icon'],
            main7Weather: resonse['daily'][5]['weather'][0]['description'],
          ),
        );
      },
    );
  }

  Future fetchLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;
    return fetchWeatherOfDays(latitude, longitude);
  }
}

String getDate(int num) {
  DateTime date = DateTime.now();
  var newDate = DateTime(date.year, date.month, date.day + num);
  String dateFormat = DateFormat('EEEE').format(newDate);
  return dateFormat;
}
