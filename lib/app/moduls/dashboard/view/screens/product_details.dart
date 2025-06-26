import 'package:e_com_cub/utils/app_color.dart';
import 'package:e_com_cub/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/view/widgets/success_message.dart';
import '../../controllers/home_controller.dart';
import '../../models/product_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(product.name, style: AppStyle.mid_large_text),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Product Image with Hero
          Hero(
            tag: 'product_image_${product.id}',
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(product.image),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Text(
                      product.category,
                      style: AppStyle.normal_text.copyWith(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Product Name
                  Text(
                    product.name,
                    style: AppStyle.mid_large_text.copyWith(fontSize: 22, fontWeight: FontWeight.bold,color: AppColor.normalTextColor),
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: AppStyle.mid_large_text.copyWith(
                      fontSize: 20,
                      color: AppColor.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Description
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        'Experience premium quality with this exclusive ${product.name}. Designed to meet your needs, it blends style, functionality, and durability. A perfect pick for everyday use.',
                        style: AppStyle.normal_text.copyWith(fontSize: 14, height: 1.5),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Obx(() {
                    final isInCart = controller.cart.any((p) => p.id == product.id);

                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(

                        icon: Icon(
                          isInCart ? Icons.check_circle_outline : Icons.shopping_cart_outlined,
                          color: isInCart ? AppColor.primaryColor : Colors.white,
                        ),
                        label: Text(
                          isInCart ? "Already Added" : "Add to Cart",
                          style: AppStyle.normal_text.copyWith(
                            color: isInCart ? AppColor.primaryColor : Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isInCart ? Colors.white : AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: isInCart ? AppColor.primaryColor : Colors.transparent,
                            ),
                          ),
                        ),
                        onPressed: isInCart
                            ? null
                            : () {
                          controller.addToCart(product.id);
                          showSuccessMessage(message: "Product added to cart ${product.name} has been added.");

                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 20),



                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
