import 'package:bloc_counter_basic_app/logic/cubit/counter_cubit.dart';
import 'package:bloc_counter_basic_app/logic/cubit/internet_cubit.dart';
import 'package:bloc_counter_basic_app/presentation/router/app__router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
    connectivity: Connectivity(),
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRouter,
    required this.connectivity,
  });
  final Connectivity connectivity;
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(
            internetCubit: BlocProvider.of<InternetCubit>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',        
        onGenerateRoute: appRouter.onGenerateRoute,
        // routes: {
        //   '/': (context) => BlocProvider.value(
        //         value: _counterCubit,
        //         child: HomeScreen(
        //           title: 'HomeScreen',
        //           colors: Colors.blueAccent,
        //         ),
        //       ),
        //   '/second': (context) => BlocProvider.value(
        //         value: _counterCubit,
        //         child: const SecondScreen(
        //           title: 'SecondScreen',
        //           colors: Colors.redAccent,
        //         ),
        //       ),
        //   '/third': (context) => BlocProvider.value(
        //         value: _counterCubit,
        //         child: const ThirdScreen(
        //           title: 'ThirdScreen',
        //           colors: Colors.greenAccent,
        //         ),
        //       ),
        // },
      ),
    );
  }
}
