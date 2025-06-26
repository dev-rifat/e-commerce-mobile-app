import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_color.dart';
import '../../../../global/utils/app_container_helper.dart';
import '../../../../global/utils/custom_spacer.dart';
import '../../../../global/view/widgets/custom_section_header.dart';
import '../../../notification/view/screens/notificaton.dart';
import '../../controllers/home_controller.dart';
import '../widgets/banner_layout.dart';
import '../widgets/category_layout.dart';
import '../widgets/product_card.dart';
import 'package:e_com_cub/app/moduls/dashboard/view/screens/product_details.dart';
import 'package:e_com_cub/app/moduls/dashboard/view/screens/search_screen.dart';
import 'package:e_com_cub/utils/app_layout.dart';
import 'package:e_com_cub/utils/app_style.dart';
import 'package:e_com_cub/utils/images.dart';

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
            ? const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              )
            : RefreshIndicator(
                color: AppColor.primaryColor,
                onRefresh: _fetchProducts,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchBar(),
                      customSpacerHeight(height: 20),
                      const AppBanner(),
                      const SizedBox(height: 8),

                      const SizedBox(height: 20),
                      const CategoryList(),
                      _buildSectionHeader(),
                      const SizedBox(height: 12),
                      _buildProductList(),
                      const SizedBox(height: 112),

                    ],
                  ),
                ),
              ),
      ),
    );
  }

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      leading: _buildProfileAvatar(),
      title: const Text(
        "E-Mart",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [_buildNotificationButton()],
    );
  }

  Widget _buildProfileAvatar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
      child: CircleAvatar(backgroundImage: AssetImage(AppImages.person)),
    );
  }

  Widget _buildNotificationButton() {
    return IconButton(
      icon: const Icon(Icons.notifications, color: Colors.black),
      onPressed: () => Get.to(() => NotificationPage()),
    );
  }

  /// Search Bar
  Widget _buildSearchBar() {
    return InkWell(
      onTap: () {
        Get.to(() => SearchScreen());
        controller.loadProducts();
      },

      child: Container(
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
            _buildSearchButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return Container(
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
    );
  }

  /// Section header for New Arrivals
  Widget _buildSectionHeader() {
    return SectionHeader(
      title: "New Arrivals",
      actionText: "View all",
      onActionTap: () {
        Get.to(() => SearchScreen());

        controller.loadProducts();
      },
    );
  }

  /// Horizontal product list
  Widget _buildProductList() {
    return SizedBox(
      height: AppLayout.getHeight(250),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final product = controller.products[index];
          return InkWell(
            onTap: () => Get.to(() => ProductDetailsPage(product: product)),
            child: ProductCard(product: product),
          );
        },
      ),
    );
  }

  /// Refresh function
  Future<void> _fetchProducts() async {
    controller.loadProducts();
  }
}
