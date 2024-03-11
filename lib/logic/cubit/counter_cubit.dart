import 'dart:async';

import 'package:bloc_counter_basic_app/constants/enums.dart';
import 'package:bloc_counter_basic_app/logic/cubit/internet_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription _internectConnectionSupscription;

  CounterCubit({required this.internetCubit})
      : super(CounterState.init(counterValue: 0)) {
    _internectConnectionSupscription = monitorInternetState();
  }

  StreamSubscription<InternetState> monitorInternetState() {
    return internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Wifi) {
        increment();
      }
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) {
        decrement();
      }
    });
  }

  @override
  Future<void> close() {
    _internectConnectionSupscription.cancel();
    return super.close();
  }

  void increment() => emit(CounterState(
        counterValue: state.counterValue + 1,
        wasIncrement: true,
      ));

  void decrement() => emit(CounterState(
        counterValue: state.counterValue - 1,
        wasIncrement: false,
      ));
}
