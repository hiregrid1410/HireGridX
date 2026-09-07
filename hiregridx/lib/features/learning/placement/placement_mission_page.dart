import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class PlacementMissionPage extends StatefulWidget {
  const PlacementMissionPage({super.key});

  @override
  State<PlacementMissionPage> createState() => _PlacementMissionPageState();
}

class _PlacementMissionPageState extends State<PlacementMissionPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leaderboard = MockRepository.leaderboard;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Placement Mission', style: AppTypography.pageTitle),
                  const SizedBox(height: 4),
                  Text(
                    'Compete in weekly placement challenges & top the rank leaderboard.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: 16),

                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: AppColors.primaryGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelColor: AppColors.backgroundDark,
                      unselectedLabelColor: AppColors.textSecondary,
                      labelStyle: AppTypography.button,
                      tabs: const [
                        Tab(text: 'Active Mission'),
                        Tab(text: 'Leaderboard'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1: Active Mission Details
                  _buildMissionTab(),

                  // Tab 2: Gamified Leaderboard
                  _buildLeaderboardTab(leaderboard),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          HgCard(
            backgroundColor: const Color(0xFF1C180B),
            border: Border.all(color: AppColors.accentYellow.withOpacity(0.4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HgBadge(label: 'WEEKLY CONTEST #12', color: Color(0x33FFD93D), textColor: AppColors.accentYellow),
                    Text('02d 14h 26m left', style: AppTypography.caption.copyWith(color: AppColors.accentYellow, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                Text('National Placement Sprint', style: AppTypography.cardTitle.copyWith(fontSize: 20)),
                const SizedBox(height: 6),
                Text(
                  'Complete 5 assessment modules with >70% score before deadline to claim +500 XP.',
                  style: AppTypography.bodyMedium,
                ),
                const SizedBox(height: 20),

                LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: AppColors.surfaceElevated,
                  color: AppColors.accentYellow,
                  borderRadius: BorderRadius.circular(6),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Completed: 3 / 5 Modules', style: AppTypography.caption),
                    Text('Reward: +500 XP', style: AppTypography.caption.copyWith(color: AppColors.accentYellow, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Mission Modules Checklist
          HgCard(
            child: Column(
              children: [
                _buildChecklistItem('1. Aptitude Assessment', 'Completed • 92%', true),
                const Divider(color: AppColors.border),
                _buildChecklistItem('2. Logical Reasoning', 'Completed • 81%', true),
                const Divider(color: AppColors.border),
                _buildChecklistItem('3. Technical MCQ Sprint', 'In Progress', false),
                const Divider(color: AppColors.border),
                _buildChecklistItem('4. Coding Fundamentals', 'Pending', false),
                const Divider(color: AppColors.border),
                _buildChecklistItem('5. Mock Technical Interview', 'Pending', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String title, String status, bool isDone) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        isDone ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isDone ? AppColors.primaryGreen : AppColors.textMuted,
      ),
      title: Text(title, style: AppTypography.cardTitle),
      subtitle: Text(status, style: AppTypography.caption.copyWith(color: isDone ? AppColors.primaryGreen : AppColors.textMuted)),
    );
  }

  Widget _buildLeaderboardTab(List leaderboard) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Top 3 Podium
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 2nd Place
              _buildPodiumItem(leaderboard[1], 2, AppColors.textSecondary, 100),
              const SizedBox(width: 12),
              // 1st Place
              _buildPodiumItem(leaderboard[0], 1, AppColors.accentYellow, 130),
              const SizedBox(width: 12),
              // 3rd Place
              _buildPodiumItem(leaderboard[2], 3, const Color(0xFFCD7F32), 90),
            ],
          ),
          const SizedBox(height: 24),

          // Student's Rank Callout
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.primaryGreen, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('#5', style: AppTypography.cardTitle.copyWith(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Position (Kaju Sharma)', style: AppTypography.cardTitle.copyWith(color: AppColors.primaryGreen)),
                        Text('MCA • Marwadi Univ', style: AppTypography.caption),
                      ],
                    ),
                  ],
                ),
                Text('1,450 XP', style: AppTypography.cardTitle.copyWith(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Leaderboard Rows
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leaderboard.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final user = leaderboard[index];
              return HgCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Text(
                        '#${user.rank}',
                        style: AppTypography.cardTitle.copyWith(
                          color: user.rank <= 3 ? AppColors.accentYellow : AppColors.textMuted,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.surfaceElevated,
                      child: Text(user.name.substring(0, 1), style: const TextStyle(fontSize: 12, color: AppColors.textPrimary)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                          Text(user.branch, style: AppTypography.caption),
                        ],
                      ),
                    ),
                    Text('${user.xp} XP', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.accentYellow)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumItem(dynamic user, int rank, Color color, double height) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(Icons.military_tech, color: color),
        ),
        const SizedBox(height: 6),
        Text(user.name.split(' ')[0], style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold)),
        Text('${user.xp} XP', style: AppTypography.caption.copyWith(color: color, fontSize: 10)),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          alignment: Alignment.center,
          child: Text('#$rank', style: AppTypography.pageTitle.copyWith(color: color)),
        ),
      ],
    );
  }
}
