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
            Text(
              'Running low ?',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'add funds to keep chatting without interruptions',
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
              text: 'not now',
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
