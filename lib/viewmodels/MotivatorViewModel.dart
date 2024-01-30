import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:your_package_name/models/motivator.dart';
import 'package:your_package_name/models/goal.dart';
import 'package:your_package_name/models/user.dart';
import 'package:your_package_name/repositories/data_repository.dart';
import 'package:your_package_name/repositories/rootines_repository.dart';
import 'package:your_package_name/repositories/user_repository.dart';
import 'package:your_package_name/util/motivator_types.dart';

class MotivatorScreenState {
  ValueNotifier<String> message = ValueNotifier("");
  ValueNotifier<bool> discreet = ValueNotifier(false);
  ValueNotifier<bool> anonymous = ValueNotifier(false);
  ValueNotifier<User> user = ValueNotifier(User());
  ValueNotifier<Rootine> goal = ValueNotifier(Rootine(Uuid().v4()));
}

class MotivatorViewModel extends ChangeNotifier {
  MotivatorScreenState _uiState = MotivatorScreenState();
  MotivatorScreenState get uiState => _uiState;

  Future<void> setGoal(Rootine goal) async {
    await RootinesRepository.setMotivatedGoal(goal);
  }

  Future<void> setUser(User user) async {
    await RootinesRepository.setMotivatedUser(user);
  }

  Future<Rootine> getGoal() async {
    return await RootinesRepository.getMotivatedGoal();
  }

  Future<User> getUser() async {
    return await RootinesRepository.getMotivatedUser();
  }

  Future<void> sendMotivation(int type) async {
    _uiState.goal.value = await getGoal();

    var motivator = Motivator()
      ..type = type
      ..message = _uiState.message.value
      ..discreet = _uiState.discreet.value
      ..anonymous = _uiState.anonymous.value;

    if (type == MotivatorTypes.MESSAGE) {
      motivator.imageUri = "";
      motivator.money = 0;
    }

    motivator.senderUsername = _uiState.user.value.username;
    motivator.senderUserImageUri = _uiState.user.value.imageLoc;

    _uiState.goal.value.motivators?.add(motivator.id);
    await updateGoal(_uiState.goal.value, motivator);

    var user = await UserRepository.getUser();
  }

  Future<void> updateGoal(Rootine goal, Motivator motivator) async {
    await DataRepository.updateGoal(goal);
    await DataRepository.uploadMotivator(motivator);
  }
}
