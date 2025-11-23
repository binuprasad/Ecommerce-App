import 'dart:convert';

ProductUpdatelResponse productUpdatelResponseFromJson(String str) =>
    ProductUpdatelResponse.fromJson(json.decode(str));

String productUpdatelResponseToJson(ProductUpdatelResponse data) =>
    json.encode(data.toJson());

class ProductUpdatelResponse {
  int? id;
  String? title;
  int? price;
  double? discountPercentage;
  int? stock;
  double? rating;
  List<String>? images;
  String? thumbnail;
  String? description;
  String? brand;
  String? category;

  ProductUpdatelResponse({
    this.id,
    this.title,
    this.price,
    this.discountPercentage,
    this.stock,
    this.rating,
    this.images,
    this.thumbnail,
    this.description,
    this.brand,
    this.category,
  });

  factory ProductUpdatelResponse.fromJson(Map<String, dynamic> json) =>
      ProductUpdatelResponse(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        discountPercentage:
            (json["discountPercentage"] as num?)?.toDouble(),
        stock: json["stock"],
        rating: (json["rating"] as num?)?.toDouble(),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
        description: json["description"],
        brand: json["brand"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "discountPercentage": discountPercentage,
        "stock": stock,
        "rating": rating,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": thumbnail,
        "description": description,
        "brand": brand,
        "category": category,
      };
}
