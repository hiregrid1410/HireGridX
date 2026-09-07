import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class SolutionsPage extends StatefulWidget {
  final String moduleId;

  const SolutionsPage({super.key, required this.moduleId});

  @override
  State<SolutionsPage> createState() => _SolutionsPageState();
}

class _SolutionsPageState extends State<SolutionsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final exam = MockRepository.dsaTreesExam;
    final q = exam.questions[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Answer Solutions', style: AppTypography.sectionHeader),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/learning/result/${widget.moduleId}'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Question ${_currentIndex + 1} of ${exam.questions.length}', style: AppTypography.caption),
              const SizedBox(height: 12),

              HgCard(
                child: Text(q.text, style: AppTypography.cardTitle.copyWith(fontSize: 16)),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  itemCount: q.options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, idx) {
                    final isCorrect = idx == q.correctOptionIndex;

                    return HgCard(
                      border: isCorrect
                          ? Border.all(color: AppColors.primaryGreen, width: 2)
                          : Border.all(color: AppColors.border),
                      backgroundColor: isCorrect
                          ? AppColors.primaryGreen.withOpacity(0.1)
                          : AppColors.surface,
                      child: Row(
                        children: [
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: isCorrect ? AppColors.primaryGreen : AppColors.textMuted,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              q.options[idx],
                              style: AppTypography.bodyMedium.copyWith(
                                color: isCorrect ? AppColors.primaryGreen : AppColors.textPrimary,
                                fontWeight: isCorrect ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Explanation Box
              HgCard(
                backgroundColor: AppColors.surfaceElevated,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lightbulb_outline, color: AppColors.accentYellow, size: 18),
                        const SizedBox(width: 6),
                        Text('Explanation', style: AppTypography.cardTitle.copyWith(color: AppColors.accentYellow)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(q.explanation, style: AppTypography.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  if (_currentIndex > 0)
                    Expanded(
                      child: HgSecondaryButton(
                        text: 'Previous',
                        onPressed: () {
                          setState(() {
                            _currentIndex--;
                          });
                        },
                      ),
                    ),
                  if (_currentIndex > 0) const SizedBox(width: 12),
                  if (_currentIndex < exam.questions.length - 1)
                    Expanded(
                      child: HgPrimaryButton(
                        text: 'Next',
                        onPressed: () {
                          setState(() {
                            _currentIndex++;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
