import 'package:e_com_cub/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/images.dart';
import '../../../../global/utils/app_container_helper.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

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
                  image: AssetImage(AppImages.pro_2),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Title
            const Text(
              'Taylor Plush 4-Piece Modular Chaise ...',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),

            const SizedBox(height: 6),

            // Price + Add to Cart Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '\$293.00',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle add to cart
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
