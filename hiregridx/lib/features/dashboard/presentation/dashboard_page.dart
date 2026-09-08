import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/common_widgets.dart';
import 'widgets/dashboard_charts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AmbientGlowBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header (Image 1 Screen 3 style)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Good Morning,',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'raj! 👋',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Let's continue your career preparation journey.",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 24),
                          onPressed: () => context.push('/learning/noticeboard'),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => context.go('/learning/profile'),
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.surfaceElevated,
                            child: Icon(Icons.person_rounded, color: AppColors.primaryGreen, size: 22),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 3. Mini Status Bar (Streak, XP, Rank)
                  Row(
                    children: [
                      Expanded(
                        child: _buildMiniStatChip(
                          icon: Icons.local_fire_department_rounded,
                          iconColor: const Color(0xFFFF9500),
                          label: '7 Day Streak',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildMiniStatChip(
                          icon: Icons.military_tech_rounded,
                          iconColor: AppColors.accentYellow,
                          label: 'Bronze V',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildMiniStatChip(
                          icon: Icons.bolt_rounded,
                          iconColor: AppColors.accentYellow,
                          label: '1,450 XP',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 4. Section 1 — YOUR OVERVIEW (2-Column Metric Grid)
                  const Text(
                    'Your Overview',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.menu_book_rounded,
                          iconColor: AppColors.primaryGreen,
                          title: 'Enrolled Courses',
                          value: '12',
                          subtitle: 'Available modules',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.assignment_rounded,
                          iconColor: AppColors.accentBlue,
                          title: 'Tests Attempted',
                          value: '25',
                          subtitle: 'Completed attempts',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.star_rounded,
                          iconColor: AppColors.accentYellow,
                          title: 'Average Score',
                          value: '82%',
                          subtitle: 'Overall accuracy',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.bolt_rounded,
                          iconColor: AppColors.accentYellow,
                          title: 'XP Earned',
                          value: '1,450',
                          subtitle: 'Total XP accumulated',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  HgCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0x1AFFE036),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.emoji_events_rounded, color: AppColors.accentYellow, size: 22),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Platform Rank',
                                style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: AppColors.textMuted),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '#24 • Gold III Tier',
                                style: TextStyle(fontFamily: 'Inter', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/learning/leaderboard'),
                          child: const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // 5. Section 2 — YOUR PROGRESS (Circular Progress Ring & Weekly Performance Chart)
                  const Text(
                    'Your Progress',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  HgCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const HgProgressRing(percentage: 65, label: 'Completion'),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Overall Completion',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '12 / 18 Modules Completed',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Great pace! Keep going to reach Gold Level.',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11,
                                      color: AppColors.secondaryGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Divider(color: AppColors.border, height: 1),
                        const SizedBox(height: 16),
                        const HgWeeklyPerformanceChart(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // 6. Section 3 — XP PROGRESS BAR
                  HgCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'XP Progress',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '1,450 / 2,000 XP',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accentYellow,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: const LinearProgressIndicator(
                            value: 1450 / 2000,
                            minHeight: 8,
                            backgroundColor: Color(0xFF142230),
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentYellow),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Bronze V',
                              style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: AppColors.textMuted),
                            ),
                            Text(
                              '550 XP to Gold II',
                              style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: AppColors.secondaryGreen),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // 7. Section 4 — CONTINUE LEARNING (Image 1 compact style)
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
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  HgCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0x1A24F16F),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.bolt_rounded, color: AppColors.primaryGreen, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'AC Concepts & Circuits',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Module B1 • In Progress',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 11,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: const LinearProgressIndicator(
                                  value: 0.8,
                                  minHeight: 4,
                                  backgroundColor: Color(0xFF142230),
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: const Icon(Icons.play_circle_fill_rounded, color: AppColors.primaryGreen, size: 36),
                          onPressed: () => context.push('/learning/module/mod_ac_01'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // 8. Section 5 — ACTIVE PLACEMENT MISSION (Yellow Hero Card)
                  HgCard(
                    backgroundColor: const Color(0xFF141A10),
                    border: Border.all(color: AppColors.accentYellow.withValues(alpha: 0.4)),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0x33FFE036),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'WEEKLY PLACEMENT MISSION',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.accentYellow,
                                ),
                              ),
                            ),
                            const Text(
                              '+500 XP',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.accentYellow,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Mission #12: Electrical Core Mock',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '3 / 5 Tasks Completed • Ends Sunday 11:59 PM',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        HgPrimaryButton(
                          text: 'Continue Mission',
                          onPressed: () => context.go('/learning/placement'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // 9. Section 6 — ASSESSMENT PERFORMANCE TREND
                  HgCard(
                    padding: const EdgeInsets.all(16),
                    child: const HgAssessmentTrendChart(),
                  ),
                  const SizedBox(height: 22),

                  // 10. Section 7 — QUICK ACTIONS (4 Square Icon Tiles matching Image 1)
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickActionTile(
                        icon: Icons.menu_book_rounded,
                        label: 'My Courses',
                        onTap: () => context.go('/learning/my-learning'),
                      ),
                      _buildQuickActionTile(
                        icon: Icons.apartment_rounded,
                        label: 'Exams',
                        onTap: () => context.go('/learning/company-exams'),
                      ),
                      _buildQuickActionTile(
                        icon: Icons.workspace_premium_rounded,
                        label: 'Plans',
                        onTap: () => context.push('/learning/plans'),
                      ),
                      _buildQuickActionTile(
                        icon: Icons.emoji_events_rounded,
                        label: 'Leaderboard',
                        onTap: () => context.push('/learning/leaderboard'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildMiniStatChip({
    required IconData icon,
    required Color iconColor,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return HgCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                ),
              ),
              Icon(icon, color: iconColor, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(icon, color: AppColors.primaryGreen, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
