import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_package_name_here/components/friend_item.dart'; // Replace with your actual package name
import 'package:your_package_name_here/viewmodels/friends_view_model.dart'; // Replace with your actual package name

class MyFriendsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(friendsViewModelProvider);
    final state = viewModel.uiState;
    var searchValue = useState("");
    var scope = useMemoized(() => ScopedCoroutine());

    useEffect(() {
      scope.launch(() {
        viewModel.getUsernames();
      });
      return null;
    }, const []);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "@${state.username}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 24),
            Text(
              "Add friend by username",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: TextEditingController(text: searchValue.value),
                    onChanged: (value) {
                      searchValue.value = value;
                      scope.launch(() => viewModel.checkUsernameExists(value));
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: state.usernameExists
                        ? () {
                      if (state.canAccept) {
                        scope.launch(() => viewModel.addFriend(searchValue.value));
                        scope.launch(() => viewModel.checkUsernameExists(searchValue.value));
                        scope.launch(() => viewModel.getFriendsList());
                      } else {
                        scope.launch(() => viewModel.sendRequest(searchValue.value));
                        scope.launch(() => viewModel.checkUsernameExists(searchValue.value));
                      }
                    }
                        : null,
                    child: Text(state.btnMessage),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            Text(
              "Friends (${state.friends.length})",
              style: TextStyle(fontSize: 24),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.friendsList.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      FriendItem(user: state.friendsList[index], navController: context.read(navControllerProvider)),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 18),
            Text(
              "Sent Requests (${state.requestedList.length})",
              style: TextStyle(fontSize: 24),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.requestedList.length,
                itemBuilder: (context, index) {
                  return Text(state.requestedList[index]);
                },
              ),
            ),
          ],
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
