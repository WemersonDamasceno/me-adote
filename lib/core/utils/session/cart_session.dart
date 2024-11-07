import 'package:flutter/material.dart';

import '../../../features/shop/data/models/product_model.dart';

class CartSession {
  final products = ValueNotifier<List<ProductModel>>([]);
  ValueNotifier<int> productCount = ValueNotifier<int>(0);
  ValueNotifier<double> totalAmount = ValueNotifier<double>(0.0);

  void addProduct(ProductModel product) {
    final existingProduct = products.value.firstWhere(
      (p) => p.id == product.id,
      orElse: () => ProductModel.empty(),
    );

    if (existingProduct.id.isEmpty) {
      products.value = List.from(products.value)..add(product);
    } else {
      existingProduct.quantity += 1;
    }
    productCount.value = _calculateTotalItems();
    totalAmount.value = _calculateTotalAmount();
  }

  void removeProduct(ProductModel product) {
    final existingProduct =
        products.value.firstWhere((p) => p.id == product.id);
    if (existingProduct.quantity > 1) {
      existingProduct.quantity -= 1;
    } else {
      products.value = List.from(products.value)..remove(product);
    }
    productCount.value = _calculateTotalItems();
    totalAmount.value = _calculateTotalAmount();
  }

  void clear() {
    products.value = [];
    productCount.value = 0;
    totalAmount.value = 0.0;
  }

  int _calculateTotalItems() {
    return products.value.fold(0, (sum, product) => sum + product.quantity);
  }

  double _calculateTotalAmount() {
    return products.value
        .fold(0.0, (sum, product) => sum + (product.price * product.quantity));
  }
}
