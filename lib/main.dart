import 'package:flutter/material.dart';
import 'package:moviles_2024/screens/home_screen.dart';
import 'package:moviles_2024/screens/login_screen.dart';
import 'package:moviles_2024/screens/movies_screen.dart';
import 'package:moviles_2024/screens/settings_screen.dart';
import 'package:moviles_2024/settings/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa Shared Preferences

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegúrate de que la inicialización de Flutter esté lista
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Cargar preferencias al iniciar
  bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false; // Por defecto, falso
  String selectedFont = prefs.getString('selectedFont') ?? "Default"; // Por defecto, "Default"

  // Actualiza los ValueNotifiers con las preferencias cargadas
  GlobalValues.banthemeDark.value = isDarkTheme;
  GlobalValues.selectedFont.value = selectedFont;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.banthemeDark,
      builder: (context, isDarkTheme, child) {
        return ValueListenableBuilder<String>(
          valueListenable: GlobalValues.selectedFont,
          builder: (context, selectedFont, child) {
            return MaterialApp(
              title: 'Material App',
              debugShowCheckedModeBanner: false,
              home: LoginScreen(),
              theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
              routes: {
                "/login": (context)=> LoginScreen(),
                "/home": (context) => HomeScreen(),
                "/db": (context) => MoviesScreen(),
                "/settings": (context) => SettingsScreen(),
              },
              // Aplicar la fuente seleccionada globalmente
              builder: (context, child) {
                return DefaultTextStyle(
                  style: TextStyle(fontFamily: selectedFont),
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
