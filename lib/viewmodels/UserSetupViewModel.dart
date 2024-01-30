import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:your_project_name_here/models/user.dart'; // replace with the actual path
import 'package:your_project_name_here/repositories/user_repository.dart';

import '../models/friend.dart'; // replace with the actual path

class UserSetupScreenState {
  late String userId;
  late String firstName;
  late bool setupSuccess;
  late String birthday;
  late int age;
  late bool validAge;
  late String image;
  late String username;
  late List<String> friendsList;
  late List<String> requestList;
  late List<String> requestedList;
  late bool continueBtnPressed;

  UserSetupScreenState() {
    userId = "";
    firstName = "";
    setupSuccess = false;
    birthday = "";
    age = 0;
    validAge = false;
    image = "";
    username = "";
    friendsList = [];
    requestList = [];
    requestedList = [];
    continueBtnPressed = false;
  }
}

class UserSetupViewModel extends ChangeNotifier {
  late UserSetupScreenState uiState;

  UserSetupViewModel() {
    uiState = UserSetupScreenState();
  }

  void calculateAge(String date) {
    List<String> localDate = date.split("/");
    int month = int.parse(localDate[0]);
    int day = int.parse(localDate[1]);
    int year = int.parse(localDate[2]);

    DateTime currentDate = DateTime.now();
    int age = currentDate.year - year;

    if (month > currentDate.month || (month == currentDate.month && day >= currentDate.day)) {
      age--;
    }

    uiState.age = age;
    uiState.validAge = age >= 18;
    notifyListeners();
  }

  Future<void> setPhoto() async {
    await UserRepository.setUserPhoto(uiState.image);
    print("URI: ${uiState.image}");
  }

  Future<void> uploadPhoto() async {
    String userId = UserRepository.getCurrentUserId();
    String imagePath = "users/profileImages/$userId";
    // Replace the following with the actual code for uploading the image to Firebase Storage
    // Example: FirebaseStorage.instance.ref(imagePath).putFile(uiState.image.toUri());
  }

  Future<void> createUser() async {
    await UserRepository.createUser();
  }

  Future<void> setUser() async {
    await UserRepository.setUser(
      uiState.userId,
      uiState.firstName,
      uiState.username,
      uiState.birthday,
      uiState.age,
      uiState.image,
      uiState.friendsList,
      uiState.requestList,
      uiState.requestedList,
    );
  }
}
