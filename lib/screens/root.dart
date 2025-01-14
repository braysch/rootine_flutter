import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/screens/goals/GoalsScreen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Background color of the AppBar
        leading: Builder(
          builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: Colors.white,),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the column
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center the text vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Center the text horizontally
                children: [
                  Text(
                    'Milestone in 2 days',
                    style: TextStyle(color: Colors.white, fontSize: 20), // Title style
                  ),
                  Text(
                    '3 Monies',
                    style: TextStyle(color: Colors.white70, fontSize: 14), // Subtitle style
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white,),
            onPressed: () {
              // Add settings functionality here
            },
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle home navigation
              },
            ),
            Container(height: 1, color: Colors.black.withOpacity(0.1), margin: EdgeInsets.symmetric(horizontal: 16),),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Me'),
              onTap: () {
                // Handle profile navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('My Friends'),
              onTap: () {
                // Handle friends navigation
              },
            ),
            Container(height: 1, color: Colors.black.withOpacity(0.1), margin: EdgeInsets.symmetric(horizontal: 16),),
            ListTile(
              leading: Icon(Icons.flag),
              title: Text('My Goals'),
              onTap: () {
                // Handle goals navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('My Projects'),
              onTap: () {
                // Handle projects navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar'),
              onTap: () {
                // Handle calendar navigation
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: GoalsScreen()
        //child: Text('Root Screen Content'), // Main content goes here
      ),
    );
  }
}
