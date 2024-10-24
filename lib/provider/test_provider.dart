import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier{
  //vamos a trabajar variables privadas con el provider
  //es necesario poner un get y un set vcon variables privadas
  String  _name = 'Chase';
  String get name => _name;
  set name (String value){
    _name = value;
    //con esto no importa si es stateless o stateful aun asi va a cambiar 
    notifyListeners();
  }
}