import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class ExamRulesPage extends StatefulWidget {
  final String moduleId;

  const ExamRulesPage({super.key, required this.moduleId});

  @override
  State<ExamRulesPage> createState() => _ExamRulesPageState();
}

class _ExamRulesPageState extends State<ExamRulesPage> {
  bool _readInstructions = false;

  @override
  Widget build(BuildContext context) {
    final exam = MockRepository.dsaTreesExam;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Exam Instructions', style: AppTypography.sectionHeader),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exam.title, style: AppTypography.pageTitle),
              const SizedBox(height: 4),
              Text('Category: ${exam.category}', style: AppTypography.bodyMedium),
              const SizedBox(height: 20),

              HgCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRuleStat('${exam.questions.length}', 'Questions'),
                    Container(width: 1, height: 24, color: AppColors.border),
                    _buildRuleStat('${exam.timeLimitMinutes} Mins', 'Duration'),
                    Container(width: 1, height: 24, color: AppColors.border),
                    _buildRuleStat('${exam.passPercentage}%', 'Pass Cutoff'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text('Rules & Marking Scheme', style: AppTypography.sectionHeader),
              const SizedBox(height: 12),

              Expanded(
                child: ListView(
                  children: const [
                    _RuleItem(text: '1. The timer starts automatically once you press "Start Exam".'),
                    _RuleItem(text: '2. Auto-submission will trigger when time reaches 00:00.'),
                    _RuleItem(text: '3. You can mark questions for review using the bottom palette.'),
                    _RuleItem(text: '4. No negative marking applies for incorrect attempts.'),
                    _RuleItem(text: '5. Navigating away during active exam will submit your attempt.'),
                  ],
                ),
              ),

              Row(
                children: [
                  Checkbox(
                    value: _readInstructions,
                    activeColor: AppColors.primaryGreen,
                    checkColor: AppColors.backgroundDark,
                    onChanged: (val) {
                      setState(() {
                        _readInstructions = val ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I have read and understood all instructions.',
                      style: AppTypography.caption,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              HgPrimaryButton(
                text: 'Start Assessment',
                onPressed: _readInstructions
                    ? () => context.go('/learning/exam-taking/${exam.id}')
                    : () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleStat(String val, String label) {
    return Column(
      children: [
        Text(val, style: AppTypography.cardTitle.copyWith(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

class _RuleItem extends StatelessWidget {
  final String text;

  const _RuleItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: AppTypography.bodyMedium),
    );
  }
}
