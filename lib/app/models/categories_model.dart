import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  String? name, imageUrl, id;

  CategoriesModel({this.name, this.imageUrl, this.id});

  factory CategoriesModel.fromJson(DocumentSnapshot json) => CategoriesModel(
        id: json.id,
        name: json["name"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "id": id,
      };
}
