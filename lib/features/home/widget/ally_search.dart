import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/home/model/ally_search_model.dart';

class AllySearchController extends GetxController {
  final searchController = TextEditingController();
  final gender = 'Any'.obs;
  final ageRange = 'All'.obs;
  final languages = <String>{'English', 'Hindi'}.obs;
  final sortBy = 'Relevance'.obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void toggleLanguage(String lang) {
    if (languages.contains(lang)) {
      languages.remove(lang);
    } else {
      languages.add(lang);
    }
  }
}

class AllySearchScreen extends StatelessWidget {
  const AllySearchScreen({super.key});

  static const List<String> _genderOptions = ['Any', 'Female', 'Male'];
  static const List<String> _ageOptions = [
    'All',
    '20-25',
    '25-30',
    '30-35',
    '35+',
  ];
  static const List<String> _languageOptions = [
    'English',
    'Hindi',
    'Kannada',
    'Tamil',
    'Telugu',
  ];
  static const List<String> _sortOptions = [
    'Relevance',
    'Rating',
    'Sessions',
    'Online first',
  ];

  final List<AllySearchModel> _allies = const [
    AllySearchModel(
      name: 'Kavya',
      rating: 4.9,
      languages: ['English', 'Hindi', 'Kannada'],
      image: 'https://i.pravatar.cc/150?img=47',
      status: AllyStatus.online,
    ),
    AllySearchModel(
      name: 'Meera',
      rating: 4.9,
      languages: ['English', 'Hindi', 'Kannada'],
      image: 'https://i.pravatar.cc/150?img=32',
      status: AllyStatus.busy,
    ),
    AllySearchModel(
      name: 'Sara',
      rating: 4.9,
      languages: ['English', 'Hindi', 'Kannada'],
      image: 'https://i.pravatar.cc/150?img=25',
      status: AllyStatus.offline,
    ),
    AllySearchModel(
      name: 'Nisha',
      rating: 4.9,
      languages: ['English', 'Hindi', 'Kannada'],
      image: 'https://i.pravatar.cc/150?img=48',
      status: AllyStatus.busy,
    ),
  ];

  Color _statusBg(AllyStatus s) {
    switch (s) {
      case AllyStatus.online:
        return const Color(0xFFE6F9F0);
      case AllyStatus.busy:
        return const Color(0xFFFFF3E0);
      case AllyStatus.offline:
        return const Color(0xFFF0F0F5);
    }
  }

  Color _statusFg(AllyStatus s) {
    switch (s) {
      case AllyStatus.online:
        return const Color(0xFF1DAF6B);
      case AllyStatus.busy:
        return const Color(0xFFF59E0B);
      case AllyStatus.offline:
        return const Color(0xFF8E8EA9);
    }
  }

  String _statusLabel(AllyStatus s) {
    switch (s) {
      case AllyStatus.online:
        return 'Online';
      case AllyStatus.busy:
        return 'Busy';
      case AllyStatus.offline:
        return 'Offline';
    }
  }

  Widget _segmentedRow({
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: options.map((opt) {
          final bool sel = selected == opt;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(opt),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                height: 36.h,
                decoration: BoxDecoration(
                  color: sel ? Color(0xFFF0EEFF) : Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                  boxShadow: sel
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                  border: sel
                      ? Border.all(
                          color: AppColors.primaryColor.withOpacity(0.35),
                          width: 1.0,
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  opt,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: sel
                        ? AppColors.primaryColor
                        : const Color(0xFF8E8EA9),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _languageChip(String lang, AllySearchController controller) {
    final bool sel = controller.languages.contains(lang);
    return GestureDetector(
      onTap: () => controller.toggleLanguage(lang),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: sel ? const Color(0xFFF0EEFF) : const Color(0xFFF3F3F7),
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(
            color: sel ? AppColors.primaryColor : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Text(
          lang,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: sel ? AppColors.primaryColor : const Color(0xFF8E8EA9),
          ),
        ),
      ),
    );
  }

  // ── Sort chip ───────────────────────────────────────────────────────────────
  Widget _sortChip(String label, AllySearchController controller) {
    final bool sel = controller.sortBy.value == label;
    return GestureDetector(
      onTap: () => controller.sortBy.value = label,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: sel ? const Color(0xFFF0EEFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(
            color: sel ? AppColors.primaryColor : const Color(0xFFD1D1DB),
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: sel ? AppColors.primaryColor : const Color(0xFF8E8EA9),
          ),
        ),
      ),
    );
  }

  Widget _filterCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  Widget _allyTile(AllySearchModel ally) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Avatar
          _AllyAvatar(name: ally.name, imagePath: ally.image),
          SizedBox(width: 12.w),

          // Name + rating + languages
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        ally.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.star_rounded,
                      color: const Color(0xFFFFC107),
                      size: 15.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      ally.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  ally.languages.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF8E8EA9),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Status badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: _statusBg(ally.status),
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Text(
              _statusLabel(ally.status),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: _statusFg(ally.status),
              ),
            ),
          ),

          SizedBox(width: 6.w),

          // Chevron
          Icon(
            Icons.chevron_right_rounded,
            color: const Color(0xFFBBBBC8),
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AllySearchController controller = Get.put(AllySearchController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 38.w,
                        height: 38.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: const Color(0xFF1A1A2E),
                          size: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Text(
                      'Find your Ally',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1A2E),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 18.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 46.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13.r),
                        ),
                        child: TextField(
                          controller: controller.searchController,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF1A1A2E),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Find your ally',
                            hintStyle: TextStyle(
                              color: const Color(0xFFBBBBC8),
                              fontSize: 14.sp,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: const Color(0xFFBBBBC8),
                              size: 20.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      width: 46.h,
                      height: 46.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13.r),
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        color: const Color(0xFF1A1A2E),
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 14.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _filterCard(
                  title: 'Prefer talking to',
                  child: Obx(
                    () => _segmentedRow(
                      options: _genderOptions,
                      selected: controller.gender.value,
                      onSelect: (v) => controller.gender.value = v,
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            // ── Age range filter ─────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _filterCard(
                  title: 'Age range',
                  child: Obx(
                    () => _segmentedRow(
                      options: _ageOptions,
                      selected: controller.ageRange.value,
                      onSelect: (v) => controller.ageRange.value = v,
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _filterCard(
                  title: 'Language',
                  child: Obx(
                    () => Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: _languageOptions
                          .map((l) => _languageChip(l, controller))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 18.h)),

            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  '${_allies.length * 3} allies found',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF8E8EA9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),

            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(
                  () => Row(
                    children: _sortOptions
                        .map(
                          (s) => Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: _sortChip(s, controller),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 18.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Your Allies',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1A1A2E),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: _allyTile(_allies[index]),
                  ),
                  childCount: _allies.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllyAvatar extends StatelessWidget {
  const _AllyAvatar({required this.name, required this.imagePath});

  final String name;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    const double size = 48;
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFD5CAFF), width: 2),
      ),
      child: ClipOval(
        child: Image.network(
          imagePath,
          width: size.w,
          height: size.w,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _ShimmerAvatar();
          },
          errorBuilder: (_, __, ___) => _FallbackAvatar(),
        ),
      ),
    );
  }
}

// Animated shimmer while image loads
class ShimmerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController ctrl;
  late final Animation<double> anim;

  @override
  void onInit() {
    super.onInit();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    anim = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeInOut));
  }

  @override
  void onClose() {
    ctrl.dispose();
    super.onClose();
  }
}

class _ShimmerAvatar extends StatelessWidget {
  const _ShimmerAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShimmerController());
    return AnimatedBuilder(
      animation: controller.anim,
      builder: (_, __) => Container(
        color: Color.lerp(
          const Color(0xFFEDE8FF),
          const Color(0xFFD5CAFF),
          controller.anim.value,
        ),
      ),
    );
  }
}

class _FallbackAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEDE8FF),
      alignment: Alignment.center,
      child: Icon(
        Icons.person_rounded,
        color: const Color(0xFF7C5CFC),
        size: 28.sp,
      ),
    );
  }
}
