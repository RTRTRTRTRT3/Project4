import 'package:flutter/material.dart';
import 'Welcome_Screen.dart'; // Убедитесь, что путь к файлу указан правильно.
import 'Home_Screen.dart'; // Импортируйте HomeScreen
import 'Details_Screen.dart'; // Импортируйте DetailsScreen
import 'Login_Page.dart'; // Убедитесь, что путь к файлу указан правильно.

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
      home: WelcomeScreen(), // Укажите WelcomeScreen как стартовый экран.
      routes: {
        '/login': (context) => LoginPage(), // Убедитесь, что здесь используется LoginPage
        '/home': (context) => HomeScreen(), // Маршрут к HomeScreen
      },
    );
  }
}
