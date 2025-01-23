import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: WelcomeScreen(),
    routes: {
      '/login': (context) => LoginPage(),
    },
  ));
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Center(child: Text('Добро пожаловать на страницу логина!')),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Stack(
          children: [
            // Задний фон
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/screen1_back.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Логотип в центре
            Center(
              child: Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
            ),
            // Кнопка "Skip" в правом нижнем углу
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: Text('Skip'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}