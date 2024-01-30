import 'package:flutter/material.dart';

class RoutinesScreen extends StatelessWidget {
  final NavHostController navController;

  RoutinesScreen({required this.navController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This feature is not yet implemented',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RoutinesScreen(navController: NavHostController()),
  ));
}
