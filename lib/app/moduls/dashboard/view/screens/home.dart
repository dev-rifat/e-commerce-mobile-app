import 'package:e_com_cub/app/global/utils/custom_spacer.dart';
import 'package:e_com_cub/utils/app_layout.dart';
import 'package:e_com_cub/utils/app_style.dart';
import 'package:e_com_cub/utils/images.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/app_color.dart';
import '../../../../global/utils/app_container_helper.dart';
import '../widgets/banner_layout.dart';
import '../widgets/category_layout.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15,top: 8,bottom: 8),
          child: CircleAvatar(
            backgroundImage: AssetImage(
              AppImages.person,
            ), // e.g. 'assets/images/person.png'
          ),
        ),

        title: Text(
          "E-Mart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            _appSearchBar(),

            customSpacerHeight(height: 20),


            // Promo Banner
            AppBanner(),

            const SizedBox(height: 20),
            CategoryList(),
            const Text(
              'New Arrivals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Product Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.70,
              children: List.generate(11, (index) => const ProductCard()),
            ),
          ],
        ),
      ),
    );
  }

  _appSearchBar() {
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
}


