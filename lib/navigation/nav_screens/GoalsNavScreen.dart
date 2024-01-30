import 'package:flutter/material.dart';

import '../../screens/goals/GoalsModificationScreen.dart';
import '../../screens/goals/GoalsScreen.dart';
import '../../screens/profile/ProfileScreen.dart';
import '../../screens/projects/ProjectsScreen.dart';
import '../../screens/routines/RoutinesScreen.dart';
import '../../screens/tasks/TasksScreen.dart';

class BottomNavGraph extends StatelessWidget {
  final NavHostController navController;
  final NavHostController navHostController;

  BottomNavGraph({required this.navController, required this.navHostController});

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
        return TasksScreen(navController: navController);
      case '/routines':
        return RoutinesScreen(navController: navController);
      case '/projects':
        return ProjectsScreen(navController: navController);
      case '/goalModification':
        return GoalModificationScreen();
      default:
        return Container(); // Replace with your default screen
    }
  }
}
