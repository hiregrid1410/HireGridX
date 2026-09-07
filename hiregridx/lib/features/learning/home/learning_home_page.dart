import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class LearningHomePage extends StatelessWidget {
  const LearningHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockRepository.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning,',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${user.name} 👋',
                      style: AppTypography.pageTitle,
                    ),
                  ],
                ),
                HgBadge(
                  label: user.branch.split(' ')[0],
                  color: AppColors.primaryGreen.withOpacity(0.15),
                  textColor: AppColors.primaryGreen,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Top Telemetry Grid
            Row(
              children: [
                Expanded(
                  child: HgStatCard(
                    label: 'Streak',
                    value: '🔥 ${user.streak} Days',
                    icon: Icons.local_fire_department_rounded,
                    iconColor: AppColors.warning,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: HgStatCard(
                    label: 'XP Rank',
                    value: '${user.xp} XP',
                    icon: Icons.stars_rounded,
                    iconColor: AppColors.accentYellow,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: HgStatCard(
                    label: 'Tier Rank',
                    value: user.rankBadge,
                    icon: Icons.military_tech_rounded,
                    iconColor: AppColors.accentYellow,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: HgStatCard(
                    label: 'Avg Accuracy',
                    value: '${user.accuracy}%',
                    icon: Icons.fact_check_outlined,
                    iconColor: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Weekly Placement Mission Card
            HgCard(
              backgroundColor: const Color(0xFF1B180C),
              border: Border.all(color: AppColors.accentYellow.withOpacity(0.4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HgBadge(
                        label: 'WEEKLY MISSION',
                        color: Color(0x33FFD93D),
                        textColor: AppColors.accentYellow,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined, size: 14, color: AppColors.accentYellow),
                          const SizedBox(width: 4),
                          Text('02d 14h 26m', style: AppTypography.caption.copyWith(color: AppColors.accentYellow)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Placement Mission #12',
                    style: AppTypography.cardTitle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Complete 5 company aptitude assessments to earn +500 XP bonus.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: 16),

                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: AppColors.surfaceElevated,
                    color: AppColors.accentYellow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Progress: 3/5 Modules', style: AppTypography.caption),
                      Text('+500 XP', style: AppTypography.caption.copyWith(color: AppColors.accentYellow, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentYellow,
                        foregroundColor: AppColors.backgroundDark,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () => context.go('/learning/placement'),
                      child: const Text('Continue Mission', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Continue Learning Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Continue Learning', style: AppTypography.sectionHeader),
                TextButton(
                  onPressed: () => context.go('/learning/my-learning'),
                  child: const Text('View All', style: TextStyle(color: AppColors.primaryGreen)),
                ),
              ],
            ),
            const SizedBox(height: 8),

            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: MockRepository.subjects.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final subj = MockRepository.subjects[index];
                  return SizedBox(
                    width: 220,
                    child: HgCard(
                      onTap: () => context.go('/learning/my-learning'),
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.folder_open_rounded, color: AppColors.primaryGreen, size: 22),
                              HgAccessBadge(type: subj.accessType == 'free' ? 'FREE' : 'PREMIUM'),
                            ],
                          ),
                          Text(
                            subj.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.cardTitle.copyWith(fontSize: 14),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LinearProgressIndicator(
                                value: subj.progress,
                                backgroundColor: AppColors.surfaceElevated,
                                color: AppColors.primaryGreen,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${(subj.progress * 100).toInt()}% completed',
                                style: AppTypography.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Recent Activity Deck
            const Text('Recent Activity', style: AppTypography.sectionHeader),
            const SizedBox(height: 12),

            HgCard(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_circle_outline, color: AppColors.primaryGreen),
                    ),
                    title: const Text('Binary Trees Assessment', style: AppTypography.cardTitle),
                    subtitle: const Text('Passed • Score: 85%', style: AppTypography.caption),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: () => context.go('/learning/result/mod_trees_01'),
                  ),
                  const Divider(color: AppColors.border),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_circle_outline, color: AppColors.primaryGreen),
                    ),
                    title: const Text('TCS NQT Aptitude Mock', style: AppTypography.cardTitle),
                    subtitle: const Text('Passed • Score: 90%', style: AppTypography.caption),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: () => context.go('/learning/company/comp_tcs'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
