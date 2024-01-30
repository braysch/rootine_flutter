import 'dart:math';

class Motivator {
  String? message;
  String? imageUri;
  String? senderUsername;
  String? senderUserImageUri;
  bool? discreet;
  bool? anonymous;
  int? type;
  int? money;
  String id;

  Motivator({
    this.message,
    this.imageUri,
    this.senderUsername,
    this.senderUserImageUri,
    this.discreet,
    this.anonymous,
    this.type,
    this.money,
    String? id,
  }) : id = id ?? Random().nextDouble().toString(); // Generating a unique ID

  factory Motivator.fromJson(Map<String, dynamic> json) {
    return Motivator(
      message: json['message'],
      imageUri: json['imageUri'],
      senderUsername: json['senderUsername'],
      senderUserImageUri: json['senderUserImageUri'],
      discreet: json['discreet'],
      anonymous: json['anonymous'],
      type: json['type'],
      money: json['money'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'imageUri': imageUri,
      'senderUsername': senderUsername,
      'senderUserImageUri': senderUserImageUri,
      'discreet': discreet,
      'anonymous': anonymous,
      'type': type,
      'money': money,
      'id': id,
    };
  }
}