import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/iconpath.dart';
import 'package:pavann27/features/success/controller/success_controller.dart';

class SuccessScreen extends StatelessWidget {
  final SuccessController controller = Get.put(SuccessController());

  SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Logo
              Center(child: Image.asset(Iconpath.successLogo, height: 85.h)),

              SizedBox(height: 39.5.h),

              // Success Text
              Text(
                "Success! You are in.",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

  
              SizedBox(height: 51.5.h),

              // Find an Ally Button
              SizedBox(
                width: 171,
                height: 42.h,
                child: ElevatedButton(
                  onPressed: () => controller.findAnAlly(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C30ED),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Find an Ally",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
