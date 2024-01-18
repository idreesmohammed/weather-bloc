import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weatherapp/permission_handler_location.dart/permission_handler_event.dart';
import 'package:weatherapp/permission_handler_location.dart/permission_handler_state.dart';

class PermissionHandlerBloc
    extends Bloc<PermissionHandlerEvent, PermissionHandlerState> {
  StreamSubscription<Position>? positionStreamSubscription;
  StreamSubscription<ServiceStatus>? serviceStatusStreamSubscription;

  bool positionStreamStarted = false;
  PermissionHandlerBloc() : super(PermissionHandlerInitialState()) {
    on<PermissionHandlerActionEvent>((event, emit) async {
      StreamSubscription<ServiceStatus> streamSubscription =
          Geolocator.getServiceStatusStream()
              .listen((ServiceStatus serviceStatus) {});
    });
  }
}
