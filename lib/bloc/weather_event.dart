import 'package:geolocator/geolocator.dart';

abstract class WeatherEvent {}

class WeatherActionEvent extends WeatherEvent {
  Position position;
  WeatherActionEvent({required this.position});
}
