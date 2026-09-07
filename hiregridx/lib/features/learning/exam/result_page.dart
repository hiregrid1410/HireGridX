import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class ResultPage extends StatelessWidget {
  final String moduleId;

  const ResultPage({super.key, required this.moduleId});

  @override
  Widget build(BuildContext context) {
    final exam = MockRepository.dsaTreesExam;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Circular Score Gauge
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryGreen.withOpacity(0.15),
                  border: Border.all(color: AppColors.primaryGreen, width: 4),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('85%', style: AppTypography.display.copyWith(color: AppColors.primaryGreen, fontSize: 36)),
                    Text('PASSED', style: AppTypography.caption.copyWith(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(exam.title, style: AppTypography.pageTitle, textAlign: TextAlign.center),
              const SizedBox(height: 6),
              Text('Congratulations! You completed the assessment.', style: AppTypography.bodyMedium),
              const SizedBox(height: 28),

              // Telemetry Grid
              HgCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildResultStat('17', 'Correct', AppColors.primaryGreen),
                    Container(width: 1, height: 24, color: AppColors.border),
                    _buildResultStat('2', 'Incorrect', AppColors.error),
                    Container(width: 1, height: 24, color: AppColors.border),
                    _buildResultStat('1', 'Skipped', AppColors.textMuted),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              HgCard(
                backgroundColor: const Color(0xFF1F1A0B),
                border: Border.all(color: AppColors.accentYellow.withOpacity(0.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.stars_rounded, color: AppColors.accentYellow),
                        SizedBox(width: 10),
                        Text('XP Earned', style: AppTypography.cardTitle),
                      ],
                    ),
                    Text('+100 XP', style: AppTypography.cardTitle.copyWith(color: AppColors.accentYellow, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const Spacer(),

              HgPrimaryButton(
                text: 'View Answer Key & Solutions',
                onPressed: () => context.go('/learning/solutions/$moduleId'),
              ),
              const SizedBox(height: 12),
              HgSecondaryButton(
                text: 'Back to Learning Dashboard',
                onPressed: () => context.go('/learning/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultStat(String val, String label, Color color) {
    return Column(
      children: [
        Text(val, style: AppTypography.cardTitle.copyWith(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
