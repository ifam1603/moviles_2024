import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviles_2024/onboarding/theme_settings_screen.dart';

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Introducción")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie_animation1.json', height: 200), // Add your Lottie animation file here
            SizedBox(height: 20),
            Text("Bienvenido a nuestra App!", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text("Esta aplicación te permitirá gestionar tus películas favoritas.",
                textAlign: TextAlign.center),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThemeSettingsScreen()),
                );
              },
              child: Text("Siguiente"),
            ),
          ],
        ),
      ),
    );
  }
}
