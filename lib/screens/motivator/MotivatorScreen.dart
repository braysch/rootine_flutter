import 'package:flutter/material.dart';

import '../../models/goal.dart';
import '../../navigation/Routes.dart';

class MotivatorScreen extends StatefulWidget {
  @override
  _MotivatorScreenState createState() => _MotivatorScreenState();
}

class _MotivatorScreenState extends State<MotivatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Text("Motivating ${state.user.value.firstName}"),
          //FriendGoalItem(rootine: state.goal.value),
          Text("SELECT MOTIVATOR"),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.motivatorMessage.route);
            },
            child: Text("Send Message (5)"),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement send picture functionality
            },
            child: Text("Send Picture (10)"),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement send money functionality
            },
            child: Text("Send Money (5)"),
          ),
        ],
      ),
    );
  }
}

class FriendGoalItem extends StatelessWidget {
  final Goal goal;

  FriendGoalItem({required this.goal});

  @override
  Widget build(BuildContext context) {
    // Implement FriendGoalItem widget
    return Container();
  }
}

void main() {
  runApp(MaterialApp(
    home: MotivatorScreen(),
  ));
}
