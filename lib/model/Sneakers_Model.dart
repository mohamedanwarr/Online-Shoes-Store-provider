import 'dart:convert';

List<Sneakers> sneakersFromJson(String str) => List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromJson(x)));
class Sneakers {
  String? id;
  String? name;
  String? category;
  List<String>? imageUrl;
  String? oldPrice;
  List<dynamic>? sizes;
  String? price;
  String? description;
  String? title;

  Sneakers(
      {this.id,
        this.name,
        this.category,
        this.imageUrl,
        this.oldPrice,
        this.sizes,
        this.price,
        this.description,
        this.title});

  Sneakers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    imageUrl = json['imageUrl'].cast<String>();
    oldPrice = json['oldPrice'];
    sizes=List<dynamic>.from(json["sizes"].map((x)=>x));
    price = json['price'];
    description = json['description'];
    title = json['title'];
  }


}



