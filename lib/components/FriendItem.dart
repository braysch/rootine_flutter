import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/viewmodels/FriendsViewModel.dart';
import 'package:rootine_flutter_real/viewmodels/MotivatorViewModel.dart';

import '../models/User.dart';
import '../screens/motivator/MotivatorScreen.dart';

Widget FriendItem(User user, BuildContext context) {
  final viewModel = FriendsViewModel();
  final state = viewModel.uiState;

  final motivViewModel = MotivatorViewModel();
  final motivState = motivViewModel.uiState;

  var motivate = false;

  if (motivate) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                "Select a Goal",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.inProgress.length,
                  itemBuilder: (context, index) {
                    var it = state.inProgress[index];
                    return Row(
                      children: [
                        FriendGoalItem(
                          goal: it,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    motivate = false;
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Select"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Container(
          color: Colors.green,
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.firstName!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "@${user.username}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          color: Colors.grey,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(120),
            ),
            elevation: 10,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                user.imageLoc!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          color: Colors.yellow,
          child: ElevatedButton(
            onPressed: () {
              motivate = true;
              /*launch(() async {
                await motivViewModel.setUser(user);
                await viewModel.getInProgress(user);
              });*/
            },
            child: Text("Motivate"),
          ),
        ),
      ),
    ],
  );
}
