import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/RootineItem.dart';
import '../../repositories/GoalsManager.dart';

GoalsManager goalsManager = GoalsManager.goalsManager;

class GoalsInProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
        children: [
          Text("Goals in progress ---> ${goalsManager.inProgress.length}"),
          Expanded(
            child: ListView.builder(
              itemCount: goalsManager.inProgress.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GoalItem(
                  goal: goalsManager.inProgress[index]
                  )
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      ),
    );
  }
}
