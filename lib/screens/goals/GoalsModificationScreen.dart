import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/repositories/GoalsManager.dart';

import '../../models/goal.dart';
import '../../util/GoalStates.dart';

class GoalModificationScreen extends StatefulWidget {
  @override
  _GoalModificationScreenState createState() => _GoalModificationScreenState();
}

class _GoalModificationScreenState extends State<GoalModificationScreen> {
  var name = "";
  var target = "";
  var units = "";
  var initialProgress = "0";
  var endDate = "";
  var weeklyAverage = "";
  var errorMessage = "ERROR MESSAGE";
  var time = true;
  var customUnits = false;
  var selectedHour = "1";
  var selectedMinute = "45";
  var selectedInitialHour = "0";
  var selectedInitialMinute = "0";
  var private = false;
  var scratch = false;
  var advanced = false;
  var weeklyAverageDialog = false;
  var inputWeeklyAverageHour = "";
  var inputWeeklyAverageMinute = "";
  var timeTargetPickerDialog = false;
  var timeProgressPickerDialog = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("New Goal!"),
            Text("What are you going to accomplish?"),
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(labelText: "Goal Title"),
            ),
            Text("How are you going to measure your success?"),
            Row(
              children: [
                Spacer(),
                Text("Time"),
                Switch(
                  value: !time,
                  onChanged: (value) {
                    setState(() {
                      time = !time;
                    });
                  },
                ),
                Text("Custom Units"),
                Spacer(),
              ],
            ),
            if (!time)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          target = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Target Value"),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          units = value;
                        });
                      },
                      decoration: InputDecoration(labelText: "Target Units"),
                    ),
                  ),
                ],
              ),
            if (time)
              Column(
                children: [
                  Text("Time Target $selectedHour:$selectedMinute"),
                  HourMinuteField(
                    onHourChanged: (hour) {
                      selectedHour = hour;
                    },
                    onMinuteChanged: (minute) {
                      selectedMinute = minute;
                    },
                    onUnfocused: () {
                      // Handle field unfocused
                    },
                  ),
                ],
              ),
            Row(
              children: [
                Text("Start from scratch"),
                Switch(
                  value: scratch,
                  onChanged: (value) {
                    setState(() {
                      scratch = !scratch;
                    });
                  },
                ),
                Text("Define initial progress"),
              ],
            ),
            if (scratch)
              Column(
                children: [
                  Text("Define your starting point"),
                  if (!time)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                initialProgress = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: "Initial Progress"),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Text(units),
                      ],
                    ),
                  if (time)
                    Column(
                      children: [
                        Text("Initial Progress $selectedInitialHour:$selectedInitialMinute"),
                        HourMinuteField(
                          onHourChanged: (hour) { selectedInitialHour = hour; },
                          onMinuteChanged: (minute) { selectedInitialMinute = minute; },
                          onUnfocused: () {
                            // Handle field unfocused
                          },
                        ),
                      ],
                    ),
                ],
              ),
            Text("When are you going to do it?"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        endDate = value;
                      });
                    },
                    decoration: InputDecoration(labelText: "End Date"),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  onPressed: () {
                    // Handle date picker dialog
                  },
                  icon: Icon(Icons.date_range),
                ),
              ],
            ),
            Row(
              children: [
                Text("Advanced"),
                Icon(Icons.accessibility),
              ],
            ),
            if (advanced)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        // Handle days input
                      },
                      decoration: InputDecoration(labelText: "Days"),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      readOnly: time,
                      onChanged: (value) {
                        // Handle weekly average input
                      },
                      onTap: () {
                        // Handle weekly average dialog
                      },
                      decoration: InputDecoration(labelText: "Weekly Average"),
                    ),
                  ),
                ],
              ),
            Row(
              children: [
                Text("Private"),
                Switch(
                  value: private,
                  onChanged: (value) {
                    setState(() {
                      private = !private;
                    });
                  },
                ),
              ],
            ),
            Text(
              "Private goals cannot be viewed or motivated by friends",
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
            ElevatedButton(
              onPressed: () {
                if (time) {
                  // Handle time case
                } else {
                  // Handle non-time case
                }
                // Handle button click
                Goal goal = Goal("123");
                goal.name = name;
                if (time)
                  {
                    goal.goal = double.tryParse(selectedHour) ?? 0.0;
                    goal.goal += (double.tryParse(selectedMinute) ?? 0.0) / 60.0;
                    goal.initialProgress = double.tryParse(selectedInitialHour) ?? 0.0;
                    goal.initialProgress += (double.tryParse(selectedInitialMinute) ?? 0.0) / 60.0;
                  }
                else
                  {
                    goal.goal = double.tryParse(target) ?? 0.0;
                    goal.initialProgress = double.tryParse(initialProgress) ?? 0.0;
                  }
                goal.units = units;
                goal.private = private;
                goal.progress = goal.initialProgress;
                goal.startDate = DateTime.now();
                goal.endDate = DateTime.now().add(Duration(days: 28));
                goal.state = GoalStates.INPROGRESS;
                goal.time = time;
                goal.calculateValues();
                goal.calculateColors();
                goal.milestoneUpdate();
                GoalsManager.goalsManager.allGoals.add(goal);
                GoalsManager.goalsManager.inProgress.add(goal);
                print("GOALS SIZE: ${GoalsManager.goalsManager.allGoals.length}\n");
              },
              child: Text("Continue"),
            ),
            Text(errorMessage),
          ],
        ),
      ),
    );
  }
}

class HourMinuteField extends StatelessWidget {
  final Function(String hour) onHourChanged;
  final Function(String minute) onMinuteChanged;
  final Function() onUnfocused;

  HourMinuteField({
    required this.onHourChanged,
    required this.onMinuteChanged,
    required this.onUnfocused
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              onHourChanged(value);
            },
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 8.0),
        Text("h"),
        SizedBox(width: 16.0),
        Expanded(
          child: TextField(
            onChanged: (value) {
              onMinuteChanged(value);
            },
            //value: minuteInputVariable,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 8.0),
        Text("m"),
      ],
    );
  }
}

class HourMinutePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NumberPicker(
            minValue: 0,
            maxValue: 23,
            defaultValue: 0,
            onValueChange: (value) {
              // Handle hour change
            },
          ),
        ),
        Text("Hours", textAlign: TextAlign.center),
        SizedBox(width: 16.0),
        Expanded(
          child: NumberPicker(
            minValue: 0,
            maxValue: 59,
            defaultValue: 0,
            onValueChange: (value) {
              // Handle minute change
            },
          ),
        ),
        Text("Minutes", textAlign: TextAlign.center),
      ],
    );
  }
}

class NumberPicker extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final int defaultValue;
  final Function(int) onValueChange;

  NumberPicker({
    required this.minValue,
    required this.maxValue,
    required this.defaultValue,
    required this.onValueChange,
  });

  @override
  Widget build(BuildContext context) {
    // Implement NumberPicker widget
    return Container();
  }
}

void main() {
  runApp(MaterialApp(
    home: GoalModificationScreen(),
  ));
}
