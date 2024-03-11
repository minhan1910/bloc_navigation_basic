part of 'counter_cubit.dart';

class CounterState {
  final int counterValue;
  bool? wasIncrement;

  CounterState({required this.counterValue, this.wasIncrement = false});

  CounterState.init({required this.counterValue});

  void increment() => counterValue + 1;

  void decrement() => counterValue - 1;
}
