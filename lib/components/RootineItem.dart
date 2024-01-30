import 'package:flutter/material.dart';
import 'package:your_package_name_here/viewmodels/goals_edit_view_model.dart';
import 'package:your_package_name_here/viewmodels/goals_view_model.dart';
import 'package:your_package_name_here/models/goal.dart';
import 'package:your_package_name_here/screens/hour_minute_field.dart';

@OptIn(ExperimentalFoundationApi::class)
Widget RootineItem(Rootine rootine) {
  var linearProgressOffset = 0.0;

  final viewModel = context.read(goalsViewModelProvider);
  final state = viewModel.uiState;

  final editViewModel = context.read(goalsEditViewModelProvider);
  final editState = editViewModel.uiState;

  final scope = rememberCoroutineScope();

  final openDialog = useState(false);
  final openDialogTime = useState(false);
  final deleteRequest = useState(false);
  final permaDeleteRequest = useState(false);
  final extendRequest = useState(false);
  final renewRequest = useState(false);
  final transition = useState(false);
  final progress = useState("");
  final progressHour = useState("");
  final progressMinute = useState("");
  final showDropdown = useState(false);
  final newGoal = useState(rootine.goalString);
  final errorMessage = useState("ERROR MESSAGE");

  final imageContent = () {
    return Image(
      image: AssetImage('images/ic_private.png'), // Replace with your image asset
      width: 24.0,
      height: 24.0,
    );
  };

  void renew() async {
    await editViewModel.validateEndDate(editState.inputEndDate);
    if (rootine.state == GoalStates.SHELVED) {
      transition.value = true;
      await viewModel.getInProgress();
      state.shelvedSize.value -= 1;
    }
    rootine.renew(
      rGoal: editState.goal.value,
      rEndDate: editState.endDate.value,
      rDailyAverage: editState.dailyAverage.value,
    );
  }

  void shelve() {
    rootine.shelve();
    transition.value = true;
    scope.launch(() async {
      await viewModel.getShelved();
    });
    state.inProgressSize.value -= 1;
  }

  void activate() async {
    rootine.activate();
    transition.value = true;
    await viewModel.getInProgress();
    state.shelvedSize.value -= 1;
  }

  void complete() {
    rootine.complete();
    transition.value = true;
    scope.launch(() async {
      await viewModel.getCompleted();
    });
    state.inProgressSize.value -= 1;
  }

  void extend() async {
    if (rootine.state == GoalStates.COMPLETE) {
      transition.value = true;
      await viewModel.getInProgress();
      state.completedSize.value -= 1;
    }
    rootine.extend();
  }

  final endYear = DateTime.now().year;
  final endMonth = DateTime.now().month;
  final endDay = DateTime.now().day;
  final endCalendar = DateTime.now();

  if (renewRequest.value) {
    useEffect(() {
      editViewModel.renewPopulateValues(
        goal: rootine.goal,
        initProgress: rootine.initialProgress,
        progress: rootine.progress,
        dailyAverage: rootine.dailyAverage,
        totalDays: rootine.daysStartDateToEndDate,
      );
    }, [true]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          onDismissRequest: () {
            renewRequest.value = false;
          },
          title: Column(
            children: [
              Text("${rootine.name}"),
              Text(
                "Let's get back on track!",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          text: Column(
            children: [
              Text("Original Goal: ${rootine.goal}"),
              OutlinedTextField(
                label: Text("Goal"),
                value: editState.inputGoal,
                onValueChange: (value) {
                  editState.inputGoal = value;
                  scope.launch(() async {
                    if (await editViewModel.validateGoal(editState.inputGoal)) {
                      await editViewModel.renewalGoalInput(
                        editState.inputGoal,
                        rootine.progress,
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
                      rootine.progress,
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
                      rootine.progress,
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
                      rootine.progress,
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
                        await viewModel.updateGoal(rootine);
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
    );
  }

  // Add the other if conditions similarly...

  return AnimatedVisibility(
    visible: !transition.value,
    enter: SlideInHorizontally(),
    exit: rootine.exitTransition,
    child: Surface(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: rootine.itemColor as Color,
      modifier: Modifier.padding(8.0, 8.0, 8.0, 0.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ResponsiveText(
                        text: rootine.name,
                        fontWeight: FontWeight.bold,
                        fontSizeRange: FontSizeRange(16.0, 18.0),
                        maxLines: 1,
                        modifier: Modifier.weight(1.0),
                      ),
                      AnimatedVisibility(
                        visible: rootine.private,
                        child: Icon(
                          Icons.lock,
                          size: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            !rootine.time
                                ? "${rootine.progress.toInt()} / ${rootine.goal.toInt()} ${rootine.units}"
                                : "${rootine.progress.toTime()} / ${rootine.goal.toTime()} ${rootine.units}",
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${(rootine.totalPercentage * 100).toInt()}%",
                            style: TextStyle(
                              backgroundColor: Colors.white.withOpacity(0.20),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            rootine.state != GoalStates.SHELVED
                                ? "Week ${rootine.currentWeek} / ${rootine.totalWeeks}"
                                : "---",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      showDropdown.value = true;
                    },
                  ),
                  DropdownMenu(
                    expanded: showDropdown.value,
                    onDismissRequest: () {
                      showDropdown.value = false;
                    },
                    items: [
                      if (rootine.goalComplete &&
                          rootine.state != GoalStates.COMPLETE)
                        DropdownMenuItem(
                          child: Text("Extend"),
                          onTap: () {
                            extendRequest.value = true;
                          },
                        ),
                      if (rootine.goalComplete &&
                          rootine.state != GoalStates.COMPLETE)
                        DropdownMenuItem(
                          child: Text("Complete"),
                          onTap: () {
                            complete();
                            scope.launch(() async {
                              await viewModel.updateGoal(rootine);
                            });
                          },
                        ),
                      // Add other menu items accordingly...
                    ],
                  ),
                ],
              ),
            ],
          ),
          LinearProgressIndicator(
            value: animatedLinearProgress,
          ),
          Surface(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            child: Row(
              children: [
                Surface(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                    ),
                  ),
                  color: rootine.targetBoxColor as Color,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("My Progress"),
                      ClickableText(
                        text: !rootine.time
                            ? "${rootine.progress.toInt()} ${rootine.units}"
                            : "${rootine.progress.toTime()}",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                        onTap: () {
                          if (rootine.time) {
                            openDialogTime.value = true;
                          } else {
                            openDialog.value = true;
                          }
                          scope.launch(() async {
                            await viewModel.updateGoal(rootine);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Surface(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  color: rootine.progressBoxColor as Color,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Weekly Target"),
                      Text(
                        rootine.state == GoalStates.INPROGRESS
                            ? (!rootine.time
                            ? "${ceil(rootine.weeklyGoal).toInt()} ${rootine.units}"
                            : "${rootine.weeklyGoal.toTime()}")
                            : "---",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Surface(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  color: rootine.percentageBoxColor as Color,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: rootine.state != GoalStates.SHELVED &&
                            !rootine.weeklyPercentage.isNaN()
                            ? rootine.weeklyPercentage
                            : 0.0,
                        strokeWidth: 20.0,
                        valueColor: AlwaysStoppedAnimation(
                          rootine.weeklyProgressColor as Color,
                        ),
                        radius: 30.0,
                      ),
                      Text(
                        rootine.state != GoalStates.SHELVED
                            ? "${(rootine.weeklyPercentage * 100).toInt()}%"
                            : "---",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnimatedVisibility(
            visible:
            rootine.goalComplete && rootine.state != GoalStates.COMPLETE,
            enter: ExpandVertically(),
            exit: ShrinkVertically(),
            child: Row(
              children: [
                Button(
                  onPressed: () {
                    extendRequest.value = true;
                  },
                  child: Text("Extend"),
                ),
                Spacer(),
                Button(
                  onPressed: () {
                    complete();
                    scope.launch(() async {
                      await viewModel.updateGoal(rootine);
                    });
                  },
                  child: Text("Complete"),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
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
  final size = useAnimatedFloatAsState(
    targetValue: totalPercentage,
    duration: 1000,
    delay: 200,
    easing: Curves.linearToEaseOut,
  );

  return Column(
    children: [
      Row(
        children: [
          Spacer(
            flex: size.value > 0 ? size.value.toInt() : 0,
          ),
          Row(
            children: [
              SizedBox(
                width: 16.0,
                child: Icon(
                  Icons.arrow_forward,
                  // Replace with your icon
                  size: imageSize,
                ),
              ),
            ],
          ),
          Spacer(
            flex: size.value < 1.0 ? (1.0 - size.value).toInt() : 0,
          ),
        ],
      ),
    ],
  );
}
