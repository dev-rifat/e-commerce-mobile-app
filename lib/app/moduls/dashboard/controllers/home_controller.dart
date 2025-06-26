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
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 1000));
      final String response = await rootBundle.loadString('assets/images/json/product.json');
      final data = json.decode(response);
      products.value = List<Product>.from(
          (data['products'] as List).map((e) => Product.fromJson(e))
      );
    } catch (e) {
      // handle error, maybe print or log
      print('Error loading products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(int id) {
    final product = products.firstWhereOrNull((p) => p.id == id);
    if (product != null) {
      // Check if already in cart
      final existing = cart.firstWhereOrNull((p) => p.id == id);
      if (existing != null) {
        increaseQuantity(existing);
      } else {
        // Add a copy to cart with quantity = 1
        cart.add(Product(
          id: product.id,
          name: product.name,
          price: product.price,
          image: product.image,
          category: product.category,
          icon: product.icon,
          quantity: 1,
        ));
      }
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

  void increaseQuantity(Product product) {
    product.quantity++;
    cart.refresh();
  }

  void decreaseQuantity(Product product) {
    if (product.quantity > 1) {
      product.quantity--;
    } else {
      cart.remove(product);
    }
    cart.refresh();
  }

  double get totalCartPrice =>
      cart.fold(0.0, (sum, p) => sum + p.price * p.quantity);
}
