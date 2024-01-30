import '../repositories/UsersRepository.dart';

class Friend {
  String? username;
  String? firstName;
  String? imageLoc;

  Friend({this.username});

  Future<String> getFirstName() async {
    var user = await UserRepository.getUserByUsername(username);
    return user.firstName ?? "";
  }

  Future<String> getImageLoc() async {
    var user = await UserRepository.getUserByUsername(username);
    return user.imageLoc ?? "";
  }
}

class UserRepository {
  static Future<User> getUserByUsername(String? username) async {
    // Implement the logic to fetch user data by username from Firebase or any other source
    // and return a User object.
    // For demonstration purposes, a dummy User is returned here.
    return User(firstName: "John", imageLoc: "path/to/image");
  }
}