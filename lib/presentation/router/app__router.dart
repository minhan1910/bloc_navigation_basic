import 'package:bloc_counter_basic_app/presentation/screens/home_screen.dart';
import 'package:bloc_counter_basic_app/presentation/screens/second_screen.dart';
import 'package:bloc_counter_basic_app/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/second':
        return MaterialPageRoute(
          builder: (context) => const SecondScreen(
            title: 'SecondScreen',
            colors: Colors.redAccent,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (context) => const ThirdScreen(
            title: 'ThirdScreen',
            colors: Colors.greenAccent,
          ),
        );

      // '/' initial route
      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(
            title: 'HomeScreen',
            colors: Colors.blueAccent,
          ),
        );
    }
  }
}
