import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_style.dart';

void showOrderSuccessDialog() {
  Get.defaultDialog(
    title: '',
    contentPadding: const EdgeInsets.all(20),
    backgroundColor: Colors.white,
    radius: 10,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 60),
        const SizedBox(height: 16),
        Text(
          'Order Successful!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Thank you for your order.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child:  Text('OK',style: AppStyle.normal_text.copyWith(color: Colors.white),),
        ),
      ],
    ),
  );
}
