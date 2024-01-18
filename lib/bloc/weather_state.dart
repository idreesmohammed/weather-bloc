import 'package:weather/weather.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadSuccessState extends WeatherState {
  Weather weather;
  WeatherLoadSuccessState({required this.weather});
}

class WeatherLoadFailedState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}
