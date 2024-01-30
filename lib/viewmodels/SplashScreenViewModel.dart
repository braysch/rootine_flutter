import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:your_project_name_here/repositories/user_repository.dart';

class SplashScreenViewModel extends ChangeNotifier {
  Future<bool> isUserLoggedIn() async {
    return UserRepository.isUserLoggedIn();
  }
}
