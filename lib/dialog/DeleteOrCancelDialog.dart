import 'package:flutter/material.dart';

import '../models/goal.dart';

Future<void> deleteOrCancelDialog(BuildContext context, Goal goal, ValueNotifier<bool> permaDeleteRequest, ValueNotifier<bool> transition) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Text("${goal.name}"),
            Text(
              "Once it's gone, it's gone!",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        content: Column(
          children: [
            Text(
              "Are you sure you want to delete ${goal.name} from your goals?",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              permaDeleteRequest.value = false;
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          Spacer(),
          TextButton(
            onPressed: () async {
              transition.value = true;
              goal.delete();
              //await DataRepository.deleteGoal(goal.identification.toString());
              permaDeleteRequest.value = false;
              Navigator.of(context).pop();
            },
            child: Text('Oh, I\'m sure'),
          ),
        ],
      );
    },
  );
}
