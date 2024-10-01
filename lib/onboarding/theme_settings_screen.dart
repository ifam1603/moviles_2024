import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviles_2024/onboarding/additional_screen.dart';
import 'package:moviles_2024/settings/global_values.dart';

class ThemeSettingsScreen extends StatefulWidget {
  @override
  _ThemeSettingsScreenState createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  void updateTheme(bool value) {
    GlobalValues.banthemeDark.value = value;
  }

  void updateFont(String font) {
    GlobalValues.selectedFont.value = font;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuración de Tema")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie_animation2.json', height: 200), // Add your Lottie animation file here
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
                            updateFont("Lobster");
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
