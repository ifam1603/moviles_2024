import 'package:flutter/material.dart';
import 'package:moviles_2024/screens/home_screen.dart';
import 'package:moviles_2024/screens/login_screen.dart';
import 'package:moviles_2024/screens/movies_screen.dart';
import 'package:moviles_2024/screens/settings_screen.dart';
import 'package:moviles_2024/onboarding/introduction_screen.dart';
import 'package:moviles_2024/settings/global_values.dart';
import 'package:moviles_2024/settings/themes_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  
  // carga las preferencias antes de inicar la app
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // checa si el onboarding ha sido visto, dejandolo en falso si no encuentra
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  
  //carga el tema guardado y la fuente
  String selectedTheme = prefs.getString('selectedTheme') ?? "Light";
  String selectedFont = prefs.getString('selectedFont') ?? "Default";
  
  //  actualiza los globalvalues con lo cargado en las preferencias 
  GlobalValues.selectedTheme.value = selectedTheme;
  GlobalValues.selectedFont.value = selectedFont;

  runApp(MyApp(hasSeenOnboarding: hasSeenOnboarding));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;

  const MyApp({required this.hasSeenOnboarding, super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: GlobalValues.selectedTheme,
      builder: (context, selectedTheme, child) {
        return ValueListenableBuilder<String>(
          valueListenable: GlobalValues.selectedFont,
          builder: (context, selectedFont, child) {
            return MaterialApp(
              title: 'Material App',
              debugShowCheckedModeBanner: false,
              home: LoginScreen(hasSeenOnboarding: hasSeenOnboarding), //pasa la bandera a login screen
              theme: (selectedTheme == "Dark")
                  ? ThemesSettings.darkTheme()
                  : (selectedTheme == "Gold")
                      ? ThemesSettings.goldTheme(context)
                      : ThemesSettings.lightTheme(context),
              routes: {
                "/login": (context) => LoginScreen(hasSeenOnboarding: hasSeenOnboarding),
                "/home": (context) => HomeScreen(),
                "/db": (context) => MoviesScreen(),
                "/settings": (context) => SettingsScreen(),
              },
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
