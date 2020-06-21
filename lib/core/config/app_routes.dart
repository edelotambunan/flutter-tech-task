import 'package:flutter/material.dart';
import 'package:tech_task/features/fridge/view/fridge_screen.dart';
import 'package:tech_task/features/recipes/view/recipe_screen.dart';

class AppRoutes{
  static const String fridgeRoute = '/';
  static const String recipesRoute = '/recipes';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case fridgeRoute:
        return MaterialPageRoute(builder: (_) => FridgeScreen());
      case recipesRoute:
        return MaterialPageRoute(builder: (_) => RecipeScreen(selectedIngredients: settings.arguments),);
      default:
        return MaterialPageRoute(builder: (_) => FridgeScreen());
    }
  }
}