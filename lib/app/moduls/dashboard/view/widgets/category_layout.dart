import 'package:e_com_cub/app/moduls/dashboard/controllers/home_controller.dart';
import 'package:e_com_cub/app/moduls/dashboard/view/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();
    final List<Map<String, dynamic>> categories = [
      {'name': 'All', 'icon': Icons.category},
      {'name': 'Electronic', 'icon': Icons.phone_android},
      {'name': 'Cloting', 'icon': Icons.checkroom},
      {'name': 'Grocery', 'icon': Icons.local_grocery_store},
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 30),
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            onTap: () {
              controller.changeCategory(category['name']);
              Get.to(() => SearchScreen());
            },
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(category['icon'], color: Colors.black),
                ),
                const SizedBox(height: 6),
                Text(
                  category['name'],
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
