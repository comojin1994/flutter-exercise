import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'John Doe';
  int _age = 25;

  String get name => _name;
  int get age => _age;

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateAge(int newAge) {
    _age = newAge;
    notifyListeners();
  }
}
