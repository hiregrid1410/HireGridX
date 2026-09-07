import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';

class MockPurchasePage extends StatefulWidget {
  const MockPurchasePage({super.key});

  @override
  State<MockPurchasePage> createState() => _MockPurchasePageState();
}

class _MockPurchasePageState extends State<MockPurchasePage> {
  final _utrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Complete Payment', style: AppTypography.sectionHeader),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HgCard(
              backgroundColor: const Color(0xFF1B190B),
              border: Border.all(color: AppColors.accentYellow.withOpacity(0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selected Plan', style: AppTypography.caption),
                      SizedBox(height: 2),
                      Text('3 Months Pro Prep', style: AppTypography.cardTitle),
                    ],
                  ),
                  Text('₹599', style: AppTypography.pageTitle.copyWith(color: AppColors.accentYellow)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('Scan QR or Pay via UPI', style: AppTypography.sectionHeader),
            const SizedBox(height: 12),

            HgCard(
              child: Column(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.qr_code_2_rounded, size: 140, color: Colors.black),
                        Text('Scan with GPay / PhonePe', style: AppTypography.caption.copyWith(color: Colors.black54, fontSize: 10)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('UPI ID: hiregrid@upi', style: AppTypography.bodyMedium),
                        IconButton(
                          icon: const Icon(Icons.copy_rounded, size: 18, color: AppColors.primaryGreen),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('Enter Transaction Details', style: AppTypography.sectionHeader),
            const SizedBox(height: 12),

            HgTextField(
              labelText: 'Transaction Reference / UTR Number',
              hintText: 'e.g. 123456789012',
              controller: _utrController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            HgSecondaryButton(
              text: 'Upload Payment Screenshot',
              icon: Icons.upload_file_rounded,
              onPressed: () {},
            ),
            const SizedBox(height: 24),

            HgPrimaryButton(
              text: 'Submit Payment Request',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppColors.surface,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Row(
                      children: [
                        Icon(Icons.check_circle_rounded, color: AppColors.primaryGreen),
                        SizedBox(width: 8),
                        Text('Request Submitted', style: AppTypography.cardTitle),
                      ],
                    ),
                    content: const Text(
                      'Your payment verification request has been sent to the administrator. Access will be unlocked upon manual verification.',
                      style: AppTypography.bodyMedium,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                          context.go('/learning/home');
                        },
                        child: const Text('Back to Home', style: TextStyle(color: AppColors.primaryGreen)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
