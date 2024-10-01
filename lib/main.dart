import 'package:flutter/material.dart';
import 'package:moviles_2024/screens/home_screen.dart';
import 'package:moviles_2024/screens/login_screen.dart';
import 'package:moviles_2024/screens/movies_screen.dart';
import 'package:moviles_2024/settings/global_values.dart';

void main() => runApp(const MyApp());

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
                "/home": (context) => HomeScreen(),
                "/db": (context) => MoviesScreen(),
              },
              // Apply the selected font globally
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
