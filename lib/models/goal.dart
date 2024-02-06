import 'dart:ui';

import 'package:flutter/material.dart';

import '../ui.theme/Color.dart';
import '../util/functions.dart';

class Goal {
  late String identification;
  late String id;
  late String userId;

  // values
  late String name = "";
  late String units = "";
  late double goal = 0;
  late DateTime endDate = DateTime.now();
  late double initialProgress = 0;
  late DateTime startDate = DateTime.now();
  late int daysStartDateToEndDate = 0;
  late double dailyAverage = 0;
  late int totalWeeks = 0;
  late double progress = 0;
  late int currentWeek = 0;
  late double weeklyStartingPoint = 0;
  late DateTime endOfWeek = DateTime.now();
  late int daysStartDateToEndOfWeek = 0;
  late double weeklyGoal = 0;
  late double weeklyPercentage = 0;
  late double totalPercentage = 0;
  late DateTime completionDate = DateTime.now();
  late double newGoal = 0;
  late bool time = false;
  late bool private = false;
  late List<String>? motivators = [];

  // states
  late int state = 0;

  late bool goalComplete = false;

  // colors
  late Color itemColor = Colors.red;
  late Color weeklyProgressColor = Colors.red;
  late Color targetBoxColor = Colors.red;
  late Color progressBoxColor = Colors.red;
  late Color percentageBoxColor = Colors.red;
  late Color totalProgressColor = Colors.red;

  // strings
  late String progressString = "";
  late String goalString = "";
  late String newGoalString = "";
  late String endDateString = "";
  late String startDateString = "";
  late String initialProgressString = "";
  late String errorMessage = "";

  // transitions
  late dynamic exitTransition;

  static const int EDIT = 0;
  static const int DELETE = 5;
  static const int RENEW = 4;
  static const int SHELVE = 1;
  static const int REACTIVATE = 2;
  static const int EXTEND = 3;

  Goal(String identification) {
    this.identification = identification;
    this.id = identification.toString();
  }

  Map<String, dynamic> colorFinder(
      Color c1, Color c2, double p) {
    double r = p * (c2.red - c1.red) + c1.red;
    double g = p * (c2.green - c1.green) + c1.green;
    double b = p * (c2.blue - c1.blue) + c1.blue;
    Color c3 = Color.fromRGBO(r.round(), g.round(), b.round(), 1.0);
    return {'r': r, 'g': g, 'b': b, 'color': c3};
  }

  void calculateColors() {
    print("CALCULATE COLORS!");
    if (weeklyPercentage.isNaN || weeklyPercentage < 0) {
      itemColor = Colors.white;
      weeklyProgressColor = Colors.white;
      targetBoxColor = Colors.white;
      progressBoxColor = Colors.white;
      percentageBoxColor = Colors.white;
      totalProgressColor = Colors.white;
    } else {
      if (weeklyPercentage < 1) {
        var colorResult = colorFinder(
            c_weekly_progress, c_weekly_progress_finished,
            weeklyPercentage);
        itemColor = colorResult['color']!;
        weeklyProgressColor = colorResult['color']!;
        targetBoxColor = colorResult['color']!;
        progressBoxColor = Colors.white;
        percentageBoxColor = colorResult['color']!;
        totalProgressColor = colorResult['color']!;
      } else {
        itemColor = c_item_complete;
        weeklyProgressColor = c_weekly_progress_complete;
        targetBoxColor = c_target_box_complete;
        progressBoxColor = c_progress_box_complete;
        percentageBoxColor = c_percentage_box_complete;
        totalProgressColor = c_total_progress_complete;
      }
      if (goalComplete) {
        itemColor = Color.fromRGBO(255, 255, 255, 1.0);
        weeklyProgressColor = Color.fromRGBO(255, 255, 255, 1.0);
        targetBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        progressBoxColor = Colors.red;
        percentageBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        totalProgressColor = Color.fromRGBO(255, 255, 255, 1.0);
      }
      if (state == 2) {
        itemColor = Color.fromRGBO(255, 255, 255, 1.0);
        targetBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        progressBoxColor = Colors.red;
        percentageBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        totalProgressColor = Color.fromRGBO(255, 255, 255, 1.0);
      }
    }
  }

  String validateName() {
    return name.trim().isNotEmpty ? '' : 'Name cannot be blank';
  }

  String validateUnits() {
    return units.trim().isNotEmpty ? '' : 'Custom units cannot be blank';
  }

  String validateProgress() {
    try {
      progress = double.parse(progressString);
      return '';
    } catch (e) {
      return 'Invalid progress';
    }
  }

  String validateGoal() {
    try {
      goal = double.parse(goalString);
      return goal.toInt() == goal ? '' : 'Goal should be an integer';
    } catch (e) {
      return goalString.trim().isEmpty ? 'Goal cannot be blank' : 'Invalid goal';
    }
  }

  String validateNewGoal() {
    try {
      newGoal = double.parse(newGoalString);
      if (newGoal.toInt() == newGoal) {
        return newGoal > progress
            ? ''
            : 'New goal should be larger than current progress';
      } else {
        return 'New goal should be an integer';
      }
    } catch (e) {
      return newGoalString.trim().isEmpty ? 'Goal cannot be blank' : 'Invalid goal';
    }
  }

  String validateStartDate() {
    try {
      startDate = DateTime.parse(startDateString);
      return '';
    } catch (e) {
      return 'Improperly formatted date';
    }
  }

  String validateInitialProgress() {
    try {
      initialProgress = double.parse(initialProgressString);
      if (initialProgress.toInt() == initialProgress) {
        progress = initialProgress;
        return '';
      } else {
        return 'Goal should be an integer';
      }
    } catch (e) {
      if (initialProgressString.trim().isEmpty) {
        initialProgress = 0.0;
        progress = initialProgress;
        return '';
      } else {
        return 'Invalid goal';
      }
    }
  }

  String validate() {
    return validateProgress() + validateName() + validateUnits() +
        validateGoal() + /*validateEndDate() +*/ validateInitialProgress();
  }

  void setStateToShelved() {
    state = 2;
    completionDate = DateTime.now();
    calculateColors();
  }

  void setStateToInProgress() {
    state = 1;
  }

  void setStateToCompleted() {
    state = 3;
  }

  void setStateToDeleted() {
    state = 0;
  }

  void calculateValues() {
    currentWeek = getWeeks(startDate, DateTime.now());
    print("current_week:$currentWeek");
    totalWeeks = getWeeks(startDate, endDate);
    print("total_weeks:$totalWeeks");
    totalPercentage = progress / goal;
    print("progress:$progress");
    print("goal:$goal");
    print("total_percentage (progress/goal):$totalPercentage");
    daysStartDateToEndDate = endDate.difference(startDate).inDays;
    dailyAverage = (goal - initialProgress) / daysStartDateToEndDate;
    endOfWeek = getEndOfWeek(DateTime.now());
    daysStartDateToEndOfWeek = endOfWeek.difference(startDate).inDays;
    weeklyGoal = (dailyAverage * daysStartDateToEndOfWeek + initialProgress);
    weeklyGoal = (time ? (weeklyGoal / 60).round() : weeklyGoal.ceilToDouble()).toDouble();
    weeklyPercentage = (progress - weeklyStartingPoint) /
        (weeklyGoal - weeklyStartingPoint);
    if (weeklyPercentage > 9.99) weeklyPercentage = 9.99;
    if (weeklyPercentage < 0) weeklyPercentage = 0.0;
    progressUpdate();
  }

  void milestoneUpdate() {
    var oldWeeklyGoal = (dailyAverage * daysStartDateToEndOfWeek - 7 +
        initialProgress).roundToDouble();
    weeklyStartingPoint = progress >= oldWeeklyGoal
        ? oldWeeklyGoal
        : progress; // set base (0%) [Change only this]
    progressUpdate(); // update progress
    // update firebase
  }

  void progressUpdate() {
    // update values
    weeklyPercentage = (progress - weeklyStartingPoint) /
        (weeklyGoal - weeklyStartingPoint);
    totalPercentage = progress / goal;
    if (totalPercentage > 9.99) totalPercentage = 9.99;
    if (weeklyGoal >= goal && progress >= goal) weeklyPercentage = progress / goal;
    if (weeklyPercentage > 9.99) weeklyPercentage = 9.99;
    if (weeklyPercentage < 0) weeklyPercentage = 0.0;

    // update states
    if (progress >= goal) {
      if (!goalComplete) {
        completionDate = DateTime.now();
      } // date when first completed
      goalComplete = true;
    } else {
      goalComplete = false;
    }

    // update colors
    calculateColors();
  }

  DateTime getEndOfWeek(DateTime date) {
    return date.add(Duration(days: 1)).subtract(
        Duration(days: date.weekday - DateTime.sunday));
  }

  DateTime getFirstEndOfWeek(DateTime startDate) {
    return getEndOfWeek(startDate);
  }

  int getWeeks(DateTime start, DateTime end) {
    print("start:$start");
    print("end:$end");
    var firstEndOfWeek = getFirstEndOfWeek(start);
    print("first end of week:$firstEndOfWeek");
    print("diff: ${firstEndOfWeek.difference(end).inDays} days");
    var w = ((end.difference(firstEndOfWeek).inDays) / 7).ceil();
    print("w:$w");
    if (start != firstEndOfWeek) w += 1;
    print("w:$w");
    return w.toInt();
  }

  void renew(double rGoal, DateTime rEndDate, double rDailyAverage) {
    endDate = rEndDate;
    goal = rGoal;
    startDate = DateTime.now()
        .subtract(Duration(days: ((progress - initialProgress) / rDailyAverage)
        .floor()));
    setStateToInProgress();
    milestoneUpdate();
    //exitTransition = Transitions.SLIDE_RIGHT;
  }

  void activate() {
    var weeksShelved = getWeeks(completionDate, DateTime.now()) - 1;
    startDate.add(Duration(days: weeksShelved*7));
    endDate.add(Duration(days: weeksShelved*7));
    setStateToInProgress();
    progressUpdate();
    //exitTransition = Transitions.SLIDE_RIGHT;
  }

  void complete() {
    setStateToCompleted();
    //exitTransition = Transitions.SLIDE_RIGHT;
  }

  void delete() {
    setStateToDeleted();
    //exitTransition = Transitions.FADE_AWAY;
  }

  void shelve() {
    setStateToShelved();
    //exitTransition = Transitions.SLIDE_LEFT;
  }

  void extend() {
    var daysToCompletion =
        endDate.difference(completionDate).inDays;
    var newDaysStartDateToEndDate = completionDate.isAfter(endDate)
        ? (daysToCompletion * (newGoal / goal)).toInt()
        : (daysStartDateToEndDate * ((newGoal - initialProgress) /
        (goal - initialProgress))).toInt();
    startDate = DateTime.now().subtract(Duration(days: daysToCompletion));
    endDate = startDate.add(Duration(days: newDaysStartDateToEndDate));
    var progressTemp = progress; // can have weekly >0% if goal was exceeded
    progress = goal;
    initialProgress = goal;
    goal = newGoal;
    daysStartDateToEndDate = newDaysStartDateToEndDate;
    milestoneUpdate();
    progress = progressTemp;
    progressUpdate();
    setStateToInProgress();
    //exitTransition = Transitions.SLIDE_LEFT;
  }
}