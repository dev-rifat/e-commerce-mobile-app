import 'dart:async';
import 'package:e_com_cub/app/moduls/dashboard/view/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_color.dart';
import '../../controllers/home_controller.dart';
import '../widgets/product_card.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final ProductController controller = Get.find<ProductController>();
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;
  Timer? _debounce;

  void _onSearchChanged(String value) {
    searchQuery.value = value.toLowerCase();
    isSearching.value = true;

    // Debounce input to reduce re-renders
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      isSearching.value = false;
    });
  }

  List _getFilteredProducts() {
    if (searchQuery.isEmpty) return controller.products;
    return controller.products.where((product) {
      return product.name.toLowerCase().contains(searchQuery.value);
    }).toList();
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search by name',
          prefixIcon: const Icon(Icons.search),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.pendingBgColor),
            borderRadius: BorderRadius.circular(50),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(List filteredList) {
    if (filteredList.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.builder(
        itemCount: filteredList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final product = filteredList[index];
          return InkWell(
            onTap: () => Get.to(() => ProductDetailsPage(product: product)),
            child: ProductCard(product: product),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Product"),
      ),
      body: Column(
        children: [
          _buildSearchField(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value || isSearching.value) {
                return Center(
                  child: CircularProgressIndicator(color: AppColor.primaryColor),
                );
              }

              final filteredList = _getFilteredProducts();
              return _buildProductGrid(filteredList);
            }),
          ),
        ],
      ),
    );
  }
}
