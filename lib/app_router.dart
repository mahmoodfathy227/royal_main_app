import 'package:flutter/material.dart';
import 'package:royal_marketing/View/Widgets/main_page.dart';

import 'View/Screens/login_screen.dart';

class AppRouter {

  AppRouter();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home_screen':
        return MaterialPageRoute(
          builder: (_) => MainPage(selectedItemPosition: 0),
        );
      case 'login_screen':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}