import 'package:e_com_cub/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../global/utils/app_container_helper.dart';
import '../../controllers/home_controller.dart';
import '../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.44;

    return Container(
      width: cardWidth,
      decoration: ContainerStyleHelper.decoration().copyWith(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: AppLayout.getHeight(150),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image:  DecorationImage(
                  image: AssetImage(product.image),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Title
             Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),

            const SizedBox(height: 6),

            // Price + Add to Cart Icon
           _addToCartIcon(context, product),
          ],
        ),
      ),
    );
  }

  Widget _addToCartIcon(BuildContext context, Product product) {
    final ProductController controller = Get.find<ProductController>();

    return Obx(() {
      final isInCart = controller.cart.any((p) => p.id == product.id);

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          InkWell(
            onTap: () {
              if (!isInCart) {
                controller.addToCart(product.id);
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isInCart ? AppColor.successColor : AppColor.primaryColor,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Icon(
                isInCart ? Icons.done : Icons.add,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      );
    });
  }
}
