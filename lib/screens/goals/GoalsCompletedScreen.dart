
import 'package:flutter/cupertino.dart';

import '../../components/RootineItem.dart';
import '../../repositories/GoalsManager.dart';

GoalsManager goalsManager = GoalsManager.goalsManager;

class GoalsCompletedScreen {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: GoalsManager.completed.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GoalItem(
                        GoalsManager.completed[index],
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
