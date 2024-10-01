import 'package:flutter/material.dart';

class ThemesSettings {
  static ThemeData lightTheme(BuildContext context){
      final theme = ThemeData.light();
      //theme.copyWith(); //En esta linea estamos copiando todas las propiedades sobre la clase que hicimos la copia
      return theme.copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Color.fromARGB(255, 152, 25, 0)
        )
      );
  }

  static ThemeData darkTheme(){
      final theme = ThemeData.dark();
      return theme.copyWith();
  }
  
}