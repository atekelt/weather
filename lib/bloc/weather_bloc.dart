import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/data/fetch_weather_and_date.dart';
import 'package:weather/data/model/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherDataFromAPI fetchWeartherData;

  WeatherBloc(this.fetchWeartherData) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if (event is GetWeatherForLocation) {
      final weather = await fetchWeartherData.fetchLocation();
      if (weather.isRight()) {
        var weathers = weather.fold((l) => null, (r) => r);
        yield WeatherLoaded(weathers);
      } else {
        yield Errors();
      }
    }
  }
}
