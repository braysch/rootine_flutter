import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_package_name_here/viewmodels/goals_view_model.dart';

import '../repositories/DataRepository.dart';

Future<void> deleteOrShelveDialog(BuildContext context, Rootine rootine, ValueNotifier<bool> deleteRequest, CoroutineScope scope, ValueNotifier<bool> transition) async {
  final viewModel = context.read(goalsViewModelProvider);

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Text("${rootine.name}"),
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
              rootine.shelve();
              await viewModel.updateGoal(rootine);
              Navigator.of(context).pop();
            },
            child: Text('Shelve'),
          ),
          Spacer(),
          TextButton(
            onPressed: () async {
              transition.value = true;
              rootine.delete();
              await DataRepository.deleteGoal(rootine.identification.toString());
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
