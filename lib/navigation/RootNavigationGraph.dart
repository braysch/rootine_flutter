import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/screens/goals/GoalsScreen.dart';
import '../main.dart';
import '../screens/motivator/MotivatorMessageScreen.dart';
import '../screens/motivator/MotivatorScreen.dart';
import '../screens/userSetup/UserSetupScreen.dart';

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

    switch (route) {
      case '/launch':
        return LaunchScreen();
      case '/userSetup':
        return UserSetupScreen();
      //case '/photo':
        //return ProfilePictureSetupScreen();
      //case '/friends':
        //return FriendsScreen();
      case '/motivator':
        return MotivatorScreen();
      case '/motivatorMessage':
        return MotivatorMessageScreen();
      //case '/splashScreen':
        //return SplashScreen();
      default:
        return Container(); // Replace with your default screen
    }
  }
}
