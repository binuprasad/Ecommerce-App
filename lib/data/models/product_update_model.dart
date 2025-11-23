
import 'dart:convert';

ProductUpdatelResponse productUpdatelResponseFromJson(String str) => ProductUpdatelResponse.fromJson(json.decode(str));

String productUpdatelResponseToJson(ProductUpdatelResponse data) => json.encode(data.toJson());

class ProductUpdatelResponse {
    int id;
    String title;
    int price;
    double discountPercentage;
    int stock;
    double rating;
    List<String> images;
    String thumbnail;
    String description;
    String brand;
    String category;

    ProductUpdatelResponse({
        required this.id,
        required this.title,
        required this.price,
        required this.discountPercentage,
        required this.stock,
        required this.rating,
        required this.images,
        required this.thumbnail,
        required this.description,
        required this.brand,
        required this.category,
    });

    factory ProductUpdatelResponse.fromJson(Map<String, dynamic> json) => ProductUpdatelResponse(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        discountPercentage: json["discountPercentage"]?.toDouble(),
        stock: json["stock"],
        rating: json["rating"]?.toDouble(),
        images: List<String>.from(json["images"].map((x) => x)),
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
        "images": List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail,
        "description": description,
        "brand": brand,
        "category": category,
    };
}
