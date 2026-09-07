import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockRepository.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header Card
            HgCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.primaryGreen.withOpacity(0.2),
                    child: Text(
                      user.name.substring(0, 1),
                      style: AppTypography.display.copyWith(color: AppColors.primaryGreen),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(user.name, style: AppTypography.pageTitle),
                  const SizedBox(height: 4),
                  Text('${user.branch} • ${user.college}', style: AppTypography.bodyMedium),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildProfileStat('XP Points', '${user.xp}'),
                      Container(width: 1, height: 24, color: AppColors.border),
                      _buildProfileStat('Streak', '${user.streak} Days'),
                      Container(width: 1, height: 24, color: AppColors.border),
                      _buildProfileStat('Badge', user.rankBadge),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Settings List
            HgCard(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline, color: AppColors.primaryGreen),
                    title: const Text('Edit Profile & Academic Info', style: AppTypography.cardTitle),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: () => context.go('/learning/edit-profile'),
                  ),
                  const Divider(color: AppColors.border),
                  ListTile(
                    leading: const Icon(Icons.star_outline, color: AppColors.accentYellow),
                    title: const Text('Upgrade Subscription Plan', style: AppTypography.cardTitle),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: () => context.go('/learning/plans'),
                  ),
                  const Divider(color: AppColors.border),
                  ListTile(
                    leading: const Icon(Icons.feedback_outlined, color: AppColors.accentBlue),
                    title: const Text('Send Feedback / Report Bug', style: AppTypography.cardTitle),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: () => context.go('/learning/feedback'),
                  ),
                  const Divider(color: AppColors.border),
                  ListTile(
                    leading: const Icon(Icons.swap_horiz_rounded, color: AppColors.primaryGreen),
                    title: const Text('Switch Space (Gateway)', style: AppTypography.cardTitle),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: () => context.go('/gateway'),
                  ),
                  const Divider(color: AppColors.border),
                  ListTile(
                    leading: const Icon(Icons.logout_rounded, color: AppColors.error),
                    title: const Text('Sign Out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                    onTap: () => context.go('/login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String val) {
    return Column(
      children: [
        Text(val, style: AppTypography.cardTitle.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
