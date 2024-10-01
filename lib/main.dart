import 'package:flutter/material.dart';
import 'package:moviles_2024/screens/home_screen.dart';
import 'package:moviles_2024/screens/login_screen.dart';
import 'package:moviles_2024/screens/movies_screen.dart';
import 'package:moviles_2024/screens/settings_screen.dart';
import 'package:moviles_2024/settings/global_values.dart';
import 'package:moviles_2024/settings/themes_settings.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa Shared Preferences

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegúrate de que la inicialización de Flutter esté lista
  
  // Cargar preferencias antes de iniciar la aplicación
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Cargar el tema guardado
  String selectedTheme = prefs.getString('selectedTheme') ?? "Light"; // Por defecto, "Light"
  String selectedFont = prefs.getString('selectedFont') ?? "Default"; // Por defecto, "Default"
  
  // Actualizar ValueNotifiers con las preferencias cargadas
  GlobalValues.selectedTheme.value = selectedTheme; // Actualiza el tema
  GlobalValues.selectedFont.value = selectedFont;   // Actualiza la fuente
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usar ValueListenableBuilder para que escuche el tema seleccionado
    return ValueListenableBuilder<String>(
      valueListenable: GlobalValues.selectedTheme,
      builder: (context, selectedTheme, child) {
        return ValueListenableBuilder<String>(
          valueListenable: GlobalValues.selectedFont,
          builder: (context, selectedFont, child) {
            return MaterialApp(
              title: 'Material App',
              debugShowCheckedModeBanner: false,
              home: LoginScreen(),
              theme: (selectedTheme == "Dark")
                  ? ThemesSettings.darkTheme()
                  : (selectedTheme == "Gold")
                      ? ThemesSettings.goldTheme(context)
                      : ThemesSettings.lightTheme(context), // Usar el tema adecuado
              routes: {
                "/login": (context) => LoginScreen(),
                "/home": (context) => HomeScreen(),
                "/db": (context) => MoviesScreen(),
                "/settings": (context) => SettingsScreen(),
              },
              builder: (context, child) {
                return DefaultTextStyle(
                  style: TextStyle(fontFamily: selectedFont), // Usar la fuente seleccionada
                  child: child!,
                );
              },
            );
          },
        );
      },
    );
  }
}
