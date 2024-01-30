import 'package:flutter/foundation.dart';
import 'package:rootine/models/user.dart';
import 'package:rootine/repositories/user_repository.dart';
import 'package:rootine/util/loading_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreenViewModel extends ChangeNotifier {
  final loadingState = ValueNotifier(LoadingState.idle);
  var loginSuccess = false;
  var newUser = false;

  Future<void> signInWithGoogleCredential(AuthCredential credential) async {
    try {
      loadingState.value = LoadingState.loading;
      await FirebaseAuth.instance.signInWithCredential(credential);
      loadingState.value = LoadingState.loaded;
      await loadUserInfo();
      loginSuccess = true;
    } catch (e) {
      loadingState.value = LoadingState.error(e.toString());
    }
  }

  Future<void> loadUserInfo() async {
    await UserRepository.loadUserInfo();
    newUser = UserRepository.getUser().userId == null;
    if (newUser) {
      print("USER STATUS: NEW USER");
    } else {
      print("USER STATUS: RETURNING USER");
      print("USERID: ${UserRepository.getUser().userId}");
    }
  }
}
