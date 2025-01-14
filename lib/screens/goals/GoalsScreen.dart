import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/navigation/Routes.dart';
import 'package:rootine_flutter_real/viewmodels/GoalsViewModel.dart';

import '../../repositories/GoalsManager.dart';
import 'GoalsCompletedScreen.dart';
import 'GoalsInProgressScreen.dart';
import 'GoalsShelvedScreen.dart';

GoalsManager goalsManager = GoalsManager.goalsManager;

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3); // 3 tabs: Shelved, In Progress, Completed
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Tabs(tabController: _tabController),
            TabsContent(tabController: _tabController),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, Routes.editGoal.route);
          },

        ),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  final TabController tabController;

  Tabs({required this.tabController});

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Set the background color of the tabs
      child: TabBar(
        controller: widget.tabController,
        indicatorColor: Colors.white, // Set the background color of the selected tab
        tabs: [
          Tab(
            text: "Shelved",
            icon: Icon(Icons.shelves),
          ),
          Tab(
            text: "In Progress",
            icon: Icon(Icons.timelapse),
          ),
          Tab(
            text: "Completed",
            icon: Icon(Icons.offline_pin_rounded),
          ),
        ],
      ),
    );
  }
}

class TabsContent extends StatefulWidget {
  final TabController tabController;

  TabsContent({required this.tabController});

  @override
  _TabsContentState createState() => _TabsContentState();
}

class _TabsContentState extends State<TabsContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: widget.tabController,
        children: [
          GoalsShelvedScreen(),
          GoalsInProgressScreen(),
          GoalsCompletedScreen(),
        ],
      ),
    );
  }
}