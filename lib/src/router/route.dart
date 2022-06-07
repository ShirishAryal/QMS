import 'package:flutter/material.dart';
import '../screens/auth_screens/signup_screen.dart';
import '../screens/bottom_nav_screens/home_screen.dart';
import '../screens/bottom_nav_screens/profile_screen.dart';
import '../screens/bottom_nav_screens/search_screen.dart';
import '../screens/bottom_nav_screens/bottom_nav.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/bottom_nav_screens/saved_screen.dart';

class QMSRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/bottomnav':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/saved':
        return MaterialPageRoute(builder: (_) => const SavedScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
