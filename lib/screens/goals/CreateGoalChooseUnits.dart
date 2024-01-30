import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateGoalChooseUnits {
  @override
  Widget build(BuildContext context ) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Give your goal a title", style: TextStyle(fontSize: 24)),
        SizedBox(height: 32),
        Text("What are you going to accomplish?"),
        TextField(
          controller: TextEditingController(text: "Hey!"),
          onChanged: (value) {
            //name.value = value;
          },
          decoration: InputDecoration(labelText: "Goal Title"),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // validate title
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.infinity, 60),
          ),
          child: Text("Continue"),
        ),
        SizedBox(height: 8),
        Text("Error message!"),
        Spacer(),
        ElevatedButton(
          onPressed: () {},
          child: Text("Go Back"),
        ),
      ],
    );
  }
}

class ScopedCoroutine {
  void launch(void Function() callback) {
    callback();
  }
}
