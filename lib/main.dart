import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/navigation/Routes.dart';
import 'package:rootine_flutter_real/repositories/GoalsManager.dart';
import 'package:rootine_flutter_real/screens/goals/CreateGoalTitleScreen.dart';
import 'package:rootine_flutter_real/screens/goals/GoalsInProgressScreen.dart';
import 'package:rootine_flutter_real/screens/goals/GoalsModificationScreen.dart';
import 'package:rootine_flutter_real/screens/goals/GoalsScreen.dart';
import 'package:rootine_flutter_real/screens/root.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RootineTheme(child: RootNavigationGraph()),
    );
  }
}

class RootNavigationGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RootScreen();
    // Replace 'LaunchScreen' with the appropriate starting screen/widget in your Flutter app
  }
}

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Launch Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GoalsManager.goalsManager.initializeGoals();
            Navigator.pushNamed(context, Routes.root.route);
          },
          child: Text('Next Screen'),
        ),
      ),
    );
  }
}

class RootineTheme extends StatelessWidget {
  final Widget child;

  RootineTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Customize your theme here
      ),
      home: Scaffold(
        body: child,

      ),
        routes: {
          'goals': (context) => GoalsScreen(),
          //'goals': (context) => GoalsScreen(),
          'createGoalTitle': (context) => CreateGoalTitleScreen(),
          'editGoal': (context) => GoalModificationScreen()
        }
    );
  }
}
