
import 'package:flutter/cupertino.dart';

import '../../components/RootineItem.dart';
import '../../repositories/GoalsManager.dart';

GoalsManager goalsManager = GoalsManager.goalsManager;

class GoalsCompletedScreen extends StatefulWidget {
  @override
  _GoalsCompletedScreenState createState() => _GoalsCompletedScreenState();
}

class _GoalsCompletedScreenState extends State<GoalsCompletedScreen> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: goalsManager.completed.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GoalItem(
                        goal: goalsManager.completed[index],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
