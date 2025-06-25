import 'package:e_com_cub/app/global/utils/custom_spacer.dart';
import 'package:e_com_cub/app/moduls/dashboard/view/screens/product_details.dart';
import 'package:e_com_cub/utils/app_layout.dart';
import 'package:e_com_cub/utils/app_style.dart';
import 'package:e_com_cub/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_color.dart';
import '../../../../global/utils/app_container_helper.dart';
import '../../../notification/view/screens/notificaton.dart';
import '../../controllers/home_controller.dart';
import '../widgets/banner_layout.dart';
import '../widgets/category_layout.dart';
import '../widgets/product_card.dart';

class HomeScreen extends GetView<ProductController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ProductController>()) {
      Get.put(ProductController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator(color: AppColor.primaryColor))
            : RefreshIndicator(
          color: AppColor.primaryColor,
          onRefresh: _fetchProducts,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _appSearchBar(),
                customSpacerHeight(height: 20),
                const AppBanner(),
                const SizedBox(height: 20),
                const CategoryList(),
                const Text(
                  'New Arrivals',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: AppLayout.getHeight(270),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ProductDetailsPage(product: product));
                          },
                          child: ProductCard(product: product,)), // <-- Ensure ProductCard accepts this
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
        child: CircleAvatar(
          backgroundImage: AssetImage(AppImages.person),
        ),
      ),
      title: const Text(
        "E-Mart",
        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          onPressed: () {
            Get.to(NotificationPage());

          },
        ),
      ],
    );
  }

  Widget _appSearchBar() {
    return Container(
      height: AppLayout.getHeight(46),
      decoration: ContainerStyleHelper.decoration().copyWith(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Enter search here",
              style: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
            ),
          ),
          Container(
            height: double.infinity,
            width: 90,
            decoration: ContainerStyleHelper.decoration().copyWith(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Search',
                style: AppStyle.normal_text.copyWith(color: AppColor.cardColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _fetchProducts() async {
     controller. loadProducts();

  }

}
