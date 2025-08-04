import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'pages/splash_page.dart';
import 'pages/role_manager.dart';
import 'data/mock_professionals.dart';
import 'data/supabase_client.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temp Staffing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: const SplashPage(),
    );
  }
} 