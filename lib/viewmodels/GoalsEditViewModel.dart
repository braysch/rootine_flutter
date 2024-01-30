import 'package:flutter/foundation.dart';
import 'package:rootine/util/date_constants.dart';
import 'package:rootine/models/date_extensions.dart';
import 'package:rootine/util/math_extensions.dart';

class GoalsEditScreenState extends ChangeNotifier {
  var inputGoal = "";
  var inputEndDate = "";
  var inputDaysToEnd = "";
  var inputWeeklyAverage = "";

  var goal = 0.0;
  var endDate = DateTime.now().toLocalDate();
  var daysToEnd = 0.0;
  var weeklyAverage = 0.0;
  var startDate = DateTime.now().toLocalDate();

  var dailyAverage = 0.0;

  var errorMessage = "";
}

class GoalsEditViewModel extends ChangeNotifier {
  final uiState = GoalsEditScreenState();

  Future<bool> validateDateInput(String input, ValueNotifier<DateTime> output) async {
    try {
      output.value = DateTime.parse(input).toLocalDate();
      if (output.value.isBefore(DateTime.now())) {
        uiState.errorMessage = "Date must be in the future";
        return false;
      } else {
        return true;
      }
    } catch (e) {
      uiState.errorMessage = "Improperly formatted date";
      return false;
    }
  }

  Future<bool> validateDaysToEndInput(String daysToEndString) async {
    if (await validateIntegerInput(daysToEndString, uiState.daysToEnd)) {
      if (uiState.goal >= 0) {
        return true;
      } else {
        uiState.errorMessage = "Date cannot be in the past";
        return false;
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
        uiState.errorMessage = "Value should be an integer";
        return false;
      }
    } catch (e) {
      if (input.trim().isEmpty) {
        uiState.errorMessage = "Value cannot be blank";
      } else {
        uiState.errorMessage = "Invalid input";
      }
      return false;
    }
  }

  Future<bool> validateEndDate(String endDateString) async {
    if (await validateDateInput(endDateString, uiState.endDate)) {
      if (uiState.endDate.isBefore(DateTime.now())) {
        uiState.errorMessage = "Date cannot be in the past";
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> validateFloatInput(String input, ValueNotifier<double> output) async {
    try {
      output.value = double.parse(input);
      return true;
    } catch (e) {
      if (input.trim().isEmpty) {
        uiState.errorMessage = "Value cannot be blank";
      } else {
        uiState.errorMessage = "Invalid input";
      }
      return false;
    }
  }

  Future<bool> validateGoal(String goalString) async {
    if (await validateIntegerInput(goalString, uiState.goal)) {
      if (uiState.goal > 0) {
        return true;
      } else {
        uiState.errorMessage = "Goal must be greater than zero";
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> validateWeeklyAverage(String weeklyAverageString) async {
    if (await validateFloatInput(weeklyAverageString, uiState.weeklyAverage)) {
      if (uiState.weeklyAverage <= 0) {
        uiState.errorMessage = "Average should be greater than zero";
        return false;
      } else {
        uiState.dailyAverage = uiState.weeklyAverage / 7.0;
        return true;
      }
    } else {
      return false;
    }
  }

  Future<void> renewalEndDateInput(String endDateString, double progress) async {
    if (await validateEndDate(endDateString)) {
      uiState.daysToEnd = (uiState.endDate - DateTime.now().toLocalDate()).inDays.toDouble();
      uiState.inputDaysToEnd = uiState.daysToEnd.toString();

      uiState.weeklyAverage = ((uiState.goal - progress) / uiState.daysToEnd) * 7;
      uiState.inputWeeklyAverage = uiState.weeklyAverage.toString();
    }
  }

  Future<void> renewalGoalInput(String goalString, double progress) async {
    if (await validateGoal(goalString)) {
      uiState.weeklyAverage = ((uiState.goal - progress) / uiState.daysToEnd) * 7;
      uiState.inputWeeklyAverage = uiState.weeklyAverage.toString();
    }
  }

  Future<bool> validateRenewal() async {
    return await validateGoal(uiState.inputGoal) &&
        await validateEndDate(uiState.inputEndDate) &&
        await validateDaysToEndInput(uiState.inputDaysToEnd) &&
        await validateWeeklyAverage(uiState.inputWeeklyAverage);
  }

  Future<void> renewalWeeklyAverageInput(String weeklyAverageString, double progress) async {
    if (await validateWeeklyAverage(weeklyAverageString)) {
      uiState.daysToEnd = (uiState.goal - progress) / uiState.dailyAverage;
      uiState.inputDaysToEnd = uiState.daysToEnd.toString();

      uiState.endDate = DateTime.now().toLocalDate().add(Duration(days: uiState.daysToEnd.toInt()));
      uiState.inputEndDate = uiState.endDate.format(DateConstants.fmt);
    }
  }

  Future<void> renewalDaysInput(String daysToEndString, double progress) async {
    if (await validateDaysToEndInput(daysToEndString)) {
      uiState.endDate = DateTime.now().toLocalDate().add(Duration(days: uiState.daysToEnd.toInt()));
      uiState.inputEndDate = uiState.endDate.format(DateConstants.fmt);

      uiState.weeklyAverage = ((uiState.goal - progress) / uiState.daysToEnd) * 7;
      uiState.inputWeeklyAverage = uiState.weeklyAverage.toString();
    }
  }

  Future<void> renewPopulateValues(double progress, double initProgress, double dailyAverage, int totalDays, double goal) async {
    uiState.weeklyAverage = dailyAverage * 7;
    uiState.inputWeeklyAverage = uiState.weeklyAverage.toString();

    uiState.goal = goal;
    uiState.inputGoal = goal.toString();

    var progToDays = (progress - initProgress) / dailyAverage;

    uiState.endDate = DateTime.now().toLocalDate().add(Duration(days: totalDays.toInt())).subtract(Duration(days: progToDays.toInt()));
    uiState.inputEndDate = uiState.endDate.format(DateConstants.fmt);

    uiState.startDate = uiState.endDate.subtract(Duration(days: totalDays.toInt()));

    await renewalWeeklyAverageInput(uiState.inputWeeklyAverage, progress);
    notifyListeners();
  }

  Future<void> calculateStartDate() async {
    uiState.startDate = DateTime.now().toLocalDate();
    notifyListeners();
  }
}
