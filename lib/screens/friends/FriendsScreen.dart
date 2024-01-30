import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_package_name_here/viewmodels/friends_view_model.dart'; // Replace with your actual package name

class FriendsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(friendsViewModelProvider);
    final tabs = [FriendsNavScreen.MyFriends, FriendsNavScreen.FriendRequests];

    useEffect(() {
      viewModel.loadFriends();
      viewModel.getFriendsList();
      return null;
    }, const []);

    final pagerController = usePageController();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: TabsContent(tabs: tabs, pagerController: pagerController),
          ),
          Tabs(tabs: tabs, pagerController: pagerController),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the main screen
          // Add your navigation logic here
        },
        child: Icon(Icons.arrow_right),
      ),
    );
  }
}

class Tabs extends ConsumerWidget {
  const Tabs({
    Key? key,
    required this.tabs,
    required this.pagerController,
  }) : super(key: key);

  final List<FriendsNavScreen> tabs;
  final PageController pagerController;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(goalsViewModelProvider);
    final state = viewModel.uiState;

    useEffect(() {
      pagerController.jumpToPage(FriendsNavScreen.MyFriends.id);
      return null;
    }, const []);

    return TabBar(
      controller: TabController(length: tabs.length, vsync: Scaffold.of(context)),
      tabs: [
        for (var i = 0; i < tabs.length; i++)
          LeadingIconTab(
            icon: Icon(Icons.person),
            text: Text('${tabs[i].title} (${i == 0 ? state.shelvedSize.value : state.inProgressSize.value})', style: TextStyle(fontSize: 10)),
            selected: pagerController.page == i,
            onTap: () {
              pagerController.animateToPage(i, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
          ),
      ],
    );
  }
}

class TabsContent extends ConsumerWidget {
  const TabsContent({
    Key? key,
    required this.tabs,
    required this.pagerController,
  }) : super(key: key);

  final List<FriendsNavScreen> tabs;
  final PageController pagerController;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(goalsViewModelProvider);
    final state = viewModel.uiState;

    return Expanded(
        child: PageView(
            controller: pagerController,
            children: [
            for (var tab in tabs)
        if (tab.id == 0) MyFriendsScreen(),
    else if (tab.id == 1) FriendRequestsScreen(),
    else SizedBox.shrink(),
    ],
    ),
    );
  }
}

class LeadingIconTab extends StatelessWidget {
  const LeadingIconTab({
    Key? key,
    required this.icon,
    required this.text,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  final Widget icon;
  final Widget text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(height: 4),
            text,
          ],
        ),
      ),
    );
  }
}
