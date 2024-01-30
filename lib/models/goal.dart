import 'dart:ui';

import 'package:flutter/material.dart';

class Goal {
  late String identification;
  late String id;
  late String userId;

  // values
  late String name;
  late String units;
  late double goal;
  late DateTime endDate;
  late double initialProgress;
  late DateTime startDate;
  late int daysStartDateToEndDate;
  late double dailyAverage;
  late int totalWeeks;
  late double progress;
  late int currentWeek;
  late double weeklyStartingPoint;
  late DateTime endOfWeek;
  late int daysStartDateToEndOfWeek;
  late double weeklyGoal;
  late double weeklyPercentage;
  late double totalPercentage;
  late DateTime completionDate;
  late double newGoal;
  late bool time;
  late bool private;
  late List<String>? motivators;

  // states
  late int state;

  late bool goalComplete;

  // colors
  late Color itemColor;
  late Color weeklyProgressColor;
  late Color targetBoxColor;
  late Color progressBoxColor;
  late Color percentageBoxColor;
  late Color totalProgressColor;

  // strings
  late String progressString;
  late String goalString;
  late String newGoalString;
  late String endDateString;
  late String startDateString;
  late String initialProgressString;
  late String errorMessage;

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
    if (weeklyPercentage.isNaN || weeklyPercentage < 0) {
      itemColor = Colors.red;
      weeklyProgressColor = Colors.red;
      targetBoxColor = Colors.red;
      progressBoxColor = Colors.red;
      percentageBoxColor = Colors.red;
      totalProgressColor = Colors.red;
    } else {
      if (weeklyPercentage < 1) {
        var colorResult = colorFinder(
            Color.fromRGBO(0, 0, 0, 1.0), Color.fromRGBO(255, 255, 255, 1.0),
            weeklyPercentage);
        itemColor = colorResult['color']!;
        weeklyProgressColor = Color.fromRGBO(255, 255, 255, 1.0);
        targetBoxColor = colorResult['color']!;
        progressBoxColor = colorResult['color']!;
        percentageBoxColor = colorResult['color']!;
        totalProgressColor = colorResult['color']!;
      } else {
        itemColor = Color.fromRGBO(255, 255, 255, 1.0);
        weeklyProgressColor = Color.fromRGBO(255, 255, 255, 1.0);
        targetBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        progressBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        percentageBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        totalProgressColor = Color.fromRGBO(255, 255, 255, 1.0);
      }
      if (goalComplete) {
        itemColor = Color.fromRGBO(255, 255, 255, 1.0);
        weeklyProgressColor = Color.fromRGBO(255, 255, 255, 1.0);
        targetBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        progressBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        percentageBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        totalProgressColor = Color.fromRGBO(255, 255, 255, 1.0);
      }
      if (state == 2) {
        itemColor = Color.fromRGBO(255, 255, 255, 1.0);
        targetBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
        progressBoxColor = Color.fromRGBO(255, 255, 255, 1.0);
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

  String validateEndDate() {
    try {
      endDate = DateTime.parse(endDateString);
      return endDate.isAfter(DateTime.now()) ? '' : 'End date must be in the future';
    } catch (e) {
      return 'Improperly formatted date';
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
        validateGoal() + validateEndDate() + validateInitialProgress();
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
    totalWeeks = getWeeks(startDate, endDate);
    totalPercentage = progress / goal;
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
    var firstEndOfWeek = getFirstEndOfWeek(start);
    var w = ((firstEndOfWeek.difference(end).inDays) / 7).ceil();
    if (start != firstEndOfWeek) w += 1;
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