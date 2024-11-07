class ProductModel {
  final String id;
  final PromotionProductModel promotion;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  int quantity;

  ProductModel({
    required this.promotion,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  factory ProductModel.empty() {
    return ProductModel(
      id: '',
      promotion: PromotionProductModel(id: '', isActive: false, price: 0.0),
      name: '',
      description: '',
      price: 0.0,
      imageUrl: '',
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      promotion: PromotionProductModel.fromJson(json['promotion']),
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'] ?? 1, // Pega a quantidade se disponível
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
      'quantity': quantity,
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
