import 'package:flutter/material.dart';

import '../../screens/goals/GoalsModificationScreen.dart';
import '../../screens/goals/GoalsScreen.dart';
import '../../screens/profile/ProfileScreen.dart';
import '../../screens/projects/ProjectsScreen.dart';
import '../../screens/routines/RoutinesScreen.dart';
import '../../screens/tasks/TasksScreen.dart';

class BottomNavGraph extends StatelessWidget {

  BottomNavGraph();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return _buildScreens(settings.name!);
            },
          );
        },
      ),
    );
  }

  Widget _buildScreens(String route) {
    switch (route) {
      case '/profile':
        return ProfileScreen();
      case '/goals':
        return GoalsScreen();
      case '/tasks':
        return TasksScreen();
      case '/routines':
        return RoutinesScreen();
      case '/projects':
        return ProjectsScreen();
      case '/goalModification':
        return GoalModificationScreen();
      default:
        return Container(); // Replace with your default screen
    }
  }
}
