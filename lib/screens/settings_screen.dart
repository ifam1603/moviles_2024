import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moviles_2024/settings/global_values.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedTheme = "Light"; // Valor inicial para el tema
  String selectedFont = "Default"; // Valor inicial para la fuente

  final List<String> themes = [
    "Light",
    "Dark",
    "Gold",
  ];

  final List<String> fonts = [
    "Default",
    "Lobster",
    "Roboto",
    "Arial",
    // Agregar más fuentes si es necesario
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Cargar las preferencias al iniciar
  }

  // Método para cargar las preferencias guardadas
  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTheme = prefs.getString('selectedTheme') ?? "Light"; // Cargar tema
      selectedFont = prefs.getString('selectedFont') ?? "Default"; // Cargar fuente
      GlobalValues.selectedTheme.value = selectedTheme; // Actualizar ValueNotifier
      GlobalValues.selectedFont.value = selectedFont; // Actualizar ValueNotifier
    });
  }

  // Método para guardar las preferencias
  _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedTheme', selectedTheme); // Guardar tema
    prefs.setString('selectedFont', selectedFont);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuraciones"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
          children: [
            // Espacio entre los Dropdowns
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButton<String>(
                value: selectedTheme,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTheme = newValue!;
                    GlobalValues.selectedTheme.value = selectedTheme; // Actualizar el tema seleccionado
                    _savePreferences(); // Guardar preferencias
                  });
                },
                items: themes.map<DropdownMenuItem<String>>((String theme) {
                  return DropdownMenuItem<String>(
                    value: theme,
                    child: Row(
                      children: [
                        Icon(Icons.brightness_6, color: Colors.blue), // Icono a la izquierda
                        SizedBox(width: 10), // Espacio entre el icono y el texto
                        Text(theme),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButton<String>(
                value: selectedFont,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedFont = newValue!;
                    GlobalValues.selectedFont.value = selectedFont; // Actualizar ValueNotifier
                    _savePreferences(); // Guardar preferencias
                  });
                },
                items: fonts.map<DropdownMenuItem<String>>((String font) {
                  return DropdownMenuItem<String>(
                    value: font,
                    child: Row(
                      children: [
                        Icon(Icons.font_download, color: Colors.green), // Icono a la izquierda
                        SizedBox(width: 10), // Espacio entre el icono y el texto
                        Text(font),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
