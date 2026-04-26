// topup_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/topup/controller/topup_controller.dart';
import 'package:pavann27/features/bottom_navbar/screen/bottom_navbar_screen.dart';

class TopupScreen extends StatelessWidget {
  final TopupController controller = Get.put(TopupController());

  TopupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 22),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Add Balance",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: Color(0xFFE5DBFF),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.wallet_outlined, size: 52, color: AppColors.primaryColor),
                    const SizedBox(height: 12),
                    Obx(() => Text(
                        "₹${controller.currentBalance.value}",
                        style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                      )),
                    const Text("Current balance", style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text("Quick Add", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              // Quick Add Grid
              Obx(() => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.35,
                    ),
                    itemCount: controller.quickAmounts.length,
                    itemBuilder: (context, index) {
                      final item = controller.quickAmounts[index];
                      return Obx(() {
                        final isSelected = item.amount == controller.selectedQuickAmount.value;
                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            controller.amountController.clear();
                            controller.selectQuickAmount(item.amount);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Text(
                              "₹${item.amount}",
                              style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  )),

              const SizedBox(height: 24),
              const Center(
                child: Text("or enter amount", style: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
              const SizedBox(height: 12),

              // Custom Amount Input
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Text("₹", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: controller.amountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          hintText: "Enter amount",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (value) {
                          controller.customAmount.value = value.trim();
                          if (value.isNotEmpty) {
                            controller.selectedQuickAmount.value = "";
                          } else if (value.isEmpty) {
                            controller.selectedQuickAmount.value = "399";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Payment Method
              const Text("Payment method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),

              Obx(() {
                final isUpiSelected = controller.selectedPaymentMethod.value == "UPI";
                final isCardSelected = controller.selectedPaymentMethod.value == "Card";

                return Column(
                  children: [
                    // UPI Option
                    GestureDetector(
                      onTap: () => controller.selectPaymentMethod("UPI"),
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: isUpiSelected ? AppColors.primaryColor.withOpacity(0.08) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isUpiSelected ? Color(0xFFE5DBFF) : Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isUpiSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                              color: isUpiSelected ? Colors.deepPurple : Colors.grey,
                              size: 32,
                            ),
                            const SizedBox(width: 14),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("UPI", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                Text("PhonePe, GPay, Paytm", style: TextStyle(color: Colors.grey, fontSize: 13)),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Recommended",
                                style: TextStyle(color: Colors.deepPurple, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // More Options (Card)
                    GestureDetector(
                      onTap: () => controller.selectPaymentMethod("Card"),
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: isCardSelected ? AppColors.primaryColor.withOpacity(0.08) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isCardSelected ? Color(0xFFE5DBFF) : Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isCardSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                              color: isCardSelected ? Colors.deepPurple : Colors.grey,
                              size: 32,
                            ),
                            const SizedBox(width: 14),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("More options", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                Text("Card", style: TextStyle(color: Colors.grey, fontSize: 13)),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 40),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: controller.showPaymentBottomSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ====================== Pixel-Perfect UPI Bottom Sheet ======================


class PaymentBottomSheet extends StatefulWidget {
  final String initialAmount;

  const PaymentBottomSheet({super.key, this.initialAmount = "399", required String amount});

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  late String selectedAmount;
  String? selectedAppName;

  // Correct, stable CDN URLs for UPI app logos
  final Map<String, String> upiLogos = {
    "PhonePe": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/PhonePe_Logo.png/240px-PhonePe_Logo.png",
    "GPay":    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Google_Pay_Logo.svg/512px-Google_Pay_Logo.svg.png",
    "Paytm":   "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Paytm_Logo_%28standalone%29.svg/512px-Paytm_Logo_%28standalone%29.svg.png",
    "FamPay":  "https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/FamPay_logo.svg/512px-FamPay_logo.svg.png",
  };

  // Background circle colors matching each app brand
  final Map<String, Color> upiColors = {
    "PhonePe": const Color(0xFF5F259F),
    "GPay":    Colors.white,
    "Paytm":   const Color(0xFF002970),
    "FamPay":  const Color(0xFFFFA500),
  };

  final List<String> packs = ["39", "119", "249", "399", "699", "999"];

  // The "Most Used" badge amount
  static const String _mostUsed = "399";

  @override
  void initState() {
    super.initState();
    selectedAmount = widget.initialAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag Handle ──────────────────────────────────────────────
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 22),

          // ── Title ────────────────────────────────────────────────────
          RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(text: "Pay "),
                    TextSpan(
                      text: "₹$selectedAmount",
                      style: const TextStyle(
                        color: Color(0xFF6236FF),
                      ),
                    ),
                  ],
                ),
              ),
         
          const SizedBox(height: 24),

          // ── Quick Add Label ──────────────────────────────────────────
          // const Align(
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     "Quick Add",
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
          //   ),
          // ),
          // const SizedBox(height: 14),

          // // ── Pack Grid ────────────────────────────────────────────────
          // GridView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 3,
          //     mainAxisSpacing: 16,
          //     crossAxisSpacing: 12,
          //     childAspectRatio: 2.4,
          //   ),
          //   itemCount: packs.length,
          //   itemBuilder: (context, index) => _buildPackChip(packs[index]),
          // ),

          const SizedBox(height: 28),

          // ── PAY WITH UPI Divider ─────────────────────────────────────
          // Row(
          //   children: [
          //     const Expanded(child: Divider(thickness: 1, color: Color(0xFFE0E0E0))),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 12),
          //       child: Text(
          //         "PAY WITH UPI",
          //         style: TextStyle(
          //           fontSize: 11,
          //           fontWeight: FontWeight.w800,
          //           color: Colors.grey[500],
          //           letterSpacing: 0.8,
          //         ),
          //       ),
          //     ),
          //     const Expanded(child: Divider(thickness: 1, color: Color(0xFFE0E0E0))),
          //   ],
          // ),
          const SizedBox(height: 22),

          // ── UPI App Icons ────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: upiLogos.entries
                .map((e) => _buildUpiIcon(e.key, e.value, upiColors[e.key]!))
                .toList(),
          ),

          const SizedBox(height: 28),

          // ── You'll Pay Footer ────────────────────────────────────────
          // RichText(
          //   text: TextSpan(
          //     style: const TextStyle(fontSize: 16, color: Colors.black87),
          //     children: [
          //       const TextSpan(text: "You'll pay  "),
          //       TextSpan(
          //         text: "₹ $selectedAmount",
          //         style: const TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.bold,
          //           color: Color(0xFF5B35E8),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 10),

          // ── Tap to Continue ──────────────────────────────────────────
          TextButton(
            onPressed: selectedAppName == null ? null : () {},
            child: Text(
              "Tap to Continue",
              style: TextStyle(
                color: selectedAppName != null ? Colors.black87 : Colors.grey[400],
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Pack Chip ─────────────────────────────────────────────────────────────
  Widget _buildPackChip(String amount) {
    final bool isSelected = selectedAmount == amount;
    final bool isMostUsed = amount == _mostUsed;

    return GestureDetector(
      onTap: () => setState(() => selectedAmount = amount),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Chip body
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF5B35E8) : Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF5B35E8)
                    : (isMostUsed ? const Color(0xFF5B35E8) : Colors.grey.shade300),
                width: isMostUsed && !isSelected ? 1.5 : 1,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "₹$amount",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.5,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),

          // "Most Used" badge — only on ₹399 chip
          if (isMostUsed)
            Positioned(
              top: -9,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5B35E8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Most Used",
                    style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── UPI App Icon ──────────────────────────────────────────────────────────
  Widget _buildUpiIcon(String name, String logoUrl, Color bgColor) {
    final bool isSelected = selectedAppName == name;

    // For white-bg apps (GPay) use a light grey ring on unselected
    final bool isLightBg = bgColor == Colors.white;

    return GestureDetector(
      onTap: () => setState(() => selectedAppName = name),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: isSelected
                  ? bgColor
                  : (isLightBg ? const Color(0xFFF5F5F7) : bgColor),
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: const Color(0xFF5B35E8), width: 2.5)
                  : (isLightBg
                      ? Border.all(color: Colors.grey.shade200, width: 1)
                      : null),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF5B35E8).withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : null,
            ),
            padding: const EdgeInsets.all(10),
            child: Image.network(
              logoUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.account_balance_wallet, size: 28, color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black87 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// ====================== Card Payment Bottom Sheet ======================


class CardPaymentBottomSheet extends StatelessWidget {
  final String amount;

  const CardPaymentBottomSheet({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              children: [
                const TextSpan(text: "Pay "),
                TextSpan(text: "₹$amount", style: const TextStyle(color: Color(0xFF6236FF))),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildTextField("Card Number", "Card Number"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField("Expiry", "mm/yy")),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField("CVV", "....")),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const PaymentSuccessScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Pay ₹$amount", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF9F9FF),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Checkmark
              Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(
                  color: Color(0xFF00C853), // Green success color
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3300C853),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Success!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your balance has been successfully\nadded",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              // Back to Home Button
              SizedBox(
                width: 180,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => BottomNavbarScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}