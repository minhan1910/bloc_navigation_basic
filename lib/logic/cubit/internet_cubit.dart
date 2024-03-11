import 'dart:async';

import 'package:bloc_counter_basic_app/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    connectivityStreamSubscription = monitorInternectConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternectConnection() {
    return connectivity.onConnectivityChanged.listen(
    (connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternectConnected(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternectConnected(ConnectionType.Mobile);
      } else {
        emitInternectDisconnected();
      }
    },
  );
  }

  void emitInternectConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternectDisconnected() =>
      emit(InternetDisconnected());

      @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
