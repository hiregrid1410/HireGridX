import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../core/widgets/common_widgets.dart';

class NetworkingPlaceholderPage extends StatelessWidget {
  const NetworkingPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Networking', style: AppTypography.sectionHeader),
        actions: [
          IconButton(
            tooltip: 'Switch Space',
            icon: const Icon(Icons.swap_horiz_rounded, color: AppColors.accentBlue),
            onPressed: () => context.go('/gateway'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.accentBlue.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.hub_outlined,
                  size: 64,
                  color: AppColors.accentBlue,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Networking Experience',
                style: AppTypography.pageTitle,
              ),
              const SizedBox(height: 12),
              Text(
                'Connect with peers, alumni, mentors, and recruiters. Networking features will be launched in the next dedicated release phase.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 32),

              HgCard(
                backgroundColor: AppColors.surface,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.people_outline, color: AppColors.accentBlue),
                      title: const Text('Connections & Peer Feed', style: AppTypography.cardTitle),
                      subtitle: const Text('Coming Soon', style: AppTypography.caption),
                    ),
                    const Divider(color: AppColors.border),
                    ListTile(
                      leading: const Icon(Icons.work_outline_rounded, color: AppColors.accentBlue),
                      title: const Text('Placement & Internship Board', style: AppTypography.cardTitle),
                      subtitle: const Text('Coming Soon', style: AppTypography.caption),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              HgSecondaryButton(
                text: 'Return to Gateway',
                icon: Icons.swap_horiz_rounded,
                onPressed: () => context.go('/gateway'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
