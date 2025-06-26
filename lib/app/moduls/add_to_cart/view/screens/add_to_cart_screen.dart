import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../global/view/widgets/dialog_widget.dart';
import '../../../dashboard/controllers/home_controller.dart';
import '../../../dashboard/models/product_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        leading: const SizedBox.shrink(),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.cart.isEmpty) {
          return _buildEmptyCart();
        }
        return _buildCartContent(controller);
      }),
    );
  }

  Widget _buildEmptyCart() {
    return const Center(
      child: Text(
        "Your cart is empty",
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _buildCartContent(ProductController controller) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: controller.cart.length,
            itemBuilder: (_, index) {
              final p = controller.cart[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Card(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    leading: Image.asset(p.image, height: 50, width: 50, fit: BoxFit.fitHeight),
                    title: Text(p.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("\$${p.price.toStringAsFixed(2)}",
                            style: AppStyle.normal_text.copyWith(color: AppColor.primaryColor)),
                        const SizedBox(height: 6),
                        _buildQuantityControls(controller, p),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => controller.cart.removeAt(index),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        _buildTotalAndOrderButton(controller),
      ],
    );
  }

  Widget _buildQuantityControls(ProductController controller, Product product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () => controller.decreaseQuantity(product),
          splashRadius: 20,
        ),
        Text('${product.quantity}', style: const TextStyle(fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () => controller.increaseQuantity(product),
          splashRadius: 20,
        ),
      ],
    );
  }

  Widget _buildTotalAndOrderButton(ProductController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, -3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                "\$${controller.totalCartPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
                showOrderSuccessDialog();
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
              child: Text(
                "Place Order",
                style: TextStyle(fontSize: 16, color: AppColor.cardColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
