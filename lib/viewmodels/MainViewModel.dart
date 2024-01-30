import 'package:flutter/material.dart';

class MainScreenState {}

class MainViewModel extends ChangeNotifier {
  MainScreenState _state = MainScreenState();
  MainScreenState get state => _state;

  MainViewModel() {
    // Initialization logic here
  }
}
