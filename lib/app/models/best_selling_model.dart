import 'package:cloud_firestore/cloud_firestore.dart';

class BestSellingModel {
  String? name, imageUrl, id, sized, price, rating, description;

  BestSellingModel(
      {this.name,
      this.imageUrl,
      this.id,
      this.price,
      this.rating,
      this.sized,
      this.description});

  factory BestSellingModel.fromJson(DocumentSnapshot json) => BestSellingModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        sized: json['sized'],
        price: json["price"],
        rating: json["rating"],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "id": id,
        "rating": rating,
        "price": price,
        "sized": sized,
        "description": description,
      };
}
