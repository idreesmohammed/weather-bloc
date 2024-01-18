import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/bloc/weather_event.dart';
import 'package:weatherapp/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<WeatherActionEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        WeatherFactory weatherFactory = WeatherFactory(
            "2c10c8fae9e54e6542e1a4e7a3e5f585",
            language: Language.ENGLISH);

        Weather weather = await weatherFactory.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        emit(WeatherLoadSuccessState(weather: weather));
      } catch (e) {
        emit(WeatherLoadFailedState());
      }
    });
  }
}
