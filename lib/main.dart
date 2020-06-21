import 'package:flutter/material.dart';
import 'core/config/app_routes.dart';

void main() => runApp(CookingForLunchApp());

class CookingForLunchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: AppRoutes.generateRoutes
    );
  }
}