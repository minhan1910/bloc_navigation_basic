import 'package:bloc_counter_basic_app/constants/enums.dart';
import 'package:bloc_counter_basic_app/logic/cubit/counter_cubit.dart';
import 'package:bloc_counter_basic_app/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.title,
    required this.colors,
  });

  final String title;
  final Color colors;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc basic'),
        backgroundColor: widget.colors,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {

                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return Text(
                    'Wi-fi',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.green,
                        ),
                  );
                }

                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return Text(
                    'Mobile',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.redAccent,
                        ),
                  );
                }

                if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.blueGrey,
                        ),
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
            const Text('You have pushed the button this many times:'),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncrement case != null && == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }

                if (state.wasIncrement case != null && == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.counterValue == 0) {
                  return Text(
                    'Start ${state.counterValue.toString()}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }

                if (state.counterValue % 2 == 0) {
                  return Text(
                    'Even  ${state.counterValue.toString()}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }

                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Builder(builder: (context) {
                  return FloatingActionButton(
                    heroTag: 'btnFirstScreenDecrement',
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  );
                }),
                Builder(builder: (context) {
                  return FloatingActionButton(
                    heroTag: 'btnFirstScreenIncrement',
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: 'increment',
                    child: const Icon(Icons.add),
                  );
                }),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: widget.colors,
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
              child: const Text('Go to second screen'),
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: widget.colors,
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              child: const Text('Go to third screen'),
            ),
          ],
        ),
      ),
    );
  }
}
