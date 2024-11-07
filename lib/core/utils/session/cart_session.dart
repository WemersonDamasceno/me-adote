import 'package:flutter/material.dart';

import '../../../features/shop/data/models/product_model.dart';

class CartSession {
  List<ProductModel> products = [];
  ValueNotifier<int> productCount = ValueNotifier<int>(0);

  void addProduct(ProductModel product) {
    products.add(product);
    productCount.value = products.length;
  }

  void removeProduct(ProductModel product) {
    products.remove(product);
    productCount.value = products.length;
  }

  void clear() {
    products.clear();
    productCount.value = products.length;
  }
}
