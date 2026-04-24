import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavann27/features/home/controller/home_page_controller.dart';
import 'package:pavann27/features/home/model/home_page_model.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';

class AllyCard extends StatelessWidget {
  final HomePageModel ally;
  final bool isHighlighted;
  final VoidCallback onTalkTap;
  final VoidCallback onCardTap;
  final HomePageController controller;

  const AllyCard({
    super.key,
    required this.ally,
    required this.isHighlighted,
    required this.onTalkTap,
    required this.onCardTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: isHighlighted ? const Color(0xFFF3EFFE) : AppColors.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isHighlighted ? AppColors.primaryColor : Colors.transparent,
            width: 1.4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ally.canTalkNow
                              ? AppColors.primaryColor
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 28.r,
                        backgroundImage: ally.image.startsWith('http')
                            ? NetworkImage(ally.image)
                            : AssetImage(ally.image) as ImageProvider,
                        backgroundColor: AppColors.lightPurple,
                      ),
                    ),
                    Positioned(
                      right: 1.w,
                      bottom: 1.h,
                      child: Container(
                        width: 13.w,
                        height: 13.w,
                        decoration: BoxDecoration(
                          color: controller.getStatusColor(ally.status),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + verified
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              ally.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                          if (ally.isVerified) ...[
                            SizedBox(width: 5.w),
                            Container(
                              height: 18.w,
                              width: 18.w,
                              decoration: const BoxDecoration(
                                color: AppColors.lightPurple,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.verified,
                                size: 12.sp,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ],
                      ),

                      SizedBox(height: 3.h),

                      // Status dot + label
                      Row(
                        children: [
                          Container(
                            width: 7.w,
                            height: 7.w,
                            decoration: BoxDecoration(
                              color: controller.getStatusColor(ally.status),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            ally.status,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: controller.getStatusColor(ally.status),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 3.h),

                      // Rating · hours
                      Text(
                        '${ally.rating} (${ally.reviews}) · ${ally.hours}+ hrs',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 10.w),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Talk now / Notify
                    ally.canTalkNow
                        ? GestureDetector(
                            onTap: onTalkTap,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C30ED),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Text(
                                'Talk now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F3F5),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.notifications_none_rounded,
                                    size: 15.sp,
                                    color: AppColors.textColor,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    'Notify',
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                    // Estimated wait time
                    if (ally.estimatedTime != null) ...[
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 7.w,
                            height: 7.w,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            ally.estimatedTime!,
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: ally.bio,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6F6F75),
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
