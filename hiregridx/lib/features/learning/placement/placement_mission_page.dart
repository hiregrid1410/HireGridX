import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class PlacementMissionPage extends StatelessWidget {
  const PlacementMissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isUserPremium = MockRepository.currentUser.isPremium;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      const Text(
                        'Placement Mission',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Weekly placement challenges & company readiness.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.push('/learning/leaderboard'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFE035),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.accentYellow),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.emoji_events_rounded, color: AppColors.accentYellow, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Leaderboard',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.accentYellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (!isUserPremium) ...[
                // Locked State Card
                HgCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: const BoxDecoration(
                          color: Color(0x33FFE035),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.lock_rounded, color: AppColors.accentYellow, size: 40),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Premium Content Locked',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Weekly Placement Missions and TCS/Infosys company mocks require an active Pro Membership.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      HgPrimaryButton(
                        text: 'Upgrade to Premium',
                        onPressed: () => context.push('/learning/plans'),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Active Mission Hero Banner
                HgCard(
                  backgroundColor: const Color(0xFF141A10),
                  border: Border.all(color: AppColors.accentYellow.withValues(alpha: 0.4)),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0x33FFE035),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'WEEKLY MISSION #12',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.accentYellow,
                              ),
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.timer_outlined, color: AppColors.accentYellow, size: 14),
                              SizedBox(width: 4),
                              Text(
                                '02d 14h 26m left',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.accentYellow,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'National Placement Sprint',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Complete 5 assessment modules with >70% score before deadline to claim +500 XP bonus.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.6,
                          minHeight: 6,
                          backgroundColor: const Color(0xFF1B2836),
                          color: AppColors.accentYellow,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Progress: 3 / 5 Modules', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppColors.textSecondary)),
                          Text('+500 XP Bonus', style: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.accentYellow)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Mission Checklist',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // 5-Stage Checklist
                HgCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildStageTile('1. Quantitative Aptitude', 'Completed • 92%', true, true),
                      const Divider(color: Color(0x1AFFFFFF)),
                      _buildStageTile('2. Logical Reasoning', 'Completed • 81%', true, true),
                      const Divider(color: Color(0x1AFFFFFF)),
                      _buildStageTile('3. Technical MCQ Sprint', 'Active • In Progress', false, true),
                      const Divider(color: Color(0x1AFFFFFF)),
                      _buildStageTile('4. Coding Fundamentals', 'Locked', false, false),
                      const Divider(color: Color(0x1AFFFFFF)),
                      _buildStageTile('5. Mock Interview Sprint', 'Locked', false, false),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStageTile(String title, String status, bool isDone, bool isUnlocked) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            isDone
                ? Icons.check_circle_rounded
                : isUnlocked
                    ? Icons.radio_button_checked_rounded
                    : Icons.lock_outline_rounded,
            color: isDone
                ? AppColors.primaryGreen
                : isUnlocked
                    ? AppColors.accentYellow
                    : AppColors.textMuted,
            size: 20,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isUnlocked ? AppColors.textPrimary : AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  status,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: isDone ? AppColors.primaryGreen : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (isUnlocked && !isDone)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF02080D),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
