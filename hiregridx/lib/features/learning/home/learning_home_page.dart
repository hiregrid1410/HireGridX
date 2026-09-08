import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../shared/mock_data/mock_repository.dart';

class LearningHomePage extends StatelessWidget {
  const LearningHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row with Drawer menu icon, title, subtitle & bell
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notes_rounded, color: AppColors.textPrimary, size: 26),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Learning',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Gain new skills. Build your future.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 24),
                ],
              ),
              const SizedBox(height: 20),

              // Search field with filter icon
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1720),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0x1AFFFFFF)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded, color: Color(0xFF6E7B85), size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              style: const TextStyle(fontFamily: 'Inter', fontSize: 13, color: AppColors.textPrimary),
                              decoration: InputDecoration(
                                hintText: 'Search subjects, topics, or skills...',
                                hintStyle: const TextStyle(fontFamily: 'Inter', fontSize: 13, color: Color(0xFF6E7B85)),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1720),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0x1AFFFFFF)),
                    ),
                    child: const Icon(Icons.tune_rounded, color: AppColors.textPrimary, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Categories Row Header
              const Text(
                'Categories',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),

              // Category Icons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem(Icons.code_rounded, 'Development', const Color(0xFF149CFF)),
                  _buildCategoryItem(Icons.psychology_rounded, 'Aptitude', const Color(0xFFFFE035)),
                  _buildCategoryItem(Icons.insights_rounded, 'Reasoning', const Color(0xFF24F16F)),
                  _buildCategoryItem(Icons.storage_rounded, 'DBMS', const Color(0xFF16E6A3)),
                ],
              ),
              const SizedBox(height: 28),

              // Continue Learning Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Continue Learning',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/learning/my-learning'),
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Popular / Continue Learning Cards List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: MockRepository.subjects.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final subj = MockRepository.subjects[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1720),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0x14FFFFFF)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFF142230),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            _getIconForSubject(index),
                            color: _getColorForSubject(index),
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subj.name,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${subj.moduleCount} Topics • ${subj.moduleCount * 3} Assessments',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: Color(0xFF6E7B85),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: subj.progress,
                                        minHeight: 4,
                                        backgroundColor: const Color(0xFF162534),
                                        color: AppColors.primaryGreen,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${(subj.progress * 100).toInt()}%',
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color accentColor) {
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFF0D1720),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x14FFFFFF)),
          ),
          child: Icon(icon, color: accentColor, size: 26),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  IconData _getIconForSubject(int index) {
    switch (index % 4) {
      case 0:
        return Icons.account_tree_rounded;
      case 1:
        return Icons.calculate_rounded;
      case 2:
        return Icons.storage_rounded;
      default:
        return Icons.code_rounded;
    }
  }

  Color _getColorForSubject(int index) {
    switch (index % 4) {
      case 0:
        return AppColors.primaryGreen;
      case 1:
        return AppColors.accentYellow;
      case 2:
        return AppColors.secondaryGreen;
      default:
        return AppColors.accentBlue;
    }
  }
}
