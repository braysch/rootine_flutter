import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/navigation/Routes.dart';

class CreateGoalTitleScreen extends StatefulWidget {
  @override
  _CreateGoalTitleScreenState createState() => _CreateGoalTitleScreenState();
}

class _CreateGoalTitleScreenState extends State<CreateGoalTitleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      padding: EdgeInsets.all(32),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Text("New Goal!", style: TextStyle(fontSize: 48)),
        SizedBox(height: 16),
        Text("Give your goal a title", style: TextStyle(fontSize: 24)),
        Text("(You can change this later)", style: TextStyle(fontSize: 18, color: Colors.grey)),
        SizedBox(height: 32),
        TextField(
          controller: TextEditingController(text: "Hello"),
          onChanged: (value) {
            //name.value = value;
          },
          decoration: InputDecoration(labelText: "Goal Title"),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // validate title;
            Navigator.pushNamed(context, Routes.editGoal.route);
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.infinity, 60),
          ),
          child: Text("Continue"),
        ),
        SizedBox(height: 8),
        Text("Error Message!"),
        Spacer(),
        ElevatedButton(
          onPressed: () {},
          child: Text("Go Back"),
        ),
      ],
    ),
    ),
    );
  }
}
