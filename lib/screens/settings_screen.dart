import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moviles_2024/settings/global_values.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkTheme = false;
  String selectedFont = "Default"; // Valor inicial

  final List<String> fonts = [
    "Default",
    "Lobster",
    "Roboto",
    "Arial",
    // Agrega más fuentes según tus necesidades
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Cargar preferencias al iniciar
  }

  // Método para cargar las preferencias guardadas
  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = prefs.getBool('isDarkTheme') ?? false; // Cargar tema
      selectedFont = prefs.getString('selectedFont') ?? "Default"; // Cargar fuente
      GlobalValues.banthemeDark.value = isDarkTheme; // Actualizar el ValueNotifier
      GlobalValues.selectedFont.value = selectedFont; // Actualizar el ValueNotifier
    });
  }

  // Método para guardar las preferencias
  _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme);
    prefs.setString('selectedFont', selectedFont);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuraciones"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text("Tema Oscuro"),
            value: isDarkTheme,
            onChanged: (bool value) {
              setState(() {
                isDarkTheme = value;
                GlobalValues.banthemeDark.value = isDarkTheme; // Actualizar ValueNotifier
                _savePreferences(); // Guardar preferencias
              });
            },
          ),
          DropdownButton<String>(
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
                child: Text(font),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
