import 'dart:async';
import 'package:e_com_cub/app/global/utils/custom_spacer.dart';
import 'package:e_com_cub/utils/images.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';

class AppBanner extends StatefulWidget {
  const AppBanner({super.key});

  @override
  State<AppBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<AppBanner> {
  final PageController _pageController = PageController();
  final List<String> _banners = [
    AppImages.banner1,
    AppImages.banner2,
    AppImages.banner3,

  ];

  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _currentPage++;
      if (_currentPage >= _banners.length) _currentPage = 0;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppLayout.getHeight(175),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _banners.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(_banners[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
              ),
            ],
          ),
        ),
        customSpacerHeight( height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: _currentPage == index ? 30 : 6,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColor.primaryColor
                    : Colors.grey[400],
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        )
      ],
    );
  }
}
