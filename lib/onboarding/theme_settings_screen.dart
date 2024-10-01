import 'package:flutter/material.dart';
import 'package:moviles_2024/onboarding/additional_screen.dart';
import 'package:moviles_2024/settings/global_values.dart'; // Importa GlobalValues

class ThemeSettingsScreen extends StatefulWidget {
  @override
  _ThemeSettingsScreenState createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  void updateTheme(bool value) {
    GlobalValues.banthemeDark.value = value; // Cambia el estado global del tema
  }

  void updateFont(String font) {
    GlobalValues.selectedFont.value = font; // Cambia el estado global de la fuente
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuración de Tema")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SwitchListTile(
            title: Text("Activar Tema Oscuro"),
            value: GlobalValues.banthemeDark.value,
            onChanged: updateTheme,
          ),
ListTile(
  title: Text("Seleccionar Fuente"),
  subtitle: Text(GlobalValues.selectedFont.value),
  onTap: () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Selecciona una fuente"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Default"),
                onTap: () {
                  updateFont("Default");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Lobster"),
                onTap: () {
                  updateFont("Lobster"); // Cambia a la fuente Lobster
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  },
),

          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdditionalScreen()),
              );
            },
            child: Text("Siguiente"),
          ),
        ],
      ),
    );
  }
}
