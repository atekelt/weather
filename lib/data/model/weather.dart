import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperatureCelsius;
  final String icon;
  final String mainWeather;
  final double day2;
  final String day2icon;
  final String main2Weather;
  final double day3;
  final String day3icon;
  final String main3Weather;
  final double day4;
  final String day4icon;
  final String main4Weather;
  final double day5;
  final String day5icon;
  final String main5Weather;
  final double day6;
  final String day6icon;
  final String main6Weather;
  final double day7;
  final String day7icon;
  final String main7Weather;

  Weather({
    this.day7,
    this.day7icon,
    this.main7Weather,
    this.day2,
    this.day2icon,
    this.main2Weather,
    this.day3,
    this.day3icon,
    this.main3Weather,
    this.day4,
    this.day4icon,
    this.main4Weather,
    this.day5,
    this.day5icon,
    this.main5Weather,
    this.day6,
    this.day6icon,
    this.main6Weather,
    @required this.mainWeather,
    @required this.cityName,
    @required this.temperatureCelsius,
    @required this.icon,
  });

  @override
  List<Object> get props => [cityName, temperatureCelsius, icon, mainWeather];
}
