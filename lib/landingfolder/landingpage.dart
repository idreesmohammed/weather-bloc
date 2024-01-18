// ignore_for_file: must_be_immutable
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';
import 'package:weatherapp/bloc/weather_event.dart';

import 'package:weatherapp/bloc/weather_state.dart';

class LandingPage extends StatelessWidget {
  Position snap;
  LandingPage({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          bloc: WeatherBloc()..add(WeatherActionEvent(position: snap)),
          builder: (context, state) {
            if (state is WeatherLoadSuccessState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(5, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                            color: Colors.deepPurple, shape: BoxShape.circle),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-5, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                            color: Colors.deepPurple, shape: BoxShape.circle),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, -0.7),
                      child: Container(
                        height: 300,
                        width: 500,
                        decoration: const BoxDecoration(color: Colors.grey),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.transparent)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text("📍${state.weather.areaName}",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            greetMethod(),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: Image.asset("assets/cloud.png"),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                      "${state.weather.temperature!.celsius.toString().substring(0, 4)}°C",
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 1),
                                  Text(
                                      state.weather.weatherDescription
                                          .toString(),
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 10),
                                  Text(
                                      DateFormat.yMMMEd()
                                          .format(DateTime.now()),
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Image.asset("assets/sunny.png"),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        Text("Sunrise",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400)),
                                        Text(
                                            DateFormat('HH:MM a')
                                                .format(state.weather.sunrise!)
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400))
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset("assets/night.png"),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        Text("Sunset",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400)),
                                        Text(
                                            DateFormat('HH:MM a')
                                                .format(state.weather.sunset!)
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Divider(
                                height: 40,
                                color: Colors.white,
                                thickness: 0.3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset("assets/cold.png"),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        Text("Min Temp",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400)),
                                        Text(state.weather.tempMin.toString(),
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400))
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset("assets/hot.png"),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        Text("Max Temp",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400)),
                                        Text(state.weather.tempMax.toString(),
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ]),
                    )
                  ],
                ),
              );
            }
            if (state is WeatherLoadFailedState) {
              return Container(
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Text greetMethod() {
    int timeOfDay = DateTime.now().hour;

    if (timeOfDay <= 12) {
      return Text("Good Morning",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500));
    }
    if (timeOfDay < 17) {
      return Text("Good Afternoon",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500));
    }
    if (timeOfDay >= 17 && timeOfDay <= 20) {
      return Text("Good Evening",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500));
    }
    return Text("Good Night",
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500));
  }
}
