import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/data/fetch_weather_and_date.dart';
import 'package:weather/data/model/weather.dart';

void main() {
  runApp(SearchWeather());
}

class SearchWeather extends StatefulWidget {
  @override
  _SearchWeatherState createState() => _SearchWeatherState();
}

class _SearchWeatherState extends State<SearchWeather> {
  String country;
  @override
  void initState() {
    // ignore: close_sinks
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeatherForLocation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is WeatherInitial) {
            return Container();
          } else if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is Errors) {
            return buildErrorIcon();
          } else if (state is WeatherLoaded) {
            return buildStack(state.weather);
          }
        },
      ),
    );
  }

  Center buildErrorIcon() {
    // ignore: close_sinks
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              return weatherBloc.add(GetWeatherForLocation());
            },
          ),
          Text('Check your internet connection and try again')
        ],
      ),
    );
  }

  Stack buildStack(Weather weather) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Image.asset(
          'assets/addisabeba.jpg',
          width: width,
          height: hight / 1.6,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: hight / 2.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  weather.cityName,
                  key: Key('cityName'),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text(
                  // Display the temperature with 1 decimal place
                  "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image:
                      'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  width: 70,
                ),
                // Icon(weather.icon, color: Colors.black,),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hight / 1.8),
          child: Container(
            color: Colors.blueGrey,
            width: width,
            height: hight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  buildRowForWaether(
                      days: 1,
                      day: weather.day2,
                      mainWeather: weather.main2Weather,
                      icon: weather.day2icon),
                  Divider(height: 4, color: Colors.black),
                  buildRowForWaether(
                      days: 2,
                      day: weather.day3,
                      mainWeather: weather.main3Weather,
                      icon: weather.day3icon),
                  Divider(height: 4, color: Colors.black),
                  buildRowForWaether(
                      days: 3,
                      day: weather.day4,
                      mainWeather: weather.main4Weather,
                      icon: weather.day4icon),
                  Divider(height: 4, color: Colors.black),
                  buildRowForWaether(
                      days: 4,
                      day: weather.day5,
                      mainWeather: weather.main5Weather,
                      icon: weather.day5icon),
                  Divider(height: 4, color: Colors.black),
                  buildRowForWaether(
                      days: 5,
                      day: weather.day6,
                      mainWeather: weather.main6Weather,
                      icon: weather.day6icon),
                  Divider(height: 4, color: Colors.black),
                  buildRowForWaether(
                      days: 6,
                      day: weather.day7,
                      mainWeather: weather.main7Weather,
                      icon: weather.day7icon),
                  Divider(height: 4, color: Colors.black),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Row buildRowForWaether(
      {int days, double day, String mainWeather, String icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getDate(days),
          key: Key('rowOfDays'),
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        Text(
          '$day °C $mainWeather',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: 'http://openweathermap.org/img/wn/$icon@2x.png',
          width: 40,
        ),
      ],
    );
  }

  Center buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
