import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class CompanyDetailPage extends StatelessWidget {
  final String companyId;

  const CompanyDetailPage({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final comp = MockRepository.companies.firstWhere(
      (c) => c.id == companyId,
      orElse: () => MockRepository.companies.first,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(comp.name, style: AppTypography.sectionHeader),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/learning/company-exams'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Header Banner
            HgCard(
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      comp.name.substring(0, 1),
                      style: AppTypography.display.copyWith(color: AppColors.primaryGreen),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(comp.name, style: AppTypography.pageTitle),
                            HgAccessBadge(type: comp.accessBadge),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(comp.description, style: AppTypography.caption),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Placement Criteria Card
            const Text('Eligibility & Criteria', style: AppTypography.sectionHeader),
            const SizedBox(height: 10),

            HgCard(
              child: Column(
                children: [
                  _buildCriteriaRow(Icons.school_outlined, 'Min. CGPA / Marks', comp.minCgpa),
                  const Divider(color: AppColors.border),
                  _buildCriteriaRow(Icons.account_tree_outlined, 'Eligible Branches', comp.eligibleBranches),
                  const Divider(color: AppColors.border),
                  _buildCriteriaRow(Icons.warning_amber_rounded, 'Backlog Policy', comp.backlogsPolicy),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Assessment Modules
            const Text('Assessment Modules', style: AppTypography.sectionHeader),
            const SizedBox(height: 12),

            if (comp.modules.isEmpty)
              const HgCard(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'No specific modules loaded for this company yet. Premium subscription unlocks complete question bank.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium,
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comp.modules.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final mod = comp.modules[index];
                  return HgCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(mod.title, style: AppTypography.cardTitle),
                            HgAccessBadge(type: mod.accessType),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined, size: 14, color: AppColors.textMuted),
                            const SizedBox(width: 4),
                            Text('${mod.timeLimitMinutes} Mins', style: AppTypography.caption),
                            const SizedBox(width: 16),
                            const Icon(Icons.grade_outlined, size: 14, color: AppColors.textMuted),
                            const SizedBox(width: 4),
                            Text('${mod.passPercentage}% Pass threshold', style: AppTypography.caption),
                          ],
                        ),
                        const SizedBox(height: 16),
                        HgPrimaryButton(
                          text: 'Start Test',
                          onPressed: () => context.go('/learning/exam-rules/${mod.id}'),
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

  Widget _buildCriteriaRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primaryGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTypography.caption),
                const SizedBox(height: 2),
                Text(value, style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
