import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/common_widgets.dart';

class ModuleDetailPage extends StatelessWidget {
  final String moduleId;

  const ModuleDetailPage({super.key, required this.moduleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button & Bookmark Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D1720),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0x1AFFFFFF)),
                          ),
                          child: const Icon(Icons.chevron_left_rounded, color: AppColors.textPrimary, size: 28),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D1720),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0x1AFFFFFF)),
                        ),
                        child: const Icon(Icons.bookmark_border_rounded, color: AppColors.textPrimary, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Hero Thumbnail Banner (Matching Screen 6)
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C1926),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0x1AFFFFFF)),
                      gradient: const RadialGradient(
                        center: Alignment(0.3, -0.3),
                        radius: 1.0,
                        colors: [Color(0x33149CFF), Color(0xFF09131C)],
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreen,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryGreen.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.play_arrow_rounded, color: Color(0xFF02080D), size: 36),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Module Title & Subtitle
                  const Text(
                    'MODULE B1 - Binary Trees & BST',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Master tree traversals, BST insertions, deletions, and level-order algorithms from scratch.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: AppColors.textMuted,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rating & Stats Row
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.accentYellow, size: 18),
                      const SizedBox(width: 4),
                      const Text(
                        '4.8',
                        style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                      const SizedBox(width: 4),
                      Text('(1.2k students)', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppColors.textMuted)),
                      const SizedBox(width: 16),
                      const Icon(Icons.schedule_rounded, color: AppColors.accentBlue, size: 16),
                      const SizedBox(width: 4),
                      Text('30 Mins', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppColors.textMuted)),
                      const SizedBox(width: 16),
                      const Icon(Icons.help_outline_rounded, color: AppColors.primaryGreen, size: 16),
                      const SizedBox(width: 4),
                      Text('20 Questions', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tabs Bar (Overview, Topics, Attempts)
                  Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0x1AFFFFFF))),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Overview',
                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryGreen),
                              ),
                              const SizedBox(height: 4),
                              Container(width: 60, height: 2, color: AppColors.primaryGreen),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 24),
                          child: Text(
                            'Topics',
                            style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textMuted),
                          ),
                        ),
                        Text(
                          'Attempts',
                          style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Section Title
                  const Text(
                    'What you\'ll learn & practice',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Checkbox Points List
                  _buildCheckPoint('Understand Binary Search Tree fundamentals & height balance.'),
                  _buildCheckPoint('In-order, Pre-order, and Post-order traversal algorithms.'),
                  _buildCheckPoint('Level-order BFS traversal using Queue Data Structures.'),
                  _buildCheckPoint('Solve 20 high-frequency gate and company interview questions.'),
                ],
              ),
            ),

            // Fixed Bottom CTA Button (Screen 6 layout)
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: HgPrimaryButton(
                text: 'Start Assessment',
                onPressed: () {
                  context.push('/learning/exam-rules/$moduleId');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Color(0x3324F16F),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_rounded, color: AppColors.primaryGreen, size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
