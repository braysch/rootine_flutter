import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/repositories/GoalsManager.dart';

import '../../components/RootineItem.dart';

GoalsManager goalsManager = GoalsManager.goalsManager;

class GoalsShelvedScreen extends StatefulWidget {
  @override
  _GoalsShelvedScreenState createState() => _GoalsShelvedScreenState();
}

class _GoalsShelvedScreenState extends State<GoalsShelvedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: goalsManager.shelved.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    GoalItem(
                      goal: goalsManager.shelved[index],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
