import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/RootineItem.dart';
import '../../repositories/GoalsManager.dart';

GoalsManager goalsManager = GoalsManager.goalsManager;

class GoalsInProgressScreen {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: GoalsManager.inProgress.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RootineItem(
                        GoalsManager.inProgress[index],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              // Navigate to rootinesModificationNavigation route
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
