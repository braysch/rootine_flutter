import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:your_package_name/models/user.dart';
import 'package:your_package_name/navigation/routes.dart';
import 'package:your_package_name/repositories/friends_repository.dart';
import 'package:your_package_name/repositories/user_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class ProfileScreenState {
  ValueNotifier<String> firstName = ValueNotifier("");
  ValueNotifier<String> username = ValueNotifier("");
  ValueNotifier<int> currency = ValueNotifier(0);
  ValueNotifier<String> image = ValueNotifier("");
  ValueNotifier<bool> profileLoaded = ValueNotifier(false);
  ValueNotifier<ui.Image> bitmap = ValueNotifier(ui.Image());
  ValueNotifier<String> imageLoc = ValueNotifier("");
  ValueNotifier<int> numMotivators = ValueNotifier(0);
}

class ProfileViewModel extends ChangeNotifier {
  ProfileScreenState _uiState = ProfileScreenState();
  ProfileScreenState get uiState => _uiState;

  Future<void> getProfileInfo() async {
    var user = await UserRepository.getUser();
    _uiState.firstName.value = user.firstName.toString();
    _uiState.username.value = user.username.toString();
    _uiState.currency.value = user.currency;
    _uiState.image.value = user.image.toString();
    _uiState.imageLoc.value = user.imageLoc.toString();
    _uiState.numMotivators.value = await UserRepository.getNumMotivators();
    _uiState.profileLoaded.value = true; // only load the profile once
  }

  Future<void> logOut(
      BuildContext context, GoogleSignIn googleSignIn, FirebaseAuth auth) async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
      await UserRepository.clearUser();
      Fluttertoast.showToast(
        msg: "Sign Out Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pushReplacementNamed(context, Routes.launchNavigation.route);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Sign Out Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

/*Future<void> setFriends() async {
    await FriendsRepository.setFriends();
  }*/
}
