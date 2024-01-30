import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_package_name_here/viewmodels/friends_view_model.dart'; // Replace with your actual package name

class FriendRequestsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(friendsViewModelProvider);
    final state = viewModel.uiState;

    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Requests (${state.requestList.length})"),
      ),
      body: ListView.builder(
        itemCount: state.requestList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(state.requestList[index]),
            // You can customize the ListTile as needed
          );
        },
      ),
    );
  }
}
