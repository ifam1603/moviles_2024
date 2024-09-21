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
      builder: (context, value ,Widget) {
        return MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
          theme: GlobalValues.banthemeDark.value ? ThemeData.dark() : ThemeData.light(),
          routes: {
            "/home": (context) => HomeScreen(),
            "/db":(context)=> MoviesScreen()
          },
        );
      }
    );
  }
}

