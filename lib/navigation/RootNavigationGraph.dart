import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/screens/goals/GoalsScreen.dart';

import '../main.dart';
import '../screens/friends/FriendsScreen.dart';
import '../screens/motivator/MotivatorMessageScreen.dart';
import '../screens/motivator/MotivatorScreen.dart';
import '../screens/userSetup/ProfilePictureSetupScreen.dart';
import '../screens/userSetup/UserSetupScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RootNavigationGraph(),
    );
  }
}

class RootNavigationGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return _buildScreens(context, settings.name!);
            },
          );
        },
      ),
    );
  }

  Widget _buildScreens(BuildContext context, String route) {
    final navController = context.read<NavHostController>();

    switch (route) {
      case '/launch':
        return LaunchScreen(navController: navController);
      case '/main':
        return MainScreen(navController);
      case '/userSetup':
        return UserSetupScreen(navController);
      case '/photo':
        return ProfilePictureSetupScreen(navController);
      case '/friends':
        return FriendsScreen(navController);
      case '/motivator':
        return MotivatorScreen(navController);
      case '/motivatorMessage':
        return MotivatorMessageScreen(navController);
      case '/splashScreen':
        return SplashScreen(navController);
      default:
        return Container(); // Replace with your default screen
    }
  }
}
