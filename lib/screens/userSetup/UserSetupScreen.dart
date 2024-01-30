import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/navigation/Routes.dart';

class UserSetupScreen extends StatefulWidget {

  @override
  _UserSetupScreenState createState() => _UserSetupScreenState();
}

class _UserSetupScreenState extends State<UserSetupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthdayController.text = picked.toString();
      });
    }
  }

  void _showInvalidAgeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Whoa, there, buckaroo!'),
          content: Text('This app is for people 18 and older. Come back when you\'ve grown up, chump.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('I understand'),
            ),
          ],
        );
      },
    );
  }

  void _showValidAgeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('If we did our math right, you should be ${_calculateAge(selectedDate)}. Is that right?'),
          actions: [
            TextButton(
              onPressed: () {
                _setUser();
                Navigator.pushNamed(context, Routes.photo.route);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Go back'),
            ),
          ],
        );
      },
    );
  }

  int _calculateAge(DateTime birthDate) {
    final DateTime currentDate = DateTime.now();
    return currentDate.year - birthDate.year - ((currentDate.month > birthDate.month || (currentDate.month == birthDate.month && currentDate.day >= birthDate.day)) ? 0 : 1);
  }

  void _setUser() {
    // Implement logic to set user details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Tell us about yourself',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              Text(
                'But just the essentials\nRootine is committed to collecting as little info on you as we can',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: birthdayController,
                decoration: InputDecoration(labelText: 'Birthday'),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_calculateAge(selectedDate) < 18) {
                    _showInvalidAgeDialog();
                  } else {
                    _showValidAgeDialog();
                  }
                },
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
