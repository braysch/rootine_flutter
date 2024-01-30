import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showDrawer = false;
  String currentRoute = 'Profile'; // Set the initial route

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              setState(() {
                showDrawer = true;
              });
            },
          ),
        ],
      ),
      drawer: DrawerNavigation(
        currentRoute: currentRoute,
        onNavigateTo: (route) {
          setState(() {
            currentRoute = route;
          });
        },
        onDrawerClose: () {
          setState(() {
            showDrawer = false;
          });
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Replace with your image loading logic
          Image.asset(
            'assets/profile_image.jpg',
            width: 120,
            height: 120,
          ),
          Text('First Name'),
          Text('@Username'),
          ElevatedButton(
            onPressed: () {
              // Handle button click
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class DrawerNavigation extends StatelessWidget {
  final String currentRoute;
  final Function(String) onNavigateTo;
  final Function onDrawerClose;

  DrawerNavigation({
    required this.currentRoute,
    required this.onNavigateTo,
    required this.onDrawerClose,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer header
          Container(
            height: 200,
            color: Colors.blue,
            // Add header contents here, such as an image or text
          ),
          // Drawer items
          DrawerItem(
            text: 'Home',
            selected: currentRoute == 'Home',
            onClick: () {
              onNavigateTo('Home');
              onDrawerClose();
            },
          ),
          DrawerItem(
            text: 'Profile',
            selected: currentRoute == 'Profile',
            onClick: () {
              onNavigateTo('Profile');
              onDrawerClose();
            },
          ),
          DrawerItem(
            text: 'Settings',
            selected: currentRoute == 'Settings',
            onClick: () {
              onNavigateTo('Settings');
              onDrawerClose();
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text;
  final bool selected;
  final Function onClick;

  DrawerItem({
    required this.text,
    required this.selected,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.red : Colors.black;

    return InkWell(
      onTap: () => onClick(),
      child: Container(
        height: 56,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}
