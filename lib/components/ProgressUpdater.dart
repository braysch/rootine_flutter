import 'package:flutter/material.dart';

import '../models/goal.dart';

class ProgressUpdater extends StatefulWidget {
  final Goal goal;
  final Function(double) updateGoal;

  ProgressUpdater({required this.goal, required this.updateGoal});

  @override
  _ProgressUpdaterState createState() => _ProgressUpdaterState();
}

class _ProgressUpdaterState extends State<ProgressUpdater> {
  late double _currentProgress;

  @override
  void initState() {
    super.initState();
    _currentProgress = widget.goal.progress;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Progress:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(width: 10.0),
              SizedBox(
                width: 100.0,
                child: TextFormField(
                  initialValue: _currentProgress.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _currentProgress = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            widget.goal.units,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Value',
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  // Add logic to add the value to the spinner
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.updateGoal(_currentProgress);
                },
                child: Text('SAVE'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
