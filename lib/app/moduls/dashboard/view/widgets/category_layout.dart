// File: category_list.dart

import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'All', 'icon': Icons.category},
      {'name': 'Electronics', 'icon': Icons.phone_android},
      {'name': 'Clothing', 'icon': Icons.checkroom},
      {'name': 'Grocery', 'icon': Icons.local_grocery_store},
      {'name': 'Books', 'icon': Icons.book},  {'name': 'All', 'icon': Icons.category},
      {'name': 'Electronics', 'icon': Icons.phone_android},
      {'name': 'Clothing', 'icon': Icons.checkroom},
      {'name': 'Grocery', 'icon': Icons.local_grocery_store},
      {'name': 'Books', 'icon': Icons.book},
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
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
          );
        },
      ),
    );
  }
}
