import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviles_2024/screens/home_screen.dart';

class AdditionalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie_animation3.json', height: 200),
            SizedBox(height: 20),
            Text("Perfil de Usuario", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text("Ir a Perfil"),
            ),
          ],
        ),
      ),
    );
  }
}
