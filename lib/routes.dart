import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/splash_page.dart';
import 'pages/main_navigation_page.dart';
import 'pages/verification_prompt_page.dart';
import 'pages/signup_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String verification = '/verification';
  static const String mainNav = '/main';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case verification:
        return MaterialPageRoute(builder: (_) => const VerificationPromptPage());
      case mainNav:
        return MaterialPageRoute(builder: (_) => const MainNavigationPage());
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