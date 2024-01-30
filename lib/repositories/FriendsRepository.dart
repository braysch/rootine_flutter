import '../models/User.dart';
import '../models/friend.dart';
import '../models/goal.dart';

class FriendsRepository {
  static List<User> friendList = [];
  static List<Goal> requestList = [];
  static List<Goal> requestedList = [];
  static List<User> friendObjectList = [];

  static Future<List<User>> getFriends() async {
    friendList.clear();
    //var currentUser = await UserRepository.getUser();
    //for (var username in currentUser.friendsList!) {
      //friendList.add(await UserRepository.getUserByUsername(username));
    //}
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
