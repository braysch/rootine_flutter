import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpException implements Exception {
  final String? message;

  SignUpException(this.message);
}

class SignInException implements Exception {
  final String? message;

  SignInException(this.message);
}

class User {
  String? userId;
  String? id;
  String? firstName;
  String? username;
  String? birthday;
  int? age;
  String? image;
  List<String>? friendsList;
  List<String>? requestList;
  List<String>? requestedList;
  int? currency;
  String? imageLoc;
  int? weekOfYear;

  User({
    this.userId,
    this.id,
    this.firstName,
    this.username,
    this.birthday,
    this.age,
    this.image,
    this.friendsList,
    this.requestList,
    this.requestedList,
    this.currency,
    this.imageLoc,
    this.weekOfYear,
  });
}

class UserRepository {
  static User user = User();
  static bool milestone = false;
  static int numMotivators = 0;

  static void setMilestone(bool state) {
    milestone = state;
  }

  static bool getMilestone() {
    return milestone;
  }

  /*static Future<List<String>> getUsernames() async {
    var usernames = <String>[];
    var snapshot = await FirebaseFirestore.instance.collection("users").get();
    var profiles = snapshot.docs.map((doc) => User.fromMap(doc.data())).toList();
    for (var x in profiles) {
      x.username?.let((it) => usernames.add(it));
    }
    return usernames;
  }*/

  /*static Future<User> getUserByUsername(String username) async {
    var otherUser = User();
    var snapshot = await FirebaseFirestore.instance.collection("users").where("username", isEqualTo: username).get();
    var documents = snapshot.docs;
    documents.forEach((doc) {
      otherUser = User.fromMap(doc.data() as Map<String, dynamic>);
      otherUser.id = doc.id;
    });
    return otherUser;
  }*/

  /*static Future<void> updateUser(User updatedUser) async {
    await FirebaseFirestore.instance.collection("users").doc(updatedUser.id!).set(updatedUser.toMap());
  }*/

  static Future<User> getUser() async {
    return user;
  }

  static Future<void> clearUser() async {
    user = User();
  }

  static Future<void> setUser({
    required String userId,
    required String firstName,
    required String username,
    required String birthday,
    required int age,
    required String image,
    required List<String> friendsList,
    required List<String> requestList,
    required List<String> requestedList,
  }) async {
    user.userId = userId;
    user.firstName = firstName;
    user.username = username;
    user.birthday = birthday;
    user.age = age;
    user.image = image;
    user.friendsList = friendsList;
    user.requestList = requestList;
    user.requestedList = requestedList;
  }

  static Future<void> setUserPhoto(String image) async {
    user.image = image;
  }

  /*static Future<User> createUser() async {
    var doc = FirebaseFirestore.instance.collection("users").doc();
    var newUser = User(
      id: doc.id,
      userId: getCurrentUserId(),
      firstName: user.firstName,
      username: user.username,
      birthday: user.birthday,
      age: user.age,
      image: user.image,
      friendsList: user.friendsList,
      requestList: user.requestList,
      requestedList: user.requestedList,
      currency: 20, // starting currency for new users
      imageLoc: user.imageLoc,
      weekOfYear: DateTime.now().weekOfYear,
    );
    await doc.set(newUser.toMap());
    return newUser;
  }*/

  /*static Future<void> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SignInException(e.message);
    }
  }*/

  /*static String? getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }*/

  /*static bool isUserLoggedIn() {
    return getCurrentUserId() != null;
  }*/

  /*static Future<String> getUserImage(String userId) async {
    return "${R.string.profile_images_ref}$userId?alt=media";
  }*/

  /*static Future<User> loadUserInfo() async {
    var snapshot = await FirebaseFirestore.instance.collection("users").where("userId", isEqualTo: getCurrentUserId()).get();
    var documents = snapshot.docs;
    documents.forEach((doc) {
      user = User.fromMap(doc.data() as Map<String, dynamic>);
      user.id = doc.id;
    });
    return user;
  }*/

  /*static void signOutUser() {
    FirebaseAuth.instance.signOut();
  }*/

  static void setNumMotivators(int size) {
    numMotivators = size;
  }

  static int getNumMotivators() {
    return numMotivators;
  }
}

extension DateTimeExtension on DateTime {
  int weekOfYear() {
    final startOfYear = DateTime(year, 1, 1);
    final firstMonday = startOfYear.weekday;
    final daysInFirstWeek = 8 - firstMonday;
    final diff = difference(startOfYear);
    if (diff.inDays < daysInFirstWeek) {
      return 1;
    }
    return 1 + ((diff.inDays - daysInFirstWeek) / 7).ceil();
  }
}
