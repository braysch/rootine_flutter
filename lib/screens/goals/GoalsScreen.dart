import 'package:flutter/material.dart';
import 'package:rootine_flutter_real/viewmodels/GoalsViewModel.dart';

import '../../repositories/GoalsManager.dart';

GoalsManager goalsManager = GoalsManager.goalsManager;

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Next milestone in ${goalsManager.daysUntilEndOfWeek} days", textAlign: TextAlign.center),
          Tabs(tabController: _tabController),
          TabsContent(tabController: _tabController),
        ],
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
    return TabBar(
      controller: widget.tabController,
      tabs: [
        Tab(
          text: "Shelved",
          icon: Icon(Icons.ac_unit),
        ),
        Tab(
          text: "In Progress",
          icon: Icon(Icons.ac_unit),
        ),
        Tab(
          text: "Completed",
          icon: Icon(Icons.ac_unit),
        ),
      ],
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
    return TabBarView(
      controller: widget.tabController,
      children: [
        GoalsShelvedScreen(),
        GoalsInProgressScreen(),
        GoalsCompletedScreen(),
      ],
    );
  }
}

class GoalsShelvedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement GoalsShelvedScreen
    return Container();
  }
}

class GoalsInProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement GoalsInProgressScreen
    return Container();
  }
}

class GoalsCompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement GoalsCompletedScreen
    return Container();
  }
}
