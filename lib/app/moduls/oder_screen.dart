import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import 'dashboard/controllers/home_controller.dart';
import 'dashboard/models/product_model.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        centerTitle: true,
      ),
      body: Obx(() {
        final orders = controller.orders;
        if (orders.isEmpty) {
          return const Center(
            child: Text(
              "No orders placed yet.",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final Product order = orders[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
              color: Colors.grey[200],
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    order.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                title: Text(
                  order.name,
                  style: AppStyle.normal_text.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${order.price.toStringAsFixed(2)}',
                      style: AppStyle.normal_text.copyWith(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Status: Placed",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                trailing: Icon(
                  Icons.check_circle,
                  color: Colors.green[400],
                ),
              ),
            );
          },
        );
      }),

    );
  }
}
