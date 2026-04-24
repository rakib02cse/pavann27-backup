import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/core/common/constants/widget/custom_button.dart';
import 'package:pavann27/features/topup/screen/topup_screen.dart';

class LowBalanceDialog extends StatelessWidget {
  const LowBalanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: const BoxDecoration(
                color: Color(0xFFEDE9FE),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.account_balance_wallet_outlined,
                color: AppColors.primaryColor,
                size: 26.sp,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              'Running low?',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Add funds to keep chatting without interruptions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.subTextColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              text: 'Add Balance',
              onPressed: () {
                Get.back();
                Get.to(() => TopupScreen());
              },
            ),
            SizedBox(height: 8.h),
            CustomButton(
              text: 'Not now',
              backgroundColor: Colors.transparent,
              textColor: const Color(0xFF727272),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}