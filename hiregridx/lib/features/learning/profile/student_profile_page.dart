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
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),

              // Student Profile Header Card (Screen 8 style)
              HgCard(
                onTap: () => context.push('/learning/edit-profile'),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFF1B2A38),
                      child: Text(
                        user.name.substring(0, 1),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user.email,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: Color(0xFF6E7B85),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user.branch,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: Color(0xFF6E7B85),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Grouped List Items with dividers
              HgCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildProfileTile(
                      icon: Icons.person_outline_rounded,
                      title: 'My Profile',
                      onTap: () => context.push('/learning/edit-profile'),
                    ),
                    const Divider(color: Color(0x14FFFFFF), height: 1),
                    _buildProfileTile(
                      icon: Icons.school_outlined,
                      title: 'My Learning & Stats',
                      onTap: () => context.go('/learning/my-learning'),
                    ),
                    const Divider(color: Color(0x14FFFFFF), height: 1),
                    _buildProfileTile(
                      icon: Icons.alt_route_rounded,
                      title: 'Switch Academic Branch',
                      onTap: () => context.push('/learning/branch-switch'),
                    ),
                    const Divider(color: Color(0x14FFFFFF), height: 1),
                    _buildProfileTile(
                      icon: Icons.workspace_premium_outlined,
                      title: 'Subscription & Plans',
                      onTap: () => context.push('/learning/plans'),
                    ),
                    const Divider(color: Color(0x14FFFFFF), height: 1),
                    _buildProfileTile(
                      icon: Icons.emoji_events_outlined,
                      title: 'Leaderboard Rankings',
                      onTap: () => context.push('/learning/leaderboard'),
                    ),
                    const Divider(color: Color(0x14FFFFFF), height: 1),
                    _buildProfileTile(
                      icon: Icons.feedback_outlined,
                      title: 'Help & Support / Feedback',
                      onTap: () => context.push('/learning/feedback'),
                    ),
                    const Divider(color: Color(0x14FFFFFF), height: 1),
                    ListTile(
                      leading: const Icon(Icons.logout_rounded, color: AppColors.error, size: 20),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.error,
                        ),
                      ),
                      onTap: () => context.go('/login'),
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

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary, size: 20),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
      onTap: onTap,
    );
  }
}
