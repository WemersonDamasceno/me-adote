class ProductModel {
  final String id;
  final PromotionProductModel promotion;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  ProductModel({
    required this.promotion,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      promotion: PromotionProductModel.fromJson(json['promotion']),
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isPromotion': promotion.toJson(),
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

class PromotionProductModel {
  final String id;
  final bool isActive;
  final double price;

  PromotionProductModel({
    required this.id,
    required this.isActive,
    required this.price,
  });

  factory PromotionProductModel.fromJson(Map<String, dynamic> json) {
    return PromotionProductModel(
      id: json['id'],
      price: json['price'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'isActive': isActive,
    };
  }
}
