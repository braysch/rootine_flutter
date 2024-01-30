import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsRepository {
  static List<User> friendList = [];
  static List<Rootine> requestList = [];
  static List<Rootine> requestedList = [];
  static List<User> friendObjectList = [];

  static Future<List<User>> getFriends() async {
    friendList.clear();
    var currentUser = await UserRepository.getUser();
    for (var username in currentUser.friendsList!) {
      friendList.add(await UserRepository.getUserByUsername(username));
    }
    return friendList;
  }

  static void addFriend(User user) {
    friendList.add(user);
  }

  static void clearFriends() {
    friendList.clear();
  }

/* Future<void> setFriends() async {
    friendList.clear();
    var currentUser = await UserRepository.getUser();
    for (var username in currentUser.friendsList!) {
      friendObjectList.add(await UserRepository.getUserByUsername(username));
    }
  }

  Future<void> addFriend(String username) async {
    friendObjectList.add(await UserRepository.getUserByUsername(username));
  }

  Future<List<User>> getFriends() async {
    return friendObjectList;
  } */
}
