import 'package:flutter/material.dart';

class MotivatorMessageScreen extends StatefulWidget {
  @override
  _MotivatorMessageScreenState createState() => _MotivatorMessageScreenState();
}

class _MotivatorMessageScreenState extends State<MotivatorMessageScreen> {
  TextEditingController messageController = TextEditingController();
  bool isDiscreet = false;
  bool isAnonymous = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Compose your message"),
          TextField(
            controller: messageController,
            onChanged: (value) {
              // Update your state with the entered message
            },
          ),
          Row(
            children: [
              Text("Discreet"),
              Switch(
                value: isDiscreet,
                onChanged: (value) {
                  setState(() {
                    isDiscreet = value;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Text("Anonymous"),
              Switch(
                value: isAnonymous,
                onChanged: (value) {
                  setState(() {
                    isAnonymous = value;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement sendMotivation functionality
                  // You can access messageController.text, isDiscreet, and isAnonymous for the entered values
                },
                child: Text("Motivate!"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MotivatorMessageScreen(),
  ));
}
