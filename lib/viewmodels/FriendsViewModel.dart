import 'package:flutter/foundation.dart';
import 'package:rootine/models/goal.dart';
import 'package:rootine/models/user.dart';
import 'package:rootine/repositories/data_repository.dart';
import 'package:rootine/repositories/friends_repository.dart';
import 'package:rootine/repositories/rootines_repository.dart';
import 'package:rootine/repositories/user_repository.dart';

class FriendsScreenState {
  final _friendsList = <User>[];
  List<User> get friendsList => List.unmodifiable(_friendsList);

  var username = "";
  var usernames = <String>[];
  var requestList = <String>[];
  var requestedList = <String>[];
  var friends = <String>[];
  var usernameExists = false;
  var btnMessage = "Add";
  var canAccept = false;
  var userImageUri = "";
  var friendObjects = <User>[];
  var user = User();

  final _inProgress = <Rootine>[];
  List<Rootine> get inProgress => List.unmodifiable(_inProgress);
}

class FriendsViewModel extends ChangeNotifier {
  var uiState = FriendsScreenState();

  Future<void> getInProgress(User user) async {
    debugPrint("ACTIVITY: Getting data");
    await DataRepository.loadOtherUserInProgressGoals(user);
    final inProgress = RootinesRepository.otherUserGetInProgress(user);
    uiState._inProgress.clear();
    uiState._inProgress.addAll(inProgress);
    notifyListeners();
  }

  Future<void> getFriendsList() async {
    final friends = await FriendsRepository.getFriends();
    uiState._friendsList.clear();
    uiState._friendsList.addAll(friends);
    notifyListeners();
  }

  Future<User> getUserByUsername(String username) async {
    final user = await UserRepository.getUserByUsername(username);
    debugPrint("getUserInViewModel: ${user.firstName}");
    return user;
  }

  Future<void> getUsernames() async {
    final user = await UserRepository.getUser();
    uiState.usernames = await UserRepository.getUsernames();
    uiState.requestList = user.requestList!;
    uiState.requestedList = user.requestedList!;
    uiState.friends = user.friendsList!;
    uiState.username = user.username!;
    uiState.userImageUri = user.imageLoc!;
    notifyListeners();
  }

  Future<void> addFriend(String otherUsername) async {
    // store data in database
    uiState.requestList.remove(otherUsername);
    uiState.friends.add(otherUsername);
    final myUser = await UserRepository.getUser();
    final myUsername = myUser.username!;
    final myUserCopy =
    myUser.copyWith(userId: myUser.userId, requestList: uiState.requestList, friendsList: uiState.friends);
    final otherUser = await UserRepository.getUserByUsername(otherUsername);
    otherUser.requestedList?.remove(myUsername);
    otherUser.friendsList?.add(myUsername);
    final otherUserCopy =
    otherUser.copyWith(userId: otherUser.userId, requestList: otherUser.requestList, friendsList: otherUser.friendsList);
    await UserRepository.updateUser(myUserCopy);
    await UserRepository.updateUser(otherUserCopy);

    // update local data
    FriendsRepository.addFriend(await UserRepository.getUserByUsername(otherUsername));
    notifyListeners();
  }

  void loadFriends() {
    FriendsRepository.clearFriends();
    for (final x in uiState.friendsList) {
      FriendsRepository.addFriend(x);
    }
    notifyListeners();
  }

  void checkUsernameExists(String username) {
    uiState.canAccept = false;
    if (username.isEmpty || username == uiState.username) {
      uiState.usernameExists = false;
      uiState.btnMessage = "Add";
    } else if (uiState.friends.contains(username)) {
      uiState.usernameExists = false;
      uiState.btnMessage = "Friends";
    } else if (uiState.requestList.contains(username)) {
      uiState.canAccept = true;
      uiState.usernameExists = true;
      uiState.btnMessage = "Accept";
    } else if (uiState.requestedList.contains(username)) {
      uiState.usernameExists = false;
      uiState.btnMessage = "Requested";
    } else if (uiState.usernames.contains(username)) {
      uiState.usernameExists = true;
      uiState.btnMessage = "Add";
    } else {
      uiState.usernameExists = false;
      uiState.btnMessage = "Add";
    }
    notifyListeners();
  }

  Future<void> sendRequest(String otherUsername) async {
    uiState.requestedList.add(otherUsername);
    final myUser = await UserRepository.getUser();
    final myUsername = myUser.username!;
    final myUserCopy = myUser.copyWith(id: myUser.id, requestedList: uiState.requestedList);
    final otherUser = await UserRepository.getUserByUsername(otherUsername);
    otherUser.requestList?.add(myUsername);
    final otherUserCopy = otherUser.copyWith(id: otherUser.id, requestList: otherUser.requestList);
    await UserRepository.updateUser(myUserCopy);
    await UserRepository.updateUser(otherUserCopy);
    notifyListeners();
  }
}
