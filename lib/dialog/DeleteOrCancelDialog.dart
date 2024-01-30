import 'package:flutter/material.dart';

Future<void> deleteOrCancelDialog(BuildContext context, Rootine rootine, ValueNotifier<bool> permaDeleteRequest, ValueNotifier<bool> transition) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Text("${rootine.name}"),
            Text(
              "Once it's gone, it's gone!",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        content: Column(
          children: [
            Text(
              "Are you sure you want to delete ${rootine.name} from your goals?",
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
              rootine.delete();
              await DataRepository.deleteGoal(rootine.identification.toString());
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
