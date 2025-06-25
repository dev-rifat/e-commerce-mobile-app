import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var cart = <Product>[].obs;
  var orders = <Product>[].obs;
  var selectedCategory = 'All'.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }

  void loadProducts() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    final String response = await rootBundle.loadString('assets/images/json/product.json');
    final data = json.decode(response);
    products.value = List<Product>.from(data['products'].map((e) => Product.fromJson(e)));
    isLoading.value = false;
  }

  void addToCart(int id) {
    final product = products.firstWhereOrNull((p) => p.id == id);
    if (product != null && !cart.any((p) => p.id == id)) {
      cart.add(product);
    }
  }

  void placeOrder() {
    if (cart.isNotEmpty) {
      orders.addAll(cart);
      cart.clear();
    }
  }

  List<Product> get filteredProducts {
    if (selectedCategory.value == 'All') {
      return products;
    }
    return products.where((p) => p.category == selectedCategory.value).toList();
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }
}

