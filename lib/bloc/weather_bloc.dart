import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/bloc/weather_event.dart';
import 'package:weatherapp/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<WeatherActionEvent>((event, emit) async {
      print("object 1 ");
      emit(WeatherLoadingState());
      try {
        print("here");
        WeatherFactory weatherFactory = WeatherFactory(
            "2c10c8fae9e54e6542e1a4e7a3e5f585",
            language: Language.ENGLISH);
        print("here");
        Weather weather = await weatherFactory.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        print("here");

        emit(WeatherLoadSuccessState(weather: weather));
      } catch (e) {
        print("here fail");
        emit(WeatherLoadFailedState());
      }
    });
  }
}
