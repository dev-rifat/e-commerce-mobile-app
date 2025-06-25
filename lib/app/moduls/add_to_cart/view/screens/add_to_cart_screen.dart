import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../dashboard/controllers/home_controller.dart';
import '../../../dashboard/models/product_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Obx(() {
        if (controller.cart.isEmpty) {
          return const Center(
            child: Text("Your cart is empty"),
          );
        }

        final double totalPrice = controller.cart.fold(
          0,
              (sum, product) => sum + product.price,
        );

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cart.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final Product product = controller.cart[index];
                  return Card(
                    elevation: 0,
                    color: Colors.grey[200],

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.asset(
                        product.image,
                        height: 50,
                        width: 50,
                        fit: BoxFit.fitHeight,
                      ),
                      title: Text(product.name),
                      subtitle: Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: AppStyle.normal_text.copyWith(color: AppColor.primaryColor),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          controller.cart.removeAt(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            // Divider

            // Total and Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "\$${totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Place Order Button
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      onPressed: () {
                        controller.placeOrder();
                        Get.snackbar(
                          "Order Placed",
                          "Your order has been placed successfully!",
                          backgroundColor: AppColor.successColor,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          margin: const EdgeInsets.all(12),
                          duration: const Duration(seconds: 2),
                        );
                      },
                      child:  Text(
                        "Place Order",
                        style: TextStyle(fontSize: 16,color: AppColor.cardColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
