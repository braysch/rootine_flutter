import 'package:flutter/material.dart';
import 'package:your_package_name/models/goal.dart';
import 'package:your_package_name/repositories/data_repository.dart';
import 'package:your_package_name/repositories/rootines_repository.dart';
import 'package:your_package_name/repositories/user_repository.dart';
import 'package:your_package_name/util/date_constants.dart';
import 'package:joda_time/joda_time.dart';
import 'dart:math';

class RootineModificationScreenState {
  ValueNotifier<String> name = ValueNotifier("");
  ValueNotifier<bool> saveSuccess = ValueNotifier(false);
  final Uuid identification = Uuid();
  final String userId = UserRepository.getCurrentUserId();
  ValueNotifier<bool> valid = ValueNotifier(false);
  ValueNotifier<String> errorMessage = ValueNotifier("");

  ValueNotifier<String> inputEndDate =
  ValueNotifier(LocalDate.now().plusWeeks(1).toString(DateConstants.fmt));
  ValueNotifier<String> inputDaysToEnd = ValueNotifier("");
  ValueNotifier<String> inputWeeklyAverage = ValueNotifier("");
  ValueNotifier<String> inputInitialProgress = ValueNotifier("");
  ValueNotifier<String> inputTarget = ValueNotifier("");
  ValueNotifier<String> inputTargetHour = ValueNotifier("");
  ValueNotifier<String> inputTargetMinute = ValueNotifier("");
  ValueNotifier<String> inputProgressHour = ValueNotifier("");
  ValueNotifier<String> inputProgressMinute = ValueNotifier("");

  ValueNotifier<double> weeklyAverageHour = ValueNotifier(0.0);
  ValueNotifier<double> weeklyAverageMinute = ValueNotifier(0.0);

  ValueNotifier<String> inputWeeklyAverageHour =
  ValueNotifier(weeklyAverageHour.value.toString());
  ValueNotifier<String> inputWeeklyAverageMinute =
  ValueNotifier(weeklyAverageMinute.value.toString());

  ValueNotifier<double> goal = ValueNotifier(0.0);
  ValueNotifier<LocalDate> endDate = ValueNotifier(LocalDate.now());
  ValueNotifier<double> daysToEnd = ValueNotifier(0.0);
  ValueNotifier<double> weeklyAverage = ValueNotifier(0.0);
  ValueNotifier<double> dailyAverage = ValueNotifier(0.0);
  ValueNotifier<double> initialProgress = ValueNotifier(0.0);
  ValueNotifier<double> target = ValueNotifier(0.0);
  ValueNotifier<double> targetHour = ValueNotifier(0.0);
  ValueNotifier<double> targetMinute = ValueNotifier(0.0);
  ValueNotifier<double> progressHour = ValueNotifier(0.0);
  ValueNotifier<double> progressMinute = ValueNotifier(0.0);
  ValueNotifier<double> timeTarget = ValueNotifier(0.0);
  ValueNotifier<double> timeProgress = ValueNotifier(0.0);

  Rootine rootine = Rootine(identification: identification);
}

class RootineModificationViewModel extends ChangeNotifier {
  RootineModificationScreenState _uiState = RootineModificationScreenState();
  RootineModificationScreenState get uiState => _uiState;

  Future<void> reformatTimeTarget() async {
    if (_uiState.targetMinute.value >= 60.0) {
      _uiState.targetHour.value = _uiState.timeTarget.value.toInt().toDouble();
      _uiState.inputTargetHour.value = _uiState.targetHour.value.toString();
      _uiState.targetMinute.value =
          (_uiState.timeTarget.value - _uiState.targetHour.value) * 60.0;
      _uiState.inputTargetMinute.value =
          _uiState.targetMinute.value.toString();
    }
  }

  Future<void> reformatTimeProgress() async {
    if (_uiState.progressMinute.value >= 60.0) {
      _uiState.progressHour.value =
          _uiState.timeProgress.value.toInt().toDouble();
      _uiState.inputProgressHour.value =
          _uiState.progressHour.value.toString();
      _uiState.progressMinute.value =
          (_uiState.timeProgress.value - _uiState.progressHour.value) * 60.0;
      _uiState.inputProgressMinute.value =
          _uiState.progressMinute.value.toString();
    }
  }

  Future<void> timeTargetInput() async {
    // Set Hour and Minute Values
    try {
      if (_uiState.inputTargetHour.value.isBlank()) {
        _uiState.targetHour.value = 0.0;
      } else {
        _uiState.targetHour.value = _uiState.inputTargetHour.value.toDouble();
      }
    } catch (e) {
      _uiState.targetHour.value = 0.0;
    }
    try {
      if (_uiState.inputTargetMinute.value.isBlank()) {
        _uiState.targetMinute.value = 0.0;
      } else {
        _uiState.targetMinute.value =
            _uiState.inputTargetMinute.value.toDouble();
      }
    } catch (e) {
      _uiState.targetHour.value = 0.0;
    }
    // Set Time Target Value
    _uiState.timeTarget.value =
        _uiState.targetHour.value + (_uiState.targetMinute.value / 60.0);
    // Set Weekly Average
    setWeeklyAverageTime();
  }

  Future<void> timeProgressInput() async {
    // Set Hour and Minute Values
    try {
      if (_uiState.inputProgressHour.value.isBlank()) {
        _uiState.progressHour.value = 0.0;
      } else {
        _uiState.progressHour.value =
            _uiState.inputProgressHour.value.toDouble();
      }
    } catch (e) {
      _uiState.progressHour.value = 0.0;
    }
    try {
      if (_uiState.inputProgressMinute.value.isBlank()) {
        _uiState.progressMinute.value = 0.0;
      } else {
        _uiState.progressMinute.value =
            _uiState.inputProgressMinute.value.toDouble();
      }
    } catch (e) {
      _uiState.progressHour.value = 0.0;
    }
    // Set Time Progress Value
    _uiState.timeProgress.value =
        _uiState.progressHour.value + (_uiState.progressMinute.value / 60.0);
    // Set Weekly Average
    setWeeklyAverageTime();
  }

  void setWeeklyAverageTime() {
    if (_uiState.daysToEnd.value < 7) {
      _uiState.weeklyAverage.value =
      (_uiState.timeTarget.value - _uiState.timeProgress.value);
    } else {
      _uiState.weeklyAverage.value = ((_uiState.timeTarget.value -
          _uiState.timeProgress.value) /
          _uiState.daysToEnd.value) *
          7.0;
    }
    if (_uiState.weeklyAverage.value >
        (_uiState.timeTarget.value - _uiState.timeProgress.value)) {
      _uiState.weeklyAverage.value =
      (_uiState.timeTarget.value - _uiState.timeProgress.value);
    } else {
      _uiState.weeklyAverageHour.value =
          _uiState.weeklyAverage.value.toInt().toDouble();
      _uiState.weeklyAverageMinute.value = ((_uiState.weeklyAverage.value -
          _uiState.weeklyAverageHour.value) *
          60.0);
      _uiState.inputWeeklyAverage.value =
      "${_uiState.weeklyAverageHour.value.toInt()}h ${_uiState.weeklyAverageMinute.value.toInt()}m";
      _uiState.inputWeeklyAverageHour.value =
          _uiState.weeklyAverageHour.value.toString();
      _uiState.inputWeeklyAverageMinute.value =
          _uiState.weeklyAverageMinute.value.toString();
    }
  }

  void setWeeklyAverageCustom() {
    if (_uiState.daysToEnd.value < 7) {
      _uiState.weeklyAverage.value =
      (_uiState.target.value - _uiState.initialProgress.value);
    } else {
      _uiState.weeklyAverage.value = ((_uiState.target.value -
          _uiState.initialProgress.value) /
          _uiState.daysToEnd.value) *
          7.0;
    }
    if (_uiState.weeklyAverage.value >
        (_uiState.target.value - _uiState.initialProgress.value)) {
      _uiState.weeklyAverage.value =
      (_uiState.target.value - _uiState.initialProgress.value);
    } else {
      _uiState.inputWeeklyAverage = _uiState.weeklyAverage.value.toString();
    }
  }

  Future<void> endDateInput(bool time) async {
    if (await validateEndDate(_uiState.inputEndDate.value)) {
      _uiState.daysToEnd.value =
          Days.daysBetween(LocalDate.now(), _uiState.endDate.value).days.toDouble();
      _uiState.inputDaysToEnd = _uiState.daysToEnd.value.toString();

      if (time) {
        setWeeklyAverageTime();
      } else {
        setWeeklyAverageCustom();
      }
    }
  }

  Future<void> inputWeeklyAverageTime() async {
    // set weekly average
    try {
      if (_uiState.inputWeeklyAverageHour.value.isBlank()) {
        _uiState.weeklyAverageHour.value = 0.0;
      } else {
        _uiState.weeklyAverageHour.value =
            _uiState.inputWeeklyAverageHour.value.toDouble();
      }
    } catch (e) {
      _uiState.weeklyAverageHour.value = 0.0;
    }
    try {
      if (_uiState.inputWeeklyAverageMinute.value.isBlank()) {
        _uiState.weeklyAverageMinute.value = 0.0;
      } else {
        _uiState.weeklyAverageMinute.value =
            _uiState.inputWeeklyAverageMinute.value.toDouble();
      }
    } catch (e) {
      _uiState.weeklyAverageMinute.value = 0.0;
    }

    _uiState.weeklyAverage.value =
        _uiState.weeklyAverageHour.value + (_uiState.weeklyAverageMinute.value / 60.0);
    // reformat weekly average
    _uiState.weeklyAverageHour.value =
        _uiState.weeklyAverage.value.toInt().toDouble();
    _uiState.inputWeeklyAverageHour.value =
        _uiState.weeklyAverageHour.value.toString();
    _uiState.weeklyAverageMinute.value = ((_uiState.weeklyAverage.value -
        _uiState.weeklyAverageHour.value) *
        60.0);
    _uiState.inputWeeklyAverageMinute.value =
        _uiState.weeklyAverageMinute.value.toString();
    // set days
    _uiState.daysToEnd.value = ((_uiState.timeTarget.value -
        _uiState.timeProgress.value) /
        (_uiState.weeklyAverage.value / 7.0)).roundToDouble();
    _uiState.inputDaysToEnd = _uiState.daysToEnd.value.toString();
    // set date
    _uiState.endDate.value = LocalDate.now().plusDays(_uiState.daysToEnd.value.toInt());
    _uiState.inputEndDate =
        _uiState.endDate.value.toString(DateConstants.fmt);
    // set this last so it doesn't get messed up
    _uiState.inputWeeklyAverage =
    "${_uiState.weeklyAverageHour.value.toInt()}h ${_uiState.weeklyAverageMinute.value.toInt()}m";
  }

  Future<void> daysInput(bool time) async {
    // set days value
    try {
      if (_uiState.inputDaysToEnd.isBlank()) {
        _uiState.daysToEnd.value = 0.0;
      } else {
        _uiState.daysToEnd.value = _uiState.inputDaysToEnd.toDouble();
      }
    } catch (e) {
      _uiState.daysToEnd.value = 0.0;
    }
    // set date
    _uiState.endDate.value =
        LocalDate.now().plusDays(_uiState.daysToEnd.value.toInt());
    _uiState.inputEndDate =
        _uiState.endDate.value.toString(DateConstants.fmt);
    // set weekly average
    if (time) {
      setWeeklyAverageTime();
    } else {
      setWeeklyAverageCustom();
    }
  }

  Future<void> validateTitle() async {
    if (_uiState.name.isBlank()) {
      _uiState.errorMessage = "Name cannot be blank";
      _uiState.valid = false;
    } else {
      _uiState.valid = true;
    }
  }

  Future<void> addRootine() async {
    _uiState.rootine.milestoneUpdate(); // set initial values and colors
    RootinesRepository.createRootine(_uiState.rootine);
    _uiState.saveSuccess = true;

    // add to database
    DataRepository.createGoal(
        _uiState.identification.toString(),
        _uiState.rootine.name,
        _uiState.rootine.units,
        _uiState.rootine.goal,
        _uiState.rootine.endDateString,
        _uiState.rootine.initialProgress,
        _uiState.rootine.startDateString.toString(),
        _uiState.rootine.weeklyStartingPoint,
        _uiState.rootine.progress,
        _uiState.rootine.state,
        _uiState.rootine.time,
        _uiState.rootine.private,
        _uiState.userId,
    );
  }

  Future<void> validateDateInput(String input, ValueNotifier<LocalDate> output) async {
    try {
      output.value = LocalDate.parse(input, DateConstants.fmt);
      if (output.value.isBefore(LocalDate.now())) {
        _uiState.errorMessage = "Date must be in the future";
        return false;
      } else {
        return true;
      }
    } catch (e) {
      _uiState.errorMessage = "Improperly formatted date";
      return false;
    }
  }

  Future<bool> validateEndDate(String endDateString) async {
    if (await validateDateInput(endDateString, _uiState.endDate)) {
      if (_uiState.endDate.value.isBefore(LocalDate.now())) {
        _uiState.errorMessage = "Date cannot be in the past";
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> validateIntegerInput(String input, ValueNotifier<double> output) async {
    try {
      output.value = double.parse(input);
      if (output.value.toInt().toDouble() == output.value) {
        return true;
      } else {
        _uiState.errorMessage = "Value should be an integer";
        return false;
      }
    } catch (e) {
      if (input.isBlank) {
        _uiState.errorMessage = "Value cannot be blank";
      } else {
        _uiState.errorMessage = "Invalid input";
      }
      return false;
    }
  }

  Future<void> weeklyAverageInput() async {
    // set weekly average
    try {
      if (_uiState.inputWeeklyAverage.isBlank) {
        _uiState.weeklyAverage.value = 0.0;
      } else {
        _uiState.weeklyAverage.value = double.parse(_uiState.inputWeeklyAverage);
      }
    } catch (e) {
      _uiState.weeklyAverage.value = 0.0;
    }

    if (_uiState.weeklyAverage.value == 0.0) {
      _uiState.inputDaysToEnd = "0";
      _uiState.daysToEnd.value = 0.0;
      _uiState.endDate.value = LocalDate.now();
      _uiState.inputEndDate = _uiState.endDate.value.toString(DateConstants.fmt);
    } else {
      // set days
      _uiState.daysToEnd.value = ((_uiState.target.value - _uiState.initialProgress.value) /
          (_uiState.weeklyAverage.value / 7.0))
          .roundToDouble();
      _uiState.inputDaysToEnd = _uiState.daysToEnd.value.toString();
      // set date
      _uiState.endDate.value = LocalDate.now().plusDays(_uiState.daysToEnd.value.toInt());
      _uiState.inputEndDate = _uiState.endDate.value.toString(DateConstants.fmt);
    }
  }

  Future<bool> validateFloatInput(String input, ValueNotifier<double> output) async {
    try {
      output.value = double.parse(input);
      return true;
    } catch (e) {
      if (input.isBlank) {
        _uiState.errorMessage = "Value cannot be blank";
      } else {
        _uiState.errorMessage = "Invalid input";
      }
      return false;
    }
  }

  Future<void> customTargetInput() async {
    // Set target value
    try {
      if (_uiState.inputTarget.isBlank) {
        _uiState.target.value = 0.0;
      } else {
        _uiState.target.value = double.parse(_uiState.inputTarget);
      }
    } catch (e) {
      _uiState.target.value = 0.0;
    }
    // Set Weekly Average
    setWeeklyAverageCustom();
  }

  void resetInitialProgress() {
    _uiState.progressHour.value = 0.0;
    _uiState.progressMinute.value = 0.0;
    _uiState.timeProgress.value = 0.0;
  }

  void reloadInitialProgress() {
    try {
      if (_uiState.inputProgressHour.value.isBlank) {
        _uiState.progressHour.value = 0.0;
      } else {
        _uiState.progressHour.value = double.parse(_uiState.inputProgressHour.value);
      }
    } catch (e) {
      _uiState.progressHour.value = 0.0;
    }
    try {
      if (_uiState.inputProgressMinute.value.isBlank) {
        _uiState.progressMinute.value = 0.0;
      } else {
        _uiState.progressMinute.value = double.parse(_uiState.inputProgressMinute.value);
      }
    } catch (e) {
      _uiState.progressMinute.value = 0.0;
    }
    _uiState.timeProgress.value = _uiState.progressHour.value + (_uiState.progressMinute.value / 60.0);
  }

  void customProgressInput() {
    // Set progress value
    try {
      if (_uiState.inputInitialProgress.isBlank) {
        _uiState.initialProgress.value = 0.0;
      } else {
        _uiState.initialProgress.value = double.parse(_uiState.inputInitialProgress);
      }
    } catch (e) {
      _uiState.initialProgress.value = 0.0;
    }
    // Set Weekly Average
    setWeeklyAverageCustom();
  }
}


