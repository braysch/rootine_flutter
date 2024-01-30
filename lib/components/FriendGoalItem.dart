
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/viewmodels/GoalsEditViewModel.dart';
import 'package:rootine_flutter_real/viewmodels/GoalsViewModel.dart';
import 'package:rootine_flutter_real/viewmodels/MotivatorViewModel.dart';

import '../models/goal.dart';
import '../repositories/GoalsManager.dart';
import '../util/GoalStates.dart';

Widget FriendGoalItem(Goal goal, BuildContext context) {
  var linearProgressOffset = 0.0;
  var animatedLinearProgress = goal.totalPercentage;
  //var localDensity = LocalDensity;

  final motivViewModel = MotivatorViewModel();
  final motivState = motivViewModel.uiState;

  final editViewModel = GoalsEditViewModel();
  final editState = editViewModel.uiState;

  var openDialog = false;
  var deleteRequest = false;
  var permaDeleteRequest = false;
  var extendRequest = false;
  var renewRequest = false;
  var transition = false;
  var progress = "";
  var showDropdown = false;
  var newGoal = goal.goalString;
  var errorMessage = "ERROR MESSAGE";

  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    color: goal.itemColor,
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.red,
                          child: Text(
                            goal.name,
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${goal.progress.toInt()} / ${goal.goal.toInt()} ${goal.units}"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("${(goal.totalPercentage * 100).toInt()}% Complete"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          value: animatedLinearProgress,
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: goal.targetBoxColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Progress"),
                      Text("${goal.progress.toInt()} ${goal.units}"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: goal.progressBoxColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Target"),
                      Text(
                        goal.state == GoalStates.INPROGRESS ? "${goal.weeklyGoal.toInt()} ${goal.units}" : "---",
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: goal.percentageBoxColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: double.infinity,
                        child: CircularProgressIndicator(
                          //value: rootine.state != GoalStates.SHELVED && !rootine.weeklyPercentage.isNaN() ? rootine.weeklyPercentage : 0.0,
                          strokeWidth: 20,
                          //color: rootine.weeklyProgressColor,
                        ),
                      ),
                      //Text(rootine.state != GoalStates.SHELVED ? "${(rootine.weeklyPercentage * 100).toInt()}%" : "---"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}
