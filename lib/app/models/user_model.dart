import 'dart:convert';

import 'package:app_8april_2022/app/models/best_selling_model.dart';

UserModel usersModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String usersModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.uid,
    this.name,
    this.keyName,
    this.email,
    this.creationTime,
    this.lastSignInTime,
    this.photoUrl,
    this.status,
    this.updatedTime,
    this.cart,
  });

  String? uid;
  String? name;
  String? keyName;
  String? email;
  String? creationTime;
  String? lastSignInTime;
  String? photoUrl;
  String? status;
  String? updatedTime;
  List<BestSellingModel>? cart;
  // List<ChatUser>? chatsRoom;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        keyName: json["keyName"],
        email: json["email"],
        creationTime: json["creationTime"],
        lastSignInTime: json["lastSignInTime"],
        photoUrl: json["photoUrl"],
        status: json["status"],
        updatedTime: json["updatedTime"],
        // cart: _convertCartItems().toList(),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "keyName": keyName,
        "email": email,
        "creationTime": creationTime,
        "lastSignInTime": lastSignInTime,
        "photoUrl": photoUrl,
        "status": status,
        "updatedTime": updatedTime,
      };

  // List<BestSellingModel> _convertCartItems(List cartFromDB) {
  //   List<BestSellingModel> _result = [];
  //   logger.i(cartFromDB.length);
  //   cartFromDB.forEach((element) {
  //     _result.add(BestSellingModel.fromJson(element));
  //   }) as Map<String, dynamic>;

  //   return _result;
  // }
}
