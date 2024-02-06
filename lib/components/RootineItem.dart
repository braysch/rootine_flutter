import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/util/functions.dart';
import '../models/goal.dart';
import '../util/GoalStates.dart';

Widget GoalItem(Goal goal) {
  var linearProgressOffset = 0.0;
  var openDialog = false;
  var openDialogTime = false;
  var deleteRequest = false;
  var permaDeleteRequest = false;
  var extendRequest = false;
  var renewRequest = false;
  var transition = false;
  var progress = "";
  var progressHour = "";
  var progressMinute = "";
  var showDropdown = false;
  var newGoal = goal.goalString;
  const errorMessage = "ERROR MESSAGE!";

  final imageContent = () {
    return Image(
      image: AssetImage('images/ic_private.png'), // Replace with your image asset
      width: 24.0,
      height: 24.0,
    );
  };

  void renew() async {
    //await editViewModel.validateEndDate(editState.inputEndDate);
    /*validateEndDate(inputEndDate);
    if (goal.state == GoalStates.SHELVED) {
      //transition.value = true;
      //await viewModel.getInProgress();
      //state.shelvedSize.value -= 1;
    }*/
    /*goal.renew(
      goal.value,
      rEndDate: editState.endDate.value,
      rDailyAverage: editState.dailyAverage.value,
    );*/
  }

  void shelve() {
    goal.shelve();
    //transition.value = true;
   /* scope.launch(() async {
      await viewModel.getShelved();
    });*/
    //state.inProgressSize.value -= 1;
  }

  void activate() async {
    goal.activate();
    //transition.value = true;
    //await viewModel.getInProgress();
    //state.shelvedSize.value -= 1;
  }

  void complete() {
    goal.complete();
    //transition.value = true;
    /*scope.launch(() async {
      await viewModel.getCompleted();
    });*/
    //state.inProgressSize.value -= 1;
  }

  void extend() async {
    if (goal.state == GoalStates.COMPLETE) {
      //transition.value = true;
      //await viewModel.getInProgress();
      //state.completedSize.value -= 1;
    }
    goal.extend();
  }

  final endYear = DateTime.now().year;
  final endMonth = DateTime.now().month;
  final endDay = DateTime.now().day;
  final endCalendar = DateTime.now();

  if (true) {
    {
      /*renewPopulateValues(
        goal: goal.goal,
        initProgress: goal.initialProgress,
        progress: goal.progress,
        dailyAverage: goal.dailyAverage,
        totalDays: goal.daysStartDateToEndDate,
      );*/
    }

    /*showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          *//*onDismissRequest: () {
            renewRequest.value = false;
          },*//*
          title: Column(
            children: [
              Text("${goal.name}"),
              Text(
                "Let's get back on track!",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          text: Column(
            children: [
              Text("Original Goal: ${goal.goal}"),
              OutlinedTextField(
                label: Text("Goal"),
                value: editState.inputGoal,
                onValueChange: (value) {
                  editState.inputGoal = value;
                  scope.launch(() async {
                    if (await editViewModel.validateGoal(editState.inputGoal)) {
                      await editViewModel.renewalGoalInput(
                        editState.inputGoal,
                        goal.progress,
                      );
                    }
                  });
                },
              ),
              OutlinedTextField(
                label: Text("New End Date"),
                value: editState.inputEndDate,
                onValueChange: (value) {
                  editState.inputEndDate = value;
                  scope.launch(() async {
                    await editViewModel.renewalEndDateInput(
                      editState.inputEndDate,
                      goal.progress,
                    );
                  });
                },
              ),
              Text("+X days from original date"),
              OutlinedTextField(
                label: Text("Days until completion"),
                value: editState.inputDaysToEnd,
                onValueChange: (value) {
                  editState.inputDaysToEnd = value;
                  scope.launch(() async {
                    await editViewModel.renewalDaysInput(
                      editState.inputDaysToEnd,
                      goal.progress,
                    );
                  });
                },
              ),
              Text("Original weekly average"),
              OutlinedTextField(
                label: Text("Weekly Average"),
                value: editState.inputWeeklyAverage,
                onValueChange: (value) {
                  editState.inputWeeklyAverage = value;
                  scope.launch(() async {
                    await editViewModel.renewalWeeklyAverageInput(
                      editState.inputWeeklyAverage,
                      goal.progress,
                    );
                  });
                },
              ),
              Text("Your current weekly average"),
            ],
          ),
          buttons: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                onPressed: () {
                  renewRequest.value = false;
                },
                child: Text("Cancel"),
              ),
              Spacer(),
              Button(
                onPressed: () {
                  scope.launch(() async {
                    if (await editViewModel.validateRenewal()) {
                      renew();
                      scope.launch(() async {
                        await viewModel.updateGoal(goal);
                      });
                      renewRequest.value = false;
                    }
                  });
                },
                child: Text("Renew"),
              ),
            ],
          ),
        );
      },
    );*/
  }

  // Add the other if conditions similarly...

  return Container(
    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: goal.itemColor as Color,
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Practice Accordion",
                        //goal.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(width: 4),
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
                            !goal.time
                                ? "${goal.progress.toInt()} / ${goal.goal.toInt()} ${goal.units}"
                                : "${goal.progress} / ${goal.goal} ${goal.units}",
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child:
                          Text(
                            "${(goal.totalPercentage * 100).toInt()}%",
                          ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Column(
                        children: [
                          Text(
                            goal.state != GoalStates.SHELVED
                                ? "Week ${goal.currentWeek} / ${goal.totalWeeks}"
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
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      showDropdown = true;
                    },
                  ),
                  /*DropdownMenu(
                    expanded: showDropdown.value,
                    onDismissRequest: () {
                      showDropdown.value = false;
                    },
                    items: [
                      if (goal.goalComplete &&
                          goal.state != GoalStates.COMPLETE)
                        DropdownMenuItem(
                          child: Text("Extend"),
                          onTap: () {
                            extendRequest.value = true;
                          },
                        ),
                      if (goal.goalComplete &&
                          goal.state != GoalStates.COMPLETE)
                        DropdownMenuItem(
                          child: Text("Complete"),
                          onTap: () {
                            complete();
                            scope.launch(() async {
                              await viewModel.updateGoal(goal);
                            });
                          },
                        ),
                      // Add other menu items accordingly...
                    ],
                  ),*/
                ],
              ),
            ],
          ),
          LinearProgressIndicator(
            value: 3,
          ),
          Container(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print("TAPPED!");
                      },
                  child: Container(
                      color: goal.progressBoxColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("My Progress"),
                          Text(
                            !goal.time
                                ? "${goal.progress.toInt()} ${goal.units}"
                                : "${goal.progress}",
                            style: TextStyle(
                              fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: goal.targetBoxColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Weekly Target"),
                          Text(
                            goal.state == GoalStates.INPROGRESS
                                ? (!goal.time
                                ? "${(goal.weeklyGoal).toInt().ceil()} ${goal.units}"
                                : "${goal.weeklyGoal}")
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
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: goal.weeklyPercentage,
                                strokeWidth: 20.0,
                                valueColor: AlwaysStoppedAnimation(
                                  goal.weeklyProgressColor as Color,
                                ),
                              ),
                              Text(
                                goal.state != GoalStates.SHELVED
                                    ? "${(goal.weeklyPercentage * 100).toInt()}%"
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
          Row(
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
            ),
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
