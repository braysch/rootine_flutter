import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../util/GoalStates.dart';
import 'ProgressUpdater.dart';

class GoalItem extends StatefulWidget {
  final Goal goal;

  const GoalItem({Key? key, required this.goal}) : super(key: key);

  @override
  _GoalItemState createState() => _GoalItemState();
}

class _GoalItemState extends State<GoalItem> with SingleTickerProviderStateMixin {
  late bool showDropdown;
  late String newGoal;
  late String progress;
  late String progressHour;
  late String progressMinute;
  late bool openDialog;
  late bool openDialogTime;
  late bool deleteRequest;
  late bool permaDeleteRequest;
  late bool extendRequest;
  late bool renewRequest;
  late bool transition;
  late AnimationController _animationController;
  late double _oldWeeklyPercentage;
  late double _oldTotalPercentage;

  @override
  void initState() {
    super.initState();
    showDropdown = false;
    newGoal = widget.goal.goalString;
    progress = "";
    progressHour = "";
    progressMinute = "";
    openDialog = false;
    openDialogTime = false;
    deleteRequest = false;
    permaDeleteRequest = false;
    extendRequest = false;
    renewRequest = false;
    transition = false;
    _oldWeeklyPercentage = widget.goal.weeklyPercentage;
    _oldTotalPercentage = widget.goal.totalPercentage;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() { setState(() { }); });
  }

  void renew() async {
    // Renewal logic goes here
  }

  void shelve() {
    // Shelve logic goes here
  }

  void activate() async {
    // Activation logic goes here
  }

  void complete() {
    // Completion logic goes here
  }

  void extend() async {
    // Extension logic goes here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.goal.itemColor as Color,
      ),
      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.goal.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          maxLines: 1,
                        ),
                        Spacer(),
                        Icon(
                          Icons.warning,
                          size: 18.0,
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.timer,
                          size: 18.0,
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.electric_bolt,
                          size: 18.0,
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.visibility_off,
                          size: 18.0,
                        ),
                      ],

                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              !widget.goal.time
                                  ? "${widget.goal.progress.toInt()} / ${widget
                                  .goal.goal.toInt()} ${widget.goal.units}"
                                  : "${convertToTime(widget.goal.progress)} / ${convertToTime(widget.goal.goal)}",
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: Text(
                                "${(widget.goal.totalPercentage * 100)
                                    .toInt()}%",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Column(
                          children: [
                            Text(
                              widget.goal.state != GoalStates.SHELVED
                                  ? "Week ${widget.goal.currentWeek} / ${widget
                                  .goal.totalWeeks}"
                                  : "---",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  PopupMenuButton<int>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (int value) {
                      // Handle selection based on the value
                      switch (value) {
                        case 0:
                        // Edit
                          break;
                        case 1:
                        // Renew
                          break;
                        case 2:
                        // Extend
                          break;
                        case 3:
                        // Activate
                          break;
                        case 4:
                        // Delete
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<int>>[
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text('Edit'),
                      ),
                      if ((widget.goal.progress - widget.goal.initialProgress) < ((widget.goal.weeklyGoal - widget.goal.initialProgress) / 2.0)) const PopupMenuItem<int>(
                        value: 1,
                        child: Text('Renew'),
                      ),
                      if (widget.goal.state == GoalStates.COMPLETE)
                        const PopupMenuItem<int>(
                          value: 2,
                          child: Text('Extend'),
                        ),
                      if (widget.goal.state == GoalStates.SHELVED)
                        const PopupMenuItem<int>(
                          value: 3,
                          child: Text('Activate'),
                        ),
                      const PopupMenuItem<int>(
                        value: 4,
                        child: Text('Delete'),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: _oldTotalPercentage, end: widget.goal.totalPercentage),
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 1000),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                color: widget.goal.totalProgressColor,
                minHeight: 6,
              ),),
          Container(
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return ProgressUpdater(
                                goal: widget.goal,
                                updateGoal: (progress) {
                                  setState(() {
                                    _oldTotalPercentage = widget.goal.progress;
                                    widget.goal.progress = progress;
                                    _oldWeeklyPercentage = widget.goal.weeklyPercentage;
                                    widget.goal.progressUpdate();
                                  });
                                }, // units for progress
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12)),
                            color: widget.goal.progressBoxColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("My Progress"),
                              Text(
                                !widget.goal.time
                                    ? "${widget.goal.progress.toInt()} ${widget.goal.units}"
                                    : convertToTime(widget.goal.progress),
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: widget.goal.targetBoxColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Weekly Target"),
                            Text(
                              widget.goal.state == GoalStates.INPROGRESS
                                  ? (!widget.goal.time
                                  ? "${(widget.goal.weeklyGoal)
                                  .toInt().ceil()} ${widget.goal.units}"
                                  : convertToTime(widget.goal.weeklyGoal))
                                  : "---",
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12)),
                          color: widget.goal.progressBoxColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                TweenAnimationBuilder(
                                  tween: Tween<double>(begin: _oldWeeklyPercentage, end: widget.goal.weeklyPercentage),
                                  curve: Curves.easeInOut,
                                  duration: Duration(milliseconds: 1000),
                                  builder: (context, value, _) => CircularProgressIndicator(
                                    value: value.isNaN ? 0 : value.isInfinite ? 100 : value,
                                    strokeWidth: 15.0,
                                    valueColor: AlwaysStoppedAnimation(
                                      widget.goal.itemColor as Color,
                                    ),
                                  )),
                                Text(
                                  widget.goal.state != GoalStates.SHELVED
                                      ? "${(widget.goal.weeklyPercentage.isNaN || widget.goal.weeklyPercentage.isInfinite)
                                      ? (widget.goal.weeklyPercentage.isInfinite ? 100 : 0)
                                      : (widget.goal.weeklyPercentage * 100).toInt()}%"
                                      : "---",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )

          ),
          widget.goal.totalPercentage >= 1 ? Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  //extendRequest.value = true;
                },
                child: Text("Extend"),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  complete();
                  // update Goal
                },
                child: Text("Complete"),
              ),
            ],
          ) : Container(),
        ],
      ),
    );
  }

  String toRemainingMinutes(double value) {
    final h = value.toInt();
    final m = (value - value.toInt()) * 60;
    return (m.round()).toString();
  }

  double toFloat(bool value) {
    return value ? 1.0 : 0.0;
  }

  String toTime(double value) {
    final h = value.toInt();
    final m = ((value - value.toInt()) * 60).round();
    return m == 0 ? "$h h" : "$h h $m m";
  }

  Widget totalTargetLinearProgressBar(double totalPercentage) {
    final imageSize = 16.0;
    final size = 1;

    return Column(
      children: [
        Row(
          children: [
            Spacer(
              flex: size > 0 ? size : 0,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16.0,
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    // Replace with your icon
                    size: imageSize,
                  ),
                ),
              ],
            ),
            Spacer(
              flex: size < 1.0 ? (1.0 - size).toInt() : 0,
            ),
          ],
        ),
      ],
    );
  }

  String convertToTime(double progress) {
    int h = progress.toInt();
    int m = (60*((progress)-(progress.toInt()))).toInt();

    return m == 0 ? "${h}h" : "${h}h ${m}m";
  }
}