class User {
  String? userId;
  String? image;
  String? firstName;
  String? name;
  String? username;
  int currency = 0;
  int age = 0;
  String birthday = "";
  List<String>? friendsList;
  List<String>? requestList;
  List<String>? requestedList;
  String? id;
  String? imageLoc;
  int weekOfYear = 0;

  User({
    this.userId,
    this.image,
    this.firstName = "Test",
    this.name,
    this.username,
    this.currency = 0,
    this.age = 0,
    this.birthday = "",
    this.friendsList,
    this.requestList,
    this.requestedList,
    this.id,
    this.imageLoc,
    this.weekOfYear = 0,
  });
}