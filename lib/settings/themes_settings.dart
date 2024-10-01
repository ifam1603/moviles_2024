import 'package:flutter/material.dart';

class ThemesSettings {
  static ThemeData lightTheme(BuildContext context) {
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 152, 25, 0), // Custom primary color
      ),
    );
  }

  static ThemeData darkTheme() {
    final theme = ThemeData.dark();
    return theme.copyWith();
  }

  static ThemeData goldTheme(BuildContext context) {
      return ThemeData(
        primaryColor: Colors.amber[700], // Gold color
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
            .copyWith(secondary: Colors.amber[600]),
        appBarTheme: AppBarTheme(
          color: Colors.amber[700], // AppBar color
          iconTheme: IconThemeData(color: Colors.white), // Icons color
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.amber[50], // Background color
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.brown[900]), // Body text color
          bodyMedium: TextStyle(color: Colors.brown[800]),
          displayLarge: TextStyle(color: Colors.brown[900], fontSize: 24),
          displayMedium: TextStyle(color: Colors.brown[800], fontSize: 20),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber[700], // Button color
          textTheme: ButtonTextTheme.primary, // Button text color
        ),
        iconTheme: IconThemeData(color: Colors.amber[700]), // Icons color
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.amber[600], // FAB color
        ),
      );
    }
}
