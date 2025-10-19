import 'package:app/src/ui/screens/cart-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/pages.dart';
import 'ui/screens/splash-screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      case '/pages':
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}