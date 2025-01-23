import 'package:flutter/material.dart';
import 'Welcome_Screen.dart'; // Убедитесь, что путь к файлу указан правильно.
import 'Home_Screen.dart'; // Импортируйте HomeScreen
import 'Details_Screen.dart'; // Импортируйте DetailsScreen
import 'Login_Page.dart'; // Импортируйте LoginPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Отключить значок "Debug".
      title: 'Welcome App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(), // Укажите стартовый экран.
      routes: {
        '/home': (context) => HomeScreen(), // Маршрут к HomeScreen
        '/login': (context) => LoginPage(), // Маршрут к LoginPage
      },
    );
  }
}
