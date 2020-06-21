import 'package:flutter/material.dart';
import 'package:tech_task/features/fridge/view/fridge_screen.dart';

class AppRoutes{
  static const String fridgeRoute = '/';
  static const String recipesRoute = '/recipes';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case fridgeRoute:
        return MaterialPageRoute(builder: (_) => FridgeScreen());
      default:
        return MaterialPageRoute(builder: (_) => FridgeScreen());
    }
  }
}