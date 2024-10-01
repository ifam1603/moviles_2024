import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviles_2024/onboarding/additional_screen.dart';
import 'package:moviles_2024/settings/global_values.dart';

class ThemeSettingsScreen extends StatefulWidget {
  @override
  _ThemeSettingsScreenState createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  // Lista de temas disponibles
  final List<String> themes = ["Light", "Dark", "Gold"];
  String selectedTheme = GlobalValues.selectedTheme.value; // Tema seleccionado inicial

  void updateTheme(String theme) {
    setState(() {
      selectedTheme = theme; // Actualizar tema seleccionado
      GlobalValues.selectedTheme.value = selectedTheme; // Actualizar ValueNotifier
    });
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
          Lottie.asset('assets/lottie_animation2.json', height: 200),
          
          // Dropdown para seleccionar el tema
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: DropdownButton<String>(
              value: selectedTheme,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  updateTheme(newValue); // Actualizar tema
                }
              },
              items: themes.map<DropdownMenuItem<String>>((String theme) {
                return DropdownMenuItem<String>(
                  value: theme,
                  child: Text(theme),
                );
              }).toList(),
            ),
          ),
          
          // ListTile para seleccionar la fuente
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
                        ListTile(
                          title: Text("Roboto"),
                          onTap: () {
                            updateFont("Roboto");
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text("Arial"),
                          onTap: () {
                            updateFont("Arial");
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
