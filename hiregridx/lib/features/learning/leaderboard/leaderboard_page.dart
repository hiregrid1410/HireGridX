import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = MockRepository.leaderboard;
    final top3 = users.take(3).toList();
    final rest = users.skip(3).toList();

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
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Leaderboard',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Podium Layout for Top 3
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1720),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x1AFFFFFF)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Silver #2
                    if (top3.length > 1) _buildPodiumColumn(top3[1], 2, const Color(0xFFC0C0C0), 100),
                    // Gold #1
                    if (top3.isNotEmpty) _buildPodiumColumn(top3[0], 1, AppColors.accentYellow, 130),
                    // Bronze #3
                    if (top3.length > 2) _buildPodiumColumn(top3[2], 3, const Color(0xFFCD7F32), 80),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Top Performers',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              // Rest of Leaderboard List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rest.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final user = rest[index];
                  final bool isMe = user.name == MockRepository.currentUser.name;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.primaryGreen.withOpacity(0.12) : const Color(0xFF0D1720),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isMe ? AppColors.primaryGreen : const Color(0x14FFFFFF)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '#${user.rank}',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: isMe ? AppColors.primaryGreen : AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(width: 14),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: const Color(0xFF162534),
                          child: Text(
                            user.name.substring(0, 1),
                            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isMe ? AppColors.primaryGreen : AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user.branch,
                                style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF6E7B85)),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.stars_rounded, color: AppColors.accentYellow, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${user.xp} XP',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
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

  Widget _buildPodiumColumn(dynamic user, int rank, Color medalColor, double height) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            CircleAvatar(
              radius: rank == 1 ? 28 : 24,
              backgroundColor: medalColor.withOpacity(0.2),
              child: Text(
                user.name.substring(0, 1),
                style: TextStyle(color: medalColor, fontWeight: FontWeight.bold, fontSize: rank == 1 ? 20 : 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: medalColor, shape: BoxShape.circle),
              child: Text(
                '$rank',
                style: const TextStyle(color: Color(0xFF02080D), fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          user.name.split(' ').first,
          style: const TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 2),
        Text(
          '${user.xp} XP',
          style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w600, color: medalColor),
        ),
        const SizedBox(height: 8),
        Container(
          width: 70,
          height: height,
          decoration: BoxDecoration(
            color: medalColor.withOpacity(0.12),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            border: Border.all(color: medalColor.withOpacity(0.3)),
          ),
        ),
      ],
    );
  }
}
