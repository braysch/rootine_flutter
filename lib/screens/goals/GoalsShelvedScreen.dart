import 'package:flutter/material.dart';

class GoalsShelvedScreen extends StatefulWidget {
  @override
  _GoalsShelvedScreenState createState() => _GoalsShelvedScreenState();
}

class _GoalsShelvedScreenState extends State<GoalsShelvedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.shelved.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    RootineItem(
                      rootine: state.shelved[index],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RootineItem extends StatelessWidget {
  final Rootine rootine;

  RootineItem({required this.rootine});

  @override
  Widget build(BuildContext context) {
    return // Implement RootineItem widget;
  }
}

void main() {
  runApp(MaterialApp(
    home: GoalsShelvedScreen(),
  ));
}
