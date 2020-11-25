import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/data/fetch_weather_and_date.dart';
import 'package:weather/screens/weathersearch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (context) => WeatherBloc(FetchWeatherDataFromAPI()),
      child: SearchWeather(),
    ));
  }
}
