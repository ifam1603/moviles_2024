import 'package:flutter/material.dart';
import 'package:moviles_2024/screens/home_screen.dart';
import 'package:moviles_2024/screens/profile_screen.dart';

class AdditionalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Perfil de Usuario", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            // Aquí puedes agregar más detalles del perfil del usuario
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de perfil
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
