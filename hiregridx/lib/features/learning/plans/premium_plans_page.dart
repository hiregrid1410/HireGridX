import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class PremiumPlansPage extends StatelessWidget {
  const PremiumPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Upgrade Plan', style: AppTypography.sectionHeader),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HgBadge(label: 'PREMIUM MEMBERSHIP', color: Color(0x33FFD93D), textColor: AppColors.accentYellow),
            const SizedBox(height: 12),
            const Text('Unlock Your Full Potential', style: AppTypography.pageTitle),
            const SizedBox(height: 6),
            Text(
              'Get unlimited access to company test suites, advanced learning modules & placement missions.',
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 24),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: MockRepository.plans.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final plan = MockRepository.plans[index];
                return HgCard(
                  backgroundColor: plan.isPopular ? const Color(0xFF1F1A0B) : AppColors.surface,
                  border: plan.isPopular
                      ? Border.all(color: AppColors.accentYellow, width: 2)
                      : Border.all(color: AppColors.border),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (plan.isPopular) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const HgBadge(
                              label: 'MOST POPULAR',
                              color: AppColors.accentYellow,
                              textColor: AppColors.backgroundDark,
                            ),
                            Text('Best Value', style: AppTypography.caption.copyWith(color: AppColors.accentYellow, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(plan.title, style: AppTypography.cardTitle.copyWith(fontSize: 18)),
                              Text(plan.durationText, style: AppTypography.caption),
                            ],
                          ),
                          Text(
                            plan.priceText,
                            style: AppTypography.display.copyWith(
                              color: AppColors.accentYellow,
                              fontSize: 26,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: AppColors.border),
                      const SizedBox(height: 12),

                      ...plan.benefits.map((b) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline, size: 16, color: AppColors.accentYellow),
                            const SizedBox(width: 8),
                            Expanded(child: Text(b, style: AppTypography.bodyMedium)),
                          ],
                        ),
                      )),

                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: plan.isPopular ? AppColors.accentYellow : AppColors.primaryGreen,
                            foregroundColor: AppColors.backgroundDark,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () => context.go('/learning/mock-purchase'),
                          child: const Text('Choose Plan', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
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
