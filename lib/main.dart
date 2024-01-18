import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';

import 'package:weatherapp/landingfolder/landingpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: _determinePosition(),
          builder: (context, snap) {
            if (snap.hasData) {
              return BlocProvider<WeatherBloc>(
                create: (context) => WeatherBloc(),
                child: LandingPage(snap: snap.data!),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return await Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return await Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}
