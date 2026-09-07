import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../core/widgets/common_widgets.dart';
import '../../shared/mock_data/mock_repository.dart';

class StudentGatewayPage extends StatelessWidget {
  const StudentGatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockRepository.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning,',
                        style: AppTypography.caption.copyWith(color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            user.name,
                            style: AppTypography.pageTitle,
                          ),
                          const SizedBox(width: 6),
                          const Text('👋', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textSecondary),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 4),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primaryGreen.withOpacity(0.2),
                        child: const Text('KS', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),

              Text(
                'Where do you want to go?',
                style: AppTypography.sectionHeader.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 6),
              Text(
                'Select a workspace to start working.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Phase Cards
              Expanded(
                child: Column(
                  children: [
                    // NETWORKING CARD
                    Expanded(
                      child: HgCard(
                        onTap: () => context.go('/networking'),
                        backgroundColor: const Color(0xFF0F1B2A),
                        border: Border.all(color: AppColors.accentBlue.withOpacity(0.4), width: 1.5),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentBlue.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.people_outline, color: AppColors.accentBlue, size: 28),
                                ),
                                const HgBadge(
                                  label: 'NETWORKING',
                                  color: Color(0x332094FF),
                                  textColor: AppColors.accentBlue,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Networking',
                                  style: AppTypography.display.copyWith(fontSize: 24),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Connect. Build. Grow.',
                                  style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Connections • Opportunities • Community',
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Enter Networking',
                                  style: AppTypography.button.copyWith(color: AppColors.accentBlue),
                                ),
                                const Icon(Icons.arrow_forward_rounded, color: AppColors.accentBlue),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // LEARNING CARD
                    Expanded(
                      child: HgCard(
                        onTap: () => context.go('/learning/home'),
                        backgroundColor: const Color(0xFF0D1D16),
                        border: Border.all(color: AppColors.primaryGreen.withOpacity(0.5), width: 1.5),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryGreen.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.menu_book_rounded, color: AppColors.primaryGreen, size: 28),
                                ),
                                const HgBadge(
                                  label: 'LEARNING',
                                  color: Color(0x3322E573),
                                  textColor: AppColors.primaryGreen,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Learning',
                                  style: AppTypography.display.copyWith(fontSize: 24),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Learn. Practice. Get Placed.',
                                  style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Courses • Exams • Placement Missions',
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Enter Learning',
                                  style: AppTypography.button.copyWith(color: AppColors.primaryGreen),
                                ),
                                const Icon(Icons.arrow_forward_rounded, color: AppColors.primaryGreen),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Bottom Quick Telemetry Bar
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Text('🔥', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 6),
                        Text('${user.streak} Day Streak', style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Container(width: 1, height: 16, color: AppColors.border),
                    Row(
                      children: [
                        const Icon(Icons.stars_rounded, color: AppColors.accentYellow, size: 18),
                        const SizedBox(width: 6),
                        Text('${user.xp} XP', style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Container(width: 1, height: 16, color: AppColors.border),
                    Row(
                      children: [
                        const Icon(Icons.military_tech_rounded, color: AppColors.accentYellow, size: 18),
                        const SizedBox(width: 6),
                        Text(user.rankBadge, style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600, color: AppColors.accentYellow)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
