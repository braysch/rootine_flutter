import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/repositories/GoalsManager.dart';
import '../models/goal.dart';
import '../repositories/DataRepository.dart';

GoalsManager goalsManager = GoalsManager.goalsManager;

Future<void> deleteOrShelveDialog(BuildContext context, Goal goal, ValueNotifier<bool> deleteRequest, ValueNotifier<bool> transition) async {

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Text("${goal.name}"),
            Text(
              "Don't let your dreams be dreams!",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        content: Column(
          children: [
            Text(
              "Consider shelving this project for future use instead.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              deleteRequest.value = false;
              goal.shelve();
              await goalsManager.updateGoal(goal);
              Navigator.of(context).pop();
            },
            child: Text('Shelve'),
          ),
          Spacer(),
          TextButton(
            onPressed: () async {
              transition.value = true;
              goal.delete();
              //await goalsManager.deleteGoal(goal.identification.toString());
              deleteRequest.value = false;
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}
